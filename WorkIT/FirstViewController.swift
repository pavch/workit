//
//  FirstViewController.swift
//  WorkIT
//
//  Created by Pavlina Koleva on 1/24/17.
//  Copyright © 2017 Pavlina Koleva. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var phrases: [String] = [];
    var workitData : NSDictionary! = [:];

    let cellIdentifier = "CellIdentifier"
    var player: ViewController? = nil
    var translateToLanguage: String = Constants.bgLangKey
    var mainLanguage: String = Constants.englishLangKey
    var sectionPrefix: String = Constants.sectionFirstPrefix
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTrackData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func loadTrackData(){
        let workitDataPath = Bundle.main.path(forResource: "WorkITAppData", ofType: "plist", inDirectory: ".")
        workitData = NSDictionary(contentsOfFile: workitDataPath!)
//        print(workitData ?? "bla")
        let itemsDictionary:NSDictionary = workitData.object(forKey: Constants.englishLangKey) as! NSDictionary
        let firstSectionItems = itemsDictionary.object(forKey: Constants.sectionFirstKey) as! NSDictionary
        
        let unsortedKeys = firstSectionItems.allKeys// ["a", "b"]
        var unsortedArray:[Int] = []
        
        unsortedArray = unsortedKeys.map { Int($0 as! String)! }
        let sortedArray:[Int] = unsortedArray.sorted(by: <)
        
        for index in sortedArray {
            phrases.append(firstSectionItems.value(forKey: String(index)) as! String)
        }
//        phrases = sortedValues as [String]!
        //choose language?
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
        if (self.player == nil) {
            self.player = self.storyboard!.instantiateViewController(withIdentifier: "audioPlayer") as! ViewController;
            self.player!.setupPlaylistFiles(section: 1, language: Constants.bgLangKey, titles: phrases)
        }
//        let currentTrackName:String = "\(self.sectionPrefix)\(indexPath.row + 1)_\(self.translateToLanguage)"
        print(indexPath.row)
        self.player!.setupTrack( index: indexPath.row + 1)
        
        self.navigationController!.pushViewController(self.player!, animated: true);

        print(phrases[indexPath.row])
    }

}

