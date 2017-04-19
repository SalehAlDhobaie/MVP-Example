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
    var tableViewData : [Post] = []
    var presnter : PostPreseter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = "Posts"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        // start initiate PostPresenter .. another option we can do it as 'lazy', and init(coder: .. ) .. etc
        self.presnter = PostPreseter(delegate: self)
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
        let item = tableViewData[indexPath.row]
        cell.textLabel?.text = item.body
        
        return cell
    }

    // MARK: - Network Method
    func fetchPosts() {
        //
        self.presnter.fetchPosts()
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



extension PostsTableViewController : PostPreseterDelegate {
    
    // to get Post Count
    func numperOfPosts(count: Int) {
        print("\n\n \(#function), \(#line) value: \(count)")
    }
    
    // Request Loading
    func startLoading() {
        loadingUI()
    }
    
    func finishLoading() {
        self.activity.stopAnimating()
        self.referchBarButton()
    }
    
    // Fetching Post from network or Any DataSource ..
    func fetchPostOnSuccess(result : [Post]) {
        self.tableViewData = result
        self.tableView.reloadData()
    }
    
    func fetchPostOnFailure(error : Error) {
        print(error.localizedDescription)
    }
}



