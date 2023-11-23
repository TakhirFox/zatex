//
//  UIScrollView+Extension.swift
//  zatex
//
//  Created by Zakirov Tahir on 23.11.2023.
//

import UIKit

extension UIScrollView {
    
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}
