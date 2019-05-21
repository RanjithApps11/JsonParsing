//
//  userData.swift
//  JsonParsing
//
//  Created by Karna Yarramsetty on 15/05/19.
//  Copyright © 2019 Invences. All rights reserved.
//

import Foundation

struct userData {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    init(_ dictionary: [String: Any]) {
        self.userId = dictionary["userId"] as? Int ?? 1
        self.id = dictionary["id"] as? Int ?? 2
        self.title = dictionary["title"] as? String ?? "NA"
        self.body = dictionary["body"] as? String ?? "NA"
    }
}

struct user {
    var name: String
    var email: String
    var mobile: Int
    
    init(_ dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.mobile = dictionary["mobile"] as? Int ?? 2
     }
}
