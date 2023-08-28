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
        setErrorView()
        hideKeyboardWhenTapped()
        setLoader()
        
        toastAlertView.isHidden = true
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.view.backgroundColor = Palette.Background.primary
            self?.navigationController?.navigationBar.barTintColor = Palette.Background.primary
            self?.navigationController?.navigationBar.backgroundColor = Palette.Background.primary
            self?.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 17)!,
                NSAttributedString.Key.foregroundColor : Palette.Text.primary
            ]
            
            self?.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "DarkBackIcon")?.withRenderingMode(.alwaysOriginal)
            self?.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "DarkBackIcon")?.withRenderingMode(.alwaysOriginal)
        }
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
        loaderView.stop()
        
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
        view.addSubview(toastAlertView)
        
        toastAlertView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(
            target: view,
            action: #selector(UIView.endEditing)
        )
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setToastAlertView()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func toastAnimation(text: String, actionHandler: @escaping () -> Void) {
        toastAlertView.setupCell(errorName: text)
        
        toastAlertView.actionHandler = { [weak self] in
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
                self?.toastAlertView.frame.origin.y = -80
            } completion: { _ in
                DispatchQueue.main.async {
                    self?.toastAlertView.isHidden = true
                }
            }
            
            actionHandler()
        }
        
        DispatchQueue.main.async {
            self.toastAlertView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            self.toastAlertView.frame.origin.y = 80
        }
    }
}

