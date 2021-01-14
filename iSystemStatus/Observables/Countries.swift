import Foundation
import Sentry

class Countries: ObservableObject {
    @Published var countries: [Country] = CountryStore.loadCountries()
    
    init() {
        if countries.count == 1 {
            ApiClient.getCountries { (countries: [Country]?, error) in
                if let error = error {
                    SentrySDK.capture(error: error)
                } else if let countries = countries {
                    DispatchQueue.main.async {
                        self.countries.removeAll()
                        for country in countries {
                            self.countries.append(country)
                        }
                    }
                    CountryStore.saveCountries(countries)
                }
            }
        }
    }
}
