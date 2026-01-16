import 'package:flutter_test/flutter_test.dart';
import 'package:pulsenow_flutter/core/errors/app_exceptions.dart';

void main() {
  group('AppException', () {
    test('should create exception with message', () {
      // Arrange & Act
      const exception = NetworkException('Test error');

      // Assert
      expect(exception.message, 'Test error');
      expect(exception.toString(), 'Test error');
    });

    test('should include code and original error', () {
      // Arrange & Act
      final originalError = Exception('Original');
      final exception = NetworkException(
        'Test error',
        code: 'NETWORK_ERROR',
        originalError: originalError,
      );

      // Assert
      expect(exception.message, 'Test error');
      expect(exception.code, 'NETWORK_ERROR');
      expect(exception.originalError, originalError);
    });
  });

  group('NetworkException', () {
    test('should be instance of AppException', () {
      // Arrange & Act
      const exception = NetworkException('Network error');

      // Assert
      expect(exception, isA<AppException>());
    });
  });

  group('ApiException', () {
    test('should include status code', () {
      // Arrange & Act
      const exception = ApiException(
        'API error',
        statusCode: 404,
      );

      // Assert
      expect(exception.statusCode, 404);
      expect(exception, isA<AppException>());
    });
  });

  group('DataParsingException', () {
    test('should be instance of AppException', () {
      // Arrange & Act
      const exception = DataParsingException('Parsing error');

      // Assert
      expect(exception, isA<AppException>());
    });
  });

  group('CacheException', () {
    test('should be instance of AppException', () {
      // Arrange & Act
      const exception = CacheException('Cache error');

      // Assert
      expect(exception, isA<AppException>());
    });
  });

  group('WebSocketException', () {
    test('should be instance of AppException', () {
      // Arrange & Act
      const exception = WebSocketException('WebSocket error');

      // Assert
      expect(exception, isA<AppException>());
    });
  });
}
