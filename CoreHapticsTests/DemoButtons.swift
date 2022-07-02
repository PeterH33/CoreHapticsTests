//
//  buttons.swift
//  CoreHapticsTests
//
//  Created by Peter Hartnett on 7/2/22.
//

import SwiftUI

//I am sure that there is a way to simplify this and not have to repeatedly make buttons instead just passing in the function and name
struct DemoButtons: View {
    var hapticManager:HapticManager?
    
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 200)),
    ]
    
    var body: some View {
        
        LazyVGrid(columns: layout){
            
            Button(){
                hapticManager?.playRandomDice() ?? {
                    print("haptics not availible")
                }()
            } label: {
                Text("Random Dice")
                    .padding(10)
                    .background(.secondary)
            }
            
            Button(){
                hapticManager?.playHudsonOne() ?? {
                    print("haptics not availible")
                }()
            } label: {
                Text("Hudson Thump")
                    .padding(10)
                    .background(.secondary)
            }
            
            Button(){
                hapticManager?.playSOS()
            } label: {
                Text("SOS")
                    .padding()
                    .background(.secondary)
            }
            
            Button(){
                hapticManager?.playBoomSparkle()
            } label: {
                Text("Boom Sparkle")
                    .padding()
                    .background(.secondary)
            }
            
            Button(){
                hapticManager?.playSlice() ?? {
                    print("no haptics!")
                }()
            } label: {
                Text("Tetlaw Slice")
                    .padding(10)
                    .background(.secondary)
            }
            
        }
        
    }
}
