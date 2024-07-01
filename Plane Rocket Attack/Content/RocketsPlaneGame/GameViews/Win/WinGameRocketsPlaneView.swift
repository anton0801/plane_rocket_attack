import SwiftUI

struct WinGameRocketsPlaneView: View {
    
    @Environment(\.presentationMode) var presmode
    @EnvironmentObject var userManager: UserManager
    
    var restartAction: () -> Void
    
    var body: some View {
        ZStack {
            Image("game_result_back")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            
            VStack {
                Image("time_over_label")
                    .resizable()
                    .frame(width: 220, height: 50)
                
                ZStack {
                    Image("balance_background")
                        .resizable()
                        .frame(width: 180, height: 50)
                    Text("\(userManager.credits)")
                        .font(.custom("PassionOne-Regular", size: 32))
                        .foregroundColor(Color.init(red: 36/255, green: 86/255, blue: 171/255))
                }
                .padding(.top, 32)
                
                ZStack {
                    Image("balance_background")
                        .resizable()
                        .frame(width: 120, height: 50)
                    Text("0:00")
                        .font(.custom("PassionOne-Regular", size: 32))
                        .foregroundColor(Color.init(red: 36/255, green: 86/255, blue: 171/255))
                }
                
                Button {
                    restartAction()
                } label: {
                    HomeButton(buttonColor: Color.init(red: 248/255, green: 0, blue: 0), text: "RESTART")
                }
                
                Button {
                    presmode.wrappedValue.dismiss()
                } label: {
                    HomeButton(buttonColor: Color.init(red: 0, green: 173/255, blue: 1), text: "GO TO HOME")
                }
            }
        }
    }
}

#Preview {
    WinGameRocketsPlaneView {
        
    }.environmentObject(UserManager())
}
