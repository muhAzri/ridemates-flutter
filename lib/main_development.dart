import 'package:ridemates/app/app.dart';
import 'package:ridemates/bootstrap.dart';
import 'package:ridemates/core/config/app_config.dart';

Future<void> main() async {
  AppConfig.instance = AppConfig.fromEnvironment(AppFlavor.development);
  await bootstrap(() => const App());
}
