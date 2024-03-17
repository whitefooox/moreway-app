class AuthValidator {
  static bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  static bool isPasswordValid(String email) {
    return RegExp(r'^.{8,}$').hasMatch(email);
  }

  static bool isUsernameValid(String username) {
    return RegExp(r'^[\p{L}\p{N}]+$', unicode: true).hasMatch(username);
  }
}