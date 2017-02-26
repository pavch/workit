//
//  TabViewController.swift
//  WorkIT
//
//  Created by Pavlina Koleva on 1/29/17.
//  Copyright © 2017 Pavlina Koleva. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    var languageIndex: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.darkGray
        for viewController in self.viewControllers! {
//                let navController = viewController as! UINavigationController
//                navController.viewControllers[0]
//                print(languageIndex);
//                print(Constants.mainLanguageAbbrArray)
//                print(Constants.mainLanguageAbbrArray[languageIndex - 1])
//                holder.mainLanguage = Constants.mainLanguageAbbrArray[languageIndex - 1]
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
