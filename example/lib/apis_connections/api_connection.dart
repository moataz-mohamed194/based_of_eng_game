import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as di;
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MainApiConnection {
  //Singleton
  MainApiConnection() {
    // Attach Interceptors.
    if (kDebugMode) dio.interceptors.add(_logger);
  }

  // static final ApiProvider instance = ApiProvider._();

  // Http Client
  final Dio dio = Dio();

  // Logger
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    error: true,
  );

  // Performance Interceptor

  // Headers
  static const Map<String, dynamic> apiHeaders = <String, dynamic>{
    'Accept': 'application/json'
  };

  ////////////////////////////// END POINTS ///////////////////////////////////
  String getGameInfoDataEndPoint = "game/game_info";
  String postLoginEndPoint = "auth/login";
  String makeParentPin = "auth/makeParentPin";
  String updateUserEndPoint = "auth/updateProfile";
  String getUserEndPoint = "getuserdata";
  String getStudentProgramsEndPoint = "student_programs";
  String getUnitsOfProgramsEndPoint = "units";
  String getStudentProgramsTestEndPoint = "student_programs_test";
  String getStudentReportsTestEndPoint = "student_progress";
  String getLessonsOfProgramsEndPoint = "lessons";
  String getLessonQuestionsEndPoint = "game";
  String getGameById = "gamebyId";
  String sendSolveData = "solveData";
  String getStudentAssignments = "studentAssignments";

////////////////////////////////////////////////////////////////////////////

  // Validating Request.
  bool validResponse(di.Response response) {
    int? statusCode = response.statusCode;
    bool? result = response.data['status'];
    if (statusCode == null || result == false) {
      return false;
    } else {
      return (statusCode >= 200 && statusCode < 300);
    }
  }
////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////// UTILS /////////////////////////////////////

  static Future<String> _getAppLanguage() async {
    return 'ar';
  }

  Future<String?> _getUserToken() async =>
      // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FtYmVybm9hay5jby51ay9GaWxsYW1lbnQvcHVibGljL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzE5MjI2NTQ1LCJleHAiOjE3MjEzODY1NDUsIm5iZiI6MTcxOTIyNjU0NSwianRpIjoiVHU5RXN6bTdlQXBZZkpDdCIsInN1YiI6IjUxIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.gKL6PXVXP_hRtZfZDclWPDy3_BgKlIweM6-DdhV5q8M';
  'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FtYmVybm9hay5jby51ay9GaWxsYW1lbnQvcHVibGljL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzE5OTE2NDg2LCJleHAiOjE3MjIwNzY0ODYsIm5iZiI6MTcxOTkxNjQ4NiwianRpIjoiektVQUpxS1Yzc3R0V09UNyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.5w5sipi3nMRjLd4A1u4ILlP9SW4aD1QWZMyiotDBQ8o';

  Future<di.Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    String language = await _getAppLanguage();
    String? token = await _getUserToken();

    di.Response response = await dio.get(
      url,
      queryParameters: queryParameters,
      options: dioOptions(language, token),
    );

    if (validResponse(response)) {
      return response;
    } else {
      throw response;
    }
  }

  Future<di.Response<dynamic>> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, String?>? headers,
  }) async {
    String language = await _getAppLanguage();
    String? token = await _getUserToken();

    final response = await dio.post(
      url,
      queryParameters: queryParameters,
      data: data,
      options: dioOptions(language, token),
    );
    if (validResponse(response)) {
      return response;
    } else {
      throw response;
    }
  }

  // TODO DIO uploadImage
  Future<http.Response> uploadImage({
    required String url,
    File? filePath,
    Map<String, String>? queryParameters,
    Map<String, String>? data,
    Map<String, String?>? headers,
  }) async {
    String? token = await _getUserToken();
    var multipartFile;
    var stream;
    var length;
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );
    request.headers['AUTHORIZATION'] = 'Bearer ${token!}';
    request.headers['Accept'] = "application/json";
    data?.forEach((key, value) {
      request.fields[key] = value;
    });
    if (filePath != null) {
      stream = http.ByteStream(DelegatingStream.typed(filePath.openRead()));
      length = await filePath.length();
      multipartFile = http.MultipartFile('photo', stream, length,
          filename: basename(filePath.path));
      request.files.add(multipartFile);
    }
    StreamedResponse response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    var bodyData = json.decode(res.body);
    debugPrint('result11${bodyData['result']}');
    debugPrint('result11$bodyData');
    if (bodyData['result'] != null && res.statusCode == 200) {
      return res;
    } else {
      throw res;
    }
  }

  Options dioOptions(String language, String? token,
      [Map<String, String?>? headers]) {
    return Options(
      // contentType: 'application/json',
      headers: {
        ...headers ?? apiHeaders,
        'Authorization': 'Bearer $token',
      },
    );
  }
}
