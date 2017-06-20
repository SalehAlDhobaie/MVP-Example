//
//  PostPresenter.swift
//  Moya-Marshal-Example
//
//  Created by Saleh AlDhobaie on 4/19/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation

protocol PostPreseterDelegate : class {
    
    // to get Post Count
    func numperOfPosts(count: Int)
    
    // Request Loading
    func startLoading()
    func finishLoading()
    
    // Fetching Post from network or Any DataSource ..
    func fetchPostOnSuccess(result : [Post])
    func fetchPostOnFailure(error : Error)
    
}


class PostPreseter {
    
    
    weak var delegate : PostPreseterDelegate?
    private var postData : [Post] = []
    
    init(delegate: PostPreseterDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Network Method
    func fetchPosts() {
        
        // start Request
        self.delegate?.startLoading()
        
        appNetworkProvider.request(.posts) { [weak self] result in
            
            switch result {
            case let .success(response):
                do {
                    
                    // Mapping
                    let mappedPosts : [Post] = try response.mapArray(of: Post.self)
                    // Return Success Response to the User.
                    
                    // Append Values to get last Post Number + stuff .. etc 
                    self?.postData = mappedPosts
                    // NOTE : We might face an issue with number that we receive with the post has returned to Cntroller
                    self?.delegate?.fetchPostOnSuccess(result: mappedPosts)
                    
                } catch (let error) {
                    self?.delegate?.fetchPostOnFailure(error: error)
                    print("Error mapping posts: \(error)")
                }
                
                // finish Loading
                self?.delegate?.finishLoading()
                
                
                
            // do something with the response data or statusCode
            case let .failure(error):
                
                // Reurtn Error Value To Post Controller
                self?.delegate?.fetchPostOnFailure(error: error)
                
                // finish Loading
                self?.delegate?.finishLoading()
                
                
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
            }
        }
    }
    
    
    func getPostCount() -> Int {
        return self.postData.count
    }
    
    func getItem(index : Int) -> Post {
        
        if index > postData.count {
            fatalError(" ")
        }
        return postData[index]
    }
    
    
    
}
