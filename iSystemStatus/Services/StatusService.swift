import SwiftUI

class StatusService {
    static func getColor(for status: String?) -> Color {
        switch status {
            case "Maintenance": fallthrough
            case "Issue": return .yellow
            case "Outage": return .red
            default: return .green
        }
    }
}
