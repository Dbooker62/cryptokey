//
//  ViewController.swift
//  CryptoKey
//
//  Created by student on 09/03/2024.
//

import UIKit

class ViewController: UIViewController {

    let value = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [CryptoKey]()
    private let keyValue = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        keyValue.numberOfLines = 0
        keyValue.textAlignment = .center
        keyValue.frame = CGRect(x: 22, y: 522, width: 349, height: 158)
        view.addSubview(keyValue)
    }
    
    @IBAction func GetKeyPressed(_ sender: Any) {
        keyValue.isHidden.toggle()
    }
    
    @IBAction func generateNewKey(_ sender: Any) {
        if let lastKey = models.last {
            deleteKey(key: lastKey)
            updatekeyLabel()
        }
    }

    
    @IBAction func KeyButtonPressed(_ sender: Any) {
        if let button = sender as? UIButton, let buttonTitle = button.titleLabel?.text {
               // Assuming key1 is a property of CryptoKey where you store the button title
               let newCryptoKey = CryptoKey(context: value)
               newCryptoKey.key1 = buttonTitle
               models.append(newCryptoKey)
           }
       getKeys()
       updatekeyLabel()
    }
    
    func updatekeyLabel(){
        let keyStrings = models.map{ $0.key1 ?? " " }
        let joinedKeys = keyStrings.joined(separator: "  ")
        keyValue.text = joinedKeys
    }
    
    func getKeys(){
        do {
            models = try value.fetch(CryptoKey.fetchRequest())
        }
        catch{
            print("No data is available")
        }
    }
    
    
    
    func saveKey(key: String){
        let newKey = CryptoKey(context: value)
        newKey.key1 = key
        
        do {
            try value.save()
            getKeys()
        }
        catch {
            print("Error while saving the data")
        }
    }
    
    
    
    func deleteKey(key: CryptoKey){
        value.delete(key)
        
        do {
            try value.save()
            
            // Remove the deleted key from the models array
            if let index = models.firstIndex(of: key) {
                models.remove(at: index)
            }
        }
        catch {
            print("Error while deleting the Key: \(error)")
        }
    }

}

