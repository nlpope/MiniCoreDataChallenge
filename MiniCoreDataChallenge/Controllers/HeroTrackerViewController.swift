//
//  HeroTrackerViewController.swift
//  MiniCoreDataChallenge
//
//  Created by Noah Pope on 7/10/23.
//

import Foundation
import UIKit
import CoreData

class HeroTrackerViewController: UITableViewController {
    var heroArray = [Hero]()
    var selectedUniverse: Universe? {
        didSet {
            loadHeroes()
            print(selectedUniverse!.name!)
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        //find a way to change this based on what universe you're in later
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        
        loadHeroes()
        
    }
    
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let heroImage: UIImage = UIImage(named: "spideyPic")!
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath)
        let hero = heroArray[indexPath.row]
        
        cell.textLabel?.text = "Hero: \(hero.name!), Identity: \(hero.identity!)"
        cell.detailTextLabel?.text = hero.activeAgent ? "Active" : "Inactive"
        cell.imageView?.image = heroImage
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(heroArray[indexPath.row])
            heroArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveHeroes()
        }
    }
    
    // MARK: - Data Maniulation Methods
    func saveHeroes() {
        do {
            try context.save()
        } catch {
            print("error saving heroes: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadHeroes(with request: NSFetchRequest<Hero> = Hero.fetchRequest()) {
        
        if request == Hero.fetchRequest() {
            let predicate = NSPredicate(format: "parentUniverse.name MATCHES %@", selectedUniverse!.name!)
            request.predicate = predicate
        }
        
        do {
            heroArray = try context.fetch(request)
        } catch {
            print("error loading heroes: \(error)")
        }
        
        tableView.reloadData()
    }
    // MARK: - Add new items
    // TODO: - get newHero.identity to pass "unknown" if nil to cellforrowat above

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var heroNameTextField = UITextField()
        var heroIDTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new Hero", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Hero", style: .default) { _ in
            let newHero = Hero(context: self.context)
            newHero.name = heroNameTextField.text
            newHero.identity = heroIDTextField.text != "" ? heroIDTextField.text : "unknown"
            newHero.activeAgent = false
            newHero.parentUniverse = self.selectedUniverse
            
            self.heroArray.append(newHero)
            self.saveHeroes()
        }
        
        //put it all together and what does that spell?
        alert.addTextField { alertNameTextField in
            alertNameTextField.placeholder = "Add a new hero"
            heroNameTextField = alertNameTextField
        }
        alert.addTextField { alertIDTextField in
            alertIDTextField.placeholder = "Optional - If you know it, add their secret identity"
            heroIDTextField = alertIDTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
