//
//  MenuView.swift
//  BlockToDo
//
//  Created by 吉江恵 on 2024/06/06.
//

import SwiftUI

struct MenuView: View {
    // 触覚タッチを呼び起こす状態変数
    @State private var feedback: Bool = false
    
    // アプリのバージョン情報を取得
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    var body: some View {
        NavigationStack {
            List {
                // ヘルプセクション
                Section(header: Text("ヘルプ").font(.headline)) {
                    NavigationLink("お問い合わせ", destination: Web(url: "https://forms.gle/Xn6qh3w3iLcVZFHv9", title: "お問い合わせ"))
                }
                .listRowBackground(Color.gray.opacity(0.1))
                .accentColor(.primary)
                
                // 情報セクション
                Section(header: Text("情報").font(.headline)) {
                    NavigationLink("利用規約", destination: Web(url: "https://furtive-angle-db9.notion.site/57d57537b23449748c75cdb2c062d4e0?pvs=4", title: "利用規約"))
                    NavigationLink("プライバシーポリシー", destination: Web(url: "https://furtive-angle-db9.notion.site/8c25d26f8b1e4aa6a88686e2d7910769?pvs=4", title: "プライバシーポリシー"))
                    
                    // バージョン情報表示
                    HStack {
                        Text("バージョン")
                        Spacer()
                        Text(version)
                            .foregroundColor(.gray)
                    }
                }
                .listRowBackground(Color.gray.opacity(0.1))
                .accentColor(.primary)
                
                // 著作権表示
                HStack {
                    Spacer()
                    Text("© 2024 Kei Yoshie")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
            .fontWeight(.medium)
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .navigationBarBackButtonHidden()
            .navigationTitle("メニュー")
        }
        .ignoresSafeArea()
    }
}
#Preview {
    MenuView()
}
