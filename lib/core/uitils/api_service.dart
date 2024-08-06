import 'package:dio/dio.dart';

import '../errors/failuresreels.dart';


class DioHelper {
  static Dio _dio = Dio(
    BaseOptions(
        //connectTimeout: 6000,
        //receiveTimeout: 6000,

        ),
  );

  // Singleton pattern to ensure a single instance of DioHelper
  static Dio get instance {
    if (_dio == null) {
      _dio = Dio();
    }
    return _dio;
  }

  // Function to perform GET request
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await instance.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (error) {
      print("error is ${error.toString()}");
      throw ServerFailure(error.toString());
    }
  }

  // Function to perform POST request
  static Future<Response> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await instance.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      print("image ++ response");
      print(response);
      return response;
    } catch (error) {
      print(error.toString());
      throw ServerFailure(error.toString());
    }
  }

  // Function to perform PUT request
  static Future<Response> putData({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await instance.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (error) {
      print(error);
      throw ServerFailure(error.toString());
    }
  }

  // Function to perform PATCH/UPDATE request
  static Future<Response> updateData({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await instance.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (error) {
      print(error);
      throw ServerFailure(error.toString());
    }
  }
}
