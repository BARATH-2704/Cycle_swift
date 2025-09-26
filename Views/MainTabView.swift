import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            BlockSelectionView()
                .tabItem {
                    Label("Book", systemImage: "bicycle")
                }
            
            BookingHistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
