//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    private let backgroundView = UIView()
    private let bottomView = UIView()
    private let viewInsideStack = UIView()
    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private let nameButton = UIButton()
    private let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension AddTaskViewController {
    
    private func style() {
        backgroundView.backgroundColor = .AddNewTaskScreenColor
        bottomView.backgroundColor = .systemBackground
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.alignment = .fill
        verticalStackView.backgroundColor = .yellow
        horizontalStackView.backgroundColor = .blue
        viewInsideStack.backgroundColor = .brown
        
       
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGreen
        config.cornerStyle = .capsule
        nameButton.configuration = config
        nameButton.setTitle("Button", for: .normal)
    
    }
    
    private func layout() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundView)
        view.addSubview(bottomView)
        view.addSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(nameButton)
        verticalStackView.addArrangedSubview(textField)
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
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
            view.bottomAnchor.constraint(equalToSystemSpacingBelow:
                                         verticalStackView.bottomAnchor,
                                         multiplier: 2),
            //View Inside The Sctack
            viewInsideStack.heightAnchor.constraint(equalToConstant: 200),
            
            //Name Button
            nameButton.heightAnchor.constraint(equalToConstant: 40),
            
            //Text Field
            textField.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}
