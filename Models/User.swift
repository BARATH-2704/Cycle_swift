import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    var name: String
    var email: String
    var walletBalance: Double = 100.0 // Default wallet amount
}
