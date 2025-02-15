//
//  BlobView.swift
//  BlockToDo
//
//  Created by 吉江恵 on 2024/06/08.
//

import SwiftUI

struct BlobView: View {
    @State var appear = false // アニメーションの状態を管理するための状態変数

    var body: some View {
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate // 現在のタイムラインの日付を取得
            let angle = Angle.degrees(now.remainder(dividingBy: 3) * 60) // アニメーションの角度を計算
            let x = cos(angle.radians) // 角度に基づいてx座標を計算
            let angle2 = Angle.degrees(now.remainder(dividingBy: 6) * 10) // 別のアニメーション角度を計算
            let x2 = cos(angle2.radians) // 別の角度に基づいてx2座標を計算

            Canvas { context, size in
                context.fill(
                    path(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), x: x, x2: x2), // パスを描画
                    with: .linearGradient(
                        Gradient(colors: [.pink, .blue]), // ピンクからブルーへのグラデーションを使用
                        startPoint: CGPoint(x: 0, y: 0), // グラデーションの開始点
                        endPoint: CGPoint(x: size.width, y: size.height) // グラデーションの終了点
                    )
                )
            }
            .frame(width: 850, height: 850) // 描画するキャンバスのフレームサイズ
            .rotationEffect(.degrees(appear ? 360 : 0)) // 回転アニメーションの効果
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 20).repeatForever(autoreverses: true)) {
                appear = true // ビューが表示されたときにアニメーションを開始
            }
        }
    }
    
    // パスを生成する関数
    func path(in rect: CGRect, x: Double, x2: Double) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.9923 * width, y: 0.42593 * height))
        path.addCurve(
            to: CGPoint(x: 0.6355 * width * x2, y: height),
            control1: CGPoint(x: 0.92554 * width * x2, y: 0.77749 * height * x2),
            control2: CGPoint(x: 0.91864 * width * x2, y: height)
        )
        path.addCurve(
            to: CGPoint(x: 0.08995 * width, y: 0.60171 * height),
            control1: CGPoint(x: 0.35237 * width * x, y: height),
            control2: CGPoint(x: 0.2695 * width, y: 0.77304 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.34086 * width, y: 0.06324 * height * x),
            control1: CGPoint(x: -0.0896 * width, y: 0.43038 * height),
            control2: CGPoint(x: 0.00248 * width, y: 0.23012 * height * x)
        )
        path.addCurve(
            to: CGPoint(x: 0.9923 * width, y: 0.42593 * height),
            control1: CGPoint(x: 0.67924 * width, y: -0.10364 * height * x),
            control2: CGPoint(x: 1.05906 * width, y: 0.07436 * height * x2)
        )
        path.closeSubpath()
        return path
    }
}


#Preview {
    BlobView()
}
