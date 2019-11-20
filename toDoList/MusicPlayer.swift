//
//  MusicPlayer.swift
//  toDoList
//
//  Created by namwhanmac on 28/6/2562 BE.
//  Copyright © 2562 namwhanmac. All rights reserved.
//

//เล่นเพลงโดยเชื่อมโยงไปยังหน้า AppDelegate หลังจากรันแอปแล้ว
//ใช้เพลงเป็น Background เพื่อเข้ากับบรรยากาศ theme สีชมพู
import AVFoundation // import ระบบการเล่นเพลง

class MusicHelper {

    var backgroundMusicPlayer: AVAudioPlayer! //ประกาศตัวแปรเพื่อเชื่อมกับระบบการเล่นเพลง
    static let sharedHelper = MusicHelper() //ใช้ static เพื่อประกาศตัวแปรในหน้า View Controller อื่นๆได้
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        //ประกาศตัวแปรเพื่อเชื่อม source ไฟล์เพลง Sneaker.mp3
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Sneaker", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            //AVAudioSession.sharedInstance เมื่อผู้ใช้ออกจากหน้าแอปชั่วคราว เพลงก็ยังสามารถเล่นได้
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(false)
            audioPlayer!.numberOfLoops = -1 //ให้เพลงเล่นซ้ำหรือวน Loop ตัวเลขคือจำนวนที่ต้องการให้เล่นซ้ำ แต่ในที่นี้ -1 เพราะต้องการเล่นวน loop เรื่อยๆ
            audioPlayer!.prepareToPlay() // เล่นเพลง
            audioPlayer!.play() // เล่นเพลง
        }
        catch {
            print("ไม่สามารถเปิดไฟล์เพลงได้")
        }
    }
    
} // จบ Class เพลง Background
 
 


