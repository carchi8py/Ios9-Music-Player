//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Chris Archibald on 1/15/16.
//  Copyright © 2016 Chris Archibald. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var musicFiles = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMusicFiles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
