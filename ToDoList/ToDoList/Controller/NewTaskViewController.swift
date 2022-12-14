//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit
import Combine

final class NewTaskViewController: UIViewController {
    //MARK: - Outlets
    private let backgroundView = UIView()
    private let bottomView = UIView()
    private let verticalStackView = VerticalStackView()
    private let horizontalStackView = HorizontalStackView()
    private let taskTextField = TaskTextField()
    private let saveTaskButton = SaveTaskButton()
    private let calendarButton = CalendarButton()
    private let deadlineLabel = UILabel()
    private lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //MARK: - Properties
    private let realmManager = RealmManager()
    private var subscribers = Set<AnyCancellable>()
    @Published private var taskString: String?
    @Published private var deadline: Date?
    static weak var delegate: MainViewControllerDelegate?
    
    //MARK: - Lifecycle
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
        saveTaskButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(calendarButtonPressed), for: .touchUpInside)
    }
    
    //MARK: - Methods
    //Enable/Disable save button
    private func observeForm() {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).map { (notification) -> String? in
            return (notification.object as? UITextField)?.text
        }.sink { [ unowned self ](text) in
            self.taskString = text
        }.store(in: &subscribers)
        $taskString.sink { (text) in
            self.saveTaskButton.isEnabled = text?.isEmpty == false
        }.store(in: &subscribers)
        //observe dealline
        $deadline.sink { date in
            self.deadlineLabel.text = date?.formatted() ?? ""
        }.store(in: &subscribers)
    }
    
    //Dismiss screen if tap at any poin except action elements
    private func setupGestures() {
        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        tapGestures.delegate = self
        view.addGestureRecognizer(tapGestures)
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    //MARK: - Calendar Actions
    private func showCalendar() {
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func dismissCalendarView (completion: () -> Void) {
        calendarView.removeFromSuperview()
        completion()
    }
    
    @objc private func calendarButtonPressed() {
        taskTextField.resignFirstResponder()
        showCalendar()
    }
    
    @objc private func saveButtonPressed() {
        let task = Task()
        task.title = taskTextField.text ?? ""
        task.deadlineDate = deadline
        NewTaskViewController.delegate?.didAddTask(task)
    }
    
    //MARK: - Keyboard Controll
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
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= keyboarHeigh
        } else {
            return
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
}

//MARK: - Gesture Recognizer Delegate
extension NewTaskViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if calendarView.isDescendant(of: view) {
            if touch.view?.isDescendant(of: calendarView) == false {
                dismissCalendarView { [ unowned self ] in
                    self.taskTextField.becomeFirstResponder()
                }
            }
            return false
        }
        return true
    }
}

//MARK: - CalendarView Delegate
extension NewTaskViewController: CalendarViewDelegate {
    
    func calendarViewDidSelectDate(date: Date) {
        dismissCalendarView { [ unowned self ] in
            self.taskTextField.becomeFirstResponder()
            self.deadline = date
        }
    }
    
    func calendarViewDidTapRemoveButton() {
        dismissCalendarView { [ unowned self ] in
            self.taskTextField.becomeFirstResponder()
            self.deadline = nil
        }
    }
}

//MARK: - Layout
extension NewTaskViewController {
   
    private func style() {
        backgroundView.backgroundColor = .AddNewTaskScreenColor
        bottomView.backgroundColor = .white
        deadlineLabel.text = "select deadline >"
        deadlineLabel.font = UIFont(name: "San Francisco", size: 17)
        deadlineLabel.textAlignment = .center
        taskTextField.setLeftPaddingPoints(10)
        taskTextField.setRightPaddingPoints(10)
    }
    
    private func layout() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        //addViews
        view.add(subviews: backgroundView, bottomView, verticalStackView)
        horizontalStackView.addArrangedSubviews([
            saveTaskButton,
            deadlineLabel,
            calendarButton
        ])
        verticalStackView.addArrangedSubviews([
            taskTextField,
            horizontalStackView
        ])
        //Constraints
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
            // Buttons
            saveTaskButton.heightAnchor.constraint(equalToConstant: 40),
            saveTaskButton.widthAnchor.constraint(equalToConstant: 100),
            calendarButton.heightAnchor.constraint(equalToConstant: 40),
            calendarButton.widthAnchor.constraint(equalToConstant: 40),
            //Text Field
            taskTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
