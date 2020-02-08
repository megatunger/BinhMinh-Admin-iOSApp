//
//  FormSendSingleStudent.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 2/8/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit

class FormSendSingleStudent: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var studentsTable: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var dataSource = [EventStudents]()
    private let minInterval = 0.05
    private var previousRun = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
//        setupTableViewBackgroundView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.searchController.isActive = true
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentsTable.dequeueReusableCell(withIdentifier: "ListStudentCell", for: indexPath) as! ListStudentCell
        let student = dataSource[indexPath.row]
        cell.titleLabel.text = student.studentName
        cell.subtitleLabel.text = "ID: \(student.id)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "studentSelectedSendNotify", sender: nil)
    }
    private func setupTableViewBackgroundView() {
        let backgroundViewLabel = UILabel(frame: .zero)
        backgroundViewLabel.textColor = .darkGray
        backgroundViewLabel.numberOfLines = 0
        backgroundViewLabel.text = " Không có kết quả "
        backgroundViewLabel.textAlignment = NSTextAlignment.center
        backgroundViewLabel.font.withSize(20)
        studentsTable.backgroundView = backgroundViewLabel
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "studentSelectedSendNotify" {
            let selectedRows = studentsTable.indexPathsForSelectedRows
            let selectedData = selectedRows?.map { dataSource[$0.row] }
            if (selectedData == nil) {
                // CASE: No Student Selected
                let alert = UIAlertController(title: "Chưa chọn học sinh", message: "Vui lòng tích vào các học sinh cần gửi", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                if let destinationVC = segue.destination as? ContentSendEvent {
                    destinationVC.selectedStudentID = selectedData ?? [EventStudents]()
                }
            }
        }
    }
}
extension FormSendSingleStudent: UISearchResultsUpdating {
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
