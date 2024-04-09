import 'package:injectable/injectable.dart';
import 'package:moreway/module/welcome/domain/dependency/i_launch_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: ILaunchChecker)
class LaunchChecker implements ILaunchChecker {

  final SharedPreferences _preferences;
  final String key = "first_launch";

  LaunchChecker(this._preferences);

  @override
  bool isFirstLaunch() {
    return _preferences.getBool(key) ?? true;
  }
  
  @override
  Future<void> setFirstLaunch(bool status) async {
    await _preferences.setBool(key, status);
  }
}