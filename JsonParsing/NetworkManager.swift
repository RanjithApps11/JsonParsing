//
//  NetworkManager.swift
//  JsonParsing
//
//  Created by Karna Yarramsetty on 21/05/19.
//  Copyright © 2019 Invences. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    class func postRequest( parameters:[String:String],requestMethod:String, completionHandler: @escaping (AnyObject?,AnyObject?) -> Void ) {
        let url:NSURL?
//        url = NSURL(string: GlobalVariables.request_url + requestMethod)
        url = NSURL(string: "")
        print(url ?? "")
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key )
                }}
        }, to: String(describing: url!), encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _): upload.validate().responseJSON {  response in
                switch response.result {
                case .success( _):
                    let responseDictionary = response.result.value as! [String:AnyObject]
                    print("Network Manager response",responseDictionary)
                    if (responseDictionary["status"] as! Int == 200)  {
                        
                        completionHandler(responseDictionary as AnyObject,nil)
                    }else {
                        completionHandler(nil,responseDictionary["message"] as? String as AnyObject)
                    }
                case .failure(let responseError):
                    print("responseError: \(responseError)")
                    completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
                }
                }
            case .failure(let encodingError):
                print("encodingError: \(encodingError)")
                completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
            }
        })
    }
    class func postImageRequest( parameters:[String:Any],imageData: Data?,requestMethod:String, param:String,customFileName:String,mimetype:String,completionHandler: @escaping (AnyObject?,AnyObject?) -> Void) {
        let url:NSURL?
        //        if type == "event"{
        //            url = NSURL(string: GlobalVariables.Eventrequest_url + requestMethod)
        //        }else{
        url = NSURL(string: "")
        //        }
        print(url ?? "")
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key )
                }
            }
            if let data = imageData{
                multipartFormData.append(data, withName: param, fileName: customFileName, mimeType: mimetype)
            }
        }, to: String(describing: url!), encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _): upload.validate().responseJSON {  response in
                switch response.result {
                case .success( _):
                    let responseDictionary = response.result.value as! [String:AnyObject]
                    if (responseDictionary["status"] as! Bool == true)  {
                        completionHandler(responseDictionary as AnyObject,nil)
                    }else {
                        completionHandler(nil,responseDictionary["msg"] as? String as AnyObject)
                    }
                case .failure(let responseError):
                    print("responseError: \(responseError)")
                    completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
                }
                }
            case .failure(let encodingError):
                print("encodingError: \(encodingError)")
                completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
            }
        })
    }
//    class func getRequest( parameters :[String:AnyObject],requestMethod:GlobalVariables.RequestAPIMethods,completionHandler: @escaping (AnyObject?,AnyObject?) -> Void ) {
//        //Url object creation
//        let url = NSURL(string: GlobalVariables.request_url + ((requestMethod.rawValue) as String) +  NetworkManager.getParamsURL(parameters: parameters))
//        print(url as Any)
//        let request = NSMutableURLRequest(url:url! as URL)
//        //Conver params to json data
//        request.httpMethod = "GET"
//        //Start requesting
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data, response, error in
//            //Connection failed case
//            if error != nil {
//                DispatchQueue.main.async {
//                    if error!.localizedDescription == NSURLErrorDomain {
//                        completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
//                    }else{
//                        completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
//                    }
//                }
//            }
//            else{
//                do{
//                    let jsonResult: Any = (try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers))
//                    DispatchQueue.main.async(execute: {
//                        let responseDictionary = jsonResult as! [String:AnyObject]
//                        if responseDictionary["status"] as? Int != 200 {
//                            //                            print(responseDictionary["message"] as! String)
//                            completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
//                            //                            delegate.networkError(errorMessage: "no Records Found")
//                        }else{
//                            completionHandler(responseDictionary as AnyObject,nil)
//                        }
//                    })
//                }catch{
//                    DispatchQueue.main.async(execute: {
//                        completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
//                    })
//                }
//            }
//
//        }
//        task.resume()
//    }
    //Convert dictionary to json
    class func getParamsURL(parameters: [String : AnyObject]) -> String {
        
        var getURL:String = "?"
        for (key, value) in parameters {
            if key != "method"{
                getURL = getURL + "\(key)" + "=" + "\(value)" + "&"
            }
        }
        return getURL.substring(to: getURL.index(before:getURL.endIndex) )
    }
    
}


