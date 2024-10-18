//
//  ContentView.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import SwiftUI

struct ContentView: View {
    @State var selection: String? = nil
    @StateObject var themeManager = ThemeManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("UCL") {
                    ClubScreenView(viewModel: .init())
                    .environmentObject(themeManager)
                }
                .simultaneousGesture(TapGesture().onEnded({
                    themeManager.setTheme(UCLTheme())
                }))
                
                NavigationLink("UEL") {
                    ClubScreenView(viewModel: .init())
                    .environmentObject(themeManager)
                    
                }
                .simultaneousGesture(TapGesture().onEnded({
                    themeManager.setTheme(UELTheme())
                }))
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
}
