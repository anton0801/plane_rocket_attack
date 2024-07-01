import SwiftUI

struct HomeButton: View {
    
    var buttonColor: Color
    var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 150, style: .continuous)
                .fill(Color.init(red: 254/255, green: 231/255, blue: 231/255))
            
            RoundedRectangle(cornerRadius: 150, style: .continuous)
                .fill(buttonColor)
                .frame(width: 330, height: 60)
            
            Text(text)
                .font(.custom("PassionOne-Regular", size: 32))
                .foregroundColor(.white)
        }
        .frame(width: 350, height: 80)
    }
}

#Preview {
    HomeButton(buttonColor: Color.init(red: 248/255, green: 0, blue: 0), text: "PLAY")
}
