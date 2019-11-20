//
//  roundButton.swift
//  toDoList
//
//  Created by namwhanmac on 26/6/2562 BE.
//  Copyright © 2562 namwhanmac. All rights reserved.
//

//ตกแต่งปุ่มโค้ง เสริมหน้าเครื่องคิดเลข
import UIKit

@IBDesignable //import ปุ่มตกแต่งเพิ่ม

class roundButton: UIButton {
    
    //ตั้งค่าระดับความโค้งของปุ่ม
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    //ตั้งค่าระดับความหนาของขอบ
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    //ตั้งค่าสีของขอบปุ่ม
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }

    //Design นี้จะเกิดขึ้นต่อเมื่อ ต้องเอาแต่ละปุ่มเพิ่ม Class ชื่อ roundButton ที่หน้า identity inspector

} // จบ Class เสริมปุ่มตกแต่ง หน้าเครื่องคิดเลข
