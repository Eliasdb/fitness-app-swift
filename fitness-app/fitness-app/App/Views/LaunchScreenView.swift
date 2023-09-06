//
//  LaunchScreenView.swift
//  fitness-app
//
//  Created by Elias on 20/07/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State private var firstPhaseIsAnimating: Bool = false
    
    private let timer = Timer.publish(every: 0.65,
                                      on: .main,
                                      in: .common).autoconnect()
    var body: some View {
        ZStack {
            background
            logo
        }
        
        .onReceive(timer) { input in
            // continuous scaling
            withAnimation(.spring()) {
                firstPhaseIsAnimating.toggle()
            }
        }
       
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

private extension LaunchScreenView {
    var background: some View {
        Color("launch-screen-background")
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo: some View {
        Image("logo")
            .scaleEffect(firstPhaseIsAnimating ? 0.6 : 1)
    }
}
