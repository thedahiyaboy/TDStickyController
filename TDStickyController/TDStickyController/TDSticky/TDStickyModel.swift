//
//  TDStickyModel.swift
//  TDStickyController
//
//  Created by MacMini-1 on 2/6/19.
//  Copyright © 2019 TinuDahiya. All rights reserved.
//

import Foundation


class TDStickyModel {
    var name : String
    var category : String
    var imgName : String
    
    init(name : String, category : String, imgName : String) {
        self.name = name
        self.category = category
        self.imgName = imgName
    }
    
    class func getStickyModelData() -> [TDStickyModel]{
        
        let array = [TDStickyModel(name: "Taylor Swift", category: "Singer, F", imgName: "1"),
                     TDStickyModel(name: "Justin Bieber", category: "Singer, M", imgName: "2"),
                     TDStickyModel(name: "Jonny Depp", category: "Actor, M", imgName: "3"),
                     TDStickyModel(name: "Sia", category: "Singer, F", imgName: "5"),
                     TDStickyModel(name: "Robert Jr.", category: "Actor, M", imgName: "6"),
                     TDStickyModel(name: "Benedict", category: "Actor, M", imgName: "7"),
                     TDStickyModel(name: "Miley Cyrus", category: "Singer, F", imgName: "8"),
                     TDStickyModel(name: "Bill Gates", category: "Microsoft, M", imgName: "9"),
                     TDStickyModel(name: "Steve Jobs", category: "Apple, M", imgName: "10")]
        
        return array
    }
    
}
