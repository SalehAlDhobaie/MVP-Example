//
//  AppNetwork.swift
//  Moya-Example
//
//  Created by Saleh AlDhobaie on 3/12/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import Moya


// used as global "needs to be enhaced" 
let appNetworkProvider = MoyaProvider<AppNetwork>()


public enum AppNetwork {
    // GET /posts
    case posts
    // GET /comments
    case comments
    // GET /albums
    case albums
}

extension AppNetwork: TargetType {
    
    // Base Url will be used to hit the api
    public var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    // dermine resource path for each end point in 'AppNetwork' enum with Base Url
    public var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .comments:
            return "/comments"
        case .albums:
            return "/albums"
        }
    }
    
    // detrmine HTTP method "GET, POST, PUT .. etc"
    public var method: Moya.Method {
        switch self {
            case .posts:
            return .get
            case .comments:
            return .get
            case .albums:
            return .get
        }
    }
    
    
    // sending parameters with endpoint in the url e.g /posts/1 or in body "depend on the service"
    public var parameters: [String: Any]? {
        switch self {
        case .posts, .comments, .albums:
            return nil
        }
    }
    
    // specify encodeing for each endpoint or service "JSONEncoding, URLEncoding.. etc"
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .posts:
            return JSONEncoding.default
        case .comments:
            return JSONEncoding.default
        case .albums:
            return JSONEncoding.default
        }
    }
    
    // specify the type for each task "request, upload, .. etc"
    public var task: Task {
        switch self {
        case .posts, .comments, .albums:
            return .request
        }
    }
    
    public var sampleData: Data {
        // will be discussed in another blog post
        return Data()
    }
    
    
    
}

// suppot urls like /posts?text=hi%20all "%20 .. etc" chars
extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
