//
//  SearchViewController.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 10.04.2024.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    
    let searchBar = UISearchBar()
    let searchHistoryLabel = UILabel()
    let searchHistoryTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "gri")
        
        self.navigationItem.title = "Search"
        configureNavigationBar()
        setupSearchBar()
        setupSearchHistoryLabel()
        setupSearchHistoryTableView()
    }
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        
        // Constraints to place it directly below the navigation bar
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44) // Standard search bar height
        ])
        
        // Setup search bar appearance
        searchBar.placeholder = "Search Products"
        searchBar.searchBarStyle = .minimal
        
        // Clear background color settings
        searchBar.backgroundImage = UIImage() // Makes the search bar background clear
        searchBar.isTranslucent = true
        
        // To remove any border or background from the text field itself within the search bar
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white
            textField.borderStyle = .none
        }
        
        // Add search icon to the left
        searchBar.setImage(UIImage(named: "search_icon"), for: .search, state: .normal)
        searchBar.tintColor = UIColor(named: "moru")
        
        // Add microphone icon to the right
        searchBar.setImage(UIImage(named: "mic_icon"), for: .bookmark, state: .normal)
        searchBar.showsBookmarkButton = true
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        // Handle microphone icon tap
        print("Microphone tapped")
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "moru")// Set the background color to purple
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Set title text color to white
        
        // Apply the appearance settings to the navigation bar
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    func setupSearchHistoryLabel() {
        view.addSubview(searchHistoryLabel)
        searchHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        searchHistoryLabel.text = "Search History"
        searchHistoryLabel.textColor = UIColor(named: "moru") // Replace with your color
        searchHistoryLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        NSLayoutConstraint.activate([
            searchHistoryLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            searchHistoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchHistoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupSearchHistoryTableView() {
        view.addSubview(searchHistoryTableView)
        searchHistoryTableView.translatesAutoresizingMaskIntoConstraints = false
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            searchHistoryTableView.topAnchor.constraint(equalTo: searchHistoryLabel.bottomAnchor, constant: 10),
            searchHistoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchHistoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchHistoryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of past searches
        return 5 // Placeholder count, replace with your dynamic count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ["Çiğ", "Nilky", "Yoğurt", "Granola", "Simply"][indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete // Enables swipe-to-delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
    
            let searchTermToRemove = ["Çiğ", "Nilky", "Yoğurt", "Granola", "Simply"][indexPath.row]

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
}
