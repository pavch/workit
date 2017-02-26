//
//  FirstViewController.swift
//  WorkIT
//
//  Created by Pavlina Koleva on 1/24/17.
//  Copyright © 2017 Pavlina Koleva. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var phrases: [String] = [];
    
    let cellIdentifier = "CellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phrases = ["Baal", "Diablo", "Mephisto"]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = phrases.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Fetch Fruit
        let phrase = phrases[indexPath.row]
        
        // Configure Cell
        cell.textLabel?.text = phrase
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(phrases[indexPath.row])
    }
    
    
}

