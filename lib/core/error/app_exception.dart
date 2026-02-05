/// Base exception class for app-specific errors
sealed class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'AppException($code): $message';
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// No internet connection
class NoConnectionException extends NetworkException {
  const NoConnectionException()
      : super(
          message: 'No internet connection',
          code: 'NO_CONNECTION',
        );
}

/// Request timeout
class AppTimeoutException extends NetworkException {
  const AppTimeoutException({String? operation})
      : super(
          message: operation != null
              ? 'Request timed out: $operation'
              : 'Request timed out',
          code: 'TIMEOUT',
        );
}

/// Server returned an error response
class ServerException extends NetworkException {
  final int? statusCode;

  const ServerException({
    required super.message,
    this.statusCode,
    super.originalError,
  }) : super(code: 'SERVER_ERROR');
}

/// Cache-related exceptions
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code = 'CACHE_ERROR',
    super.originalError,
  });
}

/// Storage-related exceptions
class StorageException extends AppException {
  const StorageException({
    required super.message,
    super.code = 'STORAGE_ERROR',
    super.originalError,
  });
}

/// Secure storage exceptions
class SecureStorageException extends StorageException {
  const SecureStorageException({
    required super.message,
    super.originalError,
  }) : super(code: 'SECURE_STORAGE_ERROR');
}

/// Credential-related exceptions
class CredentialException extends AppException {
  const CredentialException({
    required super.message,
    super.code = 'CREDENTIAL_ERROR',
    super.originalError,
  });
}

/// Credentials not found or not initialized
class CredentialNotFoundException extends CredentialException {
  const CredentialNotFoundException()
      : super(
          message: 'Google credentials not found. Please configure credentials.',
          code: 'CREDENTIALS_NOT_FOUND',
        );
}
