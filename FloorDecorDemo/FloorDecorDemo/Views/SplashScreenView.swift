import SwiftUI
import AVKit

struct SplashScreenView: View {
    let onFinish: () -> Void
    @State private var player: AVPlayer? = nil
    @State private var isVideoFinished = false
    @State private var videoLoadFailed = false
    
    var body: some View {
        ZStack {
            if let player = player {
                // Red background when video is playing
                Color.red.ignoresSafeArea()
                VStack(spacing: 32) {
                    // Logo above the video
                    LogoView(size: 200, showTagline: false)
                        .foregroundColor(.white)
                        .shadow(radius: 8)
                        .padding(.top, -70)
                    
                    VideoPlayer(player: player)
                        .onAppear {
                            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                                isVideoFinished = true
                            }
                            player.play()
                        }
                        .aspectRatio(16/9, contentMode: .fit)
                        .frame(maxWidth: 400, maxHeight: 220)
                        .background(Color.red)
                        .cornerRadius(16)
                        .shadow(radius: 8)
                    
                    // Tagline below the video
                    Text("Your dream home.\n Our unbelievable prices.")
                        .font(.largeTitle.bold())
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(radius: 6)
                }
            } else {
                // Fallback: animated logo splash with red background
                AnimatedLogoSplash(onFinish: onFinish)
            }
        }
        .onChange(of: isVideoFinished) { oldValue, newValue in
            if newValue {
                onFinish()
            }
        }
        .onAppear {
            if let url = Bundle.main.url(forResource: "splash", withExtension: "mp4") {
                player = AVPlayer(url: url)
            } else {
                videoLoadFailed = true
            }
        }
    }
}

struct AnimatedLogoSplash: View {
    let onFinish: () -> Void
    @State private var showLogo = false
    @State private var showTagline = false
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            
            VStack(spacing: 30) {
                LogoView(size: 120, showTagline: false)
                    .foregroundColor(.white)
                    .scaleEffect(showLogo ? 1.0 : 0.8)
                    .opacity(showLogo ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.8), value: showLogo)
                
                if showTagline {
                    Text("Your dream home. Our unbelievable prices.")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .opacity(showTagline ? 1.0 : 0.0)
                        .animation(.easeInOut(duration: 0.6), value: showTagline)
                }
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.2)
                    .opacity(showTagline ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.4), value: showTagline)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showLogo = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                showTagline = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                onFinish()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(onFinish: {})
    }
} 
