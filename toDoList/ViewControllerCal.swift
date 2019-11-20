//
//  ViewControllerCal.swift
//  toDoList
//
//  Created by namwhanmac on 22/6/2562 BE.
//  Copyright © 2562 namwhanmac. All rights reserved.
//

//หน้าเครื่องคิดเลข
import UIKit

class ViewControllerCal: UIViewController {
    
    func reset() {
        
        //เคลียร์พื้นที่ตัวเลขให้ว่างเปล่า
        labelCel.text = ""
        
        //ทุกอย่างเป็นเลข 0 หมด
        previousNumber = 0
        numberOnScreen = 0
        operation = 0
    }
    
    //ประกาศค่าตัวแปรให้ตัวเลขเป็นทศนิยม
    //ตัวเลขหลังทศนิยมเป็น 0 จำนวน 2 ตัว เวลาแสดงค่า
    var numberOnScreen:Double = 0;
    var previousNumber:Double = 0;
    
    var performingMath = false //ประกาศตัวแปรการแสดงข้อมูลยังไม่ขึ้น เวลาผู้ใช้ยังไม่ได้กดตัวเลข
    var operation = 0;

    //โยง label แสดลงผลหน้าจอตัวเลข
    @IBOutlet weak var labelCel: UILabel!
    
    //ปุ่ม หาร คูณ ลบ บวก
    @IBOutlet weak var divideOutlet: roundButton!
    @IBOutlet weak var multipleOutlet: roundButton!
    @IBOutlet weak var minusOutlet: roundButton!
    @IBOutlet weak var plusOutlet: roundButton!
    
    
    //Disabled +-*/ อีกครั้ง เพื่อป้องกันผู้ใช้กดเครื่องหมายซ้ำในระหว่างคำนวณ
    func buttonController(isEnable: Bool) {
        if isEnable {
            divideOutlet.isEnabled = true
            multipleOutlet.isEnabled = true
            minusOutlet.isEnabled = true
            plusOutlet.isEnabled = true
        } else {
            divideOutlet.isEnabled = false
            multipleOutlet.isEnabled = false
            minusOutlet.isEnabled = false
            plusOutlet.isEnabled = false
        }
    }
    
    //ปุ่มตัวเลข 0-9
    @IBAction func numbers(_ sender: UIButton)
    {
        //เมื่อมีการแสดงตัวเลขให้ผลเป็นจริง  โดยจะแสดงค่าเป็นเลขทศนิยม 2 ตำแหน่ง
        //เมื่อแสดงค่าแล้วสามารถกดปุ่ม บวก ลบ คูณ หาร ได้อีกครั้งเมื่อต้งการหาคำตอบอีกครั้ง
        if performingMath == true
        {
            labelCel.text = String(sender.tag-1)
            numberOnScreen = Double(labelCel.text!)!
            performingMath = false
        }
        else
        {
            labelCel.text = labelCel.text! + String(sender.tag-1)
            numberOnScreen = Double(labelCel.text!)!
        }
    }//จบปุ่ม ตัวเลข 0-9
    
    //ปุ่มตั้งแต่ C บวก ลบ คูณ หาร =
    @IBAction func buttons(_ sender: Any)
    {
        if labelCel.text != "" && (sender as AnyObject).tag != 11 && (sender as AnyObject).tag != 16
        {
            //เลขก่อนหน้านี้เป็นการบวก ลบ คูณ หาร ทศนิยมอีกครั้ง
            previousNumber = Double(labelCel.text!)!
            
            if (sender as AnyObject).tag == 12 //Divided
            {
                labelCel.text = "/";
                buttonController(isEnable: false)
            }
            else if (sender as AnyObject).tag == 13 //Multiply
            {
                labelCel.text = "x";
                buttonController(isEnable: false)
            }
            else if (sender as AnyObject).tag == 14 //Minus
            {
                labelCel.text = "-";
                buttonController(isEnable: false)
            }
            else if (sender as AnyObject).tag == 15 //Plus
            {
                labelCel.text = "+";
                buttonController(isEnable: false)
            }
            
            //ให้ operation อ้างอิงโดย tag
            operation = (sender as AnyObject).tag
            performingMath = true;
        }
        
        else if (sender as AnyObject).tag == 16
        {
            if operation == 12
            {
                if numberOnScreen == 0 {
                //ให้ตัวเลที่แสดงผลบนหน้าจอก่อนหน้านี้ หาร ตัวเลขที่กดบนุ่ม
                labelCel.text = String(previousNumber / numberOnScreen)
                
                //กรณีหาร 0 ไม่ได้
                
                    //Pop Up Alert ขึ้นมาเพื่อบอกสาเหตุการหาเลข 0 ไม่ได้
                    let alert = UIAlertController(title: "Error", message: "ไม่สามารถหารเลข 0", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "ยกเลิก", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    present(alert, animated: true)
                    
                    labelCel.text = String(0)
                } else {
                    labelCel.text = String(previousNumber / numberOnScreen)
                }
                    //ให้ผู้ใช้ดูผลการแสดงบนหน้าจอ
                    //labelCel.text = "Error"
                
                    //กลับไปหน้าหลัก ถ้าขึ้น Error เพราะถ้ากดตัวเลขปุ่มอีก ระบบแอปจะ crash
                    //self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
            }

            else if operation == 13
            {
                //ให้ตัวเลที่แสดงผลบนหน้าจอก่อนหน้านี้ คูณ ตัวเลขที่กดบนุ่ม
                labelCel.text = String(previousNumber * numberOnScreen)
            }
            else if operation == 14
            {
                //ให้ตัวเลที่แสดงผลบนหน้าจอก่อนหน้านี้ ลบ ตัวเลขที่กดบนุ่ม
                labelCel.text = String(previousNumber - numberOnScreen)
            }
            else if operation == 15
            {
                //ให้ตัวเลที่แสดงผลบนหน้าจอก่อนหน้านี้ บวก ตัวเลขที่กดบนุ่ม
                labelCel.text = String(previousNumber + numberOnScreen)
            }
            buttonController(isEnable: true)
        }
        
        //ถ้าผู้ใช้กดปุ่ม C จะให้ทำการเคลียร์ตัวเลขทุกอย่างหมด
        else if (sender as AnyObject).tag == 11 {
            reset()
            }
    } //ปุ่มตั้งแต่ C บวก ลบ คูณ หาร =

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
} // จบหน้าเครื่องคิดเลข
