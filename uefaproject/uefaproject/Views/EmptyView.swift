//
//  EmptyView.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import SwiftUI

struct EmptyView: View {
    @State var color = Color(uiColor: .white)
    var body: some View {
        VStack {
        }
        .frame(maxWidth: .infinity, minHeight: 1000, maxHeight: .infinity)
        .background(color)
    }
}
