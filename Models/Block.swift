import Foundation

struct Block: Codable, Identifiable {
    var id: String { block_id }
    let block_id: String
    let name: String
    let allowedDestinations: [String]
}
