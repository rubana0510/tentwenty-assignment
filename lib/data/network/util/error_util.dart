import 'package:flutter/cupertino.dart';
import 'base_response.dart';

class ErrorUtil {
  static const DEFAULT_ERROR_MESSAGE = "Something went wrong";
  static const _NO_INTERNET_ERROR_MESSAGE = "No internet connection";
  static const _TIMEOUT_ERROR_MESSAGE =
      "Please check your internet connection. It is taking too long to connect.";

  static const VERSION_NOT_SUPPORTED = 'VERSION_NOT_SUPPORTED';


  static String getErrorMessageFromTypeCode(ErrorType type, String? code) {
    switch (type) {
      case ErrorType.timeout:
        return _TIMEOUT_ERROR_MESSAGE;
      case ErrorType.noConnection:
        return _NO_INTERNET_ERROR_MESSAGE;
      case ErrorType.apiFailure:
        return _errorMessages[code] ?? DEFAULT_ERROR_MESSAGE;
      default:
        return DEFAULT_ERROR_MESSAGE;
    }
  }



  static Map<String, String> _errorMessages = {
    "USER_NOT_FOUND": "Incorrect phone or password",
    "INVALID_PASSWORD": "Incorrect phone or password",
    "OTP_LIMIT_REACHED": "OTP request limit reached. Please try again later",
    "USER_EXISTS": "You are already registered. Please login into system",
    "LIMIT_REACHED": "Sorry, you cannot post more",
    "INVALID_OTP": "You have entered invalid OTP",
    "NO_DATA_FOUND": "Something went wrong, please try again",
  };
}
