//
//  SpaServicesList.swift
//  JsonParsing
//
//  Created by Karna Yarramsetty on 21/05/19.
//  Copyright © 2019 Invences. All rights reserved.
//

import UIKit

class SpaServicesList: NSObject {
    var spaServiceName:String?
    var spaServiceDesc:String?
    var spaServicePrice:String?
    var serviceDiscountPrice:String?
    var validFor:String?
    var validityDetails:String?
    var spaservicesid:String?
    
    init(dictionary:[String:AnyObject]) {
        self.spaServiceName = dictionary["spa_service_name"] as? String ?? " "
        self.spaServiceDesc = dictionary["spa_service_desc"] as? String ?? " "
        self.spaServicePrice = dictionary["spa_service_price"] as? String ?? " "
        self.serviceDiscountPrice = dictionary["service_discount_price"] as? String ?? " "
        self.validFor = dictionary["valid_for"] as? String ?? " "
        self.validityDetails = dictionary["validity_details"] as? String ?? " "
        self.spaservicesid = dictionary["spa_services_id"] as? String
    }

}
