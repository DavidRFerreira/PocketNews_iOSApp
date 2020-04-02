//
//  ViewController.swift
//  Pocket_News
//
//  Created by macOSHighSierra on 07/02/2020.
//  Copyright © 2020 David R. Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var textFieldSearch: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }


    
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton)
    {
        performSegue(withIdentifier: "goToSecondScreen", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "goToSecondScreen")
        {
            let destinationVC = segue.destination as! NewsViewController
            
            destinationVC.keywordPassedOver = textFieldSearch.text!
        }
    }
}
