//
//  ViewController.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 21.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    private let segmentControll = UISegmentedControl(items: ["ToDo", "Done"])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }


}

extension MainViewController {
    
    private func style() {
        view.backgroundColor = .appBackground
        
        //SegmentControll
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
             segmentControll.setTitleTextAttributes(titleTextAttributes, for:.normal)
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
              segmentControll.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        segmentControll.backgroundColor = .black
        segmentControll.layer.borderColor = UIColor.darkGray.cgColor
        segmentControll.selectedSegmentTintColor = UIColor.white
        segmentControll.layer.borderWidth = 1
    }
    
    private func layout() {
        navigationItem.titleView = segmentControll
        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentControll)
        
        
    }
}

