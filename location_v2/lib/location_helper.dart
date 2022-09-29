import 'package:location/location.dart';
import 'package:location_v2/signalR_helper.dart';

class LocationHelper {
  void getLocation(SignalRHelper signalR) async {
    var location = Location();
    location.enableBackgroundMode(enable: true);

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }

    var loc = await location.getLocation();

    //Rprint("${loc.latitude} ${loc.longitude}");
    signalR.sendMessage("${loc.latitude}, ${loc.longitude}");
    //signalR.sendMessage("TestNewFunctionality");

    location.onLocationChanged.listen((LocationData currentLocation) {
      signalR.sendMessage(
          "${currentLocation.latitude}, ${currentLocation.longitude}");
    });

    location.enableBackgroundMode(enable: true);
  }
}
