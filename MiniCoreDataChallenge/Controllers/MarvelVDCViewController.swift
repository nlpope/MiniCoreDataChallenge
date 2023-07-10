//
//  ViewController.swift
//  MiniCoreDataChallenge
//
//  Created by Noah Pope on 7/3/23.
// MAKE ONE MORE PLAIN VC FOR THE HERO DETAILS TO POP UP IN AN EDITABLE MODAL?

import UIKit
import CoreData


class MarvelVDCViewController: UITableViewController {
    
    var multiverseArray = [Universe]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        loadMultiverse()
    }
    
// MARK: - DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return multiverseArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UniverseCell", for: indexPath)
        let universe = multiverseArray[indexPath.row]
        
        cell.textLabel?.text = universe.name
        
        return cell
    }
    
// MARK: - Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToCharacters", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

// MARK: - Data Maniulation Methods
    //save and load
    
    func saveMultiverse() {
        do {
            try context.save()
        } catch {
            print("error saving Universe: \(error)")
        }
        tableView.reloadData()
        
    }
    
    func loadMultiverse(with request: NSFetchRequest<Universe> = Universe.fetchRequest()) {
        do {
            multiverseArray = try context.fetch(request)
        } catch {
            print("error loading multiverse: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
// MARK: - Add new items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Universe", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Universe", style: .default) { _ in
            let newUniverse = Universe(context: self.context)
            
            newUniverse.name = textField.text
            self.multiverseArray.append(newUniverse)
            self.saveMultiverse()
        }
        
        alert.addTextField(configurationHandler: { alertTextField in
            alertTextField.placeholder = "Add a new universe"
            textField = alertTextField
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}



