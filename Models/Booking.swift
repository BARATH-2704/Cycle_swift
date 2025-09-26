import Foundation

struct Booking: Identifiable, Codable {
    let id: UUID
    let pickup: String
    let destination: String
    let date: Date
    
    init(pickup: String, destination: String) {
        self.id = UUID()
        self.pickup = pickup
        self.destination = destination
        self.date = Date()
    }
}
