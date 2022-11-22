//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit
import Combine

class NewTaskViewController: UIViewController {
    
    private let backgroundView = UIView()
    private let bottomView = UIView()
    private let viewInsideStack = UIView()
    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private let saveTaskButton = UIButton()
    private let taskTextField = UITextField()
    private let calendarButton = UIButton()
    
    private var subscribers = Set<AnyCancellable>()
    @Published private var taskString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeForm()
        style()
        layout()
        setupGestures()
        observeKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskTextField.becomeFirstResponder()
        saveTaskButton.addTarget(self, action: #selector(kek), for: .touchUpInside)
    }
    
    //Enable/Disable save button
    private func observeForm() {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).map { (notification) -> String? in
            return (notification.object as? UITextField)?.text
        }.sink { [unowned self](text) in
            self.taskString = text
        }.store(in: &subscribers)
        $taskString.sink { (text) in
            self.saveTaskButton.isEnabled = text?.isEmpty == false
        }.store(in: &subscribers)
    }
    
    
    
    private func setupGestures() {
        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(tapGestures)
    }
    
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        view.frame.origin.y = 0
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc private func kek() {
        print("kek")
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
        //Button
        let attributedText = NSMutableAttributedString(string: "Save", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: 1
            ])
        var config = UIButton.Configuration.gray()
        config.baseBackgroundColor = .black
        saveTaskButton.configuration = config
        saveTaskButton.setAttributedTitle(attributedText, for: .normal)
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
       
        horizontalStackView.addArrangedSubview(saveTaskButton)
        verticalStackView.addArrangedSubview(taskTextField)
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(viewInsideStack)
       
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //BottomView
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 200),
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
            //viewInsideStack.heightAnchor.constraint(equalToConstant: 200),
            //Name Button
            saveTaskButton.heightAnchor.constraint(equalToConstant: 40),
            //Text Field
            taskTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
