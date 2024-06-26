class AuthException implements Exception {
  final String message;

  const AuthException({
    required this.message
  });

  @override
  String toString() {
    return "[AuthException] -> $message";
  }
}