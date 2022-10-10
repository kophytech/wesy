import 'dart:convert';
import 'dart:io';

import 'package:api_client/src/api_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class HttpFailure implements Exception {}

class HttpRequestFailure implements Exception {
  HttpRequestFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

const baseUrl =
    (1 == 1) ? 'https://api.wesy.ch' : 'http://wesy-api.herokuapp.com';

/// {@template api_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}
  ApiClient({Dio? dio})
      : _dio = (dio ?? Dio())
          ..interceptors.add(ApiInterceptor())
          ..options.baseUrl = baseUrl;

  final Dio _dio;

  Future<Map<String, dynamic>?> login({String? email, String? password}) async {
    try {
      print(jsonEncode({'email': email, 'password': password}));
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: jsonEncode({'email': email, 'password': password}),
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createAdmin({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? region,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/users/create-admin',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: {
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'password': password,
          'region': region,
        },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> addBroadcast({
    String? note,
    String? startDate,
    String? endDate,
    String? title,
    List<String>? users,
  }) async {
    try {
      final data = {
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'notes': note,
        'users': users
      };
      final response = await _dio.post<Map<String, dynamic>>(
        '/schedule/broadcast',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: data,
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> editAdmin(
      {String? email,
      String? firstName,
      String? lastName,
      String? password,
      String? region,
      String? id}) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/auth/users/update/admin?id=$id',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: password!.isEmpty
            ? {
                'email': email,
                'firstName': firstName,
                'lastName': lastName,
                'region': region,
              }
            : {
                'email': email,
                'firstName': firstName,
                'lastName': lastName,
                'password': password,
                'region': region,
              },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createWorker({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? region,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/users/create-worker',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: region!.isEmpty
            ? {
                'email': email,
                'firstName': firstName,
                'lastName': lastName,
                'password': password,
              }
            : {
                'email': email,
                'firstName': firstName,
                'lastName': lastName,
                'password': password,
                'region': region,
              },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> editWorker({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? region,
    String? id,
  }) async {
    try {
      print({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'region': region,
      });
      final response = await _dio.patch<Map<String, dynamic>>(
        '/auth/users/update/worker?id=$id',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: password!.isEmpty
            ? {
                'email': email,
                'firstName': firstName,
                'lastName': lastName,
                'region': region,
              }
            : {
                'email': email,
                'firstName': firstName,
                'lastName': lastName,
                'password': password,
                'region': region,
              },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getWorkers() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/auth/users/fetch/all-workers',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> getRouteDetails({String? routeId}) async {
    try {
      print(routeId);
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/route-details?id=$routeId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      print(response.data!['data']);
      return response.data!['data'] as Map<String, dynamic>;
    } on DioError catch (e) {
      print(e.response);
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> getPinDetails({String? pinId}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/pin-details?pinId=$pinId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as Map<String, dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> uploadImage({
    required List<File> images,
    required String pinId,
  }) async {
    try {
      final postImages = <MultipartFile>[];

      for (var i = 0; i < images.length; i++) {
        final postImage = images[i];
        final fileName = postImage.path.split('/').last;
        final mimeTypeData =
            lookupMimeType(postImage.path, headerBytes: [0xFF, 0xD8])!
                .split('/');
        final imageFile = await MultipartFile.fromFile(
          postImage.path,
          filename: fileName,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        );
        postImages.add(imageFile);
      }

      final formData = FormData.fromMap(<String, dynamic>{});
      for (final element in postImages) {
        formData.files.add(
          MapEntry(
            'images',
            element,
          ),
        );
      }
      final response = await _dio.post<Map<String, dynamic>>(
        '/routes/update/add-images?pinId=$pinId',
        data: formData,
        options: Options(
          headers: <String, dynamic>{
            'hasToken': true,
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deletePinVisit(
      {String? pinId, String? visitId}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/routes/update/delete-visit?pinId=$pinId&visitId=$visitId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deletePinImage(
      {String? pinId, String? imgId}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/routes/update/delete-image?pinId=$pinId&imgId=$imgId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deletePinNote(
      {String? pinId, String? noteId}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/routes/update/delete-note?pinId=$pinId&noteId=$noteId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deleteRouteLocation({String? pinId}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/routes/delete/pin?pinId=$pinId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deleteIndustry({String? pinId}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/routes/delete/pin?pinId=$pinId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deleteRoute({String? routeId}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/routes/delete?id=$routeId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deleteAdmin({String? id}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/auth/users/delete/admin?id=$id',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deleteStore({String? pinId}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/routes/delete/pin?pinId=$pinId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deleteConstruction({String? pinId}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/routes/delete/pin?pinId=$pinId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deleteWorker({String? id}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/auth/users/delete/worker?id=$id',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> deleteRouteWorker(
      {String? workerId, String? routeId}) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/routes/update/remove-worker?routeId=$routeId&workerId=$workerId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getWorker({String? region}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/auth/users/fetch/all-workers-from-region?region=$region',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      print(response.data);
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> getAdminDetails(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/auth/users/fetch/admin?id=$id',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> getWorkerDetails(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/auth/users/fetch/worker?id=$id',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as Map<String, dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getVisits(
    String pinId, {
    int? page,
    int? limit,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/visits?pinId=$pinId&page=$page&limit=$limit',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getImages(
    String pinId, {
    int? page,
    int? limit,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/images?pinId=$pinId&page=$page&limit=$limit',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getNotes(
    String pinId, {
    int? page,
    int? limit,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/notes?pinId=$pinId&page=$page&limit=$limit',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      print(response.data);
      return response.data!['data'] as List;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> getImportantNotes(String pinId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/important-note?pinId=$pinId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as Map<String, dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getSchedules() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/schedule/get-schedules',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>> getUserSchedules(String userId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/schedule/get-schedules-for-user?userId=$userId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as Map<String, dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getRegions() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/all-regions',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getRegionsDetails(String regionId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/get-route-type-percentage-for-region?id=$regionId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getRegionsStats(String regionId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/pins-grouped-according-to-potential-for-region?id=$regionId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getRegionsRouteStats(String regionId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/routes-in-region?id=$regionId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      print(response.data);
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createRegion({
    String? name,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/routes/regions/new',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: {
          'name': name,
        },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> reArrangePin(
      {List<String>? pin, String? routeId}) async {
    try {
      print(routeId);
      print(jsonEncode({'pins': pin}));
      final response = await _dio.patch<Map<String, dynamic>>(
        '/routes/update/rearrange-pins?routeId=$routeId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: jsonEncode({'pins': pin}),
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createRoute({
    String? name,
    String? region,
    String? type,
    bool? hasRegion,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/routes/new/$type',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: hasRegion!
            ? {
                'name': name,
                'createdBy': region,
              }
            : {
                'name': name,
              },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw HttpRequestFailure(
            e.response!.data != null
                ? (e.response!.data as Map<String, dynamic>)['message']
                    as String
                : 'Something went wrong, Try again later',
          );
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createPinVisit({
    String? date,
    String? note,
    String? pinId,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/routes/update/add-visit?pinId=$pinId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: date!.isEmpty
            ? {
                'note': note,
                'date': DateTime.now().toIso8601String(),
              }
            : {
                'note': note,
                'date': date,
              },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        if (e.response!.statusCode == 400) {
          throw HttpRequestFailure(
            e.response!.data != null
                ? (e.response!.data as Map<String, dynamic>)['message']
                    as String
                : 'Something went wrong, Try again later',
          );
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createPinInformation({
    String? note,
    String? pinId,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/routes/update/important-note?pinId=$pinId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: {
          'note': note,
        },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        if (e.response!.statusCode == 400) {
          throw HttpRequestFailure(
            e.response!.data != null
                ? (e.response!.data as Map<String, dynamic>)['message']
                    as String
                : 'Something went wrong, Try again later',
          );
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createPinNote({
    String? note,
    String? pinId,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/routes/update/add-note?pinId=$pinId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: {
          'note': note,
        },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw HttpRequestFailure(
            e.response!.data != null
                ? (e.response!.data as Map<String, dynamic>)['message']
                    as String
                : 'Something went wrong, Try again later',
          );
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createPlan({
    String? title,
    String? startDate,
    String? endDate,
    bool? allDay,
    String? note,
    String? deviceToken,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/schedule/new',
        options: Options(
          headers: <String, dynamic>{
            'hasToken': true,
            'x-registration-token': deviceToken
          },
        ),
        data: {
          'title': title,
          'startDate': startDate,
          'endDate': endDate,
          'allDay': allDay,
          'notes': note,
        },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw HttpRequestFailure(
            e.response!.data != null
                ? (e.response!.data as Map<String, dynamic>)['message']
                    as String
                : 'Something went wrong, Try again later',
          );
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createUserPlan({
    String? title,
    String? startDate,
    String? endDate,
    bool? allDay,
    String? note,
    String? userId,
    String? deviceToken,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/schedule/create-schedule-for-user?userId=$userId',
        options: Options(
          headers: <String, dynamic>{
            'hasToken': true,
            'x-registration-token': deviceToken
          },
        ),
        data: {
          'title': title,
          'startDate': startDate,
          'endDate': endDate,
          'allDay': allDay,
          'notes': note,
        },
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        if (e.response!.statusCode == 400) {
          throw HttpRequestFailure(
            e.response!.data != null
                ? (e.response!.data as Map<String, dynamic>)['message']
                    as String
                : 'Something went wrong, Try again later',
          );
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createPin({
    String? name,
    String? address,
    String? city,
    String? postalCode,
    String? company,
    String? potential,
    String? route,
    List<double>? cordinate,
    String? startDate,
    String? endDate,
    String? constructionPhase,
    List<String>? branches,
    String? routeType,
  }) async {
    try {
      print(routeType!.toLowerCase() == 'construction');
      final pinData = routeType.toLowerCase() == 'construction'
          ? {
              'name': name,
              'address': address,
              'city': city,
              'company': company,
              'coordinates': cordinate,
              'postalCode': postalCode,
              'potential': potential,
              'branches': branches,
              'constructionPhase': constructionPhase,
              'startDate': startDate,
              'finishDate': endDate
            }
          : {
              'name': name,
              'address': address,
              'city': city,
              'company': company,
              'coordinates': cordinate,
              'postalCode': postalCode,
              'potential': potential,
            };
      print(pinData);
      final response = await _dio.patch<Map<String, dynamic>>(
        '/routes/update/route/add-pin?routeId=$route',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: jsonEncode(pinData),
      );
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw HttpRequestFailure(
            e.response!.data != null
                ? (e.response!.data as Map<String, dynamic>)['message']
                    as String
                : 'Something went wrong, Try again later',
          );
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<Map<String, dynamic>?> createRouteWorker({
    List<String>? workers,
    String? routeId,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/routes/update/add-workers?routeId=$routeId',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
        data: {'workers': workers},
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw HttpRequestFailure(
            e.response!.data != null
                ? (e.response!.data as Map<String, dynamic>)['message']
                    as String
                : 'Something went wrong, Try again later',
          );
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getAdmins() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/auth/users/fetch/all-admins',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getRouteTypeStats() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/get-route-type-percentage',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<int> getWorkerRouteCount() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/get-worker-routes-count',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as int;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List> getRouteCount() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/get-route-type-percentage',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      print(response.data!['data']);
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getPinPotentialStats() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/pins-grouped-according-to-potential',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getRegionStats() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/regions-with-highest-concentration/store',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getRegionConstructionStats() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/regions-with-highest-concentration/construction',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getConstructionBranchStats({String? year}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/branch-visit-count/construction?year=$year',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getIndustryBranchStats({String? year}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/branch-visit-count/industry?year=$year',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getStoreBranchStats({String? year}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/stats/branch-visit-count/store?year=$year',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getConstruction() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/pins/construction',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getIndustry() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/pins/industry',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getStore() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/pins/store',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getRoutes({
    int? page,
    int? limit,
  }) async {
    try {
      print('/routes/fetch/all?page=$page&limit=$limit');
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/all?page=$page&limit=$limit',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      print(response.data);
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }

  Future<List<dynamic>> getWorkerRoutes() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/routes/fetch/worker-routes',
        options: Options(
          headers: <String, dynamic>{'hasToken': true},
        ),
      );
      return response.data!['data'] as List<dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == HttpStatus.badRequest) {
          throw HttpRequestFailure(e.response!.data['message'].toString());
        }
        throw HttpFailure();
      }
      throw HttpFailure();
    }
  }
}
