import 'package:moreway/module/welcome/domain/dependency/i_launch_checker.dart';

class CheckFirstLaunchUseCase {
  final ILaunchChecker _launchChecker;

  CheckFirstLaunchUseCase(this._launchChecker);

  bool execute() {
    return _launchChecker.isFirstLaunch();
  }
}
