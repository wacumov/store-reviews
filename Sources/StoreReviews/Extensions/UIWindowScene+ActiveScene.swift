import SwiftUI

#if os(iOS)
public extension UIWindowScene {
    static func getActiveScene() -> UIWindowScene? {
        let scenes: [UIWindowScene] = UIApplication.shared.connectedScenes.compactMap {
            guard
                $0.activationState == .foregroundActive,
                let scene = $0 as? UIWindowScene
            else {
                return nil
            }
            return scene
        }
        return scenes.first
    }
}
#endif
