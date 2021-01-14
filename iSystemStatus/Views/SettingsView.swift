import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var preferences: Preferences
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("country")) {
                    NavigationLink(destination: CountriesView()) {
                        HStack {
                            Image("\(preferences.country.id)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("\(preferences.country.name)")
                        }
                    }
                }
            }.navigationBarTitle("settings").listStyle(GroupedListStyle())
        }.tabItem {
            VStack{
                Image(systemName: "gearshape.fill")
                Text(LocalizedStringKey("settings"))
            }
        }.tag(2)

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


