class Api {
  static const baseUrl = "http://193.124.33.34:8876/api/v1";
  static const loginUrl = "/auth/login";
  static const registerUrl = "/auth/register";
  static const logoutUrl = "/auth/logout";
  static const refreshToken = "/auth/refresh-token";

  static const places = "/places";
  static getPlace(String id) => "/places/$id";
  static const getPlaceFilters = "/places/filters";
  static const authMe = "/auth/me";
}
