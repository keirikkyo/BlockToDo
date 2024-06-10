//
//  CustomTabView.swift
//  BlockToDo
//
//  Created by 吉江恵 on 2024/06/06.
//

import SwiftUI

struct CustomTabView: View {
    @State var selectedTab: Tab = .taskLock
    @State var color: Color = .bl1
    
    var body: some View {
        ZStack (alignment: .bottom) {
            
            Group {
                switch selectedTab {
                case .taskLock:
                    ContentView()
                case .timeLock:
                    TimelockView()
                case .quickLock:
                    QuickLockView()
                case .menuView:
                    MenuView()
                }
            }
            
            HStack {
                ForEach(tabItems) { item in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = item.tab
                            color = item.color
                        }
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: item.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 44, height: 29)
                            Text(item.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(selectedTab == item.tab ? .bl1 : .secondary)
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: 88, alignment: .top)
            .background(.clear, in: RoundedRectangle(cornerRadius: 0, style: .continuous))
            .overlay(
                HStack {
                    if selectedTab == .menuView { Spacer() }
                    if selectedTab == .timeLock { Spacer() }
                    if selectedTab == .quickLock {
                        Spacer()
                        Spacer()
                    }
                    Rectangle()
                        .fill(color)
                        .frame(width: 28, height: 5)
                        .cornerRadius(3)
                        .frame(width: 80)
                        .frame(maxHeight: .infinity, alignment: .top)
                    if selectedTab == .taskLock { Spacer() }
                    if selectedTab == .timeLock {
                        Spacer()
                        Spacer()
                        
                    }
                    if selectedTab == .quickLock { Spacer() }
                }
                .padding(.horizontal, 12)
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem(text: "ホーム", icon: "house", tab: .taskLock, color: .bl1),
    TabItem(text: "タイムロック", icon: "deskclock", tab: .timeLock, color: .bl1),
    TabItem(text: "クイックロック", icon: "checkmark.circle", tab: .quickLock, color: .bl1),
    TabItem(text: "メニュー", icon: "rectangle.stack", tab: .menuView, color: .bl1)
]

enum Tab: String {
    case taskLock
    case timeLock
    case quickLock
    case menuView
}
#Preview {
    CustomTabView()
}
