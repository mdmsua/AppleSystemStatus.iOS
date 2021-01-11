import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ServicesView().tabItem {
                VStack{
                    Image(systemName: "staroflife.fill")
                    Text(LocalizedStringKey("services"))
                }
            }.tag(1)
            CountriesView().tabItem {
                VStack{
                    Image(systemName: "globe")
                    Text(LocalizedStringKey("country"))
                }
            }.tag(2)
            AboutView().tabItem {
                VStack{
                    Image(systemName: "info")
                    Text("about")
                }
            }.tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
