//
//  ContentView.swift
//  CoreHapticsTests
//
//  Created by Peter Hartnett on 6/30/22.
//
//  Descriptions for how the haptics class work are in haptics.swift

import SwiftUI


struct ContentView: View {
    
    private var hapticManager = HapticManager()
    
    var body: some View {
        VStack{
            
            
            TabView{
                DemoButtons(hapticManager: hapticManager)
                    .tabItem{
                        Label("Demo", systemImage: "gear")
                    }
                DesignerView(hapticManager: hapticManager)
                    .tabItem{
                        Label("Haptic Designer", systemImage: "gearshape.2")
                    }
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
