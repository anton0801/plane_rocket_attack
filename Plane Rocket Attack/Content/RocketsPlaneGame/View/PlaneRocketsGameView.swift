import SwiftUI
import SpriteKit

struct PlaneRocketsGameView: View {
    
    var time: Int = [60, 120, 180, 160, 240, 220, 140, 150, 300].randomElement() ?? 60
    
    @Environment(\.presentationMode) var presmode
    @EnvironmentObject var userManager: UserManager
    
    @State var isGameWin = false
    @State var isGameLose = false
    
    @State var planeScene: PlaneRocketsGameScene!
    
    init() {
  
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if planeScene != nil {
                    SpriteView(scene: planeScene)
                         .ignoresSafeArea()
                         .onReceive(NotificationCenter.default.publisher(for: .pubTimeOver), perform: { _ in
                             isGameWin = true
                         })
                         .onReceive(NotificationCenter.default.publisher(for: .pubLoseGame), perform: { _ in
                             isGameLose = true
                         })
                    
                    NavigationLink(destination: WinGameRocketsPlaneView(restartAction: {
                        
                    }).environmentObject(userManager)
                        .navigationBarBackButtonHidden(true), isActive: $isGameWin) {
                        
                    }
                    
                    NavigationLink(destination: LoseGameRocketsPlaneView(timeLeft: planeScene.time, restartAction: {
                        
                    }).environmentObject(userManager)
                        .navigationBarBackButtonHidden(true), isActive: $isGameLose) {
                        
                    }
                }
            }
        }
        .onAppear {
            planeScene = PlaneRocketsGameScene(time: time)
        }
        .onReceive(NotificationCenter.default.publisher(for: .pubRestartGame), perform: { _ in
            planeScene = planeScene.restartGame(time: time)
        })
        .onReceive(NotificationCenter.default.publisher(for: .pubGoToHome), perform: { _ in
            presmode.wrappedValue.dismiss()
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    PlaneRocketsGameView()
        .environmentObject(UserManager())
}
