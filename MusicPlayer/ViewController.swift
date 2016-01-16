//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Chris Archibald on 1/15/16.
//  Copyright © 2016 Chris Archibald. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var musicFiles = [String]()
    
    var musicPlayer: AVAudioPlayer = AVAudioPlayer()
    var currentIndex: Int = 0
    
    var timer: NSTimer = NSTimer()
    var timeRemaining: Bool = false
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMusicFiles()
        
        songNameLabel.text = ""
        timeLabel.text = "00:00"
        
        playMusic()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func loadMusicFiles() {
        let resourcePath: String = NSBundle.mainBundle().resourcePath!
        var directoryContents = [String]()
        
        do {
            directoryContents = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(resourcePath) as [String]
        } catch _ {
            let alertController = UIAlertController(title: "Error", message: "Error getting music", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        for i in 0...directoryContents.count - 1 {
            let fileExtension: String = (directoryContents[i] as String).pathExtension
            if fileExtension == "mp3" {
                let fileName: String = (directoryContents[i] as String).stringByDeletingPathExtension
                musicFiles.append(fileName)
            }
        }
    }
    func playMusic() {
        let filePath = NSString(string: NSBundle.mainBundle().pathForResource(musicFiles[currentIndex], ofType: "mp3")!)
        let fileURL = NSURL(fileURLWithPath: filePath as String)
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
        } catch _ {
            let alertController = UIAlertController(title: "Error", message: "Unable to load Song", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        musicPlayer.delegate = self
        musicSlider.minimumValue = 0
        musicSlider.maximumValue = Float(musicPlayer.duration)
        musicSlider.value = Float(musicPlayer.currentTime)
        musicPlayer.volume = volumeSlider.value
        musicPlayer.play()
        songNameLabel.text = musicFiles[currentIndex]
        animateSongNameLabel()
    }
    
    @IBAction func timeButton(sender: AnyObject) {
        timeRemaining = !timeRemaining
    }
    
    func updateSlider() {
        musicSlider.value = Float(musicPlayer.currentTime)
        if timeRemaining == false {
            timeLabel.text = updateTime(musicPlayer.currentTime)
        } else {
            timeLabel.text = updateTime(musicPlayer.duration - musicPlayer.currentTime)
        }
    }
    
    func updateTime(currentTime: NSTimeInterval) -> String {
        let current: Int = Int(currentTime)
        let minutes = current / 60
        let seconds = current % 60
        
        let minuteString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        if timeRemaining == false {
            return minuteString + ":" + secondsString
        } else {
            return "-" + minuteString + ":" + secondsString
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {

    }
    
    func animateSongNameLabel() {
        
    }
    
    // Mark: Buttons
    
    @IBAction func back(sender: AnyObject) {
    }
    
    @IBAction func next(sender: AnyObject) {
    }
    
    @IBAction func play(sender: AnyObject) {
    }
    @IBAction func pause(sender: AnyObject) {
    }
    @IBAction func stop(sender: UIBarButtonItem) {
    }
    
    @IBAction func musicSliderChanged(sender: AnyObject) {
    }
    
    @IBAction func VolumeSliderChanged(sender: AnyObject) {
    }

    
}
extension String {
    var pathExtension: String {
        
        get {
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).stringByDeletingPathExtension
        }
    }
}
