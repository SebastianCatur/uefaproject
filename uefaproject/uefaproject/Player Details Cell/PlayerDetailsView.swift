//
//  PlayerDetailsView.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import SwiftUI

struct PlayerDetailsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    let player: Player
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: UIImage(named: "playerImage") ?? UIImage())
                VStack(alignment: .leading, content: {
                    Text(player.playerName)
                        .font(.custom("SF Pro Text", size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Text(player.country)
                        .font(.custom("SF Pro Text", size: 12))
                        .foregroundColor(Color(uiColor: .lightGray))
                })
                
                Spacer()
                Text("\(player.points)")
                    .font(.custom("Champions", size: 20))
                    .foregroundColor(.white)
            }
            Capsule()
                .fill(.white)
                .frame(height: 1)
                .opacity(0.1)
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .background(themeManager.selectedTheme.cellBackgroundColor)
    }
}

#Preview {
    let player = Player(playerName: "Lionel", country: "country", points: 1, playerRole: "goalkeeper", playerImage: "")
    PlayerDetailsView(player: player)
        .environmentObject(ThemeManager())
}
