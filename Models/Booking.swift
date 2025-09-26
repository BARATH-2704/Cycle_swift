import Foundation

struct Booking: Identifiable, Codable {
    let id: UUID
    let pickup: String
    let destination: String
    let date: Date
    var userEmail: String // Added to link booking to user
    
    init(pickup: String, destination: String, userEmail: String = "") {
        self.id = UUID()
        self.pickup = pickup
        self.destination = destination
        self.date = Date()
        self.userEmail = userEmail
    }
}
