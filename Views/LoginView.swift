import SwiftUI

struct LoginView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var showHome = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🚲 VIT Cycle Booking")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)
            
            TextField("Enter your name", text: $name)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            TextField("Enter your email", text: $email)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Button("Login") {
                let user = User(name: name, email: email)
                DataManager.shared.saveUser(user)
                showHome = true
            }
            .disabled(name.isEmpty || email.isEmpty)
            .padding()
            .frame(maxWidth: .infinity)
            .background((name.isEmpty || email.isEmpty) ? .gray : .blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.top, 10)
            
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $showHome) {
            MainTabView()
        }
    }
}

#Preview {
    LoginView()
}
