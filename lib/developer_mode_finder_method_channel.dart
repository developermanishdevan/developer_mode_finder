import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'developer_mode_finder_platform_interface.dart';

/// An implementation of [DeveloperModeFinderPlatform] that uses method channels.
class MethodChannelDeveloperModeFinder extends DeveloperModeFinderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('developer_mode_finder');

  @override
  Future<bool> isDeveloperModeEnabled() async {
    final isEnabled = await methodChannel.invokeMethod<bool>(
      'isDeveloperModeEnabled',
    );
    return isEnabled ?? false;
  }
}
