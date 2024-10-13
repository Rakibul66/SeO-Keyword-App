import Foundation

struct SEOKeyword: Identifiable, Codable {
    var id: UUID = UUID() // Unique ID for SwiftUI lists
    var text: String
    var cpc: String
    var vol: Int
    var competition: String
    var score: Double

    enum CodingKeys: String, CodingKey {
        case text
        case cpc
        case vol
        case competition
        case score
    }
}
