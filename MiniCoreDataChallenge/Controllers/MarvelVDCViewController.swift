//
//  ViewController.swift
//  MiniCoreDataChallenge
//
//  Created by Noah Pope on 7/3/23.
//

import UIKit
import CoreData


class MarvelVDCViewController: UIViewController {
    
    var MultiVerse = [Universe]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }


}


