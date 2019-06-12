//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jonathan Digby on 06/06/2019.
//  Copyright © 2019 Jonathan Digby. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    //MARK: - TableView DATASOURCE METHODS (in order to display all the categories inside the persistant container)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - DATA MANIPULATION METHODS (save and load data for CRUD use)
    
    func saveCategories() {
        
        do {
            try context.save()
            
        } catch {
            print("\(error),Could not save data")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
           categoryArray = try context.fetch(request)
            
        } catch {
            print("\(error), could not collect data from context")
            
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add new categories whilst setting up the add button actions
    
    //GO THROUGH THIS SECTION AGAIN TO MAKE SURE THIS IS UNDERSTOOD********
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController.init(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction (title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Create New Category"
        }
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
        
    
    

}
