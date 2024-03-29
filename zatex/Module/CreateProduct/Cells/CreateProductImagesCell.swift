//
//  CreateProductImagesCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 09.04.2023.
//

import UIKit

class CreateProductImagesCell: UITableViewCell {
    
    var images: [ProductEntity.Image] = []
    
    var removeImageHandler: ((Int) -> Void) = { _ in }
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
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
        view.set(style: .primary)
        view.setTitle("Добавить фотографию", for: .normal)
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
    
    func setupCell(images: [ProductEntity.Image]) {
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
        viewContainer.layer.borderColor = Palette.BorderField.primary.cgColor
        viewContainer.backgroundColor = Palette.Background.secondary
    }
    
    private func configureSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(viewContainer)
        contentView.addSubview(plusButton)
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
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(viewContainer.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(150)
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
        cell.removeButton.addTarget(self, action: #selector(removeImageButtom), for: .touchUpInside)
        cell.removeButton.tag = indexPath.row
        cell.setupCell(image: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension CreateProductImagesCell {
    
    @objc private func removeImageButtom(sender: UIButton) {
        images.remove(at: sender.tag)
        removeImageHandler(sender.tag)
        
        DispatchQueue.main.async() {
            self.collectionView.reloadData()
        }
    }
    
    func reloadCell() {
        DispatchQueue.main.async() {
            self.collectionView.reloadData()
        }
    }
}
