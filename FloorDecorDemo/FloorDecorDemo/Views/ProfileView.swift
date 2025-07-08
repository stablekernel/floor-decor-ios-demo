import SwiftUI

struct ProfileView: View {
    @State private var isLoggedIn = false
    @State private var showingLogin = false
    @State private var showingSignUp = false
    @State private var showingProSignUp = false
    
    var body: some View {
        NavigationView {
            if isLoggedIn {
                LoggedInProfileView()
            } else {
                LoggedOutProfileView(
                    showingLogin: $showingLogin,
                    showingSignUp: $showingSignUp,
                    showingProSignUp: $showingProSignUp
                )
            }
        }
        .sheet(isPresented: $showingLogin) {
            LoginView(isLoggedIn: $isLoggedIn)
        }
        .sheet(isPresented: $showingSignUp) {
            SignUpView(isLoggedIn: $isLoggedIn)
        }
        .sheet(isPresented: $showingProSignUp) {
            ProSignUpView(isLoggedIn: $isLoggedIn)
        }
    }
}

struct LoggedOutProfileView: View {
    @Binding var showingLogin: Bool
    @Binding var showingSignUp: Bool
    @Binding var showingProSignUp: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Logo, Welcome, Subheader
                VStack(spacing: 12) {
                    Spacer(minLength: 24)
                    LogoView(size: 80, showTagline: false)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 16)
                    Text("Welcome to Floor & Decor")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    Text("Sign in to access your account, track orders, and manage your loyalty rewards.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity)
                
                // Action Buttons
                VStack(spacing: 16) {
                    // Social Sign-In Buttons
                    VStack(spacing: 12) {
                        Button(action: {
                            // Apple Sign In
                        }) {
                            HStack {
                                Image(systemName: "applelogo")
                                    .font(.title2)
                                Text("Continue with Apple")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(12)
                        }
                        
                        Button(action: {
                            // Google Sign In
                        }) {
                            HStack {
                                Image(systemName: "globe")
                                    .font(.title2)
                                Text("Continue with Google")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Divider
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.secondary.opacity(0.3))
                        Text("or")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.secondary.opacity(0.3))
                    }
                    .padding(.horizontal)
                    
                    // Traditional Sign-In Buttons
                    VStack(spacing: 12) {
                        Button(action: {
                            showingLogin = true
                        }) {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                showingProSignUp = true // PRO
                            }) {
                                Text("Create PRO Account")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.blue, lineWidth: 2)
                                    )
                            }
                                                    Button(action: {
                            showingSignUp = true // DIY
                        }) {
                            Text("Create DIY Account")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                        }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Guest Features
                VStack(spacing: 16) {
                    Text("Continue as Guest")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 12) {
                        GuestFeatureRow(
                            title: "Browse Products",
                            subtitle: "Explore our catalog",
                            icon: "square.grid.2x2.fill"
                        )
                        
                        GuestFeatureRow(
                            title: "Store Locator",
                            subtitle: "Find nearby locations",
                            icon: "location.fill"
                        )
                        
                        GuestFeatureRow(
                            title: "AR Preview",
                            subtitle: "See products in your space",
                            icon: "camera.fill"
                        )
                    }
                }
                .padding()
                Spacer(minLength: 24)
            }
            .frame(maxWidth: 500)
            .padding(.vertical)
            .padding(.horizontal, 8)
        }
        .background(Color(.systemBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                EmptyView() // Remove logo from nav bar for this screen
            }
        }
    }
}

struct LoggedInProfileView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // User Header
            UserHeaderView()
            
            // Tab Selection
            Picker("Profile Sections", selection: $selectedTab) {
                Text("Account").tag(0)
                Text("Orders").tag(1)
                Text("Loyalty").tag(2)
                Text("Settings").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Tab Content
            TabView(selection: $selectedTab) {
                AccountTabView()
                    .tag(0)
                
                OrdersTabView()
                    .tag(1)
                
                LoyaltyTabView()
                    .tag(2)
                
                SettingsTabView()
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
        .toolbar {
            ToolbarItem(placement: .principal) {
                LogoView(size: 80, showTagline: false)
            }
        }
    }
}

