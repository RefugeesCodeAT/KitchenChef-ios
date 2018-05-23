//
//  ViewController.swift
//  Kitchen-App
//
//  Created by Nourallah on 02.05.18.
//  Copyright © 2018 Nourallah. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "session") != nil {
            loginDone()
        } else {
            loginToDo()
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        performSegue(withIdentifier: "mySegue", sender: self)
        
        if loginButton.titleLabel?.text == "Logout" {
            UserDefaults.standard.removeObject(forKey: "session")
            loginToDo()
            return
        }
        
        let username = userNameLabel.text
        let password = passwordLabel.text
        
        if username == "" || password == "" {
            return
        }
        login(username: "username", password: "password")
    }
    
    func login(username: String, password: String) {
        let url = URL(string: "http://localhost:3000/user1")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let params = ["username": username, "password": password]
        if let requestBody = try? JSONSerialization.data(withJSONObject: params, options: []) {
            request.httpBody = requestBody
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("Error: \((error?.localizedDescription)!)")
                return
            }
            print(response!)
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            print(data!)
            do {
                let parseData = try JSONSerialization.jsonObject(with: responseData, options: [])
                print(parseData)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func loginToDo() {
        userNameLabel.isEnabled = true
        passwordLabel.isEnabled = true
        
        loginButton.setTitle("Login", for: .normal)
    }
    
    func loginDone() {
        userNameLabel.isEnabled = false
        passwordLabel.isEnabled = false
        
        loginButton.setTitle("Logout", for: .normal)
    }
    
}

