import SwiftUI

struct BlockSelectionView: View {
    @State private var pickup = "MGB"
    @State private var destination = "TT"
    @State private var errorMessage = ""
    @State private var bookingConfirmed = false
    
    let blocks = ["MGB","PRP","SJT","TT","SMV","MB","CDMM","GDN"]
    
    // ✅ Allowed routes based on your corrected list
    let allowedRoutes: [String: [String]] = [
        "MGB": ["TT","SMV","MB","CDMM","GDN","SJT"],
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
        VStack(spacing: 20) {
            Text("Select your blocks").font(.title).bold()
            
            // Pickup Picker
            Picker("Pickup", selection: $pickup) {
                ForEach(blocks, id: \.self) { block in
                    Text(block)
                }
            }
            .pickerStyle(.menu)
            // iOS 17+ onChange syntax
            .onChange(of: pickup) {
                // If current destination is not allowed, auto-select first allowed destination
                if !allowedDestinations.contains(destination) {
                    destination = allowedDestinations.first ?? ""
                }
            }
            
            // Destination Picker
            Picker("Destination", selection: $destination) {
                ForEach(allowedDestinations, id: \.self) { block in
                    Text(block)
                }
            }
            .pickerStyle(.menu)
            
            // Confirm Booking Button
            Button("Confirm Booking") {
                confirmBooking()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            // Error message
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            // Success message
            if bookingConfirmed {
                Text("Booking Confirmed: \(pickup) → \(destination)")
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
    
    // Booking validation
    func confirmBooking() {
        if let allowed = allowedRoutes[pickup], allowed.contains(destination) {
            errorMessage = ""
            bookingConfirmed = true
            // TODO: Save booking to local JSON / Firebase
        } else {
            errorMessage = "Booking from \(pickup) to \(destination) is not allowed."
            bookingConfirmed = false
        }
    }
}

// Preview
struct BlockSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        BlockSelectionView()
    }
}
