import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../../../core/contants/api.dart';

import '../../../../core/services/cache_storage_services.dart';

class ForgetPasswordRepo {
  Future<Either<String, String>>
  sendForgetPasswordVerificationCodeToPhone(
      String phone) async {
    try {
      final response = await http.post(
        sendForgetPasswordCodeUrl,
        body: jsonEncode({'phone': phone}),
        headers: authHeaders,
      );
      final result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>>
  reSendForgetPasswordVerificationCodeToPhone(
      String phone) async {
    try {
      final response = await http.post(
        reSendForgetPasswordCodeUrl,
        body: jsonEncode({'phone': phone}),
        headers: authHeaders,
      );

      final result = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> verifyClientForgetPasswordCode(
      String phone, int code) async {
    try {
      final response = await http.post(
        verifyClientForgetPasswordCodeUrl,
        body: jsonEncode({'phone': phone, 'code': code}),
        headers: authHeaders,
      );
      final result = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        CacheStorageServices().setToken(result['token']);
        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> sentNewPassword(String password) async {
    try {
      final response = await http.patch(
        sendNewPasswordUrl,
        body: jsonEncode({'password': password}),
        headers: authHeadersWithToken(CacheStorageServices().token),
      );
      final result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {

        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
