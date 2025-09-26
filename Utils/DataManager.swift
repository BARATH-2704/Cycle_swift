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
    
    private let userFile = "user.json"
    
    private var userFileURL: URL {
        let manager = FileManager.default
        let docs = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent(userFile)
    }
    
    // Save user
    func saveUser(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            try? data.write(to: userFileURL)
        }
    }
    
    // Load user
    func loadUser() -> User? {
        if let data = try? Data(contentsOf: userFileURL),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }
    
    // Clear user (logout)
    func clearUser() {
        try? FileManager.default.removeItem(at: userFileURL)
    }

    
    
    // Load bookings
    func loadBookings() -> [Booking] {
        if let data = try? Data(contentsOf: fileURL),
           let bookings = try? JSONDecoder().decode([Booking].self, from: data) {
            return bookings
        }
        return []
    }
    
    // ✅ Overwrite all bookings (used after deletion)
    func overwriteBookings(_ data: [Booking]) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encodedData = try? encoder.encode(data) {
            try? encodedData.write(to: fileURL)
        }
    }
}
