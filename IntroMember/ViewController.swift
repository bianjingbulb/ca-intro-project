//
//  ViewController.swift
//  IntroMember
//
//  Created by BIAN JING on 9/5/16.
//  Copyright © 2016 CA. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, ResetCorrectKeyCodeDelegate {

    var targetVideoName: String!
    var targetVideoType: String!
    var correctKey: UInt16!
    var inputtedKey: UInt16!
    var isPlaying = false

    var videoViewController = VideoViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // keyboard通知
        NSEvent.addLocalMonitorForEventsMatchingMask(.KeyDownMask) { (aEvent) -> NSEvent? in
            self.keyDown(aEvent)
            return aEvent
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        }
    }

    // Keyboardイベント
    override func keyDown(theEvent: NSEvent) {

        if self.correctKey == nil && self.inputtedKey == nil {
            self.correctKey = theEvent.keyCode
            print("正解セット完了！--- \(self.correctKey)")
        } else {
            self.inputtedKey = theEvent.keyCode
            if self.correctKey == self.inputtedKey && self.isPlaying == false {
                switch self.correctKey {
                case 29:
                    self.playVideo("yokoyama-kamome", type: "mp4")
                case 18:
                    self.playVideo("yokoyama-souseizi", type: "mp4")
                case 19:
                    self.playVideo("yokoyama-takesone", type: "mov")
                case 20:
                    self.playVideo("bianjing-basketball", type: "mp4")
                case 21:
                    self.playVideo("bianjing-drum", type: "mp4")
                case 23:
                    self.playVideo("bianjing-piano", type: "mp4")
                case 22:
                    self.playVideo("wada_1", type: "mp4")
                case 26:
                    self.playVideo("wada_2", type: "mp4")
                case 28:
                    self.playVideo("wada_3", type: "mp4")
                case 25:
                    self.playVideo("honda_1", type: "mp4")
                case 0:
                    self.playVideo("honda_2", type: "mp4")
                case 11:
                    self.playVideo("honda_3", type: "mp4")
                case 8:
                    self.playVideo("sample1", type: "mov")
                case 2:
                    self.playVideo("", type: "")
                case 14:
                    self.playVideo("", type: "")
                default:
                    self.correctKey = nil
                    self.inputtedKey = nil
                    print("番号：\(self.correctKey) ビデオがありません！正解をリセットしてください")
                }
            } else {
                print("無効key！--- \(theEvent.keyCode)")
            }
        }
    }

    // ビデオを流す
    func playVideo(name: String, type: String) {
        self.isPlaying = true
        self.targetVideoName = name
        self.targetVideoType = type
        self.performSegueWithIdentifier("showVideoView", sender: self)
        print("番号：\(self.correctKey) ビデオを流しています！")
    }

    // Segueの設定関数
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showVideoView" {
            let vc = segue.destinationController as! VideoViewController
            vc.videoName = self.targetVideoName
            vc.videoType = self.targetVideoType
            // delegatgeをセットする
            self.videoViewController = vc
            self.videoViewController.resetDelegate = self
        }
    }

    // MARK:- ResetCorrectKeyCodeDelegate
    func afterVideoDidFinished() {
        print("ビデオ流し完了！--- 正解をリセットしてください")
        self.correctKey = nil
        self.inputtedKey = nil
        self.isPlaying = false
    }
}

