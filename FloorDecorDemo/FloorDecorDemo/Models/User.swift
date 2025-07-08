import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let phoneNumber: String?
    let persona: UserPersona
    let profileImage: String?
    let loyaltyPoints: Int
    let loyaltyTier: LoyaltyTier
    let isProMember: Bool
    let proMemberSince: Date?
    let defaultStore: Store?
    let preferences: UserPreferences
    let createdAt: Date
    let lastLoginAt: Date
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

enum UserPersona: String, CaseIterable, Codable {
    case diy = "DIY"
    case pro = "Pro"
    
    var description: String {
        switch self {
        case .diy:
            return "Do-it-yourself homeowner"
        case .pro:
            return "Professional contractor or designer"
        }
    }
}

enum LoyaltyTier: String, CaseIterable, Codable {
    case bronze = "Bronze"
    case silver = "Silver"
    case gold = "Gold"
    case platinum = "Platinum"
    
    var minimumPoints: Int {
        switch self {
        case .bronze: return 0
        case .silver: return 1000
        case .gold: return 5000
        case .platinum: return 15000
        }
    }
    
    var discountPercentage: Double {
        switch self {
        case .bronze: return 0.0
        case .silver: return 2.0
        case .gold: return 5.0
        case .platinum: return 10.0
        }
    }
}

struct UserPreferences: Codable {
    let preferredCategories: [ProductCategory]
    let preferredPriceRange: ClosedRange<Double>?
    let preferredStores: [String]
    let notificationsEnabled: Bool
    let emailNotifications: Bool
    let pushNotifications: Bool
    let smsNotifications: Bool
    let language: String
    let currency: String
}

struct Store: Identifiable, Codable {
    let id: String
    let name: String
    let address: Address
    let phoneNumber: String
    let email: String?
    let hours: StoreHours
    let services: [StoreService]
    let coordinates: Coordinates
    let distance: Double?
    
    var formattedDistance: String? {
        guard let distance = distance else { return nil }
        if distance < 1 {
            return "\(Int(distance * 5280)) ft"
        } else {
            return String(format: "%.1f mi", distance)
        }
    }
}

struct Address: Codable {
    let street: String
    let city: String
    let state: String
    let zipCode: String
    let country: String
    
    var fullAddress: String {
        "\(street), \(city), \(state) \(zipCode)"
    }
}

struct StoreHours: Codable {
    let monday: DayHours
    let tuesday: DayHours
    let wednesday: DayHours
    let thursday: DayHours
    let friday: DayHours
    let saturday: DayHours
    let sunday: DayHours
}

struct DayHours: Codable {
    let isOpen: Bool
    let openTime: String?
    let closeTime: String?
    
    var formattedHours: String {
        guard isOpen, let open = openTime, let close = closeTime else {
            return "Closed"
        }
        return "\(open) - \(close)"
    }
}

struct StoreService: Codable {
    let name: String
    let description: String
    let isAvailable: Bool
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
} 