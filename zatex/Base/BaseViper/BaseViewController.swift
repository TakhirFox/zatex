//
//  BaseViewController.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.10.2022.
//

import UIKit
import SnapKit

protocol BaseViewControllerProtocol: NSObject {
    func viewDidLoad()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Palette.Background.primary
        self.navigationController?.isNavigationBarHidden = false

        setNavigationItems()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.view.backgroundColor = Palette.Background.primary
            self?.navigationController?.navigationBar.barTintColor = Palette.Background.primary
            self?.navigationController?.navigationBar.backgroundColor = Palette.Background.primary
            self?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 17)!, NSAttributedString.Key.foregroundColor : Palette.Text.primary]
            
            self?.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "DarkBackIcon")?.withRenderingMode(.alwaysOriginal)
            self?.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "DarkBackIcon")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    func setNavigationItems() {
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 17)!, NSAttributedString.Key.foregroundColor : Palette.Text.primary]
        
        let backImage = UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal)

        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.topItem?.backBarButtonItem?.imageInsets = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

