//
//  ChecklistItem.swift
//  ToDoList
//
//  Created by Aiperi Esenbay on 6/25/20.
//  Copyright © 2020 aslanarapbaev. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text: String
    var checked: Bool
    
    init(text: String, checked: Bool) {
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked(){
        checked.toggle()
    }
}
