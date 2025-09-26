import Foundation

struct Block: Codable, Identifiable {
    var id: String { block_id }
    let block_id: String
    let name: String
    let allowedDestinations: [String]
    
    // Example initializer
    init(block_id: String, name: String, allowedDestinations: [String]) {
        self.block_id = block_id
        self.name = name
        self.allowedDestinations = allowedDestinations
    }
}
