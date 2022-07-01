//
//  ContentView.swift
//  CoreHapticsTests
//
//  Created by Peter Hartnett on 6/30/22.
//
//Just a test field to make sure that things work and show the useage of the Class

import SwiftUI
struct ButtonCode{
    var closure: (() -> Void)?
    var name: String
}




struct ContentView: View {
    //This version lets us call any haptic event via the below button, if its availible and not nil it will run the function, if not nothing happens. Pretty clean implementation.
    private var hapticManager = HapticManager()
    
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 200)),
    ]
    
    var body: some View {
        LazyVGrid(columns: layout){
            
            Button(){
                hapticManager?.playHudsonOne() ?? {
                    print("haptics not availible")
                }()
                
            } label: {
                Text("Hudson Thump")
                    .padding(10)
                    .background(.secondary)
            }
            
            Button("SOS"){
                hapticManager?.playSOS()
            }.padding()
                
            Button(){
                //With this hapticManager system this is how we call an actual haptic event, the ? if missing will flag errors as well, seems good. The optional for if there is no haptics is more concise than an if statement here, but it is a little less obvious to a reader that doesn't understand optionals fully. I wonder if this is faster than an if else statement?
                // Also of note, when using autocomplete to fill in a .playxxx() it will add the ? to hapticManager automatically
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
