import SwiftUI

struct SettingFieldView: View {
    
    var slideSrc: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        Button {
            withAnimation(.linear(duration: 0.5)) {
                isEnabled = !isEnabled
            }
        } label: {
            if isEnabled {
                Image("\(slideSrc)_enabled")
                    .resizable()
                    .frame(width: 270, height: 50)
            } else {
                Image("\(slideSrc)_disabled")
                    .resizable()
                    .frame(width: 270, height: 50)
            }
        }
    }
}

#Preview {
    SettingFieldView(slideSrc: "music_slide", isEnabled: .constant(true))
}
