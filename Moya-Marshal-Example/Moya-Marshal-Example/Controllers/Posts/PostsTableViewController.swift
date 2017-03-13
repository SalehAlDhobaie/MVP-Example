//
//  PostsTableViewController.swift
//  Moya-Example
//
//  Created by Saleh AlDhobaie on 3/12/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import UIKit
import Moya_Marshal

class PostsTableViewController: UITableViewController {

    let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var tableViewData : [Post?] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = "Posts"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0

        referchBarButton()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        
        // Configure the cell...
        if let item = tableViewData[indexPath.row] {
            cell.textLabel?.text = item.body
        }
        
        return cell
    }

    // MARK: - Network Method
    func fetchPosts() {
        loadingUI()
        appNetworkProvider.request(.posts) { result in
            
            switch result {
            case let .success(response):
                do {
                    let mappedPosts : [Post] = try response.mapArray(of: Post.self)
                    self.tableViewData = mappedPosts
                    self.tableView.reloadData()
                } catch {
                    print("Error mapping posts: \(error)")
                }
                self.activity.stopAnimating()
                self.referchBarButton()
            // do something with the response data or statusCode
            case let .failure(error):
                print(error.errorDescription ?? "")
                self.activity.stopAnimating()
                self.referchBarButton()
                break
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
            }
        }
    }
    
    func referchBarButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchPosts))

    }
    func loadingUI() {
        activity.hidesWhenStopped = true
        activity.startAnimating()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: activity)
    }
}
