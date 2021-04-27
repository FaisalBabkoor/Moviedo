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
    var filterMovie = [Movie1]()
    var isSearching = false
    let searchController = UISearchController()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    
    var movies = [
        Movie1(name: "A Beautiful Mind", rate: 8.2, image: #imageLiteral(resourceName: "A Beautiful Mind"), types: [.Biography, .Drama]),
        Movie1(name: "Finding Nemo", rate: 8.1, image:  #imageLiteral(resourceName: "Finding Nemo"), types: [.Animation, .Adventure, .Comedy]),
        Movie1(name: "When a Stranger Calls", rate: 5.1, image:  #imageLiteral(resourceName: "When a Stranger Calls"), types: [.Horror, .Thriller]),
        Movie1(name: "the pursuit of happyness", rate: 8, image:  #imageLiteral(resourceName: "the pursuit of happyness"), types: [.Biography, .Drama]),
        Movie1(name: "Inside Out", rate: 8.2, image:  #imageLiteral(resourceName: "inside out"), types: [.Animation, .Adventure, .Comedy]),
        Movie1(name: "Inception", rate: 9, image:  #imageLiteral(resourceName: "Inception"), types: [.Drama, .Action, .Adventure]),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Movie.... 🎬"
        navigationItem.searchController = searchController
        searchController.searchBar.isHidden = true
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
    
    @IBAction func addMovie(_ sender: UIBarButtonItem) {
        guard let addMovieVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddMovieVC") as? AddMovieVC else { return }
        addMovieVC.delegate = self
        present(addMovieVC, animated: true)
    }
    
    @IBAction func searchBarPressed(_ sender: UIBarButtonItem) {
        searchController.searchBar.isHidden.toggle()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filterMovie = movies.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        tableView.reloadData()
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterMovie.count
        }
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if isFiltering {
            cell.configure(filterMovie[indexPath.row])
        } else {
            cell.configure(movies[indexPath.row])
        }
        return cell
    }
}

extension HomeVC: MovieDelegate {
    func movie(name: String, rate: Double, image: UIImage, types: [Type]) {
        movies.append(Movie1(name: name, rate: rate, image: image, types: types))
        tableView.reloadData()
    }
}

extension HomeVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
