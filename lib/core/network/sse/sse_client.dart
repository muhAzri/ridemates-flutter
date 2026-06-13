import 'dart:async';

import 'package:eventflux/eventflux.dart';
import 'package:ridemates/core/config/app_config.dart';

/// A single Server-Sent Event: the `event:` name and raw `data:` payload.
///
/// Feature layers parse [data] (JSON) into their own typed models — this core
/// client stays transport-only and feature-agnostic.
class SseEvent {
  const SseEvent({required this.event, required this.data, this.id});

  final String event;
  final String data;
  final String? id;
}

/// Thin, reusable wrapper over [EventFlux] for consuming the backend's SSE
/// transport (e.g. `GET /realtime`, contract §10).
///
/// Responsibilities kept here (infrastructure, not feature logic):
/// - prefix paths with [AppConfig.apiBaseUrl];
/// - attach the bearer token (native clients authenticate via header, refreshed
///   on each reconnect);
/// - auto-reconnect with backoff, matching the server's `retry:`/heartbeat model.
///
/// One [SseClient] manages one connection; call [disconnect] to tear it down.
class SseClient {
  SseClient({String? Function()? tokenProvider})
    : _tokenProvider = tokenProvider;

  final String? Function()? _tokenProvider;
  final EventFlux _flux = EventFlux.spawn();
  StreamController<SseEvent>? _controller;

  /// Opens the stream at [path] (relative to the API base URL) and yields each
  /// SSE event. The returned stream is broadcast; cancel via [disconnect].
  Stream<SseEvent> connect(String path) {
    final controller = StreamController<SseEvent>.broadcast();
    _controller = controller;

    _flux.connect(
      EventFluxConnectionType.get,
      '${AppConfig.instance.apiBaseUrl}$path',
      header: _headers(),
      autoReconnect: true,
      reconnectConfig: ReconnectConfig(
        mode: ReconnectMode.exponential,
        interval: const Duration(seconds: 3),
        maxAttempts: 20,
        reconnectHeader: () async => _headers(),
      ),
      onSuccessCallback: (response) {
        response?.stream?.listen(
          (data) => controller.add(
            SseEvent(event: data.event, data: data.data, id: data.id),
          ),
          onError: controller.addError,
        );
      },
      onError: controller.addError,
    );

    return controller.stream;
  }

  /// Closes the SSE connection and the event stream.
  Future<void> disconnect() async {
    await _flux.disconnect();
    await _controller?.close();
    _controller = null;
  }

  Map<String, String> _headers() {
    final headers = <String, String>{'Accept': 'text/event-stream'};
    final token = _tokenProvider?.call();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}
