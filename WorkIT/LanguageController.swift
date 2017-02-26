//
//  LanguageController.swift
//  WorkIT
//
//  Created by Pavlina Koleva on 2/26/17.
//  Copyright © 2017 Pavlina Koleva. All rights reserved.
//

import UIKit

class LanguageController: UIViewController,
    UIPickerViewDataSource,
    UIPickerViewDelegate {
    
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var chooseLanguageLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    let languages = ["العربية", "Български", "English", "Polski", "Românesc", "Русский", "Türk"]
    
    var languageIndex: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        chooseLanguageLabel.text = "Choose the language you speak:"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pickerView.selectRow(2, inComponent: 0, animated: true)
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.languageIndex = row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showTabBar") {
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
//            let tabViewController = segue.destination as! TabViewController;
            Constants.chosenLanguage = Constants.mainLanguageAbbrArray[self.languageIndex]
//            tabViewController.languageIndex = self.languageIndex
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = languages[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:Constants.textColor])
        return myTitle
    }
}
