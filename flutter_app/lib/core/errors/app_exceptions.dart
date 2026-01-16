/// Custom exception classes for better error handling
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException(
    this.message, {
    this.code,
    this.originalError,
  });

  @override
  String toString() => message;
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException(
    super.message, {
    super.code,
    super.originalError,
  });
}

/// API-related exceptions
class ApiException extends AppException {
  final int? statusCode;

  const ApiException(
    super.message, {
    super.code,
    this.statusCode,
    super.originalError,
  });
}

/// Data parsing exceptions
class DataParsingException extends AppException {
  const DataParsingException(
    super.message, {
    super.code,
    super.originalError,
  });
}

/// Cache-related exceptions
class CacheException extends AppException {
  const CacheException(
    super.message, {
    super.code,
    super.originalError,
  });
}

/// WebSocket-related exceptions
class WebSocketException extends AppException {
  const WebSocketException(
    super.message, {
    super.code,
    super.originalError,
  });
}

