//
//  Post.swift
//  Moya-Example
//
//  Created by Saleh AlDhobaie on 3/12/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import Marshal


public struct Post: Unmarshaling {
    
    let userId : Int
    let id: Int
    let title : String
    let body : String
    
    public init(object: MarshaledObject) throws {
        userId = try object.value(for:"userId")
        id = try object.value(for:"id")
        title = try object.value(for:"title")
        body = try object.value(for:"body")
    } 
}
