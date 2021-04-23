//
//  ViewController.swift
//  Moviedo
//
//  Created by Faisal Babkoor on 4/23/21.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    

    var movies = [
        Movie1(name: "A Beautiful Mind", rate: 8.2, image: "A Beautiful Mind", types: [.Biography, .Drama]),
        Movie1(name: "Finding Nemo", rate: 8.1, image: "Finding Nemo", types: [.Animation, .Adventure, .Comedy]),
        Movie1(name: "When a Stranger Calls", rate: 5.1, image: "When a Stranger Calls", types: [.Horror, .Thriller]),
        Movie1(name: "the pursuit of happyness", rate: 8, image: "the pursuit of happyness", types: [.Biography, .Drama]),
        Movie1(name: "Inside Out", rate: 8.2, image: "inside out", types: [.Animation, .Adventure, .Comedy]),
        Movie1(name: "Inception", rate: 9, image: "Inception", types: [.Drama, .Action, .Adventure]),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func segmentedControlWasPressed(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                movies = movies.sorted(by: {$0.name.lowercased() > $1.name.lowercased()})
            case 1:
                movies = movies.sorted(by: {$0.rate > $1.rate})
            default:
                print("Default")
        }
        tableView.reloadData()
        
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configure(movies[indexPath.row])
        return cell
    }
}
