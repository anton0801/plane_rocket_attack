import SwiftUI

struct LoseGameRocketsPlaneView: View {

    @Environment(\.presentationMode) var presmode
    @EnvironmentObject var userManager: UserManager
    
    var timeLeft: Int
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
                Image("lose_game_label")
                    .resizable()
                    .frame(width: 140, height: 50)
                
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
                    Text("\(formatTime(from: timeLeft))")
                        .font(.custom("PassionOne-Regular", size: 32))
                        .foregroundColor(Color.init(red: 36/255, green: 86/255, blue: 171/255))
                }
                
                Button {
                    // restartAction()
                    presmode.wrappedValue.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        NotificationCenter.default.post(name: .pubRestartGame, object: nil)
                    }
                } label: {
                    HomeButton(buttonColor: Color.init(red: 248/255, green: 0, blue: 0), text: "RESTART")
                }
                
                Button {
                    presmode.wrappedValue.dismiss()
                    NotificationCenter.default.post(name: .pubGoToHome, object: nil)
                } label: {
                    HomeButton(buttonColor: Color.init(red: 0, green: 173/255, blue: 1), text: "GO TO HOME")
                }
            }
        }
    }
    
    func formatTime(from seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        if seconds < 3600 {
            return formatter.string(from: TimeInterval(seconds)) ?? "00:00"
        } else {
            formatter.allowedUnits = [.hour, .minute, .second]
            return formatter.string(from: TimeInterval(seconds)) ?? "00:00"
        }
    }
    
}

#Preview {
    LoseGameRocketsPlaneView(timeLeft: 87) {
        
    }
    .environmentObject(UserManager())
}
