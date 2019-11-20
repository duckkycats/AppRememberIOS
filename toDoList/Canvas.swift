//
//  Canvas.swift
//  toDoList
//
//  Created by namwhanmac on 25/6/2562 BE.
//  Copyright © 2562 namwhanmac. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    //public function
    //ความเข้ม/ขนาด ของการวาด stroke
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    //สีของ Stroke
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    //เชื่อมปุ่มย้อนกลับ โดยสร้างฟังก์ชัน
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    //เชื่อมปุ่มลบรูปทั้งหมด โดยสร้างฟังก์ชัน
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    //กำหนดตัวแปรเส้น
    fileprivate var lines = [Line]()
    
    override func draw(_ rect: CGRect) {
        // Custom Drawing
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        //กำหนดเส้นเงื่อนไขเมื่อมีการวาดซ้ำเกิดขึ้น
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        

    }
    //การกำหนดสัมผัสกับหน้าจอ และเส้น
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    //lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    
    
    
    // track the finger as we move across screen เช่น เอานิ้วมือแตะ
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        //print(point)
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        
        //var lastLine = lines.last
        //lastLine?.append(point)
        
        //line.append(point)
        
        setNeedsDisplay()
    }
    
}
