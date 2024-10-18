//
//  SquadView.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import SwiftUI

struct SquadView: View {
    @StateObject var viewModel: ViewModel
    @EnvironmentObject private var themeManager: ThemeManager
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(viewModel.roles) { role in
                Text(role.name)
                    .foregroundColor(.white)
                    .font(.custom("SF Pro Display", size: 20))
                    .fontWeight(.medium)
                    .padding(.leading, 16)
                    .padding(.vertical, 16)
                ForEach(role.players, id: \.id) {
                    PlayerDetailsView(player: $0)
                }
            }
        }
        .background(themeManager.selectedTheme.cellBackgroundColor)
    }
}

#Preview {
    SquadView(viewModel: .init())
        .environmentObject(ThemeManager())
}
