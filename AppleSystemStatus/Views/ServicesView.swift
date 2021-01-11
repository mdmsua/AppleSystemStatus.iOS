import SwiftUI

struct ServicesView: View {
    @ObservedObject var services = Services()
    @EnvironmentObject var preferences: Preferences
    
    var body: some View {
        NavigationView {
            if services.loading {
                ProgressView()
            } else if let message = services.message {
                Text(message)
                    .multilineTextAlignment(.center)
            } else {
                List {
                    ForEach(services.services) {
                        service in
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(StatusService.getColor(for: service.status))
                            NavigationLink(service.name, destination: EventsView(service: service))
                        }
                    }
                }.navigationBarTitle("services").toolbar {
                    Button(action: {
                        loadServices()
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    })
                }
            }
        }.onAppear {
            loadServices()
        }
    }
    
    fileprivate func loadServices() {
        services.getServices(for: preferences.country)
    }
}

struct SystemStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesView()
    }
}
