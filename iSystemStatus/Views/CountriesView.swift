import SwiftUI

struct CountriesView: View {
    @EnvironmentObject var preferences: Preferences
    @ObservedObject var countries = Countries()
    var body: some View {
        VStack {
            Text("your_country")
                .font(.headline)
            List {
                ForEach(countries.countries) {
                    country in
                    Button(action: {
                        preferences.setCountry(country)
                    }) {
                        HStack {
                            Image("\(country.id)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("\(country.name) (\(country.language))")
                            if country.id == preferences.country.id {
                                Spacer()
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView().environmentObject(Preferences())
    }
}
