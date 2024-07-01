import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presmode
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
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
                       presmode.wrappedValue.dismiss()
                   } label: {
                       Image("close_button")
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
                
                SettingsFormView()
                
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(UserManager())
}
