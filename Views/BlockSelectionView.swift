import SwiftUI

struct BlockSelectionView: View {
    @State private var pickup = "MGB"
    @State private var destination = "TT"
    @State private var errorMessage = ""
    @State private var bookingConfirmed = false
    
    // List of all blocks
    let blocks = ["MGB","PRP","SJT","TT","SMV","MB","CDMM","GDN"]
    
    // Allowed routes
    let allowedRoutes: [String: [String]] = [
        "MGB": ["TT","SMV","MB","CDMM","GDN"],
        "PRP": ["TT","SMV","MB","CDMM","GDN"],
        "SJT": ["MGB","TT","SMV","MB","CDMM","GDN"],
        "TT": ["MGB","PRP","SJT","MB","CDMM","GDN"],
        "SMV": ["MGB","PRP","SJT","MB","CDMM","GDN"],
        "MB": ["MGB","PRP","SJT","TT","SMV"],
        "CDMM": ["MGB","PRP","SJT","TT","SMV"],
        "GDN": ["MGB","PRP","SJT","TT","SMV"]
    ]
    
    // Compute allowed destinations dynamically
    var allowedDestinations: [String] {
        return allowedRoutes[pickup] ?? []
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("🚲 Cycle Booking")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                VStack(spacing: 15) {
                    // Pickup Location Card
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Pickup Location")
                            .font(.headline)
                        Picker("Pickup", selection: $pickup) {
                            ForEach(blocks, id: \.self) { block in
                                Text(block)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: pickup) { oldValue, newValue in
                            if !allowedDestinations.contains(destination) {
                                destination = allowedDestinations.first ?? ""
                            }
                        }

                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    // Destination Location Card
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Destination")
                            .font(.headline)
                        Picker("Destination", selection: $destination) {
                            ForEach(allowedDestinations, id: \.self) { block in
                                Text(block)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Confirm Booking Button
                Button(action: confirmBooking) {
                    Label("Confirm Booking", systemImage: "checkmark.circle.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                }
                .padding(.horizontal)
                
                // Booking History Navigation
                NavigationLink {
                    BookingHistoryView()
                } label: {
                    Label("View Booking History", systemImage: "clock.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                }
                .padding(.horizontal)
                
                // Messages
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                
                if bookingConfirmed {
                    Text("✅ Booking Confirmed: \(pickup) → \(destination)")
                        .foregroundColor(.green)
                        .padding(.top, 10)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    // Booking validation and saving
    func confirmBooking() {
        if let allowed = allowedRoutes[pickup], allowed.contains(destination) {
            errorMessage = ""
            bookingConfirmed = true
            
            // Create new booking
            let newBooking = Booking(pickup: pickup, destination: destination)
            
            // Save booking locally
            DataManager.shared.saveBooking(newBooking)
        } else {
            errorMessage = "Booking from \(pickup) to \(destination) is not allowed."
            bookingConfirmed = false
        }
    }
}

#Preview {
    BlockSelectionView()
}
