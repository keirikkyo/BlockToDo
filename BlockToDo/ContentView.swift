//
//  ContentView.swift
//  BlockToDo
//
//  Created by 吉江恵 on 2024/05/27.
//
import SwiftUI
import FamilyControls
import ManagedSettings

let gradientView = LinearGradient(
    gradient: Gradient(colors: [.purple, .pink]),
    startPoint: .topLeading,
    endPoint: .bottomTrailing)

struct ContentView: View {
    @State private var isTaskStarted = false // タスクの開始状態を管理
    @State private var isPresented = false // FamilyActivityPickerの表示状態を管理
    @State private var selectionToDiscourage = FamilyActivitySelection() // 制限するアプリの選択を管理
    @State private var authorizationStatus: AuthorizationStatus = .notDetermined // 認証ステータスを管理
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    // ボタンの状態に応じて表示を切り替え
                    if isTaskStarted {
                        // "タスク完了"ボタン
                        Button(action: {
                            completeTask()
                        }, label:  {
                            HStack {
                                Image(systemName: "lock.open.fill")
                                Text("タスク完了")
                                    .padding(.trailing)
                            }
                            .font(.title2)
                            .fontWeight(.bold)
                        })
                        .buttonStyle(RoundedButtonStyle())
                        .padding()
                        .padding(.bottom, 100)
                    } else {
                        // "タスク開始"ボタン
                        Button(action: {
                            applyRestrictions()
                        }, label:  {
                            HStack {
                                Image(systemName: "lock.fill")
                                Text("タスク開始")
                                    .padding(.trailing)
                            }
                            .font(.title2)
                            .fontWeight(.bold)
                        })
                        .buttonStyle(RoundedButtonStyle())
                        .padding()
                        .padding(.bottom, 100)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .background(
                BlobView()
                    .blur(radius: 80)
            )
            .navigationTitle("タスクロック")
            .toolbar() {
                ToolbarItem(placement: .topBarTrailing) {
                    ZStack {
                        // ScreenTimeの使用を許可するボタン。タップでauthorize()を呼び出す
                        Button(action: {
                            Task {
                                await authorize()
                            }
                        }, label:  {
                            HStack {
                                Image(systemName: "person.crop.circle.badge.checkmark")
                            }
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.bl1)
                        })
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    // 制限するアプリを選択するボタン。タップでisPresentedをtrueにする。
                    Button(action: {
                        isPresented = true
                    }, label:  {
                        HStack {
                            Image(systemName: "plus.app")
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.bl1)
                    })
                    .familyActivityPicker(
                        isPresented: $isPresented,
                        selection: $selectionToDiscourage
                    )
                }
            }
            .onAppear {
                // ビューが表示された時に認証ステータスをチェックする。
                checkAuthorizationStatus()
            }
        }
    }
    
    // 非同期でScreenTimeの使用許可をリクエストする関数
    func authorize() async {
        do {
            // AuthorizationCenterを使って許可をリクエスト
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            // 許可ステータスを更新
            authorizationStatus = AuthorizationCenter.shared.authorizationStatus
        } catch {
            // 許可が拒否された場合の処理
            authorizationStatus = .denied
            print("Authorization failed: \(error.localizedDescription)")
        }
    }
    
    // 現在の認証ステータスをチェックする関数
    func checkAuthorizationStatus() {
        authorizationStatus = AuthorizationCenter.shared.authorizationStatus
    }
    
    // 選択されたアプリに対して制限を適用する関数
    func applyRestrictions() {
        // 許可が必要であることを確認
        guard authorizationStatus == .approved else {
            print("Authorization is required to apply restrictions")
            return
        }
        
        // 選択されたアプリのトークンを取得
        let applications = selectionToDiscourage.applicationTokens
        
        // ManagedSettingsStoreを使って制限を適用
        let store = ManagedSettingsStore(named: .init("RestrictionStore"))
        store.shield.applications = applications.isEmpty ? nil : Set(applications)
        
        // タスクの開始状態を更新
        isTaskStarted = true
    }
    
    // タスク完了時に制限を解除する関数
    func completeTask() {
        // ManagedSettingsStoreを使って制限を解除
        let store = ManagedSettingsStore(named: .init("RestrictionStore"))
        store.shield.applications = nil
        
        // タスクの開始状態を更新
        isTaskStarted = false
    }
}

// 角丸ボタンを定義
struct RoundedButtonStyle: ButtonStyle {
    let graBlue = LinearGradient(
        gradient: Gradient(colors: [.bl1, .bl2]),
        startPoint: .top,
        endPoint: .bottom)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 260)
            .foregroundStyle(.white)
            .background(graBlue)
            .cornerRadius(40)
            .opacity(configuration.isPressed ? 0.2 : 1)
           
    }
}

#Preview {
    ContentView()
}

