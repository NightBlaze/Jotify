//
//  WriteNoteController.swift
//  Sticky Notes
//
//  Created by Harrison Leath on 5/12/19.
//  Copyright © 2019 Harrison Leath. All rights reserved.
//

import UIKit
import MultilineTextField
import CoreData

class WriteNoteController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    lazy var inputTextView: MultilineTextField = {
        let frame = CGRect(x: 0, y: 100, width: screenWidth, height: screenHeight)
        let textField = MultilineTextField(frame: frame)
        textField.backgroundColor = .clear
        textField.placeholderColor = .white
        textField.textColor = .white
        textField.isEditable = true
        textField.isPlaceholderScrollEnabled = true
        textField.leftViewOrigin = CGPoint(x: 8, y: 8)
        textField.font = UIFont.boldSystemFont(ofSize: 32)
        textField.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        textField.placeholder = "Write it down..."
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addGradient()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        addGradient()
    }
    
    func setupView() {
        view.clipsToBounds = true
        inputTextView.delegate = self
        
        view.addSubview(inputTextView)
        
        setupSwipes()
    }
    
    @objc func handleSwipes(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            tabBarController?.selectedIndex = 2
            
        } else if gesture.direction == .right {
            tabBarController?.selectedIndex = 0
            
        }
    }
    
    func setupSwipes() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        view.isUserInteractionEnabled = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        view.isUserInteractionEnabled = true
    }
    
    func addGradient() {
        //add userdefaults toggle for SettingsController
        let theme = UserDefaults.standard.string(forKey: "gradientTheme")
        print(theme ?? "Sunrise")
        
        if theme == "Sunrise" {
            Colors.shared.themeColor = GradientThemes.Sunrise

        } else if theme == "Amin" {
            Colors.shared.themeColor = GradientThemes.Amin

        } else if theme == "BlueLagoon" {
            Colors.shared.themeColor = GradientThemes.BlueLagoon

        } else if theme == "Celestial" {
            Colors.shared.themeColor = GradientThemes.Celestial

        } else if theme == "DIMIGO" {
            Colors.shared.themeColor = GradientThemes.DIMIGO

        } else if theme == "GentleCare" {
            Colors.shared.themeColor = GradientThemes.GentleCare

        } else if theme == "Kyoopal" {
            Colors.shared.themeColor = GradientThemes.Kyoopal

        } else if theme == "Maldives" {
            Colors.shared.themeColor = GradientThemes.Maldives

        } else if theme == "NeonLife" {
            Colors.shared.themeColor = GradientThemes.NeonLife

        } else if theme == "SolidStone" {
            Colors.shared.themeColor = GradientThemes.SolidStone

        }
        
        self.view.setGradient()
    }
    
    @objc func handleSend() {
        
        if inputTextView.text == "" {
            
        } else {
            let colorNameArray = ["systemRed", "systemBlue", "systemGreen", "systemPink", "systemOrange", "systemPurple", "systemTeal", "systemYellow"]
            let color = colorNameArray.randomElement()!
            let date = Date.timeIntervalSinceReferenceDate
            saveNote(content: inputTextView.text, color: color, date: date)
            inputTextView.text = ""
        }
    }
    
    func saveNote(content: String, color: String, date: Double) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
        note.setValue(content, forKeyPath: "content")
        note.setValue(color, forKey: "color")
        note.setValue(date, forKey: "date")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text as NSString).rangeOfCharacter(from: CharacterSet.newlines).location == NSNotFound {
            return true
        }
        
        //dismiss keyboard on return key
//        textView.resignFirstResponder()
        handleSend()
        
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
