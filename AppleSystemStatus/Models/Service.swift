import Foundation

struct Service: Identifiable, Decodable {
    let id: String
    let name: String
    let status: String?
}
