import Foundation

struct Airplane: Identifiable, Codable {
    let id: UUID
    let name: String
    let price: Int
    let icon: String
    
    init(id: UUID = UUID(), name: String, price: Int, icon: String) {
        self.id = id
        self.name = name
        self.price = price
        self.icon = icon
    }
}
