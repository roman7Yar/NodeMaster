//
//  SoundManager.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 08.06.2023.
//

import Foundation
import AVFoundation
import UIKit

class SoundManager {
    
    enum SoundTypes: String {
        case correct, wrong, bg
    }
    
    private let soundKey = "sound"
    
    static let shared = SoundManager()
    
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var soundEffectPlayers: [String: AVAudioPlayer] = [:]
        
    private init() {
        loadSoundEffects()
    }
    
    var sound: Bool {
        get {
            return UserDefaults.standard.bool(forKey: soundKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: soundKey)
            if newValue {
                playBackgroundMusic(filename: .bg)
            } else {
                stopBackgroundMusic()
            }
        }
    }

        
    func playBackgroundMusic(filename: SoundTypes) {
        guard sound else { return }
        guard let url = Bundle.main.url(forResource: filename.rawValue, withExtension: "mp3") else { return }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.play()
        } catch {
            print("Could not play background music file: \(filename.rawValue)")
        }
    }
    
    func playSoundEffect(filename: SoundTypes) {
        guard sound else { return }
        
        guard let url = Bundle.main.url(forResource: filename.rawValue, withExtension: "mp3") else { return }
        
        if let player = soundEffectPlayers[filename.rawValue] {
            if !player.isPlaying {
                player.play()
            }
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            soundEffectPlayers[filename.rawValue] = player
            player.play()
        } catch {
            print("Could not play sound effect file: \(filename.rawValue)")
        }
    }
    
    func stopAllSoundEffects() {
        for player in soundEffectPlayers.values {
            player.stop()
        }
        soundEffectPlayers.removeAll()
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
    
    func pauseBackgroundMusic() {
        backgroundMusicPlayer?.pause()
    }
    
    func resumeBackgroundMusic() {
        backgroundMusicPlayer?.play()
    }
    
    private func loadSoundEffects() {
        let filename = SoundTypes.bg.rawValue
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else { return }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            soundEffectPlayers[filename] = player
        } catch {
            print("Could not load sound effect file: \(filename)")
        }
    }
    
    
}
