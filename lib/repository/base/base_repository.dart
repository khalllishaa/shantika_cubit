import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/dio.dart';

import '../../firebase/firebase_database.dart';
import '../../utility/resource/data_state.dart';

abstract class BaseRepository {
  final FirebaseDatabaseSender _firebaseDatabaseSender = FirebaseDatabaseSender();

  /// This method is responsible of handling the given `request`, in which
  /// it returns generic based `DataState`.
  ///
  /// Returns `DataSuccess` that holds the generic data `T` if the response
  /// is successfully recieved.
  ///
  /// Returns `DataFailed` that holds a `DioError` instance if any error occurs
  /// while sending the request or recieving the response.
  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataStateSuccess(httpResponse.data);
      } else if (httpResponse.response.statusCode == HttpStatus.created) {
        return DataStateSuccess(httpResponse.data);
      } else {
        throw DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          message: httpResponse.response.statusMessage,
        );
      }
    } on DioException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      try {
        _firebaseDatabaseSender.sendDioExceptionLog(dioException: error);
      } catch (e) {}
      return DataStateError(error);
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
      try {
        _firebaseDatabaseSender.sendErrorMessageLog(message: error.toString(), stackTrace: stackTrace.toString());
      } catch (e) {}
      final dioError = DioException(
        response: null,
        requestOptions: RequestOptions(),
        message: error.toString(),
      );
      return DataStateError(dioError);
    }
  }
}
