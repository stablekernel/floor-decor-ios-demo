import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("HOME").font(.system(size: 12, weight: .bold))
                }
                .tag(0)
            
            CatalogView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("CATALOG").font(.system(size: 12, weight: .bold))
                }
                .tag(1)
            
            ARView()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("AR PREVIEW").font(.system(size: 12, weight: .bold))
                }
                .tag(2)
            
            StoreLocatorView()
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("STORES").font(.system(size: 12, weight: .bold))
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("PROFILE").font(.system(size: 12, weight: .bold))
                }
                .tag(4)
        }
    }
}

struct HomeView: View {
    @State private var showSplashScreen = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Carousel below the logo
                    HomeCarouselView()
                    // Featured Categories
                    FeaturedCategoriesSection()
                    // Quick Actions
                    QuickActionsSection()
                    // Deals & Promotions
                    DealsSection()
                    // Pro Services
                    ProServicesSection()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemBackground))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button(action: { showSplashScreen = true }) {
                        LogoView(size: 80, showTagline: false)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .fullScreenCover(isPresented: $showSplashScreen) {
                SplashScreenView(onFinish: { showSplashScreen = false })
            }
        }
    }
}

// Carousel Data Model
struct CarouselItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
    let buttonTitle: String?
    let buttonAction: (() -> Void)?
}

// Carousel View
struct HomeCarouselView: View {
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let items: [CarouselItem] = [
        CarouselItem(
            imageName: "tile",
            title: "Your dream kitchen.",
            subtitle: "Our unbelievable prices.",
            buttonTitle: "Shop Kitchen",
            buttonAction: nil
        ),
        CarouselItem(
            imageName: "carouselCabinets",
            title: "",
            subtitle: "",
            buttonTitle: "Shop Cabinets",
            buttonAction: nil
        ),
        CarouselItem(
            imageName: "carouselVinyl",
            title: "",
            subtitle: "",
            buttonTitle: "Shop Vinyl",
            buttonAction: nil
        ),
        CarouselItem(
            imageName: "carouselTile",
            title: "Porcelain Mosaic",
            subtitle: "Durable Thin Tile",
            buttonTitle: "Shop Tile",
            buttonAction: nil
        )
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            TabView(selection: $currentIndex) {
                ForEach(Array(items.enumerated()), id: \ .offset) { index, item in
                    ZStack(alignment: .bottomLeading) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180)
                            .clipped()
                            .cornerRadius(16)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                            Text(item.subtitle)
                                .font(.headline)
                                .foregroundColor(.white)
                                .shadow(radius: 2)
                            if let buttonTitle = item.buttonTitle {
                                Button(action: { item.buttonAction?() }) {
                                    Text(buttonTitle)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(20)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 200)
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % items.count
                }
            }
            // Page indicators
            HStack(spacing: 8) {
                ForEach(0..<items.count, id: \ .self) { i in
                    Circle()
                        .fill(i == currentIndex ? Color.red : Color.gray.opacity(0.4))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}

struct LogoSection: View {
    var body: some View {
        VStack(spacing: 12) {
            // Floor & Decor Logo
            LogoView(size: 80, showTagline: true)
                .padding(.horizontal)
        }
        .padding(.top, 20)
    }
}

struct HeroSection: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Your dream kitchen")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Our unbelievable prices.")
                .font(.title2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Text("Investing in your home just got easier.")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button(action: {
                // Navigate to catalog
            }) {
                Text("Shop Now")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.systemGray6).opacity(0.3),
                    Color(.systemBackground)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }
}

struct QuickActionsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Quick Actions")
                .font(.title2)
                .fontWeight(.bold)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                QuickActionCard(
                    title: "Find Products",
                    subtitle: "Browse our catalog",
                    icon: "magnifyingglass",
                    color: .blue
                )
                
                QuickActionCard(
                    title: "AR Preview",
                    subtitle: "See it in your space",
                    icon: "camera.fill",
                    color: .green
                )
                
                QuickActionCard(
                    title: "Store Locator",
                    subtitle: "Find nearby locations",
                    icon: "location.fill",
                    color: .orange
                )
                
                QuickActionCard(
                    title: "Loyalty",
                    subtitle: "Track your rewards",
                    icon: "star.fill",
                    color: .purple
                )
            }
        }
    }
}

struct FeaturedCategoriesSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Featured Categories")
                .font(.title2)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(ProductCategory.allCases.prefix(6), id: \.self) { category in
                        CategoryCard(category: category)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct CategoryCard: View {
    let category: ProductCategory
    
    var body: some View {
        VStack(spacing: 8) {
            // Icon/image fills the box
            Group {
                switch category {
                case .wood:
                    Image("wood")
                        .resizable()
                        .scaledToFit()
                case.laminate:
                    Image("laminate")
                        .resizable()
                        .scaledToFit()
                case .tile:
                    Image("tile")
                        .resizable()
                        .scaledToFit()
                case .stone:
                    Image("stone")
                        .resizable()
                        .scaledToFit()
                case.vinyl:
                    Image("vinyl")
                        .resizable()
                        .scaledToFit()
                case.decoratives:
                    Image("decorative")
                        .resizable()
                        .scaledToFit()
                default:
                    Image(systemName: category.icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(category.color)
                }
            }
            .frame(width: 100, height: 100)
            .background(Color(.systemGray6).opacity(0.5))
            .cornerRadius(12)
            
            // Label below the box
            Text(category.rawValue)
                .font(.headline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
}

struct DealsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Deals & Promotions")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DealCard(
                    title: "Luxury Vinyl Plank",
                    subtitle: "Under $1.99/sqft",
                    color: .green
                )
                
                DealCard(
                    title: "Large Format Tile",
                    subtitle: "Under $2.99/sqft",
                    color: .blue
                )
                
                DealCard(
                    title: "18 Month Financing",
                    subtitle: "Special financing available",
                    color: .purple
                )
            }
        }
    }
}

struct DealCard: View {
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "arrow.right")
                .foregroundColor(color)
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

struct ProServicesSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Pro Services")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                ServiceCard(
                    title: "Design Services",
                    subtitle: "Free professional design help",
                    icon: "paintbrush.fill"
                )
                
                ServiceCard(
                    title: "Bulk Orders",
                    subtitle: "Special pricing for pros",
                    icon: "cube.box.fill"
                )
                
                ServiceCard(
                    title: "Installation",
                    subtitle: "Professional installation services",
                    icon: "wrench.and.screwdriver.fill"
                )
            }
        }
    }
}

struct ServiceCard: View {
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
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
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.5))
        .cornerRadius(12)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
} 
