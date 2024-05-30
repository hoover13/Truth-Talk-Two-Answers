//
//  ContentView.swift
//  Core Motion Demo
//
//  Created by Min Thu Khine on 5/30/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var motionManager = MotionManager()
    @StateObject var questionSpeaker = QuestionSpeaker()
    @State private var currentIndex = 0
    @State private var currentKey = ""
    @State private var currentValue = ""
    @State private var timer: Timer?
    @State private var isMotionActive = false
    let synthesizer = AVSpeechSynthesizer()

    var options: [String: String] = [
        "Messi": "Ronaldo",
        "iPhone": "Android",
        "Donald Trump": "Joe Biden",
        "French Fries": "Pizza",
        "Superman": "Batman",
        "Coke": "Pepsi",
        "Breaking Bad": "Game of Thrones"
    ]
    
    var body: some View {
        if isMotionActive == false {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: geometry.size.height / 2)
                        Text(currentKey)
                            .font(.largeTitle)
                            .bold()
                    }
                    ZStack {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: geometry.size.height / 2)
                        Text(currentValue)
                            .font(.largeTitle)
                            .bold()
                    }
                }
                .onAppear {
                    print("currentKey \(currentKey)")
                    print("currentValue")
                    updateTexts()
    //                startTimer()
    //                updateTexts()
    //                questionSpeaker.speakQuestion(question: "\(currentKey) or \(currentValue)")
                    
                }
            }
            .ignoresSafeArea()
 
//            .onDisappear {
//                stopTimer()
//            }
        }
        
        
        if isMotionActive == true {
            if motionManager.isAnswerKey {
                ZStack {
                    Color.red
                    Text(currentKey)
                        .font(.system(size: 200))
                        .bold()
                    
                }
                    .ignoresSafeArea()
                    .onAppear {
                        speak(text: currentKey)
                    }
                    .onDisappear {
                        isMotionActive = false
                    }
            }
            
            if motionManager.isAnswerValue {
                ZStack {
                    Color.blue
                    Text(currentValue)
                        .font(.system(size: 200))
                        .bold()
                    
                }
                .onAppear {
                    speak(text: currentValue)
                }
                    .ignoresSafeArea()
                    .onDisappear {
                        isMotionActive = false
                    }
            }
        }
    }
    
//    private func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
//            updateTexts()
//        }
//    }
//    
//    private func stopTimer() {
//        timer?.invalidate()
//    }
    
    private func updateTexts() {
        let keys = Array(options.keys)
        if currentIndex >= keys.count {
            currentIndex = 0
        }
        currentKey = keys[currentIndex]
        currentValue = options[currentKey] ?? ""
        currentIndex += 1
        
        questionSpeaker.speakQuestion(question: "\(currentKey) or \(currentValue)")
        if questionSpeaker.isSpeaking {
            isMotionActive = false
        }
        if questionSpeaker.isDoneSpeaking {
            isMotionActive = true
        }
//        speak(text: "\(currentKey) Or \(currentValue)")
    }
    
    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}


#Preview {
    ContentView()
}
