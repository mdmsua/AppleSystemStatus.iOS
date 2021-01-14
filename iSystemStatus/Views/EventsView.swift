import SwiftUI

struct EventsView: View {
    @ObservedObject var events = Events()
    let service: Service
    var body: some View {
        Section {
            if events.loading {
                ProgressView()
            } else if let message = events.message {
                Text(message)
                    .multilineTextAlignment(.center)
            } else if events.events.count == 0 {
                Text("so_far_so_good").foregroundColor(.secondary)
            } else {
                List {
                    ForEach(events.events) {
                        event in
                        NavigationLink(destination: EventView(event: event), label: {
                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(StatusService.getColor(for: event.statusType))
                                Text(generateText(for: event))
                            }
                        })
                    }
                }.navigationBarTitle("events").toolbar {
                    Button(action: {
                        loadEvents()
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    })
                }
            }
        }.onAppear {
            loadEvents()
        }
    }
    
    fileprivate func loadEvents() {
        events.getEvents(for: service)
    }
    
    fileprivate func generateText(for event: Event) -> String {
        if (event.endDate == nil) {
            return "\(event.startDate) (\(event.eventStatus))"
        }
        
        let startDateComponents = event.startDate.split(separator: " ")
        let endDateComponents = event.endDate!.split(separator: " ")
        let startDay = startDateComponents.first!
        let endDay = endDateComponents.first!
        let startTimezone = startDateComponents.last!
        let endTimezone = endDateComponents.last!
        let isSameDay = startDay == endDay
        let isSameTimezone = startTimezone == endTimezone
        let startTimeComponents = isSameTimezone ? startDateComponents[1..<startDateComponents.lastIndex(of: startTimezone)!] : startDateComponents[1...]
        return isSameDay ? "\(startDay) \(startTimeComponents.joined(separator: " ")) - \(endDateComponents[1...].joined(separator: " "))" : "\(event.startDate) - \(event.endDate!)"
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(service: Service(id: "1", name: "iTunes", status: nil))
    }
}
