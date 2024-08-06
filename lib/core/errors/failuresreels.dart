import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.sendTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioErrorType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioErrorType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response?.statusCode, dioError.response?.data);
      case DioErrorType.cancel:
        return ServerFailure('Request to ApiServer was canceled');

      case DioErrorType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 409) {
      return ServerFailure(response['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
