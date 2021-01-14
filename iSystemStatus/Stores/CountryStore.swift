import Foundation
import Sentry

class CountryStore {
    fileprivate static let fallbackCountry = Country(id: "en-US", name: "United States", language: "English")
    
    fileprivate static let countriesFile = "Countries"
    
    fileprivate static let countryFile = "Country"
    
    static func loadCountries() -> [Country] {
        if let countriesUrl = getFileUrl(for: countriesFile) {
            do {
                let data = try Data(contentsOf: countriesUrl)
                let decoder = PropertyListDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                return countries
            }
            catch {
                SentrySDK.capture(error: error)
                return [fallbackCountry]
            }
        } else {
            return [fallbackCountry]
        }
    }
    
    static func saveCountries(_ countries: [Country]) {
        if let countriesUrl = getFileUrl(for: countriesFile) {
            do {
                let encoder = PropertyListEncoder()
                let data = try encoder.encode(countries)
                try data.write(to: countriesUrl)
            }
            catch {
                SentrySDK.capture(error: error)
            }
        }
    }
    
    static func getDefaultCountry() -> Country {
        if let countryUrl = getFileUrl(for: countryFile), let data = try? Data(contentsOf: countryUrl) {
            do {
                let decoder = PropertyListDecoder()
                let country = try decoder.decode(Country.self, from: data)
                return country
            }
            catch {
                SentrySDK.capture(error: error)
                return fallbackCountry
            }
        } else {
            return fallbackCountry
        }
    }
    
    static func setDefaultCountry(_ country: Country) {
        if let countryUrl = getFileUrl(for: countryFile) {
            do {
                let encoder = PropertyListEncoder()
                let data = try encoder.encode(country)
                try data.write(to: countryUrl)
            } catch {
                SentrySDK.capture(error: error)
            }
        }
    }
    
    static func getFileUrl(for name: String) -> URL? {
        do {
            let directoryUrl = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("1.0")
            var isDirectory: ObjCBool = true
            if !FileManager.default.fileExists(atPath: directoryUrl.path, isDirectory: &isDirectory) {
                try FileManager.default.createDirectory(atPath: directoryUrl.path, withIntermediateDirectories: false, attributes: nil)
            }
            let fileUrl = directoryUrl.appendingPathComponent("\(name).plist")
            if !FileManager.default.fileExists(atPath: fileUrl.path) {
                FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
            }
            return fileUrl
        } catch {
            SentrySDK.capture(error: error)
            return nil
        }
    }
}
