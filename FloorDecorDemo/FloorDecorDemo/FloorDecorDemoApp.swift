//
//  FloorDecorDemoApp.swift
//  FloorDecorDemo
//
//  Created by Tarun Kurma on 7/7/25.
//

import SwiftUI
import UIKit

@main
struct FloorDecorDemoApp: App {
    @State private var showSplash = true
    
    init() {
        // Configure tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 234/255, green: 23/255, blue: 34/255, alpha: 1) // Floor & Decor red #ea1722
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 12)
        ]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 12)
        ]
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        // Add white border to top of tab bar
        UITabBar.appearance().layer.borderColor = UIColor.white.cgColor
        UITabBar.appearance().layer.borderWidth = 3.0
        UITabBar.appearance().clipsToBounds = true
        
        // Optimize app launch performance
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreenView {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showSplash = false
                    }
                }
            } else {
                MainTabView()
                    .transition(.opacity)
            }
        }
    }
}
