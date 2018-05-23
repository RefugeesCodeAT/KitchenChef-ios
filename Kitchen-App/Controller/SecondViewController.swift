//
//  SecondViewController.swift
//  Kitchen-App
//
//  Created by Nourallah on 14.05.18.
//  Copyright © 2018 Nourallah. All rights reserved.
//

//Creating JSON request to get all Meals list and show it like list inside the app

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var MealsTabel: UITableView!
    
    var meals = [Meals]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.MealsTabel.reloadData()
        }
        
        MealsTabel.delegate = self
        MealsTabel.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = meals[indexPath.row].username.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SecondViewController {
            destination.meals = [meals[(MealsTabel.indexPathForSelectedRow?.row)!]]
        }
    }
    
    //creating func to download the JSON from the website
    func downloadJSON(completed: @escaping () -> ()) {

        let url = URL(string: "")

        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error == nil {
                do{
                    self.meals = try JSONDecoder().decode([Meals].self, from: data!)

                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON error")
                }
            }
        }.resume()
    }
}


