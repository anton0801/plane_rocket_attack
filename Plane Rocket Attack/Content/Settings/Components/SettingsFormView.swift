import SwiftUI

struct SettingsFormView: View {
    
    @State var soundsSlideEnabled = false {
        didSet {
            saveValue(for: "sounds", value: soundsSlideEnabled)
        }
    }
    @State var musicSlideEnabled: Bool = false {
        didSet {
            saveValue(for: "music", value: musicSlideEnabled)
        }
    }
    
    init() {
        soundsSlideEnabled = getValue(for: "sounds")
        musicSlideEnabled = getValue(for: "music")
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(Color.init(red: 46/266, green: 108/255, blue: 207/255))
            
            VStack {
                Text("SETTINGS")
                    .font(.custom("PassionOne-Regular", size: 32))
                    .foregroundColor(.white)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                        .fill(.white)
                    
                    VStack {
                        SettingFieldView(slideSrc: "sound_slide", isEnabled: $soundsSlideEnabled)
                        
                        SettingFieldView(slideSrc: "music_slide", isEnabled: $musicSlideEnabled)
                    }
                }
                .frame(width: 320, height: 150)
            }
        }
        .frame(width: 350, height: 250)
    }
    
    private func getValue(for key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    private func saveValue(for key: String, value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
}

#Preview {
    SettingsFormView()
}
