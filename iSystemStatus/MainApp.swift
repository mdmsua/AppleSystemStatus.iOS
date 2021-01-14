import SwiftUI
import Sentry

@main
struct MainApp: App {
    init() {
        guard let sentryDSN = Bundle.main.object(forInfoDictionaryKey: "Sentry DSN") as? String, sentryDSN.count > 0 else {
            return
        }
        SentrySDK.start { options in
            options.dsn = sentryDSN
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Preferences())
        }
    }
}
