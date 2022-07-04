//
//  buttons.swift
//  CoreHapticsTests
//
//  Created by Peter Hartnett on 7/2/22.
//

import SwiftUI


struct DemoButtons: View {
    var hapticManager:HapticManager?
    
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 200)),
    ]
    
    var body: some View {
        VStack{
            Label("Demo/Previews", systemImage: "gear")
            LazyVGrid(columns: layout){
                //TODO: This should really be a foreach with some sort of simple reference list derived from the availible functions in haptics.
                
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
            Spacer()
        }
        
    }
}

struct DemoButtons_Previews: PreviewProvider {
    static var previews: some View {
        DemoButtons(hapticManager: HapticManager())
    }
}
