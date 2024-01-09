//
//  SelectCitySelectCityViewController.swift
//  zatex
//
//  Created by winzero on 05/12/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol SelectCityViewControllerProtocol: AnyObject {
    
    var presenter: SelectCityPresenterProtocol? { get set }
    
    func showCountries(data: [CountriesResponse])
    func showCities(data: [CountriesResponse])
    
    func showError(data: String)
    func dismissView()
}

class SelectCityViewController: BaseViewController {
    
    var presenter: SelectCityPresenterProtocol?
    
    private let tableView = UITableView()
    private let buttonView = SaveCityButtonView()
    private let searchFieldView = BaseTextView()
    private let titleLabel = UILabel()
    
    private var countries: [CountriesResponse] = []
    
    private var filteredCountries: [CountriesResponse] = []
    
    private var selectedCountry: String?
    private var selectedCity: String?
    
    private var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
        setupTableView()
        setupButtonView()
        setupTitleLabel()
        textFieldView()
        
        presenter?.getCountries()
        tableView.isHidden = true
        errorView.isHidden = true
        loaderView.isHidden = false
        loaderView.play()
    }
    
    private func setupSubviews() {
        view.addSubview(searchFieldView)
        view.addSubview(tableView)
        view.addSubview(buttonView)
        view.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
        
        searchFieldView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchFieldView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
    }
    
    private func setupTableView() {
        title = "Где вы находитест?"
        
        tableView.register(CountriesCell.self, forCellReuseIdentifier: "countriesCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func setupButtonView() {
        buttonView.setupView(buttonName: "Сохранить")
        buttonView.sendButton.addTarget(self, action: #selector(saveAndDismiss), for: .touchUpInside)
        buttonView.sendButton.isEnabled = false
        buttonView.sendButton.alpha = 0.5
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Выберите свою страну"
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        titleLabel.textColor = Palette.Text.primary
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.titleLabel.textColor = Palette.Text.primary
        }
    }
    
    private func textFieldView() {
        searchFieldView.delegate = self
    }
}

extension SelectCityViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        
        let filteredArr = countries.filter({$0.name.contains(text)})
        filteredCountries = filteredArr
        
        if filteredCountries.count == 0 {
            searchActive = false;
        } else {
            searchActive = true;
        }
        
        tableView.reloadData()
    }
}

extension SelectCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        return 1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return searchActive ? filteredCountries.count : countries.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countriesCell", for: indexPath) as! CountriesCell
        
        if searchActive {
            cell.setupCell(name: filteredCountries[indexPath.row].name)
        } else {
            cell.setupCell(name: countries[indexPath.row].name)
        }
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if selectedCountry == nil {
            let country = searchActive ? filteredCountries[indexPath.row] : countries[indexPath.row]
            
            selectedCountry = country.name
            buttonView.setupTitle(title: country.name)
            
            let name = searchActive ? filteredCountries[indexPath.row].name : countries[indexPath.row].name
            presenter?.getCities(country: name)
            
            countries = []
            searchFieldView.text = nil
            titleLabel.text = "Выберите свой город"
            
            tableView.isHidden = true
            errorView.isHidden = true
            loaderView.isHidden = false
            loaderView.play()
            
        } else {
            let country = selectedCountry ?? ""
            let city = searchActive ? filteredCountries[indexPath.row] : countries[indexPath.row]
            
            selectedCity = city.name
            
            buttonView.setupTitle(title: "\(country), \(city.name)")
            buttonView.sendButton.isEnabled = true
            buttonView.sendButton.alpha = 1
        }
    }
}

extension SelectCityViewController {
    
    @objc private func saveAndDismiss() {
        if selectedCountry != nil &&
            selectedCity != nil {
            presenter?.saveAddressAndDismiss(
                country: selectedCountry!,
                city: selectedCity!
            )
        }
    }
}

extension SelectCityViewController: SelectCityViewControllerProtocol {
    
    func showCountries(data: [CountriesResponse]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.countries = data
            self.tableView.isHidden = false
            self.loaderView.isHidden = true
            self.loaderView.stop()
            self.tableView.reloadData()
        }
    }
    
    func showCities(data: [CountriesResponse]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.countries = data
            self.tableView.isHidden = false
            self.loaderView.isHidden = true
            self.loaderView.stop()
            self.tableView.reloadData()
        }
    }
    
    func showError(data: String) {
        tableView.isHidden = true
        errorView.isHidden = false
        loaderView.isHidden = true
        
        errorView.setupCell(errorName: data)
    }
    
    func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
}
