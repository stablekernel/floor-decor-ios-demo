import Foundation
import SwiftUI

struct Product: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let category: ProductCategory
    let subcategory: String
    let price: Double
    let originalPrice: Double?
    let currency: String
    let images: [String]
    let specifications: ProductSpecifications
    let colors: [String]
    let sizes: [String]
    let inStock: Bool
    let stockQuantity: Int?
    let rating: Double
    let reviewCount: Int
    let isProExclusive: Bool
    let isNew: Bool
    let isOnSale: Bool
    
    var discountPercentage: Int? {
        guard let originalPrice = originalPrice, originalPrice > price else { return nil }
        return Int(((originalPrice - price) / originalPrice) * 100)
    }
}

struct ProductSpecifications: Codable {
    let material: String
    let finish: String?
    let thickness: String?
    let coverage: String?
    let installationType: String?
    let warranty: String?
    let features: [String]
}

enum ProductCategory: String, CaseIterable, Codable {
    case wood = "Wood"
    case laminate = "Laminate"
    case vinyl = "Vinyl"
    case tile = "Tile"
    case stone = "Stone"
    case decoratives = "Decoratives"
    case fixtures = "Fixtures"
    case installationMaterials = "Installation Materials"
    
    // Return an optional image asset name for custom icons
    var imageAsset: String? {
        switch self {
        case .tile: return "tile"
        case .stone: return "stone"
        case .wood: return "wood"
        default: return nil
        }
    }
    
    var icon: String {
        switch self {
        case .tile: return "square.grid.3x3.fill"
        case .stone: return "mountain.2.fill"
        case .wood: return "leaf.fill"
        case .laminate: return "rectangle.3.group.fill"
        case .vinyl: return "rectangle.fill"
        case .decoratives: return "sparkles"
        case .fixtures: return "lightbulb.fill"
        case .installationMaterials: return "wrench.and.screwdriver.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .tile: return .blue
        case .stone: return .brown
        case .wood: return .orange
        case .laminate: return .green
        case .vinyl: return .purple
        case .decoratives: return .pink
        case .fixtures: return .yellow
        case .installationMaterials: return .gray
        }
    }
} 
