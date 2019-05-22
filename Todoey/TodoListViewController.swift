//
//  ViewController.swift
//  Todoey
//
//  Created by Jonathan Digby on 15/05/2019.
//  Copyright © 2019 Jonathan Digby. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Sophie", "Find Millie", "New Zealand"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    
    
    //MARK - TableView Delegate Methods
    
        
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
//        {

//        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        
//        tableView(UITableView, cellForRowAt: IndexPath).accessoryType = UITableViewCell.AccessoryCheckmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
       //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
    
        let alert = UIAlertController.init(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction (title: "Add Item", style: .default) { (action) in
        //what will happen once the user clicks the Add Item button on our UIAlert
            
            self.itemArray.append(textField.text!)
            
            self.tableView.reloadData()
       
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Todoey"
            
            textField = alertTextField
            
        
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

