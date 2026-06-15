import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

/// Picks an image and compresses it aggressively to WebP.
///
/// Compression runs in native code on a background thread (off the Dart UI
/// isolate), so the main thread never freezes — pure-Dart WebP encoding isn't
/// viable, and native codecs are hardware-accelerated.
class ImagePickService {
  ImagePickService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  /// Picks a square-ish avatar from the gallery and returns compressed WebP
  /// bytes (≈512px, quality 75), or null if the user cancels.
  Future<Uint8List?> pickAvatar() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (file == null) return null;

    return FlutterImageCompress.compressWithFile(
      file.path,
      format: CompressFormat.webp,
      quality: 75,
      minWidth: 512,
      minHeight: 512,
    );
  }
}
