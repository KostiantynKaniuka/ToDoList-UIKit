//
//  DescriptionViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 27.11.2022.
//

import UIKit
import RealmSwift
import Combine

final class DescriptionViewController: UIViewController {
    //MARK: - Outlets
    private let dummyView = UIView()
    private let taskNameTextField = DescriptionTextField()
    private let dateOfAddingTextField = DescriptionTextField()
    private let shortDescriptionTextField = DescriptionTextField()
    private let deadlineTextField = DescriptionTextField()
    private let completedDateTextField = DescriptionTextField()
    //Stack Views
    private let verticalStackView = VerticalStackView()
    private let actionButtonsStackView = HorizontalStackView()
    //Labels
    private let taskNameLabel = NameLabel()
    private let dateOfAddingLabel = NameLabel()
    private let shortDescriptionLabel = NameLabel()
    private let deadlineLabel = NameLabel()
    private let completedDateLabel = NameLabel()
    private let calendarLabel = NameLabel()
    //Buttons
    private let saveChangesButton = SaveChangesButton()
    private let changeDateCalendarButton = CalendarButton()
    private let doneButton = DoneButton()
    private let editButton = EditButton()
    private let deleteButton = DeleteButton()
    //MARK: - Properties
    private let realmManafer = RealmManager()
    private var taskId = ObjectId()
    @Published private var newDeadline:Date?
    private var subscribers = Set<AnyCancellable>()
    static weak var delegate: UpdateChanges?
    
