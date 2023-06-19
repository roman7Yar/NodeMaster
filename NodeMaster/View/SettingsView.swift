//
//  SettingsView.swift
//  NodeMaster
//
//  Created by Roman Yarmoliuk on 12.06.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isVibrationOn = VibrationManager.shared.vibration
    @State private var isSoundOn = SoundManager.shared.sound
    @State private var isPrivacyOpen = false
    @State private var isTermsOpen = false
    
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                Button(isVibrationOn ? "Vibration: On" : "Vibration: Off") {
                    isVibrationOn.toggle()
                    VibrationManager.shared.vibration = isVibrationOn
                }
                Button(isSoundOn ? "Sound: On" : "Sound: Off") {
                    isSoundOn.toggle()
                    SoundManager.shared.sound = isSoundOn

                }
                Button("Privacy Policy") {
                    isPrivacyOpen = true
                }
                .sheet(isPresented: $isPrivacyOpen, content: {
                    WebView(url: URL(string: "https://docs.google.com/document/d/1JUVG1nvVNmqBBvszF6FYF4XKa4dj8BHltVXMwtDKS_s/edit?usp=sharing")!)
                })
                Button("Terms of use") {
                    isTermsOpen = true
                }
                .sheet(isPresented: $isTermsOpen, content: {
                    WebView(url: URL(string: "https://docs.google.com/document/d/1S8fmgp8oSpQOByXOUQLx7lNc40WOOomdYdwecHKTAeg/edit?usp=sharing")!)
                })

            }
            VStack {
                HStack {
                    backButton
                    Spacer()
                }
                Spacer()
            }
            
        }
        
    }
    
    private var backButton: some View {
        Button(action: {
            isPresented = false
        }) {
            BackButton()
        }
    }
}

