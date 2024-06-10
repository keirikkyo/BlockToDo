//
//  QuickLockView.swift
//  BlockToDo
//
//  Created by 吉江恵 on 2024/06/06.
//

import SwiftUI

struct QuickLockView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                   
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
           
            .background(
            BlobView()
                .blur(radius: 40)
            )
            .overlay(.regularMaterial)
            .navigationTitle("クイックロック")
        }
    }
    
}

#Preview {
    QuickLockView()
}
