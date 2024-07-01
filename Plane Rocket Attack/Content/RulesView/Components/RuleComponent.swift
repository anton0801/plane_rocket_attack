import SwiftUI

struct RuleComponent: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(Color.init(red: 46/266, green: 108/255, blue: 207/255))
            
            VStack {
                Text("RULES")
                    .font(.custom("PassionOne-Regular", size: 32))
                    .foregroundColor(.white)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                        .fill(.white)
                    Text("Your goal is to dodge missile strikes and earn points")
                        .font(.custom("PassionOne-Regular", size: 32))
                        .foregroundColor(Color.init(red: 46/266, green: 108/255, blue: 207/255))
                        .multilineTextAlignment(.center)
                }
                .frame(width: 320, height: 150)
            }
        }
        .frame(width: 350, height: 250)
    }
}

#Preview {
    RuleComponent()
}
