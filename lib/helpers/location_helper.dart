import 'package:location/location.dart';

class LocationHelper {
  LocationHelper();

  final Location location = Location();

  Future<bool> enableService() async {
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      return await location.requestService();
    }
    return true;
  }

  Future<bool> getPermission() async {
    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<LocationData> getLocation() async {
    if (await enableService()) {
      if (await getPermission()) {
        return await location.getLocation();
      }
    }
    throw StateError('You should enable and give permission');
  }
}
