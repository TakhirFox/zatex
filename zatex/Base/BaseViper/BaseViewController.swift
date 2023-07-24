//
//  BaseViewController.swift
//  zatex
//
//  Created by Zakirov Tahir on 17.10.2022.
//

import UIKit
import SnapKit
import Lottie

protocol BaseViewControllerProtocol: NSObject {
    func viewDidLoad()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    var loaderView = LottieAnimationView(name: "loader")
    var errorView = BaseErrorView()
    var toastAlertView = BaseToastView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Palette.Background.primary
        self.navigationController?.isNavigationBarHidden = false
        
        setNavigationItems()
        setLoader()
        setErrorView()
        
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.view.backgroundColor = Palette.Background.primary
            self?.navigationController?.navigationBar.barTintColor = Palette.Background.primary
            self?.navigationController?.navigationBar.backgroundColor = Palette.Background.primary
            self?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 17)!, NSAttributedString.Key.foregroundColor : Palette.Text.primary]
            
            self?.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "DarkBackIcon")?.withRenderingMode(.alwaysOriginal)
            self?.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "DarkBackIcon")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setToastAlertView()
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 17)!, NSAttributedString.Key.foregroundColor : Palette.Text.primary]
        
        let backImage = UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal)
        
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.topItem?.backBarButtonItem?.imageInsets = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
    }
    
    private func setLoader() {
        loaderView.contentMode = .scaleAspectFill
        loaderView.loopMode = .loop
        loaderView.animationSpeed = 2
        loaderView.isHidden = true
        loaderView.play()
        
        view.addSubview(loaderView)
        
        loaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    private func setErrorView() {
        errorView.isHidden = true
        view.addSubview(errorView)
        
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setToastAlertView() {
        toastAlertView.isHidden = true
        toastAlertView.frame.origin.y = -140
        
        view.addSubview(toastAlertView)
        
        toastAlertView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
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

