//
//  String+Extension.swift
//  zatex
//
//  Created by Zakirov Tahir on 03.08.2023.
//

import UIKit

extension String {
    
    func heightForLabel(
        font: UIFont,
        width: CGFloat
    ) -> CGFloat {
        let label: UILabel = UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: width,
                height: CGFloat.greatestFiniteMagnitude
            )
        )
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        
        return label.frame.height
    }
}
