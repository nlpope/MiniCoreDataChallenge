//
//  ViewController.swift
//  MiniCoreDataChallenge
//
//  Created by Noah Pope on 7/3/23.
//  researching realm w stewart lynch



/**
 --------------------------
 NOTES:
 "if let indexPath = tableView.indexPathForSelectedRow" not working for some reason
 (later) set up model for non editable modal on hero selection
 (later) FIND A WAY TO EXPAND CELL SIZE BASED ON CONTENTS - SEE NETFLIX CLONE
 --------------------------
 UPDATES & QUESTIONS:
 brushing up on binding day 3
 */

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
//        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToHeroes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! HeroTrackerViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedUniverse = multiverseArray[indexPath.row]
            destinationVC.title = destinationVC.selectedUniverse?.name
        } else { print("problems setting indexPath") }
    }

// MARK: - Data Maniulation Methods
    
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


