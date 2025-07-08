import SwiftUI

struct StoreLocatorView: View {
    @State private var searchText = ""
    @State private var selectedStore: Store?
    @State private var showingMap = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                SearchBar(text: $searchText)
                
                // Store List
                StoreListView(
                    searchText: searchText,
                    selectedStore: $selectedStore
                )
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemBackground))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    LogoView(size: 80, showTagline: false)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingMap.toggle()
                    }) {
                        Image(systemName: showingMap ? "list.bullet" : "map")
                    }
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search stores by city or zip...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray6).opacity(0.7))
        .cornerRadius(8)
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

struct StoreListView: View {
    let searchText: String
    @Binding var selectedStore: Store?
    
    private var filteredStores: [Store] {
        if searchText.isEmpty {
            return mockStores
        } else {
            return mockStores.filter { store in
                store.name.localizedCaseInsensitiveContains(searchText) ||
                store.address.city.localizedCaseInsensitiveContains(searchText) ||
                store.address.zipCode.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        List(filteredStores) { store in
            StoreRowView(store: store)
                .onTapGesture {
                    selectedStore = store
                }
        }
    }
}

struct StoreRowView: View {
    let store: Store
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(store.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(store.address.fullAddress)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if let distance = store.formattedDistance {
                    Text(distance)
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            
            HStack(spacing: 16) {
                // Phone
                Button(action: {
                    // Call store
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "phone.fill")
                            .font(.caption)
                        Text(store.phoneNumber)
                            .font(.caption)
                    }
                    .foregroundColor(.blue)
                }
                
                // Hours
                HStack(spacing: 4) {
                    Image(systemName: "clock.fill")
                        .font(.caption)
                    Text("Open until 9 PM")
                        .font(.caption)
                }
                .foregroundColor(.green)
                
                Spacer()
                
                // Services
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                    Text("Pro Services")
                        .font(.caption)
                }
                .foregroundColor(.orange)
            }
            
            // Quick Actions
            HStack(spacing: 12) {
                Button(action: {
                    // Get directions
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                        Text("Directions")
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
                
                Button(action: {
                    // Reserve for pickup
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "bag.fill")
                        Text("Reserve")
                    }
                    .font(.caption)
                    .foregroundColor(.green)
                }
                
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }
}

// Mock store data
private let mockStores: [Store] = [
    Store(
        id: "1",
        name: "Floor & Decor - Austin",
        address: Address(
            street: "1234 S Lamar Blvd",
            city: "Austin",
            state: "TX",
            zipCode: "78704",
            country: "USA"
        ),
        phoneNumber: "(512) 555-0123",
        email: "austin@flooranddecor.com",
        hours: StoreHours(
            monday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            tuesday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            wednesday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            thursday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            friday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            saturday: DayHours(isOpen: true, openTime: "8:00 AM", closeTime: "8:00 PM"),
            sunday: DayHours(isOpen: true, openTime: "9:00 AM", closeTime: "7:00 PM")
        ),
        services: [
            StoreService(name: "Design Services", description: "Free design consultation", isAvailable: true),
            StoreService(name: "Installation", description: "Professional installation", isAvailable: true),
            StoreService(name: "Pro Services", description: "Special pricing for contractors", isAvailable: true)
        ],
        coordinates: Coordinates(latitude: 30.2672, longitude: -97.7431),
        distance: 2.3
    ),
    Store(
        id: "2",
        name: "Floor & Decor - Round Rock",
        address: Address(
            street: "4567 N Interstate 35",
            city: "Round Rock",
            state: "TX",
            zipCode: "78664",
            country: "USA"
        ),
        phoneNumber: "(512) 555-0456",
        email: "roundrock@flooranddecor.com",
        hours: StoreHours(
            monday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            tuesday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            wednesday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            thursday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            friday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            saturday: DayHours(isOpen: true, openTime: "8:00 AM", closeTime: "8:00 PM"),
            sunday: DayHours(isOpen: true, openTime: "9:00 AM", closeTime: "7:00 PM")
        ),
        services: [
            StoreService(name: "Design Services", description: "Free design consultation", isAvailable: true),
            StoreService(name: "Installation", description: "Professional installation", isAvailable: true),
            StoreService(name: "Pro Services", description: "Special pricing for contractors", isAvailable: true)
        ],
        coordinates: Coordinates(latitude: 30.5083, longitude: -97.6789),
        distance: 8.7
    ),
    Store(
        id: "3",
        name: "Floor & Decor - San Antonio",
        address: Address(
            street: "7890 W Loop 1604",
            city: "San Antonio",
            state: "TX",
            zipCode: "78249",
            country: "USA"
        ),
        phoneNumber: "(210) 555-0789",
        email: "sanantonio@flooranddecor.com",
        hours: StoreHours(
            monday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            tuesday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            wednesday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            thursday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            friday: DayHours(isOpen: true, openTime: "7:00 AM", closeTime: "9:00 PM"),
            saturday: DayHours(isOpen: true, openTime: "8:00 AM", closeTime: "8:00 PM"),
            sunday: DayHours(isOpen: true, openTime: "9:00 AM", closeTime: "7:00 PM")
        ),
        services: [
            StoreService(name: "Design Services", description: "Free design consultation", isAvailable: true),
            StoreService(name: "Installation", description: "Professional installation", isAvailable: true),
            StoreService(name: "Pro Services", description: "Special pricing for contractors", isAvailable: true)
        ],
        coordinates: Coordinates(latitude: 29.4241, longitude: -98.4936),
        distance: 15.2
    )
]

struct StoreLocatorView_Previews: PreviewProvider {
    static var previews: some View {
        StoreLocatorView()
    }
} 