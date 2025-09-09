import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:developer_mode_finder/developer_mode_finder_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelDeveloperModeFinder platform =
      MethodChannelDeveloperModeFinder();
  const MethodChannel channel = MethodChannel('developer_mode_finder');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'isDeveloperModeEnabled') {
            return true; // Return boolean instead of string
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('isDeveloperModeEnabled returns true', () async {
    expect(await platform.isDeveloperModeEnabled(), true);
  });

  test('isDeveloperModeEnabled returns false when null', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'isDeveloperModeEnabled') {
            return null; // Simulate null response
          }
          return null;
        });

    expect(await platform.isDeveloperModeEnabled(), false);
  });
}
