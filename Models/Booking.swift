import Foundation

struct Booking: Codable, Identifiable {
    var id: String { booking_id }
    let booking_id: String
    let userId: String
    let cycleId: String
    let pickupBlock: String
    let destinationBlock: String
    let startTime: Date
    let endTime: Date
    var status: String // "booked", "finished", "late"
}
