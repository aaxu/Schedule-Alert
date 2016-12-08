//
//  Line.swift
//  ScheduleAlert
//
//  Created by Leeann Hu on 12/6/16.
//  Copyright © 2016 Aaron Xu. All rights reserved.
//

import UIKit

class Line: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: rect.midX, y:rect.minY))
        
        aPath.addLine(to: CGPoint(x:rect.midX, y:rect.maxY))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.green.set()
        aPath.stroke()
    }
 

}
