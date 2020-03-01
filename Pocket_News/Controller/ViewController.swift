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
        // Do any additional setup after loading the view, typically from a nib.
    }


    
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton)
    {
        performSegue(withIdentifier: "goToSecondScreen", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("hello2")
        if (segue.identifier == "goToSecondScreen")
        {
            let destinationVC = segue.destination as! NewsViewController
            print("hello3")
            destinationVC.keywordPassedOver = textFieldSearch.text!
        }
    }
}
