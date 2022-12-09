// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Failure {
  int? statusCode;
  String message;

  Failure({
    this.statusCode,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'message': message,
    };
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      statusCode: map['statusCode'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source) as Map<String, dynamic>);
}

//just to decode and return json if response body is in json format, else it will return failure with message, Error.
Either<Map<String, dynamic>, Failure> decodeJson(Response response) {
  List statusCodeList = [
    200,
    201,
    202,
    203,
    204,
    205,
    206,
  ];
  try {
    if (statusCodeList.any((element) => element == response.statusCode)) {
      return Left(
        response.data['data'],
      );
    } else {
      return Right(
        Failure(
            message: response.data['message'], statusCode: response.statusCode),
      );
    }
  } catch (e) {
    return Right(
      Failure(
          message: response.data['message'], statusCode: response.statusCode),
    );
  }
}
