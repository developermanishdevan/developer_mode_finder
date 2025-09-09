import 'package:flutter_test/flutter_test.dart';
import 'package:developer_mode_finder/developer_mode_finder.dart';
import 'package:developer_mode_finder/developer_mode_finder_platform_interface.dart';
import 'package:developer_mode_finder/developer_mode_finder_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeveloperModeFinderPlatform
    with MockPlatformInterfaceMixin
    implements DeveloperModeFinderPlatform {
  @override
  Future<bool> isDeveloperModeEnabled() => Future.value(true);
}

void main() {
  final DeveloperModeFinderPlatform initialPlatform =
      DeveloperModeFinderPlatform.instance;

  test('$MethodChannelDeveloperModeFinder is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeveloperModeFinder>());
  });

  test('isDeveloperModeEnabled returns true', () async {
    DeveloperModeFinder developerModeFinderPlugin = DeveloperModeFinder();
    MockDeveloperModeFinderPlatform fakePlatform =
        MockDeveloperModeFinderPlatform();
    DeveloperModeFinderPlatform.instance = fakePlatform;

    expect(await developerModeFinderPlugin.isDeveloperModeEnabled(), true);
  });

  test('isDeveloperModeEnabled returns false', () async {
    DeveloperModeFinder developerModeFinderPlugin = DeveloperModeFinder();

    // Create a mock that returns false
    MockDeveloperModeFinderPlatform fakePlatform =
        MockDeveloperModeFinderPlatformFalse()
            as MockDeveloperModeFinderPlatform;
    DeveloperModeFinderPlatform.instance = fakePlatform;

    expect(await developerModeFinderPlugin.isDeveloperModeEnabled(), false);
  });
}

class MockDeveloperModeFinderPlatformFalse
    with MockPlatformInterfaceMixin
    implements DeveloperModeFinderPlatform {
  @override
  Future<bool> isDeveloperModeEnabled() => Future.value(false);
}
