import Foundation

class DataManager {
    static let shared = DataManager()
    private init() {}
    
    // MARK: - Booking Storage
    private let bookingFile = "bookings.json"
    
    private var bookingFileURL: URL {
        let manager = FileManager.default
        let docs = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent(bookingFile)
    }
    // MARK: - Blocks
    private let blocksFile = "blocks.json"

    func loadBlocks() -> [Block] {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(blocksFile)
        
        if let data = try? Data(contentsOf: url),
           let blocks = try? JSONDecoder().decode([Block].self, from: data) {
            return blocks
        }
        
        // Default blocks if blocks.json does not exist
        let defaultBlocks = [
            Block(block_id: "MGB", name: "Mahatma Gandhi Block", allowedDestinations: ["TT","SMV","MB","CDMM","GDN"]),
            Block(block_id: "PRP", name: "PRP", allowedDestinations: ["TT","SMV","MB","CDMM","GDN"]),
            Block(block_id: "SJT", name: "SJT", allowedDestinations: ["MGB","TT","SMV","MB","CDMM","GDN"]),
            Block(block_id: "TT", name: "TT", allowedDestinations: ["MGB","PRP","SJT","MB","CDMM","GDN"]),
            Block(block_id: "SMV", name: "SMV", allowedDestinations: ["MGB","PRP","SJT","MB","CDMM","GDN"]),
            Block(block_id: "MB", name: "MB", allowedDestinations: ["MGB","PRP","SJT","TT","SMV"]),
            Block(block_id: "CDMM", name: "CDMM", allowedDestinations: ["MGB","PRP","SJT","TT","SMV"]),
            Block(block_id: "GDN", name: "GDN", allowedDestinations: ["MGB","PRP","SJT","TT","SMV"])
        ]
        
        saveBlocks(defaultBlocks)
        return defaultBlocks
    }

    func saveBlocks(_ blocks: [Block]) {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(blocksFile)
        if let data = try? JSONEncoder().encode(blocks) {
            try? data.write(to: url)
        }
    }

    
    // Save a booking
    func saveBooking(_ booking: Booking) {
        var bookings = loadBookings()
        var newBooking = booking
        newBooking.userEmail = loadUser()?.email ?? "unknown"
        bookings.append(newBooking)
        
        if let data = try? JSONEncoder().encode(bookings) {
            try? data.write(to: bookingFileURL)
        }
    }
    
    // Load bookings (all or filtered by user email)
    func loadBookings(for email: String? = nil) -> [Booking] {
        var allBookings: [Booking] = []
        if let data = try? Data(contentsOf: bookingFileURL),
           let bookings = try? JSONDecoder().decode([Booking].self, from: data) {
            allBookings = bookings
        }
        if let email = email {
            return allBookings.filter { $0.userEmail == email }
        }
        return allBookings
    }
    
    // Overwrite all bookings
    func overwriteBookings(_ data: [Booking]) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encodedData = try? encoder.encode(data) {
            try? encodedData.write(to: bookingFileURL)
        }
    }
    
    // MARK: - User Storage
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
    
    // MARK: - Wallet Operations
    // Add money to wallet
    func updateWallet(for email: String, amount: Double) {
        guard var user = loadUser(), user.email == email else { return }
        user.walletBalance += amount
        saveUser(user)
    }
    
    // Deduct money from wallet (returns false if insufficient funds)
    func deductWallet(for email: String, amount: Double) -> Bool {
        guard var user = loadUser(), user.email == email else { return false }
        if user.walletBalance >= amount {
            user.walletBalance -= amount
            saveUser(user)
            return true
        } else {
            return false
        }
    }
}
