//
//  Theme.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import SwiftUI

protocol ThemeProtocol {
    var backgroundColor: Color { get }
    var cellBackgroundColor: Color { get }
    var segementColor: Color { get }
    var headerImage: UIImage { get }
}

struct UCLTheme: ThemeProtocol {
    var backgroundColor: Color { return Color("blueBackgroundColor") }
    var cellBackgroundColor: Color { return Color("cellBlueColorBackground") }
    var segementColor: Color { Color("UCLGreenColor") }
    var headerImage: UIImage { UIImage(named: "uclHeader") ?? UIImage() }
}

struct UELTheme: ThemeProtocol {
    var backgroundColor: Color { return Color("blackBackgroundColor") }
    var cellBackgroundColor: Color { return Color("cellBlackColorBackground") }
    var segementColor: Color { Color("uelOrangeColor") }
    var headerImage: UIImage { UIImage(named: "uelHeader") ?? UIImage() }
}

class ThemeManager: ObservableObject {
    @Published var selectedTheme: ThemeProtocol = UCLTheme()
    
    func setTheme(_ theme: ThemeProtocol) {
        selectedTheme = theme
    }
}
