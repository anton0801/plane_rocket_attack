import SwiftUI

struct ShopeListView: View {
    
    @StateObject var airplaneStore: AirplaneStore = AirplaneStore()
    @EnvironmentObject var userManager: UserManager
    
    @State var errorVisible = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(Color.init(red: 46/266, green: 108/255, blue: 207/255))
            
            VStack {
                Text("SKINS")
                    .font(.custom("PassionOne-Regular", size: 32))
                    .foregroundColor(.white)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                        .fill(.white)
                    
                    VStack {
                        ForEach(airplaneStore.availableAirplanes, id: \.id) { airplane in
                            if userManager.selectedPlane == airplane.icon {
                                AirplaneSelectedView(airplane: airplane)
                            } else {
                                if airplaneStore.purchasedAirplanes.contains(where: { $0.name == airplane.name }) {
                                    AirplaneBoughtView(airplane: airplane) {
                                        userManager.selectedPlane = airplane.icon
                                    }
                                    .padding(2)
                                } else {
                                    AirplaneView(airplane: airplane) {
                                        airplaneStore.buyAirplane(airplane) {
                                            if userManager.credits >= airplane.price {
                                                return true
                                            }
                                            withAnimation(.linear(duration: 0.5)) {
                                                self.errorVisible = true
                                            }
                                            return false
                                        }
                                    }
                                    .padding(2)
                                }
                            }
                        }
                        
                        if errorVisible {
                            Text("Error buy plane! Not enougth credits!")
                                .font(.custom("PassionOne-Regular", size: 20))
                                .foregroundColor(.red)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(.linear(duration: 0.5)) {
                                            self.errorVisible = false
                                        }
                                    }
                                }
                        }
                    }
                }
                .frame(width: 320, height: 350)
            }
        }
        .frame(width: 350, height: 450)
    }
    
}

#Preview {
    ShopeListView()
        .environmentObject(UserManager())
}
