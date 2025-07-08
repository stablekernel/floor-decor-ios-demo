import SwiftUI

struct CatalogView: View {
    @State private var searchText = ""
    @State private var selectedCategory: ProductCategory?
    @State private var showingFilters = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search and Filter Bar
                SearchFilterBar(
                    searchText: $searchText,
                    selectedCategory: $selectedCategory,
                    showingFilters: $showingFilters
                )
                
                // Category Pills
                CategoryPillsView(selectedCategory: $selectedCategory)
                
                // Product Grid
                ProductGridView(
                    searchText: searchText,
                    selectedCategory: selectedCategory
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
                        showingFilters.toggle()
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
    }
}

struct SearchFilterBar: View {
    @Binding var searchText: String
    @Binding var selectedCategory: ProductCategory?
    @Binding var showingFilters: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search products...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6).opacity(0.7))
                .cornerRadius(8)
                
                Button(action: {
                    showingFilters.toggle()
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

struct CategoryPillsView: View {
    @Binding var selectedCategory: ProductCategory?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                CategoryPill(
                    title: "All",
                    isSelected: selectedCategory == nil
                ) {
                    selectedCategory = nil
                }
                
                ForEach(ProductCategory.allCases, id: \.self) { category in
                    CategoryPill(
                        title: category.rawValue,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
    }
}

struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct ProductGridView: View {
    let searchText: String
    let selectedCategory: ProductCategory?
    
    // Mock data - in real app this would come from API
    private var filteredProducts: [Product] {
        // This would be replaced with actual API call
        return mockProducts.filter { product in
            let matchesSearch = searchText.isEmpty || 
                product.name.localizedCaseInsensitiveContains(searchText) ||
                product.description.localizedCaseInsensitiveContains(searchText)
            
            let matchesCategory = selectedCategory == nil || product.category == selectedCategory
            
            return matchesSearch && matchesCategory
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(filteredProducts) { product in
                    ProductCard(product: product)
                }
            }
            .padding()
        }
    }
}

struct ProductCard: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product Image
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                product.category.color.opacity(0.15),
                                product.category.color.opacity(0.05)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .aspectRatio(1, contentMode: .fit)
                
                // Product Image
                if let firstImageName = product.images.first {
                    Image(firstImageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .cornerRadius(8)
                        .onAppear {
                            print("Displaying product image: \(firstImageName) for product: \(product.name)")
                        }
                } else {
                    // Fallback to category icon
                    VStack(spacing: 8) {
                        Image(systemName: product.category.icon)
                            .font(.system(size: 40, weight: .medium))
                            .foregroundColor(product.category.color)
                            .frame(width: 60, height: 60)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(product.category.color.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
                
                // Overlay badges
                VStack {
                    HStack {
                        Spacer()
                        if product.isNew {
                            Text("NEW")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.green)
                                .cornerRadius(4)
                        }
                    }
                    Spacer()
                }
                .padding(8)
                
                VStack {
                    Spacer()
                    HStack {
                        if product.isOnSale {
                            Text("SALE")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.red)
                                .cornerRadius(4)
                        }
                        Spacer()
                    }
                }
                .padding(8)
            }
            
            // Product Info
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Text(product.category.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack {
                    Text("$\(String(format: "%.2f", product.price))")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    if let originalPrice = product.originalPrice {
                        Text("$\(String(format: "%.2f", originalPrice))")
                            .font(.caption)
                            .strikethrough()
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    if product.isOnSale {
                        Text("SALE")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.red)
                            .cornerRadius(4)
                    }
                }
                
                HStack {
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(product.rating) ? "star.fill" : "star")
                                .font(.caption2)
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    Text("(\(product.reviewCount))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        // Add to cart
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .padding(8)
        .background(Color(.systemBackground).opacity(0.95))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

// Mock data for demonstration
private let mockProducts: [Product] = [
    Product(
        id: "1",
        name: "Luxury Vinyl Plank - Oak",
        description: "Premium vinyl plank flooring with oak wood look",
        category: .vinyl,
        subcategory: "Luxury Vinyl Plank",
        price: 2.99,
        originalPrice: 3.99,
        currency: "USD",
        images: ["vinyl", "carouselVinyl"],
        specifications: ProductSpecifications(
            material: "Vinyl",
            finish: "Matte",
            thickness: "6mm",
            coverage: "20 sq ft per box",
            installationType: "Click-lock",
            warranty: "25 years",
            features: ["Waterproof", "Scratch resistant", "Easy installation"]
        ),
        colors: ["Natural Oak", "Gray Oak", "Brown Oak"],
        sizes: ["6\" x 36\""],
        inStock: true,
        stockQuantity: 150,
        rating: 4.5,
        reviewCount: 127,
        isProExclusive: false,
        isNew: false,
        isOnSale: true
    ),
    Product(
        id: "2",
        name: "Porcelain Tile - Marble Look",
        description: "Large format porcelain tile with marble appearance",
        category: .tile,
        subcategory: "Porcelain",
        price: 4.99,
        originalPrice: nil,
        currency: "USD",
        images: ["tile", "carouselTile"],
        specifications: ProductSpecifications(
            material: "Porcelain",
            finish: "Polished",
            thickness: "10mm",
            coverage: "15 sq ft per box",
            installationType: "Thinset",
            warranty: "Lifetime",
            features: ["Stain resistant", "Frost resistant", "Low maintenance"]
        ),
        colors: ["White Marble", "Gray Marble", "Beige Marble"],
        sizes: ["24\" x 24\"", "12\" x 24\""],
        inStock: true,
        stockQuantity: 75,
        rating: 4.8,
        reviewCount: 89,
        isProExclusive: false,
        isNew: true,
        isOnSale: false
    ),
    Product(
        id: "3",
        name: "Engineered Hardwood - Hickory",
        description: "Premium engineered hardwood with hickory species",
        category: .wood,
        subcategory: "Engineered Hardwood",
        price: 6.99,
        originalPrice: 8.99,
        currency: "USD",
        images: ["wood"],
        specifications: ProductSpecifications(
            material: "Hickory",
            finish: "Satin",
            thickness: "3/4\"",
            coverage: "18 sq ft per box",
            installationType: "Nail down",
            warranty: "30 years",
            features: ["Durable", "Natural variation", "Easy to maintain"]
        ),
        colors: ["Natural Hickory", "Smoked Hickory"],
        sizes: ["3\" x 36\"", "5\" x 36\""],
        inStock: true,
        stockQuantity: 45,
        rating: 4.7,
        reviewCount: 156,
        isProExclusive: true,
        isNew: false,
        isOnSale: true
    ),
    Product(
        id: "4",
        name: "Laminate Flooring - Gray Oak",
        description: "Modern laminate flooring with gray oak finish",
        category: .laminate,
        subcategory: "Laminate",
        price: 1.99,
        originalPrice: 2.49,
        currency: "USD",
        images: ["laminate"],
        specifications: ProductSpecifications(
            material: "Laminate",
            finish: "Textured",
            thickness: "8mm",
            coverage: "22 sq ft per box",
            installationType: "Click-lock",
            warranty: "20 years",
            features: ["Scratch resistant", "Easy to clean", "Budget friendly"]
        ),
        colors: ["Gray Oak", "Natural Oak", "White Oak"],
        sizes: ["7\" x 48\""],
        inStock: true,
        stockQuantity: 200,
        rating: 4.3,
        reviewCount: 89,
        isProExclusive: false,
        isNew: false,
        isOnSale: true
    ),
    Product(
        id: "5",
        name: "Glass Mosaic Tile - Blue",
        description: "Decorative glass mosaic tile for backsplash",
        category: .decoratives,
        subcategory: "Mosaic",
        price: 8.99,
        originalPrice: nil,
        currency: "USD",
        images: ["decorative"],
        specifications: ProductSpecifications(
            material: "Glass",
            finish: "Glossy",
            thickness: "8mm",
            coverage: "5 sq ft per sheet",
            installationType: "Thinset",
            warranty: "Lifetime",
            features: ["Stain resistant", "Easy to clean", "Decorative"]
        ),
        colors: ["Blue", "Green", "White"],
        sizes: ["12\" x 12\" sheet"],
        inStock: true,
        stockQuantity: 30,
        rating: 4.9,
        reviewCount: 67,
        isProExclusive: false,
        isNew: true,
        isOnSale: false
    ),
    Product(
        id: "6",
        name: "Bathroom Vanity - White",
        description: "Modern bathroom vanity with storage",
        category: .fixtures,
        subcategory: "Vanities",
        price: 299.99,
        originalPrice: 399.99,
        currency: "USD",
        images: ["carouselCabinets"],
        specifications: ProductSpecifications(
            material: "Wood",
            finish: "White",
            thickness: nil,
            coverage: nil,
            installationType: "Freestanding",
            warranty: "5 years",
            features: ["Storage included", "Easy installation", "Modern design"]
        ),
        colors: ["White", "Gray", "Oak"],
        sizes: ["36\"", "48\"", "60\""],
        inStock: true,
        stockQuantity: 15,
        rating: 4.6,
        reviewCount: 234,
        isProExclusive: false,
        isNew: false,
        isOnSale: true
    ),
    Product(
        id: "7",
        name: "Natural Stone - Travertine",
        description: "Classic travertine stone tile for elegant spaces",
        category: .stone,
        subcategory: "Travertine",
        price: 7.99,
        originalPrice: 9.99,
        currency: "USD",
        images: ["stone"],
        specifications: ProductSpecifications(
            material: "Travertine",
            finish: "Honed",
            thickness: "12mm",
            coverage: "12 sq ft per box",
            installationType: "Thinset",
            warranty: "Lifetime",
            features: ["Natural stone", "Unique variation", "Timeless appeal"]
        ),
        colors: ["Beige", "Cream", "Gold"],
        sizes: ["12\" x 12\"", "18\" x 18\""],
        inStock: true,
        stockQuantity: 25,
        rating: 4.8,
        reviewCount: 112,
        isProExclusive: false,
        isNew: false,
        isOnSale: true
    ),
    Product(
        id: "8",
        name: "Grout - Premium Plus",
        description: "Professional-grade grout for tile installations",
        category: .installationMaterials,
        subcategory: "Grout",
        price: 12.99,
        originalPrice: nil,
        currency: "USD",
        images: ["tile"],
        specifications: ProductSpecifications(
            material: "Cement-based",
            finish: "Sanded",
            thickness: nil,
            coverage: "25 sq ft per bag",
            installationType: "Professional",
            warranty: "5 years",
            features: ["Stain resistant", "Mold resistant", "Easy to clean"]
        ),
        colors: ["White", "Gray", "Beige", "Black"],
        sizes: ["25 lb bag"],
        inStock: true,
        stockQuantity: 100,
        rating: 4.4,
        reviewCount: 78,
        isProExclusive: true,
        isNew: false,
        isOnSale: false
    )
]

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
} 