    private lazy var editCalendarView: EditCalendarView = {
        let calendarview = EditCalendarView()
        calendarview.delegate = self
        calendarview.translatesAutoresizingMaskIntoConstraints = false
        return calendarview
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        OngoingTaskTableViewController.delegate = self
        DoneTaskTableViewController.delegate = self
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        saveChangesButton.addTarget(self, action: #selector(SaveChangesButtonTapped), for: .touchUpInside)
        changeDateCalendarButton.addTarget(self, action: #selector(editCalendarButtonTapped), for: .touchUpInside)
        setupViews()
        layout()
       // setupGestures()
        observeCalendar()
    }
    
    //MARK: - Methods
    private func observeCalendar() {
        $newDeadline.sink { date in
            self.deadlineTextField.text = date?.toString() ?? ""
        }.store(in: &subscribers)
    }
    
    @objc private func SaveChangesButtonTapped(_sender: UIButton) {
        let taskName = taskNameTextField.text ?? ""
        let shortDescription = shortDescriptionTextField.text ?? ""
        realmManafer.applyChanges(id: taskId, taskName: taskName, shortDescription: shortDescription)
        DescriptionViewController.delegate?.refreshTableView()
        taskNameTextField.isEnabled = false
        shortDescriptionTextField.isEnabled = false
        saveChangesButton.isHidden = true
        changeDateCalendarButton.isHidden = true
    }
    
    @objc private func editButtonTapped(_sender: UIButton) {
        saveChangesButton.isHidden = false
        changeDateCalendarButton.isHidden = false
        taskNameTextField.isEnabled = true
        shortDescriptionTextField.isEnabled = true
        taskNameTextField.becomeFirstResponder()
    }
    
    @objc private func editCalendarButtonTapped(_sender: Any) {
        taskNameTextField.resignFirstResponder()
        showEditCalendar()
    }
    
    private func showEditCalendar() {
        view.addSubview(editCalendarView)
        NSLayoutConstraint.activate([
            editCalendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editCalendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editCalendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func dismissEditCalendarView (completion: () -> Void) {
        editCalendarView.removeFromSuperview()
        completion()
    }
//
////    private func setupGestures() {
//        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
//        tapGestures.delegate = self
//        view.addGestureRecognizer(tapGestures)
//    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

extension DescriptionViewController: SendOngoingTaskDataToDescription {
    
    func didSendData(from task: Task) {
        taskNameTextField.text = task.title
        shortDescriptionTextField.text = task.shortDescription
        dateOfAddingTextField.text = task.dateOfAdding.toString()
        deadlineTextField.text = task.deadlineDate?.toString()
        taskId = task._id
    }
}

extension DescriptionViewController: SendDoneTaskDataToDescription {
    
    func didSendDoneData(from task: Task) {
        taskNameTextField.text = task.title
        shortDescriptionTextField.text = task.shortDescription
        completedDateTextField.text = task.doneAt?.toString()
        dateOfAddingTextField.text = task.dateOfAdding.toString()
        deadlineTextField.text = task.deadlineDate?.toString()
        taskId = task._id
    }
}

extension DescriptionViewController: EditCalendarViewDelegate {
    func editCalendarViewDidSelectDate(date: Date) {
        dismissEditCalendarView { [unowned self] in
            self.newDeadline = date
        }
    }
}

//extension DescriptionViewController: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        if editCalendarView.isDescendant(of: view) {
//            return false
//        }
//        return true
//    }
//}

extension DescriptionViewController {
    
    //MARK: - Views settings
    private func setupViews() {
        changeDateCalendarButton.isHidden = true
        saveChangesButton.isHidden = true
        view.backgroundColor = .appBackground
        verticalStackView.spacing = 8
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        taskNameLabel.text = "Task name"
        dateOfAddingLabel.text = "Date of adding"
        shortDescriptionLabel.text = "Short description"
        deadlineLabel.text = "Deadline"
        completedDateLabel.text = "Completed Date"
    }
    
    //MARK: - Layout
    private func layout() {
        dummyView.translatesAutoresizingMaskIntoConstraints = false
        actionButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        saveChangesButton.translatesAutoresizingMaskIntoConstraints = false
        changeDateCalendarButton.translatesAutoresizingMaskIntoConstraints = false
        calendarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        actionButtonsStackView.addArrangedSubview(doneButton)
        actionButtonsStackView.addArrangedSubview(editButton)
        actionButtonsStackView.addArrangedSubview(deleteButton)
        
        verticalStackView.addArrangedSubview(taskNameLabel)
        verticalStackView.addArrangedSubview(taskNameTextField)
        verticalStackView.addArrangedSubview(shortDescriptionLabel)
        verticalStackView.addArrangedSubview(shortDescriptionTextField)
        verticalStackView.addArrangedSubview(dateOfAddingLabel)
        verticalStackView.addArrangedSubview(dateOfAddingTextField)
        verticalStackView.addArrangedSubview(deadlineLabel)
        verticalStackView.addArrangedSubview(deadlineTextField)
        verticalStackView.addArrangedSubview(completedDateLabel)
        verticalStackView.addArrangedSubview(completedDateTextField)
        
        view.addSubview(verticalStackView)
        view.addSubview(actionButtonsStackView)
        view.addSubview(saveChangesButton)
        view.addSubview(changeDateCalendarButton)
        view.addSubview(calendarLabel)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            actionButtonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            actionButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveChangesButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 70),
            saveChangesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeDateCalendarButton.leadingAnchor.constraint(equalTo: saveChangesButton.trailingAnchor),
            changeDateCalendarButton.centerYAnchor.constraint(equalTo: saveChangesButton.centerYAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            doneButton.widthAnchor.constraint(equalToConstant: 60),
            editButton.heightAnchor.constraint(equalToConstant: 60),
            editButton.widthAnchor.constraint(equalToConstant: 60),
            deleteButton.heightAnchor.constraint(equalToConstant: 60),
            deleteButton.widthAnchor.constraint(equalToConstant: 60),
            saveChangesButton.widthAnchor.constraint(equalToConstant: 100),
            saveChangesButton.heightAnchor.constraint(equalToConstant: 50),
            changeDateCalendarButton.widthAnchor.constraint(equalToConstant: 100),
            changeDateCalendarButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

