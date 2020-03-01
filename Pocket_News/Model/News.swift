//
//  newsClass.swift
//  Pocket_News
//
//  Created by macOSHighSierra on 08/02/2020.
//  Copyright © 2020 David R. Ferreira. All rights reserved.
//

import Foundation

class News
{
    var title : String
    var description : String
    var imageURL : String
    var articleURL : String
    
    init ()
    {
        title = ""
        description = ""
        imageURL = ""
        articleURL = ""
    }
    
    init (titl : String, descrip : String, image : String, article : String)
    {
        title = titl
        description = descrip
        imageURL = image
        articleURL = article
    }
}
