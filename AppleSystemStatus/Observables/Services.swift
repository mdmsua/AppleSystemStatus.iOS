import Foundation
import Sentry

class Services: ObservableObject {
    @Published var services = [Service]()
    @Published var loading = true
    @Published var message: String?

    func getServices(for country: Country) {
        loading = true
        ApiClient.getServices(for: country.id) { (services: [Service]?, error: Error?) in
            DispatchQueue.main.async {
                self.loading = false
                if let error = error {
                    SentrySDK.capture(error: error)
                    self.message = error.localizedDescription
                } else if let services = services {
                    self.services.removeAll()
                    for service in services {
                        self.services.append(service)
                    }
                }
            }
        }
    }
}
