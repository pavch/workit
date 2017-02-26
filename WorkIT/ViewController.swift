//
//  ViewController.swift
//  SwiftAudioPlayer
//
//  Created by Prashant on 01/11/15.
//  Copyright © 2015 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    // audio player object
    var audioPlayer = AVAudioPlayer()
    
    // timer (used to show current track play time)
    var timer:Timer!
    
    
    // play list file and title list
    var playListFiles = [String]()
    var playListTitles = [String]()
    var translations = [String]()
    var section: Int = 0
    var language: String = ""
    
    // total number of track
    var trackCount: Int = 0
    
    // currently playing track
    var currentTrackIndex: Int = 0
    
    // is playing or not
    var isPlaying: Bool = false
        
    
    // outlet - track info label (e.g. Track 1/5)
    @IBOutlet var trackInfo: UILabel!
    
    // outlet - play duration label
    @IBOutlet var translation: UILabel!
    
    // outlet - track title label
    @IBOutlet var trackTitle: UILabel!
    
    
    
    // outlet & action - prev button
    @IBOutlet var prevButton: UIBarButtonItem!
    @IBAction func prevButtonAction(_ sender: UIBarButtonItem) {
        self.playPrevTrack()
    }
    
    // outlet & action - play button
    @IBOutlet var playButton: UIBarButtonItem!
    @IBAction func playButtonAction(_ sender: UIBarButtonItem) {
        self.playTrack()
    }
    
    // outlet & action - pause button
    @IBOutlet var pauseButton: UIBarButtonItem!
    @IBAction func pauseButtonAction(_ sender: UIBarButtonItem) {
        self.pauseTrack()
    }
    
    // outlet & action - forward button
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
        self.playNextTrack()
    }
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupTrack(index: self.currentTrackIndex)

        self.setButtonStatus()
        
        self.playTrack()
    }
    
    
    // MARK: - AVAudio player delegate functions.
    
    // set status false and set button  when audio finished.
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        self.isPlaying = false
        
        // invalidate scheduled timer.
//        self.timer.invalidate()
        
        self.setButtonStatus()
    }
    
    // show message if error occured while decoding the audio
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print(error!.localizedDescription)
    }

    func setupPlaylistFiles(section: Int, language: String, titles: [String], translations: [String]) {
        
        self.playListFiles = [];
        
        for index in 1...20 {
            self.playListFiles.append("\(section)_\(index)_\(language)")
        }
        // track title list
        self.playListTitles = titles
        self.translations = translations
        
        // total number of track
        self.trackCount = self.playListFiles.count
        
        // set current track
        self.currentTrackIndex = 1
        
        // set playing status
        self.isPlaying = false
        
        self.section = section
        self.language = language
    }
    
    
    // setup audio player
    func setupTrack(index: Int) {
        if (self.playListFiles.count == 0) {
            print("Y no setup the files? What should I play?")
        } else {
            self.currentTrackIndex = index

            // choose file from play list
            let fileURL:URL =  Bundle.main.url(
                forResource: self.playListFiles[self.currentTrackIndex - 1]
                , withExtension: "mp3"
                , subdirectory: "mp3/\(self.language)")!
            
            
            do {
                // create audio player with given file url
//                if (self.audioPlayer) {
//                    self.audioPlayer.url =
//                } else {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
//                }
                
                // set audio player delegate
                self.audioPlayer.delegate = self
                
                // set default volume level
                self.audioPlayer.volume = 0.7
                
                // make player ready (i.e. preload buffer)
                self.audioPlayer.prepareToPlay()
                
            } catch let error as NSError {
                // print error in friendly way
                print(error.localizedDescription)
            }
        }
    }
    
    // play current track
    fileprivate func playTrack() {
        
        // set play status
        self.isPlaying = true
        
        // set timer, so it will update played time lable every second.
//        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updatePlayedTimeLabel), userInfo: nil, repeats: true)
        
        // play currently loaded track
        self.audioPlayer.play()
        
        
        self.setButtonStatus()
    }
    
    // pause current track
    fileprivate func pauseTrack() {
        
        // invalidate scheduled timer.
//        self.timer.invalidate()
        
        // set play status
        self.isPlaying = false
        
        // play currently loaded track
        self.audioPlayer.pause()
        
        self.setButtonStatus()
    }
    
    
    // play next track
    fileprivate func playNextTrack() {
        
        // pause current track
        self.pauseTrack()
        
        // change track
        if self.currentTrackIndex < self.trackCount {
            self.currentTrackIndex += 1
        }
        
        // stop player if currently playing
        if self.audioPlayer.isPlaying {
            self.audioPlayer.stop()
        }
        // setup player for updated track
//        self.setupAudioPlayer()
        self.setupTrack(index: self.currentTrackIndex)
        // play track
        self.playTrack()
    }
    
    
    // play prev track
    fileprivate func playPrevTrack() {
        
        // pause current track
        self.pauseTrack()
        
        // change track
        if self.currentTrackIndex > 1 {
            self.currentTrackIndex -= 1
        }
        
        // stop player if currently playing
        if self.audioPlayer.isPlaying {
            self.audioPlayer.stop()
        }
        
        // setup player for updated track
//        self.setupAudioPlayer()
        
        // play track
        self.playTrack()
    }
    
    
    // enable / disable player button based on track
    fileprivate func setButtonStatus() {
        
        // set play/pause button based on playing status
        if isPlaying {
            self.playButton.isEnabled = false
            self.pauseButton.isEnabled = true
        }else {
            self.playButton.isEnabled = true
            self.pauseButton.isEnabled = false
        }
        
        // set prev/next button based on current track
        if self.currentTrackIndex == 1  {
            self.prevButton.isEnabled = false
            if self.trackCount > 1 {
                self.nextButton.isEnabled = true
            }else{
                self.nextButton.isEnabled = false
            }
        }else if self.currentTrackIndex == self.trackCount {
            self.prevButton.isEnabled = true
            self.nextButton.isEnabled = false
        }else {
            self.prevButton.isEnabled = true
            self.nextButton.isEnabled = true
        }
        
        // set track info
        self.trackInfo.text = "\(self.currentTrackIndex) / \(self.trackCount)"
        
        // set track title
        self.trackTitle.text = self.playListTitles[self.currentTrackIndex - 1]
        
        //set translation title
        self.translation.text = self.translations[self.currentTrackIndex - 1]
    }
    
}

