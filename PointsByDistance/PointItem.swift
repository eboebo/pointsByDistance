//
//  PointItem.swift
//  PointsByDistance
//
//  Created by Elena Boyd on 1/7/15.
//  Copyright (c) 2015 Whole Foods. All rights reserved.
//

import UIKit

class PointItem: NSObject {
    var title : String
    var x : Double
    var y : Double
    
    init(title : String, x : Double, y : Double) {
        self.title = title
        self.x     = x
        self.y     = y
        super.init()
    }
    
    func distanceFromPointItem(pointItem : PointItem) -> Double {
        let xDist : Double = self.x - pointItem.x
        let yDist : Double = self.y - pointItem.y
        let zDist : Double = pow(xDist, 2) + pow(yDist, 2)
        return sqrt(zDist)
    }
}
