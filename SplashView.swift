//
//  SplashView.swift
//  
//
//  Created by Aaron on 2024/12/30.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    @State private var flipAngle = Double.zero
    @State private var gradientColors = [Color.red, Color.orange]
    @State private var animateGradient = false
    
    let txt = Array("輸入文字")
    
    var body: some View {
        if isActive {
            MainView() // 進入主畫面
        } else {
            ZStack {
                // 背景漸層呼吸燈
                LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
                .onAppear {
                    withAnimation(
                        Animation.easeInOut(duration: 3.0)
                            .repeatForever(autoreverses: true)
                    ) {
                        animateGradient.toggle()
                    }
                }
                .onChange(of: animateGradient) { newValue in
                    gradientColors = newValue
                    ? [Color.yellow, Color.red]
                        : [Color.red, Color.orange]
                }
                
                VStack {
                    HStack(spacing: 0) {
                        ForEach(0..<txt.count, id: \.self) { flip in
                            Text(String(txt[flip]))
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                                .rotation3DEffect(
                                    .degrees(flipAngle),
                                    axis: (x: 1, y: 0, z: 1)
                                )
                                .animation(.easeInOut(duration: 1).delay(Double(flip) * 0.1), value: flipAngle)
                        }
                    }
                    .onAppear {
                        flipAngle = 360 // 啟動動畫
                    }
                }
            }
            .onAppear {
                // 延遲後進入主畫面
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

struct MainView: View {
    var body: some View {
        Text("主畫面")
            .font(.title)
            .bold()
    }
}

#Preview {
    SplashView()
}
