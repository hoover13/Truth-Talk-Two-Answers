//
//  QuestionSpeaker.swift
//  Core Motion Demo
//
//  Created by Min Thu Khine on 5/30/24.
//

import Foundation
import AVFoundation

class QuestionSpeaker: NSObject, ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking = false
    @Published var isDoneSpeaking = true
    
    override init() {
        super.init()
        self.synthesizer.delegate = self
    }
    
    func speakQuestion(question: String) {
        let utterance = AVSpeechUtterance(string: question)
        utterance.voice = AVSpeechSynthesisVoice(language: "en")
        self.synthesizer.speak(utterance)
    }
    
}


extension QuestionSpeaker: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        self.isSpeaking = true
        print("Starting speaking")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        self.isSpeaking = false
        self.isDoneSpeaking = true
        print("Done")
    }
}

