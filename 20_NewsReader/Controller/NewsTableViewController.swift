//
//  ViewController.swift
//  20_NewsReader
//
//  Created by Chrissy Satyananda on 03/08/19.
//  Copyright © 2019 Odjichrissy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsTableViewController: UITableViewController {

    let APIURL = "https://storage.googleapis.com/kurio-test/mobile-engineer-ios/magazine/articles"
    var judul: String?
    var thumbnail: String?
    var url: String?
    var judulArray: [String?] = []
    var thumbnailArray: [String?] = []
    var urlArray: [String?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        retrieveNews(url: APIURL)
    }
    
    func retrieveNews(url: String){
        Alamofire.request(url, method: .get).responseJSON {
            response in
            let value = response.result.value
            let newsJSON : JSON = JSON(value!)
            
            for item in 0..<(newsJSON.count) {
                self.judul = newsJSON[item]["title"].stringValue
                self.thumbnail = newsJSON[item]["thumbnail"].stringValue
                self.url = newsJSON[item]["url"].stringValue

                self.judulArray.append(self.judul!)
                self.thumbnailArray.append(self.thumbnail!)
                self.urlArray.append(self.url)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func bookmarkFunction(cell: UITableViewCell){
        let indexPathClicked = tableView.indexPath(for: cell)
//        print(indexPathClicked as Any)
        let judulClicked = judulArray[indexPathClicked!.row]
        let urlClicked = urlArray[indexPathClicked!.row]
        let newsArray = News(judul: judulClicked, url: urlClicked, hasFavorited: true)
        
        let bookVC = BookmarkTableViewController()
        bookVC.judulArray.append(newsArray.judul!)
        bookVC.urlArray.append(newsArray.url!)
        DispatchQueue.main.async {
            bookVC.tableView.reloadData()
        }
        // Clicked articled to be saved
        print(newsArray.judul! as String)
        print(newsArray.url! as String)
//        print(newsArray.judul! as String)
//        print(newsArray.url! as String)
//        print(newsArray.hasFavorited)
    }
    
    
    //Mark - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return judulArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsItemCell", for: indexPath) as! NewsCell
        cell.link = self
        
        let judulClicked = judulArray[indexPath.row]
        let urlClicked = urlArray[indexPath.row]
        let newsArray = News(judul: judulClicked, url: urlClicked, hasFavorited: true)
        cell.accessoryView?.tintColor = newsArray.hasFavorited ? UIColor.blue: .lightGray
        
        cell.labelJudul?.text = judulArray[indexPath.row]
        cell.thumbnail.downloadImage(from: (thumbnailArray[indexPath.row]!))
        return cell
    }
    
    
    //Mark - Tableview delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toWebPage" {
            
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let webVC : WebViewController = segue.destination as! WebViewController
            webVC.urlBerita = self.urlArray[selectedRow!]
            webVC.judulBerita = self.judulArray[selectedRow!]
            
        } else if segue.identifier == "toBookmark"{
//            let selectedRow = tableView.indexPathForSelectedRow?.row
//            let bookVC : BookmarkTableViewController = segue.destination as! BookmarkTableViewController
//            bookVC.urlArray.append(self.urlArray[selectedRow!])
//            bookVC.judulArray.append(self.judulArray[selectedRow!]!)
            
//            print("Halaman Bookmark")
        }
    }
    
}

    //Mark - Extension display Image from URL
extension UIImageView {
    func downloadImage(from url: String){
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
