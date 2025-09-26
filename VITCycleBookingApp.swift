import SwiftUI

@main
struct VITCycleBookingApp: App {
    var body: some Scene {
        WindowGroup {
            if DataManager.shared.loadUser() == nil {
                LoginView()
            } else {
                MainTabView()
            }
        }
    }
}
