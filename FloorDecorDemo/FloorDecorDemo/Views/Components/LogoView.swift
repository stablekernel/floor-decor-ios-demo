import SwiftUI

struct LogoView: View {
    let size: CGFloat
    let showTagline: Bool
    
    init(size: CGFloat = 60, showTagline: Bool = true) {
        self.size = size
        self.showTagline = showTagline
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .accessibilityIdentifier("Logo")
            
            if showTagline {
                Text("Your Home, Your Style")
                    .font(.system(size: size * 0.15, weight: .medium, design: .default))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct CompactLogoView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            LogoView(size: 80, showTagline: true)
            LogoView(size: 40, showTagline: false)
            CompactLogoView()
        }
        .padding()
    }
} 