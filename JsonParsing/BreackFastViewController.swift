//
//  BreackFastViewController.swift
//  JsonParsing
//
//  Created by Karna Yarramsetty on 21/05/19.
//  Copyright © 2019 Invences. All rights reserved.
//
//
//  BreackfastPlanViewController.swift
//  PramidaDemo
//
//  Created by Karna Yarramsetty on 06/02/19.
//  Copyright © 2019 Invences. All rights reserved.
//

import UIKit
import SwiftyJSON

struct postStruct {
    var image: UIImage!
    var name: String!
}
class BreackfastPlanViewController: UITableViewController{
    
    var arrayOfPosts = [postStruct]()
    @IBOutlet weak var mealPlanTableview: UITableView!
    
    var date = ""
    var recipeDataService = [receipeData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfPosts = [postStruct.init(image: #imageLiteral(resourceName: "ADD BreakFast"), name: "Breakfast"),postStruct.init(image: #imageLiteral(resourceName: "ADDLunch"), name: "Lunch"),postStruct.init(image:#imageLiteral(resourceName: "ADDSNACK"), name: "Snaks"),postStruct.init(image:#imageLiteral(resourceName: "ADDDinner"), name: "Dinner")]
        receipeListServiceCall()
    }
    
    func receipeListServiceCall(){
        super.showProgress(message: "assign Recipes", firstTimeLoading: true)
        let params:NSDictionary = ["API_KEY":GlobalVariables.healthPortalUserDefaults.string(forKey: apiKey) ?? "","customer_id":GlobalVariables.healthPortalUserDefaults.string(forKey: kuseridID) ?? "","date":date]
        print(params)
        NetworkManager.postRequest(parameters: params as! [String : String], requestMethod: String(GlobalVariables.RequestAPIMethods.getRecipiesByDiet.rawValue), completionHandler: {responseData, errorMessage in
            print(responseData)
            if (responseData != nil)  {
                let responseDictionary = responseData as! [String:AnyObject]
                //                self.mealsListArray.removeAll()
                if let DictionariesArray = responseDictionary["response"] as? [AnyObject] {
                    self.recipeDataService = DictionariesArray.map({return receipeData(json: JSON($0))})
                    
                    self.mealPlanTableview.reloadData()
                    self.hideProgress()
                }
            }else {
                self.hideProgress()
                self.errorMessage(errMessage:String(describing: errorMessage!))
            }
        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return recipeDataService.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeDataService[section].receipeArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let temp = recipeDataService[indexPath.section].receipeArray[indexPath.row]
        let lblTitle : UILabel = cell.contentView.viewWithTag(51) as! UILabel
        let value : UILabel = cell.contentView.viewWithTag(52) as! UILabel
        lblTitle.text = temp.itemName
        value.text =  temp.recipe_servings
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let profileUpdate = self.storyboard?.instantiateViewController(withIdentifier: "MealsDetailsViewController") as? MealsDetailsViewController else {
            return
        }
        profileUpdate.type = "diet"
        profileUpdate.selectedDate = date
        profileUpdate.mealTypeId = "\(indexPath.section + 1)"
        profileUpdate.mealsDataObjects =   recipeDataService[indexPath.section].receipeArray[indexPath.row]
        
        DispatchQueue.main.async {
            //            self.present(navController, animated: true, completion: nil)
            self.navigationController?.pushViewController(profileUpdate, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerView = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        headerView.headerImageView.image = arrayOfPosts[section].image
        headerView.headerTitleLabel.text = arrayOfPosts[section].name
        return headerView
    }
    
}

