import Foundation

class UserManager: ObservableObject {
    
    @Published var credits: Int = 0 {
        didSet {
            saveIntValue(for: "credits", value: credits)
        }
    }
    @Published var selectedPlane: String = "" {
        didSet {
            saveStringValue(for: "selected_plane", value: selectedPlane)
        }
    }
    
    
    init() {
        credits = getIntValue(for: "credits")
        selectedPlane = getStringValue(for: "selected_plane") ?? "a101_plane"
    }
    
    private func getIntValue(for key: String) -> Int {
      return UserDefaults.standard.integer(forKey: key)
    }
    
    private func getStringValue(for key: String) -> String? {
      return UserDefaults.standard.string(forKey: key)
    }

    private func saveIntValue(for key: String, value: Int) {
      UserDefaults.standard.set(value, forKey: key)
    }

    private func saveStringValue(for key: String, value: String) {
      UserDefaults.standard.set(value, forKey: key)
    }
    
}
