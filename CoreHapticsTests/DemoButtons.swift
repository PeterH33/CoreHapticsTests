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
    var body: some View {
        Group{
            //With this hapticManager system this is how we call an actual haptic event, the ? if missing will flag errors as well, seems good. The optional for if there is no haptics is more concise than an if statement here, but it is a little less obvious to a reader that doesn't understand optionals fully. I wonder if this is faster than an if else statement?
            // Also of note, when using autocomplete to fill in a .playxxx() it will add the ? to hapticManager automatically
            
            
            Button(){
                hapticManager?.playSOS()
            } label: {
                Text("SOS")
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
