import Foundation

class DataManager {
    static let shared = DataManager()

    func loadJSON<T: Decodable>(_ filename: String) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("❌ File not found: \(filename).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("❌ Failed to load or decode \(filename).json: \(error)")
            return nil
        }
    }

    func saveJSON<T: Encodable>(_ filename: String, data: T) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let encodedData = try encoder.encode(data)
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent(filename)
            try encodedData.write(to: url)
            print("✅ Saved \(filename) to documents folder")
        } catch {
            print("❌ Failed to save \(filename): \(error)")
        }
    }
}
