import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/src/extension/size.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

part 'create_pin_state.dart';

class CreatePinCubit extends Cubit<CreatePinState> {
  CreatePinCubit(this.csRepository) : super(const CreatePinState());

  final CsRepository csRepository;
  loc.Location location = loc.Location();
  Position? position;

  void onNameChanged(String name) {
    emit(state.copyWith(pinName: name, status: CreatePinStatus.initial));
  }

  void onAddressChanged(String address) {
    emit(state.copyWith(address: address, status: CreatePinStatus.initial));
  }

  void onCityChanged(String city) {
    emit(state.copyWith(city: city, status: CreatePinStatus.initial));
  }

  void onConstructionPhaseChanged(String phase) {
    emit(
      state.copyWith(
        constructionPhase: phase,
        status: CreatePinStatus.initial,
      ),
    );
  }

  void onStartDateChanged(String startDate) {
    debugPrint('start date changed: $startDate');
    emit(state.copyWith(startDate: startDate, status: CreatePinStatus.initial));
  }

  void onEndDateChanged(String endDate) {
    debugPrint('end date changed');
    emit(state.copyWith(endDate: endDate, status: CreatePinStatus.initial));
  }

  void onBranchesChanged(String value) {
    final branches = <String>[];
    for (final branch in state.branches) {
      branches.add(branch);
    }
    if (!branches.contains(value)) {
      branches.add(value);
    } else {
      branches.remove(value);
    }
    emit(state.copyWith(branches: branches, status: CreatePinStatus.initial));
  }

  void onPostalCodeChanged(String postalCode) {
    emit(
      state.copyWith(
        postalCode: postalCode,
        status: CreatePinStatus.initial,
      ),
    );
  }

  void onCompanyChanged(String company) {
    emit(state.copyWith(company: company, status: CreatePinStatus.initial));
  }

  void onPotentialChanged(String potential) {
    emit(state.copyWith(potential: potential, status: CreatePinStatus.initial));
  }

  Future<void> onLocationClicked(BuildContext context) async {
    try {
      // print(currentLocation.latitude);
      // final latLng =
      //     LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
      // emit(state.copyWith(currentLocation: latLng));
    } on PermissionDeniedException {
      context.showErrorMessage(
        'Location is diabled, Pls enable location to continue',
      );
    } on Exception {
      context.showErrorMessage('Something went wrong, Try again');
    }
  }

  Future<void> onGetCurrentLocation() async {
    try {
      emit(state.copyWith(currentLocation: const LatLng(0, 0)));
      if (await isPermissionGranted() && await isServiceEnable()) {
        position = await Geolocator.getCurrentPosition();
        final latLng = LatLng(position!.latitude, position!.longitude);
        emit(state.copyWith(currentLocation: latLng));
      }
    } on TimeoutException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isPermissionGranted() async {
    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return false;
      }
      return true;
    }
    return true;
  }

  Future<bool> isServiceEnable() async {
    final _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      return location.requestService();
    }
    return _serviceEnabled;
  }

  void onGetRouteId(String id) {
    emit(state.copyWith(routeId: id, status: CreatePinStatus.initial));
  }

  void onHasLocation(bool value) {
    emit(state.copyWith(hasLocation: value, status: CreatePinStatus.initial));
  }

  void onCurrentLocationUpdated(LatLng location) {
    emit(
      state.copyWith(
        currentLocation: location,
        status: CreatePinStatus.initial,
      ),
    );
  }

  void onCurrentLocationChanged(LatLng currentLocation) {
    emit(state.copyWith(currentLocation: currentLocation));
  }

  Future<void> createPin(String type) async {
    try {
      emit(state.copyWith(status: CreatePinStatus.loading));
      final response = await csRepository.addPin(
        name: state.pinName.isEmpty ? ' ' : state.pinName,
        address: state.address.isEmpty ? ' ' : state.address,
        city: state.city.isEmpty ? ' ' : state.city,
        postalCode: state.postalCode.isEmpty ? ' ' : state.postalCode,
        company: state.company.isEmpty ? ' ' : state.company,
        potential: state.potential.isEmpty ? ' ' : state.potential,
        route: state.routeId.isEmpty ? ' ' : state.routeId,
        lat: state.currentLocation.latitude,
        lng: state.currentLocation.longitude,
        startDate: state.startDate.isEmpty ? ' ' : state.startDate,
        endDate: state.endDate.isEmpty ? ' ' : state.endDate,
        type: type.isEmpty ? ' ' : type,
        constructionPhase: state.constructionPhase.isEmpty
            ? ' '
            : state.constructionPhase,
        branches: state.branches,
      );
      final pin = Pin(
        id: (response.data as Map<String, dynamic>)['_id'] as String?,
        name: (response.data as Map<String, dynamic>)['name'] as String?,
        address: (response.data as Map<String, dynamic>)['address'] as String?,
        city: (response.data as Map<String, dynamic>)['city'] as String?,
        region: (response.data as Map<String, dynamic>)['region'] as String?,
        postalCode:
            (response.data as Map<String, dynamic>)['postalCode'] as String?,
        coordinates:
            ((response.data as Map<String, dynamic>)['coordinates'] as List)
                .map((dynamic e) => e as double)
                .toList(),
        pinId: (response.data as Map<String, dynamic>)['id'] as String?,
      );
      emit(
        state.copyWith(
          status: CreatePinStatus.success,
          successMessage: response.message,
          pin: pin,
        ),
      );
    } on RouteFailure {
      emit(
        state.copyWith(
          status: CreatePinStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on RouteRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: CreatePinStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: CreatePinStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }
}

class PermissionDeniedException implements Exception {}
