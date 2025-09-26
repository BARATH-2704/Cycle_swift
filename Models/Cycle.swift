import Foundation

struct Cycle: Codable, Identifiable {
    var id: String { cycle_id }
    let cycle_id: String
    var status: String // "available", "in_use", "damaged"
    var currentBlock: String
}
