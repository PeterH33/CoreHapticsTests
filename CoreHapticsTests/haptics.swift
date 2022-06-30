//
//  haptics.swift
//  CoreHapticsTests
//
//  Created by Peter Hartnett on 6/30/22.
//  Concepts and code parts from Andrew Tetlaw at https://www.raywenderlich.com/10608020-getting-started-with-core-haptics
//  and from Paul Hudson at https://www.hackingwithswift.com/example-code/core-haptics/how-to-play-custom-vibrations-using-core-haptics

//The point of this class is to make the CoreHaptics system a bit easier to implement in a swiftui project.
// Useage:
// 1- Drop this file into a project.
// 2- Where you want to use haptics create an instance of this class
// 3- use yourClassInstance?.playSlice to play that haptic as defined below
// 4- if you want to use an alternate code when haptics is not availible, follow #3 with ?? { what you want to do without haptics }()
// 5- Define new haptic patterns using the format below in the HapticManager extensions

// I am sure there is a better way to write all of the above let me know if it is hard to understand or if there are other issues that arrise

//TODO: Extend the code further to allow for encoding and decoding patterns to send to other people, or to save in the case of a system that would give a visual system for creating haptics
//TODO: Create a visual haptics creator program to accompany this format.
//Something with a gui that covers the possible variables, lets you play test the haptic, and then lets you save out the file for use in a program.
//The HapticManager class would then need a way to load the encoded data for use in a program... perhaps the file could simply be in the extension format below
import Foundation
import CoreHaptics

class HapticManager {
    //This pattern is a combination of those presented by Andrew Tetlaw and Paul Hudson, picking things that make more sense logically and can help to simplify and reduce the number of complications and further optional questions in the code.
    let hapticEngine: CHHapticEngine
    
    //should be able to check if haptics manager is nil to verify the use of haptics with this method. Using init? and returning nil for init allows for a simplified call to haptic functions elsewhere in the program
    init?() {
        
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("haptics not supported on device")
            return nil
        }
        
        //here we are testing the creation of an engine and also whether it can actually start.
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine.start()
        } catch {
            print("Haptic engine Creation Error: \(error.localizedDescription)")
            return nil
        }
        
        // The engine stopped; print out why
        // This will happen shortly after every use of the haptic engine, it saves power by not having the haptic engine running constantly and is an interesting note. Whatever is in this closure will run often, I am not sure of a purpose besides an educational one.
        hapticEngine.stoppedHandler = { reason in
            print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
            switch reason {
            case .audioSessionInterrupt: print("Audio session interrupt")
            case .applicationSuspended: print("Application suspended")
            case .idleTimeout: print("Idle timeout")
            case .systemError: print("System error")
            case .notifyWhenFinished: print("Notify when finiished")
            case .engineDestroyed: print("Engine Destroyed")
            case .gameControllerDisconnect: print("Game Controller Disconnected")
            @unknown default: print("Unknown error")
            }
        }
        
        // If something goes wrong, attempt to restart the engine immediately
        // I am not sure how to force test this code, it is currently untested.
        hapticEngine.resetHandler = { [weak self] in
            print("The engine reset")
            do {
                try self?.hapticEngine.start()
            } catch {
                print("Failed to restart the engine: \(error)")
            }
        }
    }
    
    private func playHaptic(_ pattern : CHHapticPattern){
        do {
            try hapticEngine.start()
            let player = try hapticEngine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
            hapticEngine.notifyWhenPlayersFinished { _ in
                return .stopEngine
            }
        } catch {
            print("Failed to play Haptic: \(error)")
        }
    }
}

//Follow this format to create new haptic patterns.
extension HapticManager {

    func playSlice(){
        if let pattern = try? slicePattern() {
            playHaptic(pattern)
        }
    }
    
    private func slicePattern() throws -> CHHapticPattern {
        let slice = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.35),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.25)
            ],
            relativeTime: 0,
            duration: 0.25)
        
        let snip = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ],
            relativeTime: 0.08)
        
        return try CHHapticPattern(events: [slice, snip], parameters: [])
    }
}


extension HapticManager {
    func playHudsonOne(){
        if let pattern = try? hudsonOnePattern() {
            playHaptic(pattern)
        }
    }
    
    private func hudsonOnePattern() throws -> CHHapticPattern{
        
        // create a dull, strong haptic
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        
        // create a curve that fades from 1 to 0 over one second
        let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1)
        let end = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 0)
        
        // use that curve to control the haptic strength
        let parameter = CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: [start, end], relativeTime: 0)
        
        // create a continuous haptic event starting immediately and lasting one second
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [sharpness, intensity], relativeTime: 0, duration: 1)
        
        return try CHHapticPattern(events: [event], parameterCurves: [parameter])
    }
}
