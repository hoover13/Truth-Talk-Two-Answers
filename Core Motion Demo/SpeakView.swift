//
//  SpeakView.swift
//  Core Motion Demo
//
//  Created by Min Thu Khine on 5/30/24.
//

import SwiftUI
import AVFoundation

struct SpeakView: View {
    let synthesizer = AVSpeechSynthesizer()
    @State private var text = "Hello, World! When I combined both of the answers above, so from @Vinoth Vino and @devdchaudhary I made it work.Remember, your preview provider can contain several devices and they’ll display one above the other. This means you can have both portrait and landscape visible at the same time:"
    
    var body: some View {
        Text(text)
            .onAppear {
                speak(text: text)
            }
    }
        
    
    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}

#Preview {
    SpeakView()
}

//
//  ContentView.swift
//  text to speech demo
//
//  Created by Hoover on 9/7/23.
//
 


