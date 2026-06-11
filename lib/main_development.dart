import 'package:ridemates/app/app.dart';
import 'package:ridemates/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
