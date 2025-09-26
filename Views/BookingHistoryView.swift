import SwiftUI

struct BookingHistoryView: View {
    @State private var bookings: [Booking] = []
    
    var body: some View {
        VStack {
            Text("Booking History")
                .font(.title)
                .bold()
                .padding()
            
            if bookings.isEmpty {
                Text("No bookings yet.")
                    .foregroundColor(.gray)
            } else {
                List(bookings) { booking in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(booking.pickup) → \(booking.destination)")
                            .font(.headline)
                        Text("Date: \(booking.date.formatted(date: .abbreviated, time: .shortened))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .onAppear {
            loadBookings()
        }
    }
    
    private func loadBookings() {
        bookings = DataManager.shared.loadBookings()
    }
}

#Preview {
    BookingHistoryView()
}
