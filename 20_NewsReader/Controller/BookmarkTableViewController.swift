//
//  BookmarkTableViewController.swift
//  20_NewsReader
//
//  Created by Chrissy Satyananda on 04/08/19.
//  Copyright © 2019 Odjichrissy. All rights reserved.
//

import UIKit

class BookmarkTableViewController: UITableViewController, UISearchResultsUpdating {

    var judulArray: [String] = [
        "NasDem Ingin Anies Sukses Pimpin Jakarta","Ministers Discuss Preparation for RI-Africa Infrastructure Dialogue",
        "Amnesti Baiq Nuril Disetujui","Pejabat Kemenpora Hadirkan Ahli Hukum ke Persidangan","Konflik Berkepanjangan",
        "KBRI Yaman Ditutup Sementara","Tips Memilih Waktu Makan yang Tepat","190 Hektare Wilayah di Babel Terancam Kekeringan"]
    
    var urlArray: [String?] = []

    var filteredJudul: [String]?
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredJudul = judulArray
        self.tableView.reloadData()
        
        searchController.searchResultsUpdater = self
        
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredJudul!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as! BookmarkCell
        let text = judulArray[indexPath.row]
        cell.textLabel?.text = text
        
        if let berita = filteredJudul {
            let judul = berita[indexPath.row]
            cell.textLabel!.text = judul
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //Mark - Delete saved bookmark
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            judulArray.remove(at: indexPath.item)
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation to webpage from bookmark view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebPage" {
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let webVC : WebViewController = segue.destination as! WebViewController
            webVC.urlBerita = self.urlArray[selectedRow!]
            webVC.judulBerita = self.judulArray[selectedRow!]

        }
    }
    
    // MARK: - Search bar title filtering method
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredJudul = judulArray.filter { judul in
                return judul.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            filteredJudul = judulArray
        }
        self.tableView.reloadData()
    }


}

