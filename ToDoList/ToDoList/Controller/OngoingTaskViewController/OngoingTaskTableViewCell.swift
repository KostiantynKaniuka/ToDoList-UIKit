//
//  OngoingTaskTableViewCell.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 25.11.2022.
//

import UIKit

final class OngoingTaskTableViewCell: UITableViewCell {
    private let taskName = UILabel()
    private let doneButton = UIButton()
    static private let rowHeight: CGFloat = 150
    static let reuseID = "ongoingTaskCell"
    static weak var delegate: DoneTaskTableViewControllerDelegate?
    var doneButtonDidTap: (() -> Void)?
    
     func configure(with task: Task) {
        taskName.text = task.title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func doneButtonTapped(_ sender: UIButton) {
        doneButtonDidTap?()
        OngoingTaskTableViewCell.delegate?.didDoneButtonTapped()
    }
}

//MARK: - Layout
extension OngoingTaskTableViewCell {
    
    private func setup() {
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        self.contentView.backgroundColor = .appBackground
        //Button
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .systemBlue)
        let image = UIImage(systemName: "circle.circle", withConfiguration: imageConfiguration) as UIImage?
        var doneButtonconfiguration = UIButton.Configuration.gray()
        doneButtonconfiguration.baseBackgroundColor = .clear
        doneButtonconfiguration.cornerStyle = .capsule
        doneButton.configuration = doneButtonconfiguration
        doneButton.setImage(image, for: .normal)
        //Label
        taskName.text = "Task name"
        taskName.font = UIFont(name: "San Francisco", size: 17)
        taskName.sizeToFit()
    }
    
    private func layout() {
        taskName.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(doneButton)
        addSubview(taskName)
        
        NSLayoutConstraint.activate([
            doneButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            doneButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            
            taskName.centerYAnchor.constraint(equalTo: doneButton.centerYAnchor),
            taskName.leadingAnchor.constraint(equalTo: doneButton.trailingAnchor, constant: 16)
        ])
    }
}
