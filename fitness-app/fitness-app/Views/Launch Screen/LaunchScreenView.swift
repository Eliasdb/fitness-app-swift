//
//  LaunchScreenView.swift
//  fitness-app
//
//  Created by Elias on 20/07/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State private var firstPhaseIsAnimating: Bool = false
    @State private var secondPhaseIsAnimating: Bool = false

    private let timer = Timer.publish(every: 0.65,
                                      on: .main,
                                      in: .common).autoconnect()
    var body: some View {
        ZStack {
            background
            logo
        }
        
        .onReceive(timer) { input in
            
            switch launchScreenManager.state {
                case .first:
                withAnimation(.spring()) {
                    // continuous scaling
                    firstPhaseIsAnimating.toggle()
                }
                case .second:
                withAnimation(.easeInOut) {
                    // second phase
                    secondPhaseIsAnimating.toggle()
                }
                default: break
            }
          
        }
        .opacity(secondPhaseIsAnimating ? 0 : 1)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenManager())
    }
}

private extension LaunchScreenView {
    var background: some View {
        Color("launch-screen-background")
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo: some View {
        Image("logo")
            .scaleEffect(firstPhaseIsAnimating ? 0.65 : 1)
            .scaleEffect(secondPhaseIsAnimating ? (UIApplication.shared.connectedScenes.first as! UIWindowScene).screen.nativeBounds.size.height / 4 : 1)
    }
}
