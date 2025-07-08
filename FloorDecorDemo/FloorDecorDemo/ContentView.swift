//
//  ContentView.swift
//  FloorDecorDemo
//
//  Created by Tarun Kurma on 7/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Text("Floor & Decor")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.blue)
                    
                    Text("Your Home, Your Style")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)
                
                Spacer()
                
                // Main Content
                VStack(spacing: 30) {
                    // Quick Actions
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 20) {
                        QuickActionCard(
                            title: "Browse Products",
                            subtitle: "Find your perfect flooring",
                            icon: "house.fill",
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
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Footer
                Text("Welcome to Floor & Decor")
                    .font(.title2)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct QuickActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(color)
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
