//
//  AudioPlay.swift
//  mezamaShare
//
//  Created by Ellie NAGAISHI on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

//
// let audioPlay = AudioPlay()
// var audioPlayDelegate: AudioPlayDelegate? = nil
//
// audioPlayDelegate = audioPlay
// audioPlayDelegate?.setAudio(audioName: "bgm_01")
// audioPlayDelegate?.audioPlay(needsLoop: false)
//

import UIKit
import AVFoundation

class AudioPlay: AudioPlayDelegate {
    
    var audioPlayer:AVAudioPlayer!
    
    func setAudio(audioName: String) {
        let audioPath: String = Bundle.main.path(forResource: audioName, ofType: "mp3")!
        let audioUrl: URL = URL(fileURLWithPath: audioPath)
        
        var audioError: NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch let error as NSError {
            audioError = error
            audioPlayer = nil
        }
        
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func audioPlay(needsLoop: Bool) {
        if needsLoop {
            audioPlayer.numberOfLoops = -1
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func audioStop() {
        audioPlayer.stop()
    }
}

protocol AudioPlayDelegate {
    func setAudio(audioName: String) -> Void
    func audioPlay(needsLoop: Bool) -> Void
    func audioStop() -> Void
}
