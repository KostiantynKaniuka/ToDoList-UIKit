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
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 150
    
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
}

extension OngoingTaskTableViewCell {
    
    private func setup() {
        self.contentView.backgroundColor = .appBackground
        //Button
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .green)
        let image = UIImage(systemName: "checkmark.seal.fill", withConfiguration: imageConfiguration) as UIImage?
        var calendarButtonconfiguration = UIButton.Configuration.gray()
        calendarButtonconfiguration.baseBackgroundColor = .clear
        calendarButtonconfiguration.cornerStyle = .capsule
        doneButton.configuration = calendarButtonconfiguration
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
