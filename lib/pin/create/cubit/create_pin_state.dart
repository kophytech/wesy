part of 'create_pin_cubit.dart';

enum CreatePinStatus { loading, failure, success, initial }

class CreatePinState extends Equatable {
  const CreatePinState({
    this.successMessage = '',
    this.errorMessage = '',
    this.pinName = '',
    this.address = '',
    this.city = '',
    this.postalCode = '',
    this.company = '',
    this.potential = '',
    this.routeId = '',
    this.currentLocation = const LatLng(0, 0),
    this.status = CreatePinStatus.initial,
    this.startDate = '',
    this.endDate = '',
    this.branches = const [],
    this.constructionPhase = '',
    this.pin = const Pin(),
    this.hasLocation = false,
    this.potentials = const [
      'Select Potential',
      'Low',
      'Medium',
      'High',
    ],
  });

  CreatePinState copyWith({
    String? successMessage,
    String? errorMessage,
    String? pinName,
    String? address,
    String? city,
    String? postalCode,
    String? company,
    String? potential,
    CreatePinStatus? status,
    String? routeId,
    LatLng? currentLocation,
    String? startDate,
    String? endDate,
    String? constructionPhase,
    List<String>? branches,
    List<String>? potentials,
    Pin? pin,
    bool? hasLocation,
  }) {
    return CreatePinState(
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      pinName: pinName ?? this.pinName,
      address: address ?? this.address,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      company: company ?? this.company,
      potential: potential ?? this.potential,
      status: status ?? this.status,
      routeId: routeId ?? this.routeId,
      currentLocation: currentLocation ?? this.currentLocation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      constructionPhase: constructionPhase ?? this.constructionPhase,
      branches: branches ?? this.branches,
      potentials: potentials ?? this.potentials,
      pin: pin ?? this.pin,
      hasLocation: hasLocation ?? this.hasLocation,
    );
  }

  final String successMessage;
  final String errorMessage;
  final String pinName;
  final String address;
  final String city;
  final String postalCode;
  final String company;
  final String potential;
  final String routeId;
  final CreatePinStatus status;
  final LatLng currentLocation;
  final String startDate;
  final String endDate;
  final String constructionPhase;
  final List<String> branches;
  final List<String> potentials;
  final Pin pin;
  final bool hasLocation;

  @override
  List<Object> get props => [
        successMessage,
        errorMessage,
        pinName,
        address,
        city,
        postalCode,
        company,
        potential,
        status,
        routeId,
        startDate,
        endDate,
        hasLocation,
        constructionPhase,
        branches,
        currentLocation,
        potentials,
        pin,
      ];
}
