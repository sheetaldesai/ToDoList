//
//  ItemViewController.swift
//  ToDoList
//
//  Created by Sheetal Desai on 11/8/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    weak var delegate: ItemDelegate?
    var indexPath:NSIndexPath?
    var t: String?
    var desc: String?
    var date: Date?
    
    @IBOutlet weak var dueDate: UIDatePicker!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var txtTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSubmitPressed(_ sender: UIButton) {
        var title = "", desc = ""
        print("submitPressed delegate: \(delegate)")
        if let t = txtTitle.text, let d = txtDesc.text {
            title = t
            desc = d
        }
        
        if title != "" {
            print("Calling addItem")
            delegate?.addItem(title: title, desc: desc, due_date: dueDate.date, at:indexPath)
        }
        else {
            print("Empty title")
        }
    }
}
