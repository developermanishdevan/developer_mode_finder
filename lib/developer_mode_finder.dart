import 'developer_mode_finder_platform_interface.dart';

class DeveloperModeFinder {
  Future<bool> isDeveloperModeEnabled() {
    return DeveloperModeFinderPlatform.instance.isDeveloperModeEnabled();
  }
}
