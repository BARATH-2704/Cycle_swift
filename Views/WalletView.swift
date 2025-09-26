import SwiftUI

struct WalletView: View {
    @State private var user: User? = DataManager.shared.loadUser()
    @State private var topUpAmount = ""
    @State private var message = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("💰 Wallet")
                .font(.largeTitle)
                .bold()
            
            if let user = user {
                Text("Balance: ₹\(String(format: "%.2f", user.walletBalance))")
                    .font(.title)
                    .padding(.top, 20)
                
                TextField("Top-up amount", text: $topUpAmount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button("Add Money") {
                    addMoney()
                }
                .disabled(topUpAmount.isEmpty)
                .padding()
                .frame(maxWidth: .infinity)
                .background(topUpAmount.isEmpty ? Color.gray : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                if !message.isEmpty {
                    Text(message)
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                }
            } else {
                Text("No user logged in")
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func addMoney() {
        if let amount = Double(topUpAmount), amount > 0,
           let email = user?.email {
            DataManager.shared.updateWallet(for: email, amount: amount)
            user = DataManager.shared.loadUser()
            message = "₹\(String(format: "%.2f", amount)) added successfully!"
            topUpAmount = ""
        } else {
            message = "Enter a valid amount."
        }
    }
}

#Preview {
    WalletView()
}
