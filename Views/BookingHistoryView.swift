import SwiftUI

struct BookingHistoryView: View {
    @State private var bookings: [Booking] = []
    
    var body: some View {
        VStack {
            Text("📜 Booking History")
                .font(.largeTitle)
                .bold()
                .padding()
            
            if bookings.isEmpty {
                Spacer()
                Text("No bookings yet.")
                    .foregroundColor(.gray)
                    .font(.headline)
                Spacer()
            } else {
                List {
                    ForEach(bookings) { booking in
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("\(booking.pickup) → \(booking.destination)")
                                    .font(.headline)
                                Text(booking.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "bicycle.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                        }
                        .padding(8)
                    }
                    .onDelete(perform: deleteBooking)
                }
                .listStyle(.insetGrouped)
            }
        }
        .onAppear {
            loadBookings()
        }
    }
    
    private func loadBookings() {
        bookings = DataManager.shared.loadBookings()
    }
    
    private func deleteBooking(at offsets: IndexSet) {
        bookings.remove(atOffsets: offsets)
        DataManager.shared.overwriteBookings(bookings)
    }
}

#Preview {
    BookingHistoryView()
}
