//
//  ReceivedChatCell.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.03.2023.
//

import UIKit
import SnapKit

class ReceivedChatCell: UITableViewCell {
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let messageLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Medium", size: 14)
        view.preferredMaxLayoutWidth = 300
        view.numberOfLines = 0
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Medium", size: 11)
        view.textAlignment = .left
        view.numberOfLines = 1
        return view
    }()
    
    private let curveView = UIView()
    
    private let path: UIBezierPath = {
        let view = UIBezierPath()
        view.move(to: CGPoint(x: 15, y: -15))
        view.addCurve(to: CGPoint(x: 0, y: 0),
                      controlPoint1: CGPoint(x: 7.5, y: 0),
                      controlPoint2: CGPoint(x: 0, y: 0))
        view.addLine(to: CGPoint(x: 15, y: 0))
        return view
    }()
    
    private let shape = CAShapeLayer()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setupCell(_ data: ChatMessageResult?) {
        messageLabel.text = data?.content
        dateLabel.text = dateFormatter(data?.sentAt)
        
        configureSubviews()
        configureConstraints()
        updateAppearence()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    private func configureSubviews() {
        addSubview(curveView)
        addSubview(bubbleView)
        addSubview(dateLabel)
        bubbleView.addSubview(messageLabel)
        curveView.layer.addSublayer(shape)
        shape.path = path.cgPath
    }
    
    private func configureConstraints() {
        curveView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(4)
        }
        
        bubbleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(21)
            make.bottom.equalToSuperview().inset(4)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(bubbleView).inset(10)
            make.leading.equalTo(bubbleView).inset(10)
            make.bottom.equalTo(bubbleView).inset(10)
            make.trailing.equalTo(bubbleView).inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(bubbleView.snp.trailing).inset(-10)
            make.width.equalTo(100)
        }
    }
        
    private func updateAppearence() {
        backgroundColor = .clear
        bubbleView.backgroundColor = Palette.ChatStyle.yourBubble
        messageLabel.textColor = Palette.ChatStyle.text
        dateLabel.textColor = Palette.ChatStyle.time
        shape.fillColor = Palette.ChatStyle.yourBubble.cgColor
        selectionStyle = .none
    }
    
    private func dateFormatter(_ dateString: String?) -> String {
        let originalDate = DateFormatter()
        originalDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let dateString = dateString,
                let date = originalDate.date(from: dateString) else { return "" }
        
        let convertedDate = DateFormatter()
        convertedDate.dateFormat = "HH:mm"

        return convertedDate.string(from: date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
