import Foundation

struct Event: Identifiable, Decodable {
    var id: Int64 { get { return epochStartDate } }
    let epochStartDate: Int64
    let epochEndDate: Int64?
    let startDate: String
    let endDate: String?
    let datePosted: String
    let statusType: String
    let eventStatus: String
    let usersAffected: String
    let message: String
    let affectedServices: String?
    var servicesAffected: [Substring]? { get { return affectedServices?.split(separator: ",", omittingEmptySubsequences: true) } }
}
