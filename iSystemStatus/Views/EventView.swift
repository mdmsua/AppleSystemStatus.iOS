import SwiftUI

struct EventView: View {
    let event: Event
    var body: some View {
        List {
            Text(event.message)
            HStack {
                Text("started")
                Spacer()
                Text(event.startDate).foregroundColor(.secondary)
            }
            HStack {
                Text("ended")
                Spacer()
                Text(event.endDate ?? "").foregroundColor(.secondary)
            }
            HStack {
                Text("posted")
                Spacer()
                Text(event.datePosted).foregroundColor(.secondary)
            }
            HStack {
                Text("users")
                Spacer()
                Text(event.usersAffected).foregroundColor(.secondary)
            }
            HStack(alignment: .top) {
                Text("services")
                Spacer()
                if let servicesAffected = event.servicesAffected {
                    VStack(alignment: .trailing) {
                        ForEach(servicesAffected, id: \.hash) {
                            service in Text(service).foregroundColor(.secondary)
                        }
                    }
                } else {
                    Text("").foregroundColor(.secondary)
                }
            }
        }.navigationBarTitle("\(event.statusType) (\(event.eventStatus))")
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(epochStartDate: 1609405500000, epochEndDate: nil, startDate: "12/31/2020 01:05 PST", endDate: nil, datePosted: "12/31/2020 05:22 PST", statusType: "Issue", eventStatus: "Ongoing", usersAffected: "All users are affected", message: "Some users may not be able to access their Apple Card statements.", affectedServices: nil))
    }
}
