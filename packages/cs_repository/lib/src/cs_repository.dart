import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:cs_repository/cs_repository.dart';

class WorkerFailure implements Exception {}

class WorkerRequestFailure implements Exception {
  WorkerRequestFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class AdminFailure implements Exception {}

class AdminRequestFailure implements Exception {
  AdminRequestFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class AddWorkerFailure implements Exception {}

class AddWorkerRequestFailure implements Exception {
  AddWorkerRequestFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class RegionFailure implements Exception {}

class RegionRequestFailure implements Exception {
  RegionRequestFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class RouteFailure implements Exception {}

class RouteRequestFailure implements Exception {
  RouteRequestFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class PlanFailure implements Exception {}

class PlanRequestFailure implements Exception {
  PlanRequestFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class PinFailure implements Exception {}

class PinRequestFailure implements Exception {
  PinRequestFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class CsRepository {
  CsRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<Message> addAdmin({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? region,
  }) async {
    try {
      final response = await _apiClient.createAdmin(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        region: region,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<Message> addBroadcast({
    String? note,
    String? startDate,
    String? endDate,
    String? title,
    List<String>? users,
  }) async {
    try {
      final response = await _apiClient.addBroadcast(
        note: note,
        startDate: startDate,
        endDate: endDate,
        title: title,
        users: users,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<Message> editAdmin({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? region,
    String? id,
  }) async {
    try {
      final response = await _apiClient.editAdmin(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        region: region,
        id: id,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<Message> addWorker({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? region,
  }) async {
    try {
      final response = await _apiClient.createWorker(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        region: region,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw AddWorkerFailure();
    } on HttpRequestFailure catch (e) {
      throw AddWorkerRequestFailure(e.toString());
    }
  }

  Future<Message> editWorker({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? region,
    String? id,
  }) async {
    try {
      final response = await _apiClient.editWorker(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        region: region,
        id: id,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw WorkerFailure();
    } on HttpRequestFailure catch (e) {
      throw WorkerRequestFailure(e.toString());
    }
  }

  Future<Message> addRegion({
    String? name,
  }) async {
    try {
      final response = await _apiClient.createRegion(
        name: name,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw AddWorkerFailure();
    } on HttpRequestFailure catch (e) {
      throw AddWorkerRequestFailure(e.toString());
    }
  }

  Future<Message> reArrangePin({
    List<String>? pin,
    String? routeId,
  }) async {
    try {
      final response = await _apiClient.reArrangePin(
        pin: pin,
        routeId: routeId,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw AddWorkerFailure();
    } on HttpRequestFailure catch (e) {
      throw AddWorkerRequestFailure(e.toString());
    }
  }

  Future<Message> addRoute({
    String? name,
    String? region,
    String? type,
    bool? hasRegion,
  }) async {
    try {
      final response = await _apiClient.createRoute(
        name: name,
        region: region,
        type: type,
        hasRegion: hasRegion,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<Message> addPinInformation({
    String? note,
    String? pinId,
  }) async {
    print(note);
    try {
      final response = await _apiClient.createPinInformation(
        note: note,
        pinId: pinId,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw PinFailure();
    } on HttpRequestFailure catch (e) {
      throw PinRequestFailure(e.toString());
    }
  }

  Future<Message> addPinVisit({
    String? date,
    String? note,
    String? pinId,
  }) async {
    try {
      final response = await _apiClient.createPinVisit(
        date: date,
        note: note,
        pinId: pinId,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw PinFailure();
    } on HttpRequestFailure catch (e) {
      throw PinRequestFailure(e.toString());
    }
  }

  Future<Message> addPinNote({
    String? note,
    String? pinId,
  }) async {
    try {
      final response = await _apiClient.createPinNote(
        note: note,
        pinId: pinId,
      );
      print(response);
      return Message.fromJson(response!);
    } on HttpFailure {
      throw PinFailure();
    } on HttpRequestFailure catch (e) {
      throw PinRequestFailure(e.toString());
    }
  }

  Future<Message> addPinImage({
    List<File>? images,
    String? pinId,
  }) async {
    try {
      final response = await _apiClient.createPinNote(
        // note: note,
        pinId: pinId,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw PinFailure();
    } on HttpRequestFailure catch (e) {
      throw PinRequestFailure(e.toString());
    }
  }

  Future<RouteDetails> getRouteDetails({String? routeId}) async {
    try {
      final response = await _apiClient.getRouteDetails(routeId: routeId);
      return RouteDetails.fromJson(response);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<PinDetails> getPinDetails({String? pinId}) async {
    try {
      final response = await _apiClient.getPinDetails(pinId: pinId);
      return PinDetails.fromJson(response);
    } on HttpFailure {
      throw PinFailure();
    } on HttpRequestFailure catch (e) {
      throw PinRequestFailure(e.toString());
    }
  }

  Future<UploadImage> uploadImage({
    required List<File> images,
    required String pinId,
  }) async {
    try {
      final response = await _apiClient.uploadImage(
        images: images,
        pinId: pinId,
      );
      return UploadImage.fromJson(response!);
    } on HttpFailure {
      throw PinFailure();
    } on HttpRequestFailure catch (e) {
      throw PinRequestFailure(e.toString());
    }
  }

  Future<Message> deletePinVisit({String? pinId, String? visitId}) async {
    try {
      final response =
          await _apiClient.deletePinVisit(pinId: pinId, visitId: visitId);
      return Message.fromJson(response);
    } on HttpFailure {
      throw PinFailure();
    } on HttpRequestFailure catch (e) {
      throw PinRequestFailure(e.toString());
    }
  }

  Future<Message> deletePinImage({String? pinId, String? imageId}) async {
    try {
      final response =
          await _apiClient.deletePinImage(pinId: pinId, imgId: imageId);
      return Message.fromJson(response);
    } on HttpFailure {
      throw PinFailure();
    } on HttpRequestFailure catch (e) {
      throw PinRequestFailure(e.toString());
    }
  }

  Future<Message> deleteRouteLocation({String? locationId}) async {
    try {
      final response = await _apiClient.deleteRouteLocation(pinId: locationId);
      return Message.fromJson(response);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<Message> deleteRouteWorker({String? routeId, String? workerId}) async {
    try {
      final response = await _apiClient.deleteRouteWorker(
          workerId: workerId, routeId: routeId);
      return Message.fromJson(response);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<Message> deleteIndustry({String? pinId}) async {
    try {
      final response = await _apiClient.deleteIndustry(pinId: pinId);
      return Message.fromJson(response);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<Message> deleteRoute({String? routeId}) async {
    try {
      final response = await _apiClient.deleteRoute(routeId: routeId);
      return Message.fromJson(response);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<Message> deleteWorker({String? id}) async {
    try {
      final response = await _apiClient.deleteWorker(id: id);
      return Message.fromJson(response);
    } on HttpFailure {
      throw WorkerFailure();
    } on HttpRequestFailure catch (e) {
      throw WorkerRequestFailure(e.toString());
    }
  }

  Future<Message> deleteAdmin({String? id}) async {
    try {
      final response = await _apiClient.deleteAdmin(id: id);
      return Message.fromJson(response);
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<Message> deleteStore({String? pinId}) async {
    try {
      final response = await _apiClient.deleteStore(pinId: pinId);
      return Message.fromJson(response);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<Message> deleteConstruction({String? pinId}) async {
    try {
      final response = await _apiClient.deleteConstruction(pinId: pinId);
      return Message.fromJson(response);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<Message> deletePinNote({String? pinId, String? noteId}) async {
    try {
      final response =
          await _apiClient.deletePinNote(pinId: pinId, noteId: noteId);
      return Message.fromJson(response);
    } on HttpFailure {
      throw PinFailure();
    } on HttpRequestFailure catch (e) {
      throw PinRequestFailure(e.toString());
    }
  }

  Future<List<Worker>> getWorkers({String? region}) async {
    try {
      final response = await _apiClient.getWorker(region: region);
      return response.map((value) => Worker.fromJson(value)).toList();
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<AdminDetails> getAdminDetails(String id) async {
    try {
      final response = await _apiClient.getAdminDetails(id);
      return AdminDetails.fromJson(response['data']);
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<Image>> getImages(
    String pinId, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiClient.getImages(
        pinId,
        page: page,
        limit: limit,
      );
      final images = response.map((e) => Image.fromJson(e)).toList();
      return images;
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<AdminDetails> getWorkerDetails(String id) async {
    try {
      final response = await _apiClient.getWorkerDetails(id);
      return AdminDetails.fromJson(response);
    } on HttpFailure {
      throw WorkerFailure();
    } on HttpRequestFailure catch (e) {
      throw WorkerRequestFailure(e.toString());
    }
  }

  Future<List<Visit>> getVisits(
    String pinId, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiClient.getVisits(
        pinId,
        page: page,
        limit: limit,
      );
      final visits = response.map((e) => Visit.fromJson(e)).toList();
      return visits;
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<List<Note>> getNotes(
    String pinId, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiClient.getNotes(
        pinId,
        page: page,
        limit: limit,
      );
      final notes = response
          .map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList();
      return notes;
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<ImportantNote> getImportantNotes(String pinId) async {
    try {
      log("important note:::");
      final response = await _apiClient.getImportantNotes(pinId);
      log("Important: ${jsonEncode(response)}");
      return ImportantNote.fromJson(response);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<Message> addPin({
    String? name,
    String? address,
    String? city,
    String? postalCode,
    String? company,
    String? potential,
    String? route,
    double? lat,
    double? lng,
    String? startDate,
    String? endDate,
    String? constructionPhase,
    List<String>? branches,
    String? type,
  }) async {
    try {
      final response = await _apiClient.createPin(
        name: name,
        address: address,
        city: city,
        postalCode: postalCode,
        company: company,
        potential: potential,
        route: route,
        routeType: type,
        cordinate: [lat!, lng!],
        startDate: startDate,
        endDate: endDate,
        constructionPhase: constructionPhase,
        branches: branches,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<List<Schedule>> getSchedules() async {
    try {
      final response = await _apiClient.getSchedules();
      return response.map((e) => Schedule.fromJson(e)).toList();
    } on HttpFailure {
      throw WorkerFailure();
    } on HttpRequestFailure catch (e) {
      throw WorkerRequestFailure(e.toString());
    }
  }

  Future<List<Schedule>> getUserSchedules(String userId) async {
    try {
      final response = await _apiClient.getUserSchedules(userId);
      final List<dynamic> schedules = response['schedules'] as List<dynamic>;
      return schedules.map((e) => Schedule.fromJson(e)).toList();
    } on HttpFailure {
      throw WorkerFailure();
    } on HttpRequestFailure catch (e) {
      throw WorkerRequestFailure(e.toString());
    }
  }

  Future<Message> addPlan({
    String? startDate,
    String? endDate,
    String? note,
    String? title,
    bool? allDay,
    String? deviceToken,
  }) async {
    try {
      final response = await _apiClient.createPlan(
        startDate: startDate,
        endDate: endDate,
        note: note,
        title: title,
        allDay: allDay,
        deviceToken: deviceToken,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw PlanFailure();
    } on HttpRequestFailure catch (e) {
      throw PlanRequestFailure(e.toString());
    }
  }

  Future<Message> addUserPlan({
    String? startDate,
    String? endDate,
    String? note,
    String? title,
    bool? allDay,
    String? deviceToken,
    String? userId,
  }) async {
    try {
      final response = await _apiClient.createUserPlan(
        startDate: startDate,
        endDate: endDate,
        note: note,
        title: title,
        allDay: allDay,
        userId: userId,
        deviceToken: deviceToken,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw PlanFailure();
    } on HttpRequestFailure catch (e) {
      throw PlanRequestFailure(e.toString());
    }
  }

  Future<Message> addRouteWorker({
    List<String>? workers,
    String? routeId,
  }) async {
    try {
      final response = await _apiClient.createRouteWorker(
        workers: workers,
        routeId: routeId,
      );
      return Message.fromJson(response!);
    } on HttpFailure {
      throw RouteFailure();
    } on HttpRequestFailure catch (e) {
      throw RouteRequestFailure(e.toString());
    }
  }

  Future<List<Worker>> allWorker() async {
    try {
      final response = await _apiClient.getWorkers();
      return response.map((e) => Worker.fromJson(e)).toList();
    } on HttpFailure {
      throw WorkerFailure();
    } on HttpRequestFailure catch (e) {
      throw WorkerRequestFailure(e.toString());
    }
  }

  Future<List<Region>> allRegions() async {
    try {
      final response = await _apiClient.getRegions();
      return response.map((e) => Region.fromJson(e)).toList();
    } on HttpFailure {
      throw RegionFailure();
    } on HttpRequestFailure catch (e) {
      throw RegionRequestFailure(e.toString());
    }
  }

  Future<List<RouteTypeStats>> regionDetails(String regionId) async {
    try {
      final response = await _apiClient.getRegionsDetails(regionId);
      return response.map((e) => RouteTypeStats.fromJson(e)).toList();
    } on HttpFailure {
      throw RegionFailure();
    } on HttpRequestFailure catch (e) {
      throw RegionRequestFailure(e.toString());
    }
  }

  Future<List<RouteTypeStats>> regionPinStats(String regionId) async {
    try {
      final response = await _apiClient.getRegionsStats(regionId);
      return response.map((e) => RouteTypeStats.fromJson(e)).toList();
    } on HttpFailure {
      throw RegionFailure();
    } on HttpRequestFailure catch (e) {
      throw RegionRequestFailure(e.toString());
    }
  }

  Future<List<RegionRoute>> regionRouteStats(String regionId) async {
    try {
      final response = await _apiClient.getRegionsRouteStats(regionId);
      return response.map((e) => RegionRoute.fromJson(e)).toList();
    } on HttpFailure {
      throw RegionFailure();
    } on HttpRequestFailure catch (e) {
      throw RegionRequestFailure(e.toString());
    }
  }

  Future<List<Admin>> allAdmin() async {
    try {
      final response = await _apiClient.getAdmins();
      return response.map((e) => Admin.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<Construction>> allConstruction() async {
    try {
      final response = await _apiClient.getConstruction();
      return response.map((e) => Construction.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<Industry>> allIndustry() async {
    try {
      final response = await _apiClient.getIndustry();
      return response.map((e) => Industry.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<RouteTypeStats>> routeTypeStats() async {
    try {
      final response = await _apiClient.getRouteTypeStats();
      return response.map((e) => RouteTypeStats.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<int> getWorkerRouteCount() async {
    try {
      final response = await _apiClient.getWorkerRouteCount();
      return response;
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<RouteTypeStats>> getRouteCount() async {
    try {
      final response = await _apiClient.getRouteCount();
      return response.map((e) => RouteTypeStats.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<RouteTypeStats>> pinPotentialStats() async {
    try {
      final response = await _apiClient.getPinPotentialStats();
      return response.map((e) => RouteTypeStats.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<RouteTypeStats>> regionStats() async {
    try {
      final response = await _apiClient.getRegionStats();
      return response.map((e) => RouteTypeStats.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<RouteTypeStats>> regionConstructionStats() async {
    try {
      final response = await _apiClient.getRegionConstructionStats();
      return response.map((e) => RouteTypeStats.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<BranchStats>> constructionBranchStats({String? year}) async {
    try {
      final response = await _apiClient.getConstructionBranchStats(year: year);
      return response.map((e) => BranchStats.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<BranchStats>> storeBranchStats({String? year}) async {
    try {
      final response = await _apiClient.getStoreBranchStats(year: year);
      return response.map((e) => BranchStats.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<BranchStats>> industryBranchStats({String? year}) async {
    try {
      final response = await _apiClient.getIndustryBranchStats(year: year);
      return response.map((e) => BranchStats.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<Construction>> allStore() async {
    try {
      final response = await _apiClient.getStore();
      return response.map((e) => Construction.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<Route>> allRoutes({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiClient.getRoutes(
        page: page,
        limit: limit,
      );
      return response.map((e) => Route.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }

  Future<List<Route>> allWorkerRoutes() async {
    try {
      final response = await _apiClient.getWorkerRoutes();
      return response.map((e) => Route.fromJson(e)).toList();
    } on HttpFailure {
      throw AdminFailure();
    } on HttpRequestFailure catch (e) {
      throw AdminRequestFailure(e.toString());
    }
  }
}
