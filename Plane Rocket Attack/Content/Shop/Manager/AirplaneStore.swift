import Foundation

class AirplaneStore: ObservableObject {
    
    private let purchasedAirplanesKey = "purchasedAirplanes"
    
    @Published var availableAirplanes: [Airplane] = [
        Airplane(name: "A-101", price: 0, icon: "a101_plane"),
        Airplane(name: "B-102", price: 2000, icon: "b102_plane"),
        Airplane(name: "C-103", price: 3000, icon: "c103_plane"),
        Airplane(name: "D-104", price: 10000, icon: "d104_plane")
    ]
    
    @Published var purchasedAirplanes: [Airplane] = []
    
    init() {
        loadPurchasedAirplanes()
        if purchasedAirplanes.isEmpty {
            buyAirplane(availableAirplanes[0]) { return true }
        }
    }
    
    func buyAirplane(_ airplane: Airplane, checkConditions: () -> Bool) {
        if checkConditions() {
            purchasedAirplanes.append(airplane)
            savePurchasedAirplanes()
        }
    }
    
    private func savePurchasedAirplanes() {
        if let encoded = try? JSONEncoder().encode(purchasedAirplanes) {
            UserDefaults.standard.set(encoded, forKey: purchasedAirplanesKey)
        }
    }
    
    private func loadPurchasedAirplanes() {
        if let savedData = UserDefaults.standard.data(forKey: purchasedAirplanesKey),
           let decodedAirplanes = try? JSONDecoder().decode([Airplane].self, from: savedData) {
            purchasedAirplanes = decodedAirplanes
        }
    }
    
}
