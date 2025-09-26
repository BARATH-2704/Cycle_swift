import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    var name: String
    var email: String
}
