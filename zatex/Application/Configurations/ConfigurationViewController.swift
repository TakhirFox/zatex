//
//  ConfigurationViewController.swift
//  zatex
//
//  Created by Zakirov Tahir on 24.06.2024.
//

import UIKit
import SnapKit

class ConfigurationViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    
    private let currentStandLabel = UILabel()
    private let testButton = UIButton()
    private let prodButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        currentStandLabel.text = "Current stand \(defaults.standConfiguration?.rawValue ?? "NONE")"
        view.addSubview(currentStandLabel)
        
        currentStandLabel.snp.makeConstraints { make in
            make.top.equalTo(35)
            make.leading.trailing.equalTo(16)
            make.height.equalTo(50)
        }
        
        testButton.setTitle("Тестовый стенд", for: .normal)
        testButton.addTarget(self, action: #selector(activateTestStand), for: .touchUpInside)
        view.addSubview(testButton)
        
        testButton.snp.makeConstraints { make in
            make.top.equalTo(currentStandLabel.snp.bottom).inset(16)
            make.leading.trailing.equalTo(16)
            make.height.equalTo(50)
        }
        
        prodButton.setTitle("Продакшн стенд", for: .normal)
        prodButton.addTarget(self, action: #selector(activateProdStand), for: .touchUpInside)
        view.addSubview(prodButton)
        
        prodButton.snp.makeConstraints { make in
            make.top.equalTo(testButton.snp.bottom).inset(16)
            make.leading.trailing.equalTo(16)
            make.height.equalTo(50)
        }
    }
}

extension ConfigurationViewController {
    
    @objc private func activateTestStand() {
        UserDefaults.standard.standConfiguration = .test
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            exit(0)
        }
    }
    
    @objc private func activateProdStand() {
        UserDefaults.standard.standConfiguration = .production
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            exit(0)
        }
    }
}
