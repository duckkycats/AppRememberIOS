//
//  TodoCell.swift
//  toDoList
//
//  Created by namwhanmac on 22/6/2562 BE.
//  Copyright © 2562 namwhanmac. All rights reserved.
//

//เสริมหน้าตาราง
//ทำเครื่องหมายติ๊กถูก ตกแต่งเฉยๆ ไม่ได้สำคัญและไม่ได้ส่งไปยังฐานข้อมูล
import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var todoLabel: UILabel!
    
    //เครื่องหมายถูก .png
    @IBOutlet weak var checkmarkImage: UIImageView!
    var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // ตั้งค่า view เพื่อดู state
    }
    

}//จบ Class เสริมตกแต่งเครื่องหมายติ๊กถูก
