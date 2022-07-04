//
//  SchoolList.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/3/22.
//

import Foundation
import UIKit

class SchoolListViewController: UIViewController {
    private let viewModel: SchoolViewModel
    
    init(viewModel: SchoolViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SchoolCell.self, forCellReuseIdentifier: "SchoolCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    func loadData() -> Void {
        // Load data
        viewModel.fetchSchools { [weak self] success, error in
            guard error == nil else {
                // Show error
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                DispatchQueue.main.async {
                    self?.present(alert, animated: true)
                }
                return
            }
            
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func setupUI() -> Void {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor
                .constraint(equalTo: view.topAnchor,
                            constant: 0),
            tableView.leftAnchor
                .constraint(equalTo: view.leftAnchor,
                            constant: 0),
            tableView.rightAnchor
                .constraint(equalTo: view.rightAnchor,
                           constant: 0),
            tableView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor,
                            constant: 0),
        ])
        
    }
    
    
}

extension SchoolListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath) as? SchoolCell {
            viewModel.setupCell(cell, indexPath: indexPath)
            
            return cell
        }
        
        // Error
        return UITableViewCell()
    }
    
}
