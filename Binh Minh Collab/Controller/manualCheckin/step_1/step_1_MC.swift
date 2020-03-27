//
//  step_1_MC.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 3/18/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit

class step_1_MC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dataSource = [EventStudents]()
    private let minInterval = 0.05
    private var previousRun = Date()
    let searchController = UISearchController(searchResultsController: nil)
    var params = manualCheckinResponseParams.init(student_id: nil, classroom_id: nil, event_id: nil)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentsTable.dequeueReusableCell(withIdentifier: "ListStudentCell", for: indexPath) as! ListStudentCell
        let student = dataSource[indexPath.row]
        cell.titleLabel.text = student.studentName
        cell.subtitleLabel.text = "ID: \(student.id)"
        return cell
    }
    
    @IBOutlet weak var studentsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        // Do any additional setup after loading the view.
    }
    

    private func setupSearchController() {
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Tìm bằng tên hoặc ID hoặc SĐT.."

        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        self.navigationController?.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.params.student_id = dataSource[indexPath.row].id
        let storyboard = UIStoryboard(name: "manualCheckin", bundle: nil)
        let controller :step_2_MC  = storyboard.instantiateViewController(withIdentifier: "step_2_MC") as! step_2_MC
        controller.params = self.params
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension step_1_MC: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            Constant.APIManager.searchStudent(query: text, completion: {(data, error) in
                self.dataSource = data ?? [EventStudents]()
                self.studentsTable.reloadData()
            })
        }
  }
}

