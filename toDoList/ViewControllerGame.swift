//
//  ViewControllerGame.swift
//  toDoList
//
//  Created by namwhanmac on 26/6/2562 BE.
//  Copyright © 2562 namwhanmac. All rights reserved.
//

//หน้าเกม
import UIKit

class ViewControllerGame: UIViewController {
    
    //เชื่อม image ใส่ใน code
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var imageFour: UIImageView!
    @IBOutlet var scoreBoard: UILabel!
    
    //ประกาศตัวแปรไฟล์ 4 รูป
    let imageNames = ["cookie02", "impress", "sad", "What"]
    
    //ประกาศตัวแปรให้จำนวนนกเป็น 0 ก่อน
    var gameMode = 0
    var scoreInt = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //ตัวเลขให้เป็นเลข 0 กับตัวอักษร เอารวมเข้าด้วยกัน
        scoreInt = 0
        scoreBoard.text = String("จำนวนคุกกี้ที่หาได้: \(scoreInt)")
    }
    //เชื่อโยงรูป 4 รูป
    //ใน 4 รูป ให้ทำการสุ่มรูปภาพที่มีทั้งหมด 4 ไฟล์ ซึ่งแต่ละรูปอาจซ้ำหรือไม่ซำ แต่อยู่ใน 4 รุป
    @IBAction func playButton(_ sender: Any) {
        let firstNumber:Int = Int(arc4random_uniform(4))
        imageOne.image = UIImage (named: imageNames[firstNumber])
        
        let secondNumber:Int = Int(arc4random_uniform(4))
        imageTwo.image = UIImage (named: imageNames[secondNumber])
        
        let thirdNumber:Int = Int(arc4random_uniform(4))
        imageThree.image = UIImage (named: imageNames[thirdNumber])
        
        let fourthNumber:Int = Int(arc4random_uniform(4))
        imageFour.image = UIImage (named: imageNames[fourthNumber])
        
        //ก่อนเริ่มเกมให้ตั้งค่าการซ่อนรูป เป็นจริงก่อน
        imageOne.isHidden = true
        imageTwo.isHidden = true
        imageThree.isHidden = true
        imageFour.isHidden = true
    } //จบการเชื่อมโยง 4 รูป

    //เครื่องหมายคำถามรูปภาพที่ 1
    @IBAction func firstQuestion(_ sender: Any) {
        imageOne.isHidden = false
        
        if gameMode == 0 {
            //ถ้าสุ่มเจอรูปภาพที่ชื่อ  ให้ทำการเพิ่มคะแนน
            if imageOne.image == UIImage (named: "cookie02"){
                scoreInt += 1 //คะแนนจะบวก 1
                scoreBoard.text = String("จำนวนคุกกี้ที่หาได้: \(scoreInt)") //แสดงตัวเลขให้ผู้เล่นเห็น
            }
        }
    }//จบรูปเครื่องหมายคำถาม
    
    //เครื่องหมายคำถามรูปภาพที่ 2
    @IBAction func secondQuestion(_ sender: Any) {
        imageTwo.isHidden = false
        //ถ้าสุ่มเจอรูปภาพที่ชื่อ cookie02 ให้ทำการเพิ่มคะแนน
        if imageTwo.image == UIImage (named: "cookie02") {
            scoreInt += 1 //คะแนนจะบวก 1
            scoreBoard.text = String("จำนวนคุกกี้ที่หาได้: \(scoreInt)") //แสดงตัวเลขให้ผู้เล่นเห็น
        }
    }
    //เครื่องหมายคำถามรูปภาพที่ 3
    @IBAction func thirdQuestion(_ sender: Any) {
        imageThree.isHidden = false
         //ถ้าสุ่มเจอรูปภาพที่ชื่อ cookie02 ให้ทำการเพิ่มคะแนน
        if imageThree.image == UIImage (named: "cookie02") {
            scoreInt += 1 //คะแนนจะบวก 1
            scoreBoard.text = String("จำนวนคุกกี้ที่หาได้: \(scoreInt)") //แสดงตัวเลขให้ผู้เล่นเห็น
        }
    }
    //เครื่องหมายคำถามรูปภาพที่ 4
    @IBAction func fourthQuestion(_ sender: Any) {
        imageFour.isHidden = false
        //ถ้าสุ่มเจอรูปภาพที่ชื่อ cookie02 ให้ทำการเพิ่มคะแนน
        if imageFour.image == UIImage (named: "cookie02") {
            scoreInt += 1 //คะแนนจะบวก 1
            scoreBoard.text = String("จำนวนคุกกี้ที่หาได้: \(scoreInt)") //แสดงตัวเลขให้ผู้เล่นเห็น
        }
    }

} //จบ Class ใหญ่หน้าเกม
