//
//  TestViewController.swift
//  toDoList
//
//  Created by namwhanmac on 28/6/2562 BE.
//  Copyright © 2562 namwhanmac. All rights reserved.
//

import UIKit
import AVFoundation


class TestViewController: UIViewController {
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        MusicHelper.sharedHelper.playBackgroundMusic()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
