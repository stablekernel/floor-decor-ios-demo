import SwiftUI

struct SignUpView: View {
    @Binding var isLoggedIn: Bool
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentStep = 0
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var selectedPersona: UserPersona = .diy
    @State private var agreedToTerms = false
    @State private var isLoading = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Progress Indicator
                ProgressView(value: Double(currentStep), total: 4)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding()
                
                // Step Content
                TabView(selection: $currentStep) {
                    // Step 1: Basic Info
                    BasicInfoStep(
                        email: $email,
                        password: $password,
                        confirmPassword: $confirmPassword,
                        firstName: $firstName,
                        lastName: $lastName,
                        phoneNumber: $phoneNumber
                    )
                    .tag(0)
                    
                    // Step 2: Persona Selection
                    PersonaSelectionStep(selectedPersona: $selectedPersona)
                        .tag(1)
                    
                    // Step 3: Preferences
                    PreferencesStep()
                        .tag(2)
                    
                    // Step 4: Terms & Conditions
                    TermsStep(agreedToTerms: $agreedToTerms)
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Navigation Buttons
                HStack(spacing: 16) {
                    if currentStep > 0 {
                        Button("Back") {
                            withAnimation {
                                currentStep -= 1
                            }
                        }
                        .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Button(currentStep == 3 ? "Create Account" : "Next") {
                        if currentStep == 3 {
                            createAccount()
                        } else {
                            withAnimation {
                                currentStep += 1
                            }
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(canProceed ? Color.blue : Color.gray)
                    .cornerRadius(8)
                    .disabled(!canProceed || isLoading)
                }
                .padding()
            }
            .navigationTitle("Create Account")
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
    
    private var canProceed: Bool {
        switch currentStep {
        case 0:
            return !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty &&
                   !firstName.isEmpty && !lastName.isEmpty && password == confirmPassword
        case 1:
            return true // Persona is always selected
        case 2:
            return true // Preferences are optional
        case 3:
            return agreedToTerms
        default:
            return false
        }
    }
    
    private func createAccount() {
        isLoading = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isLoading = false
            
            // Mock validation
            if !email.contains("@") {
                errorMessage = "Please enter a valid email address"
                showingError = true
                return
            }
            
            if password.count < 8 {
                errorMessage = "Password must be at least 8 characters"
                showingError = true
                return
            }
            
            // Success - in real app this would create account with backend
            isLoggedIn = true
            dismiss()
        }
    }
}

struct BasicInfoStep: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var phoneNumber: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 12) {
                    Text("Tell us about yourself")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("We'll use this information to personalize your experience")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                // Form Fields
                VStack(spacing: 20) {
                    // Name Fields
                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("First Name")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            TextField("First name", text: $firstName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Last Name")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            TextField("Last name", text: $lastName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    
                    // Email
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        TextField("Enter your email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    
                    // Phone
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Phone Number (Optional)")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        TextField("Enter your phone number", text: $phoneNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.phonePad)
                    }
                    
                    // Password
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        SecureField("Create a password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // Confirm Password
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Confirm Password")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        SecureField("Confirm your password", text: $confirmPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct PersonaSelectionStep: View {
    @Binding var selectedPersona: UserPersona
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            VStack(spacing: 12) {
                Text("How do you plan to use Floor & Decor?")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("This helps us personalize your experience and show you relevant products")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
            
            // Persona Options
            VStack(spacing: 16) {
                ForEach(UserPersona.allCases, id: \.self) { persona in
                    PersonaCard(
                        persona: persona,
                        isSelected: selectedPersona == persona
                    ) {
                        selectedPersona = persona
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct PersonaCard: View {
    let persona: UserPersona
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: persona == .diy ? "house.fill" : "briefcase.fill")
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : .blue)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(persona.rawValue)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(isSelected ? .white : .primary)
                    
                    Text(persona.description)
                        .font(.subheadline)
                        .foregroundColor(isSelected ? .white.opacity(0.8) : .secondary)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

struct PreferencesStep: View {
    @State private var preferredCategories: Set<ProductCategory> = []
    @State private var notificationsEnabled = true
    @State private var emailNotifications = true
    @State private var pushNotifications = true
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            VStack(spacing: 12) {
                Text("Customize Your Experience")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Tell us what you're interested in")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
            
            ScrollView {
                VStack(spacing: 20) {
                    // Category Preferences
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Product Categories")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            ForEach(ProductCategory.allCases, id: \.self) { category in
                                CategoryPreferenceCard(
                                    category: category,
                                    isSelected: preferredCategories.contains(category)
                                ) {
                                    if preferredCategories.contains(category) {
                                        preferredCategories.remove(category)
                                    } else {
                                        preferredCategories.insert(category)
                                    }
                                }
                            }
                        }
                    }
                    
                    // Notification Preferences
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Notifications")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 12) {
                            Toggle("Enable Notifications", isOn: $notificationsEnabled)
                            
                            if notificationsEnabled {
                                Toggle("Email Notifications", isOn: $emailNotifications)
                                Toggle("Push Notifications", isOn: $pushNotifications)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct CategoryPreferenceCard: View {
    let category: ProductCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: category.icon)
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : category.color)
                
                Text(category.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : .primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

struct TermsStep: View {
    @Binding var agreedToTerms: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            VStack(spacing: 12) {
                Text("Terms & Conditions")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Please review and accept our terms")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
            
            ScrollView {
                VStack(spacing: 16) {
                    // Terms Text
                    VStack(alignment: .leading, spacing: 12) {
                        Text("By creating an account, you agree to:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Our Terms of Service")
                            Text("• Our Privacy Policy")
                            Text("• Receiving marketing communications")
                            Text("• Our return and shipping policies")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    
                    // Agreement Toggle
                    HStack {
                        Toggle("", isOn: $agreedToTerms)
                            .labelsHidden()
                        
                        Text("I agree to the terms and conditions")
                            .font(.subheadline)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isLoggedIn: .constant(false))
    }
} 