struct UserHeaderView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Profile Image
            Image(systemName: "person.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            // User Info
            VStack(spacing: 4) {
                Text("John Doe")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Pro Member")
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
            }
            
            // Quick Stats
            HStack(spacing: 30) {
                StatView(title: "Orders", value: "12")
                StatView(title: "Points", value: "2,450")
                StatView(title: "Tier", value: "Gold")
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

struct StatView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct AccountTabView: View {
    var body: some View {
        List {
            Section("Personal Information") {
                ProfileRow(title: "Name", value: "John Doe", icon: "person.fill")
                ProfileRow(title: "Email", value: "john.doe@email.com", icon: "envelope.fill")
                ProfileRow(title: "Phone", value: "(512) 555-0123", icon: "phone.fill")
                ProfileRow(title: "Persona", value: "Pro", icon: "briefcase.fill")
            }
            
            Section("Addresses") {
                ProfileRow(title: "Default Shipping", value: "123 Main St, Austin, TX", icon: "location.fill")
                ProfileRow(title: "Default Billing", value: "123 Main St, Austin, TX", icon: "creditcard.fill")
            }
            
            Section("Payment Methods") {
                ProfileRow(title: "Default Payment", value: "Visa ending in 1234", icon: "creditcard.fill")
            }
        }
    }
}

struct OrdersTabView: View {
    var body: some View {
        List {
            ForEach(mockOrders) { order in
                OrderRowView(order: order)
            }
        }
    }
}

struct LoyaltyTabView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Loyalty Card
            LoyaltyCardView()
            
            // Rewards
            RewardsSectionView()
            
            Spacer()
        }
        .padding()
    }
}

struct SettingsTabView: View {
    var body: some View {
        List {
            Section("Preferences") {
                SettingsRow(title: "Notifications", icon: "bell.fill", hasToggle: true)
                SettingsRow(title: "Email Notifications", icon: "envelope.fill", hasToggle: true)
                SettingsRow(title: "Push Notifications", icon: "iphone", hasToggle: true)
            }
            
            Section("Account") {
                SettingsRow(title: "Change Password", icon: "lock.fill")
                SettingsRow(title: "Privacy Settings", icon: "hand.raised.fill")
                SettingsRow(title: "Terms of Service", icon: "doc.text.fill")
                SettingsRow(title: "Privacy Policy", icon: "doc.text.fill")
            }
            
            Section("Support") {
                SettingsRow(title: "Help Center", icon: "questionmark.circle.fill")
                SettingsRow(title: "Contact Support", icon: "message.fill")
                SettingsRow(title: "Feedback", icon: "star.fill")
            }
            
            Section {
                Button(action: {
                    // Sign out
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                        Text("Sign Out")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct ProfileRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            Text(title)
            
            Spacer()
            
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

struct SettingsRow: View {
    let title: String
    let icon: String
    var hasToggle: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            Text(title)
            
            Spacer()
            
            if hasToggle {
                Toggle("", isOn: .constant(true))
            } else {
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct LoyaltyCardView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Floor & Decor")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Loyalty Card")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("GOLD")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                    
                    Text("Member")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("2,450")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Points")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("John Doe")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Member since 2023")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }
}

struct RewardsSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Available Rewards")
                .font(.headline)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                RewardRow(
                    title: "$10 Off",
                    subtitle: "500 points",
                    icon: "dollarsign.circle.fill",
                    color: .green
                )
                
                RewardRow(
                    title: "Free Shipping",
                    subtitle: "1,000 points",
                    icon: "shippingbox.fill",
                    color: .blue
                )
                
                RewardRow(
                    title: "20% Off Tile",
                    subtitle: "2,000 points",
                    icon: "square.grid.3x3.fill",
                    color: .orange
                )
            }
        }
    }
}

struct RewardRow: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button("Redeem") {
                // Redeem reward
            }
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(color)
            .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.3))
        .cornerRadius(12)
    }
}

struct OrderRowView: View {
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Order #\(order.orderNumber)")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(order.status.displayName)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(order.status.color)
                    .cornerRadius(8)
            }
            
            Text("$\(String(format: "%.2f", order.total))")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(order.createdAt, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

// Mock data
private let mockOrders: [Order] = [
    Order(
        id: "1",
        userId: "user1",
        orderNumber: "FD123456",
        items: [],
        subtotal: 299.99,
        discountAmount: 0,
        taxAmount: 24.99,
        shippingAmount: 0,
        total: 324.98,
        status: .delivered,
        paymentMethod: PaymentMethod(id: "1", type: .creditCard, lastFourDigits: "1234", cardBrand: "Visa", isDefault: true, expiryDate: "12/25"),
        shippingAddress: Address(street: "123 Main St", city: "Austin", state: "TX", zipCode: "78704", country: "USA"),
        billingAddress: Address(street: "123 Main St", city: "Austin", state: "TX", zipCode: "78704", country: "USA"),
        pickupStore: nil,
        estimatedDelivery: Date(),
        createdAt: Date().addingTimeInterval(-86400 * 7),
        updatedAt: Date().addingTimeInterval(-86400 * 7)
    ),
    Order(
        id: "2",
        userId: "user1",
        orderNumber: "FD123457",
        items: [],
        subtotal: 199.99,
        discountAmount: 20.00,
        taxAmount: 16.99,
        shippingAmount: 0,
        total: 196.98,
        status: .shipped,
        paymentMethod: PaymentMethod(id: "1", type: .creditCard, lastFourDigits: "1234", cardBrand: "Visa", isDefault: true, expiryDate: "12/25"),
        shippingAddress: Address(street: "123 Main St", city: "Austin", state: "TX", zipCode: "78704", country: "USA"),
        billingAddress: Address(street: "123 Main St", city: "Austin", state: "TX", zipCode: "78704", country: "USA"),
        pickupStore: nil,
        estimatedDelivery: Date().addingTimeInterval(86400 * 2),
        createdAt: Date().addingTimeInterval(-86400 * 2),
        updatedAt: Date().addingTimeInterval(-86400 * 1)
    )
]

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
} 

