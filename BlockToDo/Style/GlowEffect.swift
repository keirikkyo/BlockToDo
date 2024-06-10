//
//  GloEffect.swift
//  BlockToDo
//
//  Created by 吉江恵 on 2024/06/07.
//

import SwiftUI

struct Glow: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            content.blur(radius:15)
            content
        }
    }
}

extension View {
    func glow() -> some View {
        modifier(Glow())
    }
}
                        
