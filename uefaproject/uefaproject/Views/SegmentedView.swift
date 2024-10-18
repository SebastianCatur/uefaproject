//
//  SegmentedView.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import SwiftUI

struct SegmentedView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    let segments = ["Overview", "Matches", "Groups", "Stats", "Squad"]
    @Binding var selected: String
    
    var body: some View {
        HStack {
            ForEach(segments, id: \.self) { segment in
                Button {
                    selected = segment
                } label: {
                    VStack {
                        Text(segment)
                            .font(.custom("SF Pro Text", size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(selected == segment ? themeManager.selectedTheme.segementColor : Color(uiColor: .white))
                        ZStack {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 3)
                            if selected == segment {
                                Capsule()
                                    .fill(themeManager.selectedTheme.segementColor)
                                    .frame(height: 3)
                            }
                        }
                    }
                    .padding(.top, 5)
                }
            }
        }
        .frame(height: 44)
        .background(themeManager.selectedTheme.cellBackgroundColor)
    }
}
