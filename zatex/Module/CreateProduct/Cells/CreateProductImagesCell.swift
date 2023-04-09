//
//  CreateProductImagesCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 09.04.2023.
//

import UIKit

class CreateProductImagesCell: UITableViewCell {
    
    var images = [UIImage]()
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = Palette.BorderField.primary.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    let plusButton: BaseButton = {
        let view = BaseButton()
        view.setImage(UIImage(named: "plusImage"), for: .normal)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
        
        configureCollectionView()
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    func setupCell(images: [UIImage]) {
        titleLabel.text = "Фотографии"
        self.images = images
        collectionView.reloadData()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UploadProductImageCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func updateAppearence() {
        titleLabel.textColor = Palette.Text.primary
    }
    
    private func configureSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(viewContainer)
        viewContainer.addSubview(plusButton)
        viewContainer.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(22)
        }
        
        viewContainer.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(12)
            make.height.equalTo(100)
            make.width.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalTo(plusButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateProductImagesCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UploadProductImageCell
        cell.setupCell(image: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension CreateProductImagesCell {
    
    func reloadCell() {
        DispatchQueue.main.async() {
            self.collectionView.reloadData()
        }
    }
}
