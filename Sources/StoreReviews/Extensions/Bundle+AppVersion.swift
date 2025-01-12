import Foundation

public extension Bundle {
    static var appVersion: String? {
        #if os(macOS)
        let key = "CFBundleShortVersionString"
        #else
        let key = "CFBundleVersion"
        #endif

        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
