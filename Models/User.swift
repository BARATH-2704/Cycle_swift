import Foundation

struct User: Codable, Identifiable {
    var id: String { vitId }
    let name: String
    let email: String
    let vitId: String
}
