import Foundation
import SwiftUI

struct CartItem: Identifiable, Codable {
    let id: String
    let product: Product
    let quantity: Int
    let selectedColor: String?
    let selectedSize: String?
    let notes: String?
    let addedAt: Date
    
    var totalPrice: Double {
        product.price * Double(quantity)
    }
    
    var originalTotalPrice: Double? {
        guard let originalPrice = product.originalPrice else { return nil }
        return originalPrice * Double(quantity)
    }
}

struct Cart: Codable {
    let id: String
    let userId: String
    let items: [CartItem]
    let appliedDiscounts: [Discount]
    let appliedLoyaltyPoints: Int
    let estimatedTax: Double
    let shippingCost: Double
    let createdAt: Date
    let updatedAt: Date
    
    var subtotal: Double {
        items.reduce(0) { $0 + $1.totalPrice }
    }
    
    var discountAmount: Double {
        appliedDiscounts.reduce(0) { $0 + $1.amount }
    }
    
    var loyaltyDiscountAmount: Double {
        Double(appliedLoyaltyPoints) * 0.01 // 1 point = $0.01
    }
    
    var total: Double {
        subtotal - discountAmount - loyaltyDiscountAmount + estimatedTax + shippingCost
    }
    
    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
}

struct Discount: Codable {
    let id: String
    let code: String
    let type: DiscountType
    let amount: Double
    let description: String
    let expiresAt: Date?
}

enum DiscountType: String, Codable {
    case percentage = "percentage"
    case fixedAmount = "fixed_amount"
    case freeShipping = "free_shipping"
}

struct Order: Identifiable, Codable {
    let id: String
    let userId: String
    let orderNumber: String
    let items: [OrderItem]
    let subtotal: Double
    let discountAmount: Double
    let taxAmount: Double
    let shippingAmount: Double
    let total: Double
    let status: OrderStatus
    let paymentMethod: PaymentMethod
    let shippingAddress: Address
    let billingAddress: Address
    let pickupStore: Store?
    let estimatedDelivery: Date?
    let createdAt: Date
    let updatedAt: Date
    
    var isEligibleForCancellation: Bool {
        status == .pending || status == .confirmed
    }
}

struct OrderItem: Identifiable, Codable {
    let id: String
    let product: Product
    let quantity: Int
    let price: Double
    let selectedColor: String?
    let selectedSize: String?
    let notes: String?
}

enum OrderStatus: String, CaseIterable, Codable {
    case pending = "pending"
    case confirmed = "confirmed"
    case processing = "processing"
    case shipped = "shipped"
    case delivered = "delivered"
    case cancelled = "cancelled"
    case returned = "returned"
    
    var displayName: String {
        switch self {
        case .pending: return "Pending"
        case .confirmed: return "Confirmed"
        case .processing: return "Processing"
        case .shipped: return "Shipped"
        case .delivered: return "Delivered"
        case .cancelled: return "Cancelled"
        case .returned: return "Returned"
        }
    }
    
    var color: Color {
        switch self {
        case .pending: return .orange
        case .confirmed: return .blue
        case .processing: return .purple
        case .shipped: return .green
        case .delivered: return .green
        case .cancelled: return .red
        case .returned: return .red
        }
    }
}

struct PaymentMethod: Codable {
    let id: String
    let type: PaymentType
    let lastFourDigits: String?
    let cardBrand: String?
    let isDefault: Bool
    let expiryDate: String?
}

enum PaymentType: String, Codable {
    case creditCard = "credit_card"
    case debitCard = "debit_card"
    case applePay = "apple_pay"
    case googlePay = "google_pay"
    case paypal = "paypal"
    case financing = "financing"
} 