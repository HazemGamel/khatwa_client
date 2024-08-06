import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/contants/api.dart';
import '../../../../core/services/cache_storage_services.dart';

class VerifyEmailAddressRepo {
  Future<Either<String, String>> clientVerifyPhoneCode(
      String phone, String verificationCode) async {
    try {
      final response = await http.post(
        verifyClientPhoneCodeUrl,
        body:
            jsonEncode({'phone': phone, 'code': verificationCode}),
        headers: authHeaders,
      );
      final result = jsonDecode(response.body);
      CacheStorageServices().setToken(result['token']);
      CacheStorageServices().setId(result['user']['_id']);
      if (response.statusCode == 200) {
        CacheStorageServices().setToken(result['token']);
        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> clientResendphoneCode(String phone) async {
    try {
      final response = await http.post(
        verifyClientResendEmailCodeUrl,
        body: jsonEncode({'phone': phone}),
        headers: authHeaders,
      );
      final result = jsonDecode(response.body);
      if (response.statusCode == 200||response.statusCode == 201) {
        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
