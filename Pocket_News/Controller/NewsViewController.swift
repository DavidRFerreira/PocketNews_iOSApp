//
//  NewsViewController.swift
//  Pocket_News
//
//  Created by macOSHighSierra on 27/02/2020.
//  Copyright © 2020 David R. Ferreira. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let baseURL = "https://newsapi.org/v2/everything?"
    let APP_ID = "" // Insert Here Your API Code.
    
    var keywordPassedOver : String?
    var formattedDate : String = ""
    
    let newsList = NewsBank()
    
    @IBOutlet weak var tableView: UITableView!
    

    /***************************************************************/
    //MARK: - View Did Load
    /***************************************************************/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        getOneWeekBeforeDate()
        
    }
    
    
    
    /***************************************************************/
    //MARK: - Table View - Cell For Row
    // Asks the data source to insert a cell.
    /***************************************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        cell.newsTitle.text = newsList.list[indexPath.row].title
        
        cell.newsDescription.text = newsList.list[indexPath.row].description
        
        cell.readMoreButton.tag = indexPath.row

        // displays the image in the cell.
        if let imageURL = URL(string: newsList.list[indexPath.row].imageURL)
        {
            DispatchQueue.global().async
            {
                
                let data = try? Data(contentsOf: imageURL)
                
                if let data = data
                {
                    let image = UIImage(data: data)
                
                    DispatchQueue.main.async
                    {
                        cell.newsImage.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    

    /***************************************************************/
    //MARK: - Table View - Number Of Rows in Section
    // Returns the number of cells that we want to display.
    /***************************************************************/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    

    
    /***************************************************************/
    //MARK: - Table View - Height For Row At
    // Returns the height of each cell.
    /***************************************************************/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    

    
    /***************************************************************/
    //MARK: - News Date
    // Determines the date for the oldest news that can be showed.
    /***************************************************************/
  
    func getOneWeekBeforeDate()
    {
        let previousWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        formattedDate = formatter.string(from: previousWeek!)

        getFinalURL()
    }

    
    
    /***************************************************************/
    //MARK: - Google News API Final URL
    // Determines the URL we are going to use to do the request.
    /***************************************************************/

    func getFinalURL()
    {
        let finalURL : String = baseURL + "q=\(keywordPassedOver!)&from=\(formattedDate)&sortBy=popularity&apiKey=\(APP_ID)"

        getNewsData(url: finalURL)
    }

    
    
    /***************************************************************/
    //MARK: - Networking
    /***************************************************************/
    
    func getNewsData(url: String)
    {
        Alamofire.request(url, method: .get).responseJSON
        {
            response in
            if (response.result.isSuccess)
            {
                let newsJSON : JSON = JSON(response.result.value!)
                self.updateNewsData(json: newsJSON)
            }
            else
            {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }

    /***************************************************************/
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateNewsData(json : JSON)
    {
        for i in 0...5
        {
            if let newsTitle = json["articles"][i]["title"].string
            {
                newsList.list[i].title = newsTitle
                newsList.list[i].description = json["articles"][i]["description"].stringValue
                newsList.list[i].imageURL = json["articles"][i]["urlToImage"].stringValue
                newsList.list[i].articleURL = json["articles"][i]["url"].stringValue
            }
            else
            {
                newsList.list[i].title = "Unavailable"
                newsList.list[i].description = "Unavailable"
                newsList.list[i].imageURL = "Unavailable"
                newsList.list[i].articleURL = "Unavailable"
            }
        }
        
        SVProgressHUD.show()
        
        DispatchQueue.main.async
        {
            self.tableView.reloadData()
        }
        
        SVProgressHUD.dismiss()
        
    }
    
    
    /***************************************************************/
    //MARK: - Read More Button Pressed
    // Opens the news' URL in a browser.
    /***************************************************************/
    
    @IBAction func readMoreButtonPressed(_ sender: UIButton)
    {
        let buttonTag = sender.tag
        
        SVProgressHUD.show()
        
        if let url = NSURL(string: newsList.list[buttonTag].articleURL)
        {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        SVProgressHUD.dismiss()
    }
}

