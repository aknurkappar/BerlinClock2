//
//  CustomShapes.swift
//  BerlinClock2
//
//  Created by коня on 06.10.2023.
//

import UIKit

class CustomShape : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShape()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupShape()
    }
    
    func setupShape(){
        layer.cornerRadius = 7
        layer.borderColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1).cgColor
        layer.borderWidth = 7
        
        backgroundColor = .darkGray
    }

}


