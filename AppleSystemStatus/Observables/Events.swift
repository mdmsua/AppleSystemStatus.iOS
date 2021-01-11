import Foundation
import Sentry

class Events: ObservableObject {
    @Published var events = [Event]()
    @Published var loading = false
    @Published var message: String?

    func getEvents(for service: Service) {
        loading = true
        ApiClient.getEvents(for: service.id) { (events: [Event]?, error: Error?) in
            DispatchQueue.main.async {
                self.loading = false
                if let error = error {
                    SentrySDK.capture(error: error)
                    self.message = error.localizedDescription
                } else if let events = events {
                    self.events.removeAll()
                    for event in events {
                        self.events.append(event)
                    }
                }
            }
        }
    }
}
