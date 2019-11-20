//
//  ViewController.swift
//  toDoList
//
//  Created by namwhanmac on 22/6/2562 BE.
//  Copyright © 2562 namwhanmac. All rights reserved.
//

//หน้าหลัก
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//เกี่ยวกับ Label เวลา และวันที่
    @IBOutlet weak var dateTime: UILabel!
    //ประกาศตัวแปรเวลา
    var timer = Timer()
    
    //ใช้ viewDidAppear เพื่อเวลาโหลดหน้าใหม่อีกครั้งก็จะทำให้เป็นเวลา ณ ปัจจุบัน
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updateClock), userInfo: nil, repeats: true)
    }
    
    @objc func updateClock()
    {
        //ตั้งค่าเพื่อตกแต่งปุ่ม
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .medium //ตกแต่งขนาดตัวอักษร
        timeFormatter.dateStyle = .medium //ตกแต่งขนาดตัวอักษร
        let timeString = "\(timeFormatter.string(from: Date() as Date))" //นำมาแสดงผลในรูปแบบวันที่
        dateTime.text = String(timeString) //แปลงค่าเพื่อแสดงเป็น String
    }
   
//เกี่ยวกับปุ่มกดออกจากแอป
    @IBAction func exitBtn(_ sender: Any) {
        exit(0) //เป็นเลข 0 เพราะเป็นการ Terminate ค่าอื่นๆออกให้หมด
    }
//ใช้ exit(0) เฉพาะแอปเล็กเท่านั้น เพราะไม่ได้ใส่ค่าเงื่อนไขอื่นเวลาออก
    
} // จบ Class ใหญ่ หน้าหลัก


