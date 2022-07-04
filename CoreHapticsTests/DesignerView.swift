//
//  DesignerView.swift
//  CoreHapticsTests
//
//  Created by Peter Hartnett on 7/2/22.
//

import SwiftUI

struct DesignerView: View {
    var hapticManager:HapticManager?
    
    @State private var intensity = 0.5
    @State private var randomIntensity = false
    @State private var sharpness = 0.5
    @State private var randomSharpness = false
    @State private var duration = 1.0
    @State private var randomDuration = false
    
    var body: some View {
        
        VStack{
            Label("Haptic Designer", systemImage: "gearshape.2")
            
            List{
                Section(){
                    randomIntensity ? nil : (Slider(value: $intensity, in: 0...1, step: 0.01))
                    Toggle("Random", isOn: $randomIntensity.animation())
                        .background()
                } header: {
                    Text("Intensity: \(intensity)")
                }
                Section(){
                    randomSharpness ? nil : Slider(value: $sharpness, in: 0...1, step: 0.01)
                    Toggle("Random Sharpness", isOn: $randomSharpness.animation())
                        .background()
                } header: {
                    Text("Sharpness: \(sharpness)")
                }
                Section(){
                    randomDuration ? nil : Slider(value: $duration, in: 0...1, step: 0.01)
                    Toggle("Random Duration", isOn: $randomDuration.animation())
                        .background()
                } header: {
                    Text("Duration: \(duration)")
                }
                
                
                
            }
            //.animation(.default, value: randomIntensity)
            
            .listStyle(.sidebar)
            Button(){
                hapticManager?.playHaptic(
                    sharpness: randomSharpness ? Double.random(in: 0...1.0) : sharpness,
                    intensity: randomIntensity ? Double.random(in: 0...1.0) : intensity)
            } label: {
                Text("Test Haptic")
            }
            .padding()
            .background(.thickMaterial)
        }
    }
}

struct DesignerView_Previews: PreviewProvider {
    static var previews: some View {
        DesignerView(hapticManager: HapticManager())
    }
}
