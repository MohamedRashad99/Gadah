import 'package:gadha/comman/services/location_services.dart';

class PermissionsService {
  Future<bool> allPermissionsGranted() async {
    try {
      await LocationServices.instance.requestLocationPermission();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> requestLocationPerrmision() async {}
}
