import Flutter
import UIKit

public class DeveloperModeFinderPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "developer_mode_finder", binaryMessenger: registrar.messenger())
        let instance = DeveloperModeFinderPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isDeveloperModeEnabled":
            let isEnabled = isDeveloperModeEnabled()
            result(isEnabled)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func isDeveloperModeEnabled() -> Bool {
        // Check if the device is jailbroken (closest equivalent to Android's developer mode)
        return isJailbroken() || isSimulator()
    }
    
    private func isJailbroken() -> Bool {
        // Check for common jailbreak files and directories
        let jailbreakPaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/",
            "/Applications/blackra1n.app",
            "/Applications/FakeCarrier.app",
            "/Applications/Icy.app",
            "/Applications/IntelliScreen.app",
            "/Applications/MxTube.app",
            "/Applications/RockApp.app",
            "/Applications/SBSettings.app",
            "/Applications/WinterBoard.app"
        ]
        
        for path in jailbreakPaths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        // Try to write to a restricted area
        do {
            let text = "jailbreak test"
            try text.write(toFile: "/private/test.txt", atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: "/private/test.txt")
            return true
        } catch {
            // Expected for non-jailbroken devices
        }
        
        return false
    }
    
    private func isSimulator() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
}
