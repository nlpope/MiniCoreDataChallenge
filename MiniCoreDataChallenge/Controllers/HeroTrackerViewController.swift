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
        
    }
    
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath)
        let hero = heroArray[indexPath.row]
        
        cell.textLabel?.text = hero.name
        return cell
    }
}
