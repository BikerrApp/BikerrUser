import 'package:bikerr_partner_app/src/models/device_model.dart';
import 'package:bikerr_partner_app/src/models/event_model.dart';
import 'package:bikerr_partner_app/src/models/geofence_model.dart';
import 'package:bikerr_partner_app/src/models/position_model.dart';

class UpdateDeviceAction {
  final List<Device> devices;

  UpdateDeviceAction(this.devices);
}

class UpdatePositionAction {
  final List<PositionModel> positions;

  UpdatePositionAction(this.positions);
}

class UpdateGeofenceAction {
  final List<GeofenceModel> geofences;

  UpdateGeofenceAction(this.geofences);
}

class AddEventsAction {
  final List<Event> events;

  AddEventsAction(this.events);
}