struct ProSignUpView: View {
    @Binding var isLoggedIn: Bool
    @Environment(\.dismiss) private var dismiss
    
    // Personal Information
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    // Account Type
    @State private var accountType = "PRO"
    
    // Business Information
    @State private var businessName = ""
    @State private var businessType = ""
    @State private var taxId = ""
    @State private var licenseNumber = ""
    
    // Address Information
    @State private var address1 = ""
    @State private var address2 = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipCode = ""
    
    // Preferences
    @State private var emailNotifications = true
    @State private var textNotifications = false
    @State private var termsAccepted = false
    
    @State private var isLoading = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        LogoView(size: 60, showTagline: false)
                        Text("Create PRO Account")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                    
                    // Account Type Selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Account Type")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 8) {
                            HStack {
                                Button(action: { accountType = "PRO" }) {
                                    HStack {
                                        Image(systemName: accountType == "PRO" ? "largecircle.fill.circle" : "circle")
                                            .foregroundColor(accountType == "PRO" ? .blue : .gray)
                                        Text("PRO Account")
                                            .fontWeight(.medium)
                                        Spacer()
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            
                            HStack {
                                Button(action: { accountType = "DIY" }) {
                                    HStack {
                                        Image(systemName: accountType == "DIY" ? "largecircle.fill.circle" : "circle")
                                            .foregroundColor(accountType == "DIY" ? .blue : .gray)
                                        Text("DIY Account")
                                            .fontWeight(.medium)
                                        Spacer()
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Personal Information
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Personal Information")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 12) {
                            HStack(spacing: 12) {
                                TextField("First Name", text: $firstName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                TextField("Last Name", text: $lastName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            TextField("Email Address", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            
                            TextField("Phone Number", text: $phone)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.phonePad)
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            SecureField("Confirm Password", text: $confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal)
                    
                    // Business Information (for PRO accounts)
                    if accountType == "PRO" {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Business Information")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            VStack(spacing: 12) {
                                TextField("Business Name", text: $businessName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                TextField("Business Type", text: $businessType)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                TextField("Tax ID", text: $taxId)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                TextField("License Number", text: $licenseNumber)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Address Information
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Address Information")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 12) {
                            TextField("Address Line 1", text: $address1)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            TextField("Address Line 2 (Optional)", text: $address2)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            HStack(spacing: 12) {
                                TextField("City", text: $city)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                TextField("State", text: $state)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            TextField("ZIP Code", text: $zipCode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Preferences
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Preferences")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 12) {
                            Toggle("Email Notifications", isOn: $emailNotifications)
                            
                            Toggle("Text Notifications", isOn: $textNotifications)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Terms and Conditions
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Button(action: { termsAccepted.toggle() }) {
                                HStack {
                                    Image(systemName: termsAccepted ? "checkmark.square.fill" : "square")
                                        .foregroundColor(termsAccepted ? .blue : .gray)
                                    Text("I agree to the Terms of Service and Privacy Policy")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    
                    // Create Account Button
                    Button(action: createProAccount) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Create PRO Account")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(canCreateAccount ? Color.blue : Color.gray)
                    .cornerRadius(12)
                    .disabled(!canCreateAccount || isLoading)
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationTitle("Create PRO Account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private var canCreateAccount: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && 
        !phone.isEmpty && !password.isEmpty && !confirmPassword.isEmpty &&
        password == confirmPassword && termsAccepted
    }
    
    private func createProAccount() {
        isLoading = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            isLoggedIn = true
            dismiss()
        }
    }
} 
