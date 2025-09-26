import SwiftUI

struct ProfileView: View {
    @State private var user: User? = DataManager.shared.loadUser()
    @State private var goLogin = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let user = user {
                Text("👤 Profile")
                    .font(.largeTitle).bold()
                
                Text("Name: \(user.name)")
                Text("Email: \(user.email)")
                
                Button("Logout") {
                    DataManager.shared.clearUser()
                    goLogin = true
                }
                .foregroundColor(.red)
                .padding(.top, 20)
            } else {
                Text("No user logged in")
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $goLogin) {
            LoginView()
        }
    }
}

#Preview {
    ProfileView()
}
