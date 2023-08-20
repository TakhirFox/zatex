//
//  ChatDetailChatDetailViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 24/02/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit

protocol ChatDetailViewControllerProtocol: AnyObject {
    var presenter: ChatDetailPresenterProtocol? { get set }

    func setChatMesssages(data: [ChatMessageResult])
    func setChatInfo(data: ChatInfoResult)
    func showError(data: String)
    func showToastError(text: String)
}

class ChatDetailViewController: BaseViewController {
    
    var presenter: ChatDetailPresenterProtocol?
    
    var messages: [ChatMessageResult] = []
    var chatInfo: ChatInfoResult?
    var messageContent = String()
    var userId: String?
    
    let chatInfoView = ChatInfoView()
    let chatView = UIView()
    let tableView = UITableView()
    
    let chatTextFieldView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        return view
    }()
    
    let sendButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 16
        view.setImage(UIImage(systemName: "paperplane"), for: .normal)
        view.tintColor = .white
        view.addTarget(self, action: #selector(sendMessageAction), for: .touchUpInside)
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSubviews()
        setupConstraints()
        setupNavigationView()
        updateAppearence()
        registerKeyboardNotifications()
        resubmitRequest()
        
        Appearance.shared.theme.bind(self) { [weak self] newTheme in
            self?.updateAppearence()
        }
    }
    
    private func updateAppearence() {
        chatTextFieldView.layer.borderColor = Palette.BorderField.primary.cgColor
        chatTextFieldView.backgroundColor = Palette.Background.secondary
        sendButton.backgroundColor = Palette.Button.primary
    }
    
    func setupTableView() {
        tableView.register(SentChatCell.self, forCellReuseIdentifier: "sentChatCell")
        tableView.register(ReceivedChatCell.self, forCellReuseIdentifier: "receivedChatCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        textView.delegate = self
    }
    
    func setupNavigationView() {
        navigationItem.titleView = chatInfoView
    }
    
    func setupSubviews() {
        view.addSubview(chatView)
        chatView.addSubview(tableView)
        chatView.addSubview(chatTextFieldView)
        chatTextFieldView.addSubview(textView)
        chatTextFieldView.addSubview(sendButton)
    }
    
    func setupConstraints() {
        chatInfoView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
        }
        
        chatView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(chatView)
        }
        
        chatTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8)
            make.trailing.leading.equalTo(chatView).inset(16)
            make.bottom.equalTo(chatView).inset(26)
            make.height.equalTo(40)
        }
        
        textView.snp.makeConstraints { make in
            make.leading.equalTo(chatTextFieldView).inset(8)
            make.top.bottom.equalTo(chatTextFieldView).inset(4)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalTo(chatTextFieldView).inset(4)
            make.height.equalTo(32)
            make.width.equalTo(32)
            make.leading.equalTo(textView.snp.trailing).offset(4)
        }
    }
    
    private func getRequests() {
        presenter?.getChatMessages()
        presenter?.getChatInfo()
        
        tableView.isHidden = true
        chatView.isHidden = true
        errorView.isHidden = true
        loaderView.isHidden = false
        loaderView.play()
    }
}

extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return messages.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if messages[indexPath.row].senderID == nil {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "sentChatCell",
                for: indexPath
            ) as! SentChatCell
            cell.setupCell(messages[indexPath.row])
            
            return cell
        } else if messages[indexPath.row].senderID != userId {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "receivedChatCell",
                for: indexPath
            ) as! ReceivedChatCell
            cell.setupCell(messages[indexPath.row])
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "sentChatCell",
                for: indexPath
            ) as! SentChatCell
            cell.setupCell(messages[indexPath.row])
            
            return cell
        }
    }
}

extension ChatDetailViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        messageContent = textView.text
    }
}

extension ChatDetailViewController {
    
    func resubmitRequest() {
        Timer.scheduledTimer(
            withTimeInterval: 30.0,
            repeats: true
        ) { _ in
            self.presenter?.getChatMessages()
        }
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            chatView.snp.updateConstraints { make in
                make.height.equalTo(self.view.frame.height - keyboardHeight)
            }
        }
         
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
        
        goToBottomCell()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
        chatView.snp.updateConstraints { make in
            make.height.equalTo(self.view.frame.height)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func goToBottomCell() {
        
        if messages.count > 0 {
            let lastRow = self.tableView.numberOfRows(inSection: 0) - 1
            let indexPath = IndexPath(row: lastRow, section: 0);
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    @objc func sendMessageAction() {
        messages.append(
            ChatMessageResult(
                messageID: nil,
                senderID: nil,
                receiverID: nil,
                content: messageContent,
                sentAt: nil,
                isRead: nil
            )
        )
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        textView.text = ""
        presenter?.sendChatMessage(message: messageContent)
        
        DispatchQueue.main.async {
            self.goToBottomCell()
        }
    }
}

extension ChatDetailViewController: ChatDetailViewControllerProtocol {

    func setChatMesssages(data: [ChatMessageResult]) {
        DispatchQueue.main.async { [weak self] in
            self?.messages = data
            self?.tableView.isHidden = false
            self?.chatView.isHidden = false
            self?.loaderView.isHidden = true
            self?.loaderView.stop()
            self?.tableView.reloadData()
            self?.goToBottomCell()
        }
    }
    
    func setChatInfo(data: ChatInfoResult) {
        DispatchQueue.main.async { [weak self] in
            self?.chatInfoView.setupCell(author: data)
            self?.chatInfoView.onSignal = { [weak self] signal in
                switch signal {
                case .onOpenAuthor(let id):
                    self?.presenter?.goToProfile(id: id)
                    
                case .onOpenProduct(let id):
                    self?.presenter?.goToProduct(id: id)
                }
            }
        }
    }
    
    func showError(data: String) {
        tableView.isHidden = true
        chatView.isHidden = true
        errorView.isHidden = false
        loaderView.isHidden = true
        
        errorView.setupCell(errorName: data)
        errorView.actionHandler = { [weak self] in
            self?.getRequests()
        }
    }
    
    func showToastError(text: String) {
        toastAnimation(text: text) { [weak self] in
            self?.presenter?.sendChatMessage(message: self?.messageContent ?? "")
        }
    }
}
