import SwiftUI

struct HomeMenuView: View {
    
    @StateObject var userManager = UserManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("home_menu_background")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button {
                            
                        } label: {
                            Image("menu_button")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Image("balance_background")
                                .resizable()
                                .frame(width: 150, height: 50)
                            Text("\(userManager.credits)")
                                .font(.custom("PassionOne-Regular", size: 32))
                                .foregroundColor(Color.init(red: 36/255, green: 86/255, blue: 171/255))
                        }
                    }
                    .padding()
                    .offset(y: 40)
                    
                    Spacer()
                    Spacer()
                    
                    NavigationLink(destination: PlaneRocketsGameView()
                        .environmentObject(userManager)
                        .navigationBarBackButtonHidden(true)) {
                        HomeButton(buttonColor: Color.init(red: 248/255, green: 0, blue: 0), text: "PLAY")
                    }
                    
                    NavigationLink(destination: ShopView()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(userManager)) {
                        HomeButton(buttonColor: Color.init(red: 0, green: 173/255, blue: 1), text: "SHOP")
                    }
                    
                    NavigationLink(destination: SettingsView()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(userManager)) {
                        HomeButton(buttonColor: Color.init(red: 0, green: 173/255, blue: 1), text: "SETTINGS")
                    }
                    
                    NavigationLink(destination: RulesView()
                        .navigationBarBackButtonHidden(true)
                        .environmentObject(userManager)) {
                        HomeButton(buttonColor: Color.init(red: 0, green: 173/255, blue: 1), text: "RULES")
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    HomeMenuView()
}
