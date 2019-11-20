//
//  ViewControllerTwo.swift
//  toDoList
//
//  Created by namwhanmac on 22/6/2562 BE.
//  Copyright © 2562 namwhanmac. All rights reserved.
//

//หน้าตาราง
import UIKit
import CoreData //เอกไว้ import ฐานข้อมูล จากหน้า toDoList.xcdatamodeld

//Import ตำแหน่ง Source ของแหล่งข้อมูลที่จะเก็บ
class ViewControllerTwo: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //เชื่อมโยงตาราง table view
    @IBOutlet weak var todoTableView: UITableView!
    
    //NSManagedObject เอาไว้แทนค่าที่ userใส่ข้อมูล ไม่ต้องใส่ String แล้ว
    var todos: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //หลังจาก loadview และตกแต่งตาราง
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.rowHeight = 80
    }
    
    //Fetching เพื่อเชื่อมข้อมูลระหว่าง Interface กับ ฐานข้อมูล
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //3
        do {
            todos = try managedContext.fetch(fetchRequest)
            
          
        // Save Changes
        try managedContext.save()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // ทำปุ่ม Alert ต่างๆ
    @IBAction func addTodo(_ sender: Any) {
        
        let todoAlert = UIAlertController(title: "จดบันทึก", message: "จดเพื่อเพิ่มความจำใหม่", preferredStyle: .alert)
        todoAlert.addTextField()
        
        /*
        //สำรอง
        let addTodoAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newTodo = todoAlert.textFields![0]
            self.todos.append(newTodo.text!)
        */
 
        let addTodoAction = UIAlertAction(title: "เพิ่ม", style: .default) {
            [unowned self] action in
            
            guard let newTodo = todoAlert.textFields?.first,
                let nameToSave = newTodo.text else {
                    return
            }
        
            self.add(name: nameToSave)
            self.todoTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "ยกเลิก", style: .default)
        
        todoAlert.addAction(addTodoAction)
        todoAlert.addAction(cancelAction)
        
        present(todoAlert, animated: true, completion: nil)
        
    }
    
    //เคลียร์พื้นที่เพื่อเตรียมเพิ่ม String จาก user ก่อนทำ override Fetching
    func add(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        //แทนค่าตัวแปรเพื่อเชื่อมต่ฐาน้อมูล
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
            todos.append(person)
        } catch let error as NSError {
            print("Could not add. \(error), \(error.userInfo)")
        }
    }

    //จำนวน Row
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        
        let person = todos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        //name แทน attribite ที่อยู่ใน Entity
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        
        //cell.todoLabel.text = todos[indexPath.row]
        return cell
    }
    
    //เอาไว้ทำเครื่องหม่ยติ๊กถูก
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TodoCell
    
    //เอารูปภาพขีดทับไปเลย เอาติ๊กถูกไว้เพื่อดูว่าอ่านถึงบรรทัดไหน ไม่ได้เซฟไว้ในฐานข้อมูล
        if cell.isChecked == false {
            cell.checkmarkImage.image = UIImage(named: "Check Mark.png")
            cell.isChecked = true
        }
        else {
            cell.checkmarkImage.image = nil
            cell.isChecked = false
        }
    }
    
    //ตารางลบ ใช้ func แทน เพราะ override ไม่ได้
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            //มี container ที่ตั้งค่า AppDelegates และเอาไว้แทนค่าตัวแปรเรียกคำสั่งจากฐานข้อมูล Entity
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
 
            // ลบ row array ออก
            todos.remove(at: indexPath.row)
            todoTableView.deleteRows(at: [indexPath], with: .fade)
            
            // Do กับ Catch
            do
            {
                //ใช้สำหรับลบออกจากฐานข้อมูล
                let test = try managedContext.fetch(fetchRequest)
                
                //ตรง Indexpath ที่อยู่ใน array คือลบใน row ตัวเอง แต่ถ้าใส่ตัวเลขในนั้นไป มันจะลบบรรทัด array นั้นๆ
                let objectToDelete = test[indexPath.row] as! NSManagedObject
                managedContext.delete(objectToDelete)
                
                //เซฟ data และ relode ข้อมูลหลังจากมีการแก้ไข
                try managedContext.save()
                todoTableView.reloadData()
            }
            catch
            {
                print("ไม่สามารถลบได้ Error")
            }
            //จบ Do กับ Catch
            
        }
    }
    

} // จบปีกกาใหญ่
