class Api {
  static const baseUrl = "http://193.124.33.34:8876/api/v1";
  static const loginUrl = "/auth/login";
  static const registerUrl = "/auth/register";
  static const logoutUrl = "/auth/logout";
  static const refreshToken = "/auth/refresh-token";

  static const places = "/places";
  static getPlace(String id) => "/places/$id";
  static getPlaceReviews(String placeId) => "/places/$placeId/reviews";
  static createReview(String placeId) => "/places/$placeId/reviews";
  static const getPlaceFilters = "/places/filters";
  static const authMe = "/auth/me";
  static getConstructor(String userId) => "/users/$userId/constructor";
  static putConstructor(String userId) => "/users/$userId/constructor";

  static const routes = "/routes";
  static const users = "/users";
  static routesRoutesId(String routeId) => "/routes/$routeId";
  static favoriteRoutes(String userId) => "/users/$userId/favorite-routes";
  static favoriteRoutesRouteId(String userId, String routeId) => "/users/$userId/favorite-routes/$routeId";

  static const rating = "/rating";

  static getActiveRoute(String userId) => "/users/$userId/active-route";
}
