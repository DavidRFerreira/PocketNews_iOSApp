//
//  NewsBank.swift
//  Pocket_News
//
//  Created by macOSHighSierra on 08/02/2020.
//  Copyright © 2020 David R. Ferreira. All rights reserved.
//

import Foundation

class NewsBank
{
    var list = [News]()
    
    init()
    {
        for _ in 0...5
        {
            let item = News()
            
            list.append(item)
        }
    }
}
