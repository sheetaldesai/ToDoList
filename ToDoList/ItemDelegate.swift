//
//  ItemDelegate.swift
//  ToDoList
//
//  Created by Sheetal Desai on 11/9/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit

protocol ItemDelegate : class {
    func addItem(title:String, desc:String, due_date:Date, at:NSIndexPath?)
}
