import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'developer_mode_finder_method_channel.dart';

abstract class DeveloperModeFinderPlatform extends PlatformInterface {
  /// Constructs a DeveloperModeFinderPlatform.
  DeveloperModeFinderPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeveloperModeFinderPlatform _instance =
      MethodChannelDeveloperModeFinder();

  /// The default instance of [DeveloperModeFinderPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeveloperModeFinder].
  static DeveloperModeFinderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeveloperModeFinderPlatform] when
  /// they register themselves.
  static set instance(DeveloperModeFinderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isDeveloperModeEnabled() {
    throw UnimplementedError(
      'isDeveloperModeEnabled() has not been implemented.',
    );
  }
}
