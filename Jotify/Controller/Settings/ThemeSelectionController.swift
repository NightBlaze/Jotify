//
//  ThemeSelectionController.swift
//  Jotify
//
//  Created by Harrison Leath on 8/31/19.
//  Copyright © 2019 Harrison Leath. All rights reserved.
//

import UIKit

class ThemeSelectionController: UITableViewController {
    let sections: Array = ["Color Palettes"]
    let palettes: Array = ["Default", "Sunset", "Kypool", "Celestial", "Scarlet Azure", "Apple Vibrant"]
    
    let settingsController = SettingsController()
    
    let defaults = UserDefaults.standard
    var lastIndexPath: NSIndexPath = NSIndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Themes"
        
        UIApplication.shared.windows.first?.backgroundColor = UIColor.grayBackground
        
        setupDynamicElements()
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
    }
    
    func setupDynamicElements() {
        if settingsController.darkModeEnabled() {
            view.backgroundColor = InterfaceColors.viewBackgroundColor
            tableView.separatorColor = InterfaceColors.separatorColor
            
        } else {
            view.backgroundColor = InterfaceColors.viewBackgroundColor
            tableView.separatorColor = nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        
        settingsController.setupDynamicCells(cell: cell, enableArrow: false)
        
        cell.textLabel?.text = "\(palettes[indexPath.row])"
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            if isSelectedColorFromDefaults(key: "default", indexPath: indexPath) {
                cell.accessoryType = .checkmark
            }
        case 1:
            if isSelectedColorFromDefaults(key: "sunset", indexPath: indexPath) {
                cell.accessoryType = .checkmark
            }
        case 2:
            if isSelectedColorFromDefaults(key: "kypool", indexPath: indexPath) {
                cell.accessoryType = .checkmark
            }
        case 3:
            if isSelectedColorFromDefaults(key: "celestial", indexPath: indexPath) {
                cell.accessoryType = .checkmark
            }
        case 4:
            if isSelectedColorFromDefaults(key: "scarletAzure", indexPath: indexPath) {
                cell.accessoryType = .checkmark
            }
        case 5:
            if isSelectedColorFromDefaults(key: "appleVibrant", indexPath: indexPath) {
                cell.accessoryType = .checkmark
            }
        default:
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newRow = indexPath.row
        let oldRow = lastIndexPath.row
        
        if oldRow != newRow {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: lastIndexPath as IndexPath)?.accessoryType = .none
            
            lastIndexPath = indexPath as NSIndexPath
        }
        
        switch indexPath.row {
        case 0:
            defaults.set("default", forKey: "noteColorTheme")
            setNewColorsForExistingNotesIfNotStatic()
            
        case 1:
            if !defaults.bool(forKey: "com.austinleath.Jotify.Premium") {
                PremiumView.shared.presentPremiumView(viewController: self)
                tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = .checkmark
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                
            } else {
                defaults.set("sunset", forKey: "noteColorTheme")
                setNewColorsForExistingNotesIfNotStatic()
            }
            
        case 2:
            if !defaults.bool(forKey: "com.austinleath.Jotify.Premium") {
                PremiumView.shared.presentPremiumView(viewController: self)
                tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = .checkmark
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                
            } else {
                defaults.set("kypool", forKey: "noteColorTheme")
                setNewColorsForExistingNotesIfNotStatic()
            }
            
        case 3:
            if !defaults.bool(forKey: "com.austinleath.Jotify.Premium") {
                PremiumView.shared.presentPremiumView(viewController: self)
                tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = .checkmark
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                
            } else {
                defaults.set("celestial", forKey: "noteColorTheme")
                setNewColorsForExistingNotesIfNotStatic()
            }
            
        case 4:
            if !defaults.bool(forKey: "com.austinleath.Jotify.Premium") {
                PremiumView.shared.presentPremiumView(viewController: self)
                tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = .checkmark
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                
            } else {
                defaults.set("scarletAzure", forKey: "noteColorTheme")
                setNewColorsForExistingNotesIfNotStatic()
            }
            
        case 5:
            if !defaults.bool(forKey: "com.austinleath.Jotify.Premium") {
                PremiumView.shared.presentPremiumView(viewController: self)
                tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = .checkmark
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                
            } else {
                defaults.set("appleVibrant", forKey: "noteColorTheme")
                setNewColorsForExistingNotesIfNotStatic()
            }
            
        default:
            print("Setting not implemented")
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func setNewColorsForExistingNotesIfNotStatic() {
        if defaults.bool(forKey: "useRandomColor") {
            let appearanceController = AppearanceSettingsController()
            appearanceController.fetchData()
            appearanceController.setNewColorsForExistingNotes()
        }
    }
    
    func isSelectedColorFromDefaults(key: String, indexPath: IndexPath) -> Bool {
        let colorTheme = defaults.string(forKey: "noteColorTheme")
        if colorTheme == key {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .bottom)
            return true
        } else {
            return false
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return palettes.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Each theme has at least 8 colors which will be applied at random."
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func setupDefaultPersistentNavigationBar() {
        navigationController?.navigationBar.backgroundColor = InterfaceColors.navigationBarColor
        navigationController?.navigationBar.barTintColor = InterfaceColors.navigationBarColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupDarkPersistentNavigationBar() {
        navigationController?.navigationBar.backgroundColor = InterfaceColors.navigationBarColor
        navigationController?.navigationBar.barTintColor = InterfaceColors.navigationBarColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let themes = Themes()
        themes.triggerSystemMode(mode: traitCollection)
        setupDynamicElements()
        tableView.reloadData()
        
        if UserDefaults.standard.bool(forKey: "useSystemMode") {
            if UserDefaults.standard.bool(forKey: "darkModeEnabled") {
                setupDarkPersistentNavigationBar()
            } else {
                setupDefaultPersistentNavigationBar()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if !UserDefaults.standard.bool(forKey: "useSystemMode") && !UserDefaults.standard.bool(forKey: "darkModeEnabled") {
            return .darkContent
        } else if !UserDefaults.standard.bool(forKey: "useSystemMode") && UserDefaults.standard.bool(forKey: "darkModeEnabled") {
            return .lightContent
        } else if UserDefaults.standard.bool(forKey: "useSystemMode") && traitCollection.userInterfaceStyle == .light {
            return .darkContent
        } else {
            return .lightContent
        }
    }
}
