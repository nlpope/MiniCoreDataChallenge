//
//  ViewController.swift
//  MiniCoreDataChallenge
//
//  Created by Noah Pope on 7/3/23.
//

import UIKit
import CoreData


class MarvelVDCViewController: UITableViewController {
    
    var MultiVerse = [Universe]()
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
    }
    
// MARK: - DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UniverseCell", for: indexPath)
        
        cell.textLabel?.text = "testing10"
        
        return cell
    }
    
// MARK: - Delegate Methods

// MARK: - Data Maniulation Methods
    //save and load
    
// MARK: - Add new items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    }
}



