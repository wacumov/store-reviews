import StoreKit
import SwiftUI

#if os(iOS)
public enum Reviews {
    public static let daysBetweenPrompts: Double = 2

    private static let lastVersionPromptedForReviewKey = "lastVersionPromptedForReviewKey"
    private static let lastPromptedDateKey = "lastPromptedDateKey"

    private static var currentVersion: String {
        Bundle.appVersion ?? "1"
    }

    @available(iOS 14.0, *)
    @MainActor public static func requestIfNeeded() {
        guard
            !hasRequestedForCurrentVersion(),
            !hasRequestedRecently()
        else {
            return
        }
        request()
    }

    @available(iOS 14.0, *)
    @MainActor private static func request() {
        guard
            let scene = UIWindowScene.getActiveScene()
        else {
            return
        }
        SKStoreReviewController.requestReview(in: scene)
        UserDefaults.standard.set(currentVersion, forKey: lastVersionPromptedForReviewKey)
        UserDefaults.standard.set(Date(), forKey: lastPromptedDateKey)
    }

    @MainActor public static func requestManually(appID: String) {
        guard let url = URL(string: "https://apps.apple.com/app/id\(appID)?action=write-review") else {
            return
        }
        UIApplication.shared.open(url)
    }

    private static func hasRequestedForCurrentVersion() -> Bool {
        let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: lastVersionPromptedForReviewKey) ?? ""
        return currentVersion == lastVersionPromptedForReview
    }

    private static func hasRequestedRecently() -> Bool {
        guard let lastPromptedDate = UserDefaults.standard.object(forKey: lastPromptedDateKey) as? Date else {
            return false
        }
        let intervalSinceLastPrompt = Date().timeIntervalSince(lastPromptedDate)
        let daysSinceLastPrompt = intervalSinceLastPrompt / (60 * 60 * 24)
        return daysSinceLastPrompt < daysBetweenPrompts
    }
}
#endif
