//
//  ClubScreenView.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import SwiftUI
import ScalingHeaderScrollView

struct ClubScreenView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var themeManager: ThemeManager
    @State var selected = "Squad"
    @State var progress: CGFloat = 0
    
    var body: some View {
        ScalingHeaderScrollView {
            VStack(spacing: 0) {
                ZStack {
                    Image(uiImage: themeManager.selectedTheme.headerImage)
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFit()
                        .background(.black)

                    hideHeaderContent(progress: progress)
                }
                
                SegmentedView(selected: $selected)
            }
        } content: {
            VStack(spacing: 0) {
                VStack {
                    switch selected {
                    case "Overview":
                        EmptyView(color: Color.purple)
                    case "Matches":
                        EmptyView(color: Color.cyan)
                    case "Groups":
                        EmptyView(color: Color.green)
                    case "Stats":
                        EmptyView(color: Color.yellow)
                    case "Squad":
                        ScrollView {
                            SquadView(viewModel: .init(networkService: MockNetworkService()))
                        }
                    default:
                        EmptyView(color: Color.white)
                    }
                }
            }
        }
        .collapseProgress($progress)
        .toolbar(content: {
            ToolbarItem(placement: .navigation) {
                Button {
                    dismiss()
                } label: {
                    Image(uiImage: UIImage(named: "whiteBackButtonImage") ?? UIImage())
                }
                .frame(width: 50, height: 50)
            }
        })
        .toolbarBackground(.hidden, for: .navigationBar)
        .ignoresSafeArea()
        .background(themeManager.selectedTheme.backgroundColor)
        .navigationBarBackButtonHidden(true)
    }
    
    var headerView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.squadName)
                .foregroundColor(.white)
                .font(.custom("Champions", size: 48))
                .padding(.top, 100)
            HStack(alignment: .bottom, content: {
                VStack(alignment: .leading){
                    Text("Playing")
                        .foregroundColor(Color(uiColor: .lightGray))
                        .font(.custom("SF Pro Text", size: 14) )
                    Text("Round of \(viewModel.roundNumber)")
                        .foregroundColor(.white)
                        .font(.custom("SF Pro Text", size: 16) )
                }
                Spacer()
                Image(uiImage: viewModel.squadCrest)
                    .frame(width: 110, height: 110)
            })
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    private func hideHeaderContent(progress: CGFloat) -> some View {
        headerView
            .opacity(1 - progress)
    }
}

#Preview {
    ClubScreenView(viewModel: .init())
        .environmentObject(ThemeManager())
}
