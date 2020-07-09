//
//  ChecklistViewController.swift
//  ToDoList
//
//  Created by Aiperi Esenbay on 6/25/20.
//  Copyright © 2020 aiperiesenbay. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemVCDelegate {

    var items: [ChecklistItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        items.append(ChecklistItem(text: "go to yoga class", checked: true))
        items.append(ChecklistItem(text: "Play with Emily", checked: true))
        items.append(ChecklistItem(text: "Learn IOS", checked: true))
        items.append(ChecklistItem(text: "Eat healthy food", checked: true))
        items.append(ChecklistItem(text: "Read books", checked: true))
        
//        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddItemViewController
            
            controller.delegate = self
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath)
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckMark(for: cell, with: item)
        
        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            
            item.toggleChecked()
            configureCheckMark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    
    // MARK: - Helping methods
    func configureCheckMark(for cell: UITableViewCell, with item: ChecklistItem) {
        cell.accessoryType = item.checked ? .checkmark : .none
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem){
        let label = cell.viewWithTag(100) as! UILabel
        label.text = item.text
    }
    
    // MARK: - AddItemVC Delegate
    
    func addItemVCDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemVC(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
}
