//
//  DoneTaskTableViewCell.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 27.11.2022.
//

import UIKit

final class DoneTaskTableViewCell: UITableViewCell {
    private let taskName = UILabel()
    private let tickButton = UIButton()
    static private let rowHeight: CGFloat = 150
    static let reuseID = "doneTaskCell"
    var doneButtonDidTap: (() -> Void)?
    
    func configure(with task: Task) {
        taskName.text = task.title
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
        tickButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func doneButtonTapped(_ sender: UIButton) {
        doneButtonDidTap?()
        OngoingTaskTableViewCell.delegate?.didDoneButtonTapped()
    }
}

extension DoneTaskTableViewCell {
    
    private func setup() {
        self.contentView.backgroundColor = .appBackground
        //Button
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .green)
        let image = UIImage(systemName: "checkmark.seal.fill", withConfiguration: imageConfiguration) as UIImage?
        var tickButtonfiguration = UIButton.Configuration.gray()
        tickButtonfiguration.baseBackgroundColor = .clear
        tickButtonfiguration.cornerStyle = .capsule
        tickButton.configuration = tickButtonfiguration
        tickButton.setImage(image, for: .normal)
        //Label
        taskName.text = "Task name"
        taskName.font = UIFont(name: "San Francisco", size: 17)
        taskName.sizeToFit()
    }
    
    private func layout() {
        taskName.translatesAutoresizingMaskIntoConstraints = false
        tickButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tickButton)
        addSubview(taskName)
        
        NSLayoutConstraint.activate([
            tickButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            tickButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            taskName.centerYAnchor.constraint(equalTo: tickButton.centerYAnchor),
            taskName.leadingAnchor.constraint(equalTo: tickButton.trailingAnchor, constant: 16)
        ])
    }
}
