//
//  ArticleListViewController.swift
//  IntroToAPI
//
//  Created by Masaki Kanto on H30/06/19.
//  Copyright © 平成30年 masakikanto. All rights reserved.
//

//import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class ArticleListViewController: UIViewController, UITableViewDataSource{
    var articles: [[String: String?]] = []
    let table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Latest Article"
        table.frame = view.frame
        view.addSubview(table)
        table.dataSource = self
        getArticles()
    
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    
    
    func getArticles(){
        Alamofire.request("https://qiita.com/api/v2/items" , method: .get)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                
                
                let json = JSON(object)
                json.forEach { (_, json) in
                    let article: [String: String?] = [
                        "title": json["title"].string,
                        "userId": json["user"]["id"].string
                    ]
                    self.articles.append(article)
                }
                self.table.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        cell.textLabel?.text = article["title"]!
        cell.detailTextLabel?.text = article["userId"]!
        return cell
    }
    
}
