//
//  ViewControllerDraw.swift
//  toDoList
//
//  Created by namwhanmac on 25/6/2562 BE.
//  Copyright © 2562 namwhanmac. All rights reserved.
//


import UIKit

class ViewControllerDraw: UIViewController {
    
    let canvas = Canvas()
    
    
    // ปุ่ม Home
    let homeButton: UIButton = {
        
        let image = UIImage(named: "icons8-home-512") as UIImage?
        
        let button = UIButton(type: .custom)
        button.setTitle("Home", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitleColor(.red, for: .normal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(openNextView), for: .touchUpInside)
        return button
    }()

    

    @objc func openNextView() {
        /*
        //สร้างไฟล์ทดสอบ เพื่อเชื่อไปยังหน้า MainVC (ตัวอย่าง)
        let mainVC = MainVC()
        present(mainVC, animated: true, completion: nil)
         */
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let viewController = storyBoard.instantiateViewController(withIdentifier: "homeView") as! ViewController
        self.present(viewController, animated:true, completion:nil)
        
    }

    //ปุ่มย้อนกลับ
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ย้อนกลับ", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    //ย้อนกลับในแต่ละครั้งที่มีการวาดรูป
    @objc fileprivate func handleUndo() {
        print("Undo lines drawn")
        
        canvas.undo()
    }
    //ลบที่วาดทั้งหมด บน Canvas
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ลบทั้งหมด", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    @objc func handleClear() {
        canvas.clear()
    }
    //พู่กันสีเหลือง
    let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    //พู่กันสีแดง
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    //พู่กันสีน้ำเงิน
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleColorChange(button: UIButton) {
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    //สไลด์ปรับขนาดพู่กัน
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc fileprivate func handleSliderChange() {
        canvas.setStrokeWidth(width: slider.value)
    }
    
    //โหลด Canvas
    override func loadView() {
        self.view = canvas
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //พื้นหลังในการวาดรูป ใ้หเป็นพื้นสีขาว
        canvas.backgroundColor = .white
        view.addSubview(homeButton)
        
        setupLayout()

    }
    //จัดปุ่มสีพู่กันและเครื่องมือทั้งหมด เป็นกลุ่มให้อยู่ด้านล่าง
    fileprivate func setupLayout() {
        let colorsStackView = UIStackView(arrangedSubviews: [yellowButton, redButton, blueButton])
        colorsStackView.distribution = .fillEqually
        
        let stackview = UIStackView(arrangedSubviews: [
            undoButton,
            clearButton,
            colorsStackView,
            slider,
            ])
        stackview.spacing = 12
        stackview.distribution = .fillEqually
        
        //เขียน Code Stackview เพื่อกำหนดการจัดวาง
        view.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        let stackviewHome = UIStackView(arrangedSubviews: [
            homeButton,
            ])
        
        view.addSubview(stackviewHome)
        stackviewHome.frame = CGRect(x: 30, y: 40, width: 80, height: 80)
        
    }
    
    //การวาดรูปในหน้านี้เขียน Code ขึ้นมาเพื่อเติมเครื่องมือ ซึ่งไม่ได้สร้างหน้าวาดรูปใน Main Storyboard และปุ่มต่างๆใช้การสร้าง Code เพื่อจัดรุปแบบการวางให้เรียบร้อย

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
