import SwiftUI

struct AirplaneBoughtView: View {
    
    var airplane: Airplane
    var selectPlane: () -> Void
    
    var body: some View {
        HStack {
            Image(airplane.icon)
                .resizable()
                .frame(width: 60, height: 60)
            Text(airplane.name)
                .font(.custom("PassionOne-Regular", size: 26))
                .foregroundColor(Color.init(red: 46/266, green: 108/255, blue: 207/255))
                .multilineTextAlignment(.center)
                .padding(.leading, 6)
            Spacer()
            Button {
                selectPlane()
            } label: {
                ZStack {
                    Image("buy_button")
                        .resizable()
                        .frame(width: 100, height: 40)
                    Text("SELECT")
                        .font(.custom("PassionOne-Regular", size: 20))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal)
        .background(
            Rectangle()
                .fill(Color.init(red: 186/255, green: 232/255, blue: 1))
        )
    }
}
