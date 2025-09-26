import Foundation

class DataManager {
    static let shared = DataManager()
    private init() {}
    
    private let fileName = "bookings.json"
    
    private var fileURL: URL {
        let manager = FileManager.default
        let docs = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent(fileName)
    }
    
    // Save booking
    func saveBooking(_ booking: Booking) {
        var bookings = loadBookings()
        bookings.append(booking)
        
        if let data = try? JSONEncoder().encode(bookings) {
            try? data.write(to: fileURL)
        }
    }
    
    // Load bookings
    func loadBookings() -> [Booking] {
        if let data = try? Data(contentsOf: fileURL),
           let bookings = try? JSONDecoder().decode([Booking].self, from: data) {
            return bookings
        }
        return []
    }
}
