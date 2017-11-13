//
//  ListViewController.swift
//  ToDoList
//
//  Created by Sheetal Desai on 11/8/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {

    var todoItems = [ToDoList]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchAllItems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! ItemViewController
        destination.delegate = self
//        destination.indexPath = sender as! NSIndexPath
        
    }
    
    func fetchAllItems() {
        print("FetchAllItems")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
        do {
            let results = try (managedObjectContext.fetch(request))
            print("Got results")
            todoItems = results as! [ToDoList]
        } catch {
            print("\(error)")
        }
        
    }


}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath) as! ToDoCellItem
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        cell.lblDate.text = dateFormatterPrint.string(from: todoItems[indexPath.row].dueDate!)
        cell.lblTItel.text = todoItems[indexPath.row].title
        cell.lblDesc.text = todoItems[indexPath.row].desc
        print("status \(todoItems[indexPath.row].status)")
        if (todoItems[indexPath.row].status) {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = todoItems[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
            print("Success")
        } catch {
            print("\(error)")
        }
        todoItems.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoItems[indexPath.row].status = !todoItems[indexPath.row].status
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
}

extension ListViewController: ItemDelegate {
    func addItem(title: String, desc: String, due_date: Date, at:NSIndexPath?) {
        print("add item received")
        self.navigationController?.popViewController(animated: true)
        if let indexPath = at {
           let item = todoItems[indexPath.row]
            item.title = title
            item.desc = desc
            item.dueDate = due_date
        }
        else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: managedObjectContext) as! ToDoList
            item.title = title
            item.desc = desc
            item.dueDate = due_date
            item.status = false
            todoItems.append(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    
    }
    
}
