import Foundation

class Preferences: ObservableObject {
    @Published var country: Country = CountryStore.getDefaultCountry()
    func setCountry(_ country: Country) {
        self.country = country
        CountryStore.setDefaultCountry(country)
    }
}
