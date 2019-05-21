//
//  ViewController.swift
//  JsonParsing
//
//  Created by Karna Yarramsetty on 13/03/19.
//  Copyright © 2019 Invences. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var usersList = [userData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//          getApiCall()
//        getApiCalls()
        postApiCall()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let url = Bundle.main.url(forResource: "response", withExtension: "json")
//
//        guard let jsonData = url
//            else{
//                print("data not found")
//                return
//        }
//
//        guard let data = try? Data(contentsOf: jsonData) else { return }
//
//        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else{return}
//
//        if let dictionary = json as? [String: Any] {
//
//            if let title = dictionary["title"] as? String {
//                labelHeader.text = title
//            }
//
//            if let year = dictionary["year"] as? Double {
//                print("Year is \(year)")
//            }
//            if let more_info = dictionary["more_info"] as? Double {
//                //This doesn't get printed.
//                print("More_info is \(more_info)")
//            }
//
//            for (key, value) in dictionary {
//                print("Key is: \(key) and value is \(value)" )
//            }
//
//        }
//
//        //Now lets populate our TableView
//        let newUrl = Bundle.main.url(forResource: "marvel", withExtension: "json")
//
//        guard let j = newUrl
//            else{
//                print("data not found")
//                return
//        }
//        guard let d = try? Data(contentsOf: j)
//            else { print("failed")
//                return
//        }
//        guard let rootJSON = try? JSONSerialization.jsonObject(with: d, options: [])
//            else{ print("failedh")
//                return
//        }
//
//        if let JSON = rootJSON as? [String: Any] {
//            labelHeader.text = JSON["title"] as? String
//
//            guard let jsonArray = JSON["movies"] as? [[String: Any]] else {
//                return
//            }
//
//            print(jsonArray)
//            let name = jsonArray[0]["name"] as? String
//            print(name ?? "NA")
//            print(jsonArray.last!["year"] as? Int ?? 1970)
//
////            movieList = jsonArray.compactMap{return MarvelData($0)}
//            movieList = jsonArray.map({return MarvelData(json: JSON($0))})
//            self.tableView.reloadData()
//        }
    }
    func postApiCall(){
        let parameters = ["user_id": "75", "date": "2019-01-08","API_KEY":"sk8gck40gos4k8g0ssg8cow88g40sw448okc8skc"]
        
        guard let url = URL(string: "http://roadwagons.com/prathibha/index.php/Auth_new/get_workouts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    func getApiCall(){
            
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
            
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    print(data)
                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        print(json)
                        let json : AnyObject! = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                    
                    } catch {
                        print(error)
                    }
                }
                }.resume()
        
    }
    
    func apiCalling(){
        //Url object creation
        let url = NSURL(string: "https://jsonplaceholder.typicode.com/posts")
        print(url as Any)
        let request = NSMutableURLRequest(url:url! as URL)
        //Conver params to json data
        request.httpMethod = "GET"
        //Start requesting
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            //Connection failed case
            if error != nil {
                DispatchQueue.main.async {
                    if error!.localizedDescription == NSURLErrorDomain {
//                        completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
                    }else{
//                        completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
                    }
                }
            }
            else{
                do{
                    let jsonResult: Any = (try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers))
                    DispatchQueue.main.async(execute: {
                        let responseDictionary = jsonResult as! [String:AnyObject]
                        if responseDictionary["status"] as? Int != 200 {
                            print(responseDictionary["message"] as! String)
//                            completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
                            //                            delegate.networkError(errorMessage: "no Records Found")
                        }else{
//                            completionHandler(responseDictionary as AnyObject,nil)
                        }
                    })
                }catch{
                    DispatchQueue.main.async(execute: {
//                        completionHandler(nil,"Apologies something went wrong. Please try again later..." as AnyObject)
                    })
                }
            }
            
        }
        task.resume()
    }
    
    func getApiCalls(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                print(jsonResponse) //Response result
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                print(jsonArray)
                self.usersList = jsonArray.map({userData($0)})
//                for dic in jsonArray{
//                    self.usersList.append(userData(dic))
//                }
                print(" response data \(self.usersList[0].title)")
                
                DispatchQueue.main.async {
                         self.tableView.reloadData()
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func errorMessage(errMessage:String)  {
        let alert = UIAlertController(title:"ERROR", message: errMessage , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let title = cell.contentView.viewWithTag(10) as! UILabel
        let price = cell.contentView.viewWithTag(11) as! UILabel
        title.text = usersList[indexPath.row].title
        price.text = usersList[indexPath.row].body
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


