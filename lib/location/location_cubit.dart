import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shantika_cubit/utility/extensions/latlng_extension.dart';

import '../utility/permission_handler.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  getLocation() async {
    emit(LocationStateLoading());
    try {
      final permission = await PermissionHandler().askPermission(permissions: [PermissionType.location]);
      if (permission[PermissionType.location] == true) {
        Position position = await Geolocator.getCurrentPosition();
        final address = await LatLng(position.latitude, position.longitude).getAddress();
        emit(LocationStateGetLocation(latLng: LatLng(position.latitude, position.longitude), address: address));
      } else {
        emit(LocationStateError(message: "Silahkan beri izin akses lokasi"));
      }
    } catch (e) {}
  }

  setLocation({required LatLng latLng}) async {
    final address = await latLng.getAddress();
    emit(LocationStateGetLocation(latLng: latLng, address: address));
  }
}
