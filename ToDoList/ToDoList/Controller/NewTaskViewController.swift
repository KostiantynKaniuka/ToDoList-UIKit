//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    private let backgroundView = UIView()
    private let bottomView = UIView()
    private let viewInsideStack = UIView()
    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private let addTaskButton = UIButton()
    private let taskTextField = UITextField()
    private var bottomConstraint = NSLayoutConstraint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupGestures()
        observeKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskTextField.becomeFirstResponder()
    }
    
    private func setupGestures() {
        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(tapGestures)
    }
    
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func getKeyboarHeight(notification: Notification) -> CGFloat {
        guard let keyboarHeigh = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return 0 }
        
        return keyboarHeigh
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        let keyboarHeigh = getKeyboarHeight(notification: notification)
        view.frame.origin.y = view.frame.origin.y - keyboarHeigh
    
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let keyboarHeigh = getKeyboarHeight(notification: notification)
        view.frame.origin.y = 0
    
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

extension NewTaskViewController {
    
    private func style() {
        backgroundView.backgroundColor = .AddNewTaskScreenColor
        bottomView.backgroundColor = .systemBackground
        //Vertical Stack
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 16
        //Horizontal Stack
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.alignment = .fill
       // verticalStackView.backgroundColor = .yellow
       // horizontalStackView.backgroundColor = .blue
       viewInsideStack.backgroundColor = .brown
        //Button
        let attributedText = NSMutableAttributedString(string: "Save", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
            NSAttributedString.Key.kern: 1
            ])
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBackground
        addTaskButton.configuration = config
        addTaskButton.setAttributedTitle(attributedText, for: .normal)
        
        //TextField
        taskTextField.backgroundColor = .systemBackground
        taskTextField.layer.cornerRadius = 10
        taskTextField.layer.borderWidth = 1
        taskTextField.layer.borderColor = UIColor.lightGray.cgColor
        taskTextField.font = UIFont(name: "Avenir Next", size: 17)
        taskTextField.placeholder = " Enter a new task"
    }
    
    private func layout() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundView)
        view.addSubview(bottomView)
        view.addSubview(verticalStackView)
       
        horizontalStackView.addArrangedSubview(addTaskButton)
        verticalStackView.addArrangedSubview(taskTextField)
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(viewInsideStack)
       
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //BottomView
            bottomView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            
            //Vertical Stack View
            verticalStackView.leadingAnchor.constraint(equalToSystemSpacingAfter:
                                                        bottomView.leadingAnchor,
                                                        multiplier: 2),
            bottomView.trailingAnchor.constraint(equalToSystemSpacingAfter:
                                                 verticalStackView.trailingAnchor,
                                                 multiplier: 2),
            verticalStackView.topAnchor.constraint(equalToSystemSpacingBelow:
                                                    bottomView.topAnchor,
                                                    multiplier: 1),
            backgroundView.bottomAnchor.constraint(equalToSystemSpacingBelow:
                                         verticalStackView.bottomAnchor,
                                         multiplier: 2),
            //View Inside The Sctack
            viewInsideStack.heightAnchor.constraint(equalToConstant: 200),
            //Name Button
            addTaskButton.heightAnchor.constraint(equalToConstant: 40),
            //Text Field
            taskTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
