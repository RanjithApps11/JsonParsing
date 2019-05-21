//
//  SpaData.swift
//  JsonParsing
//
//  Created by Karna Yarramsetty on 21/05/19.
//  Copyright © 2019 Invences. All rights reserved.
//

import UIKit

class SpaData: NSObject {
    var categoryName:String?
    var spaServicesArray = [SpaServicesList]()
    
    
    init(dictionary:[String:AnyObject]) {
        self.categoryName = dictionary["spa_category_name"] as? String
        
        if let dictionariesArray = dictionary["spa_services"]  as? [AnyObject]{
            for Dictionary in dictionariesArray {
                let dataObject = SpaServicesList(dictionary: Dictionary as! [String : AnyObject])
                spaServicesArray.append(dataObject)
            }
        }
    }


}
