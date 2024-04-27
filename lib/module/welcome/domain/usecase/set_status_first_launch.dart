import 'package:moreway/module/welcome/domain/dependency/i_launch_checker.dart';

class SetStatusFirstLaunchUseCase {
  final ILaunchChecker _launchChecker;

  SetStatusFirstLaunchUseCase(this._launchChecker);

  Future<void> execute(bool status) async {
    return _launchChecker.setFirstLaunch(status);
  }
}
