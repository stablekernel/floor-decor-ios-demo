import SwiftUI

struct ARView: View {
    @State private var showingCameraPermission = false
    @State private var isARActive = false
    @State private var selectedProduct: Product?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // AR Preview Header
                VStack(spacing: 16) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("AR Preview")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("See how flooring looks in your space")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                Spacer()
                
                // AR Features
                VStack(spacing: 16) {
                    ARFeatureCard(
                        title: "Room Scanner",
                        subtitle: "Scan your room to get started",
                        icon: "viewfinder",
                        color: .blue
                    )
                    
                    ARFeatureCard(
                        title: "Product Overlay",
                        subtitle: "See products in your space",
                        icon: "square.3.layers.3d",
                        color: .green
                    )
                    
                    ARFeatureCard(
                        title: "Lighting Simulation",
                        subtitle: "Test different lighting conditions",
                        icon: "lightbulb.fill",
                        color: .orange
                    )
                    
                    ARFeatureCard(
                        title: "Measurement Tools",
                        subtitle: "Measure and calculate coverage",
                        icon: "ruler",
                        color: .purple
                    )
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Start AR Button
                Button(action: {
                    showingCameraPermission = true
                }) {
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("Start AR Preview")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemBackground))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    LogoView(size: 80, showTagline: false)
                }
            }
            .alert("Camera Permission", isPresented: $showingCameraPermission) {
                Button("Allow") {
                    // Request camera permission
                    requestCameraPermission()
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("AR Preview needs camera access to show products in your space.")
            }
        }
    }
    
    private func requestCameraPermission() {
        // In a real app, this would request camera permissions
        // and then start the AR session
        print("Requesting camera permission...")
    }
}

struct ARFeatureCard: View {
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
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.5))
        .cornerRadius(12)
    }
}

struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView()
    }
} 