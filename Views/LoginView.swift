import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var vitId = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false

    // For testing, hardcoded users
    let users: [User] = [User(name: "Barath", email: "barath.s2023@vitstudent.ac.in", vitId: "23BCE2021")]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("VIT Cycle Booking").font(.largeTitle).bold()
                
                TextField("VIT Email", text: $email)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(8)
                
                TextField("VIT ID", text: $vitId)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(8)

                Button("Login") {
                    login()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                if !errorMessage.isEmpty {
                    Text(errorMessage).foregroundColor(.red)
                }
            }
            .padding()
            .navigationDestination(isPresented: $isLoggedIn) {
                BlockSelectionView()
            }
        }
    }

    func login() {
        guard email.contains("@vitstudent.ac.in") else {
            errorMessage = "Use your VIT email"
            return
        }

        if users.contains(where: { $0.email.lowercased() == email.lowercased() && $0.vitId == vitId }) {
            errorMessage = ""
            isLoggedIn = true
        } else {
            errorMessage = "Invalid credentials"
        }
    }
}

// Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
