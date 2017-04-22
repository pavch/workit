//
//  FirstViewController.swift
//  WorkIT
//
//  Created by Pavlina Koleva on 1/24/17.
//  Copyright © 2017 Pavlina Koleva. All rights reserved.
//

import UIKit

class FirstViewController: LanguageHolder, UITableViewDataSource, UITableViewDelegate  {
    
    var phrases: [String] = [];
    var translations: [String] = [];
    var workitData : NSDictionary! = [:];

    let cellIdentifier = "CellIdentifier"
    var player: ViewController? = nil
    var translateToLanguage: String = Constants.englishLangKey
//    var mainLanguage: String = Constants.englishLangKey
    var sectionKey: String = Constants.sectionFirstKey
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPhrases()
//        self.settingsButton.action = #selector(settingsTapped)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func settingsTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    @IBAction func settingButtonTapped(_ sender: Any) {

//       self.navigationController.pop
    }

    func loadPhrases(){
        let workitDataPath = Bundle.main.path(forResource: "WorkITAppData", ofType: "plist", inDirectory: ".")
        workitData = NSDictionary(contentsOfFile: workitDataPath!)
        print(Constants.chosenLanguage)
        let itemsDictionary:NSDictionary = workitData.object(forKey: Constants.chosenLanguage) as! NSDictionary
        let firstSectionItems = itemsDictionary.object(forKey: self.sectionKey) as! NSDictionary

        self.navigationItem.title = (firstSectionItems.object(forKey: "title") as! String).uppercased()
        let unsortedKeys = firstSectionItems.allKeys.filter() { ($0 as! String) != "title"}// ["a", "b"]
        var unsortedArray:[Int] = []
        
        unsortedArray = unsortedKeys.map { Int($0 as! String)! }
        let sortedArray:[Int] = unsortedArray.sorted(by: <)
        
        for index in sortedArray {
            phrases.append(firstSectionItems.value(forKey: String(index)) as! String)
        }
    }
    
    func loadTracks(){
        let workitDataPath = Bundle.main.path(forResource: "WorkITAppData", ofType: "plist", inDirectory: ".")
        workitData = NSDictionary(contentsOfFile: workitDataPath!)
        let itemsDictionary:NSDictionary = workitData.object(forKey: self.translateToLanguage) as! NSDictionary
        let firstSectionItems = itemsDictionary.object(forKey: self.sectionKey) as! NSDictionary
        
        let unsortedKeys = firstSectionItems.allKeys.filter() { ($0 as! String) != "title"}// ["a", "b"]
        var unsortedArray:[Int] = []
        
        unsortedArray = unsortedKeys.map { Int($0 as! String)! }
        let sortedArray:[Int] = unsortedArray.sorted(by: <)
        
        for index in sortedArray {
            self.translations.append(firstSectionItems.value(forKey: String(index)) as! String)
        }
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
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textColor = Constants.textColor
        cell.textLabel?.text = phrase
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.player == nil) {
            self.player = self.storyboard!.instantiateViewController(withIdentifier: "audioPlayer") as! ViewController;
            loadTracks()
            self.player!.setupPlaylistFiles(section: 1, language: self.translateToLanguage, titles: phrases, translations: translations)
//            self.player!.imageView.image = UIImage(named: "section1")
            
        }
        print("imageview\(self.player!.imageView)")

        self.player!.setupTrack( index: indexPath.row + 1)
        
        self.navigationController!.pushViewController(self.player!, animated: true);

        print(phrases[indexPath.row])
    }

}

