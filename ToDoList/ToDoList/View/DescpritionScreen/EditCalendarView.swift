//
//  EditCalendarView.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 29.11.2022.
//

import UIKit
import FSCalendar

final class EditCalendarView: UIView {
    weak var delegate: EditCalendarViewDelegate?
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.delegate = self
        
        return calendar
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select deadline"
        label.font = UIFont(name: "San Francisco", size: 17)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, calendar])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            calendar.heightAnchor.constraint(equalToConstant: 240),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

extension EditCalendarView: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate?.editCalendarViewDidSelectDate(date: date)
    }
}


