abstract class ILaunchChecker {
  bool isFirstLaunch();
  Future<void> setFirstLaunch(bool status);
}