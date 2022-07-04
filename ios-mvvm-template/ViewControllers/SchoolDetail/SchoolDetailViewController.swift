//
//  SchoolDetailViewController.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/3/22.
//

import Foundation
import UIKit

class SchoolDetailViewController: UIViewController {
    private let viewModel: SchoolDetailViewModel
    
    init(viewModel: SchoolDetailViewModel) {
        self.viewModel = viewModel
        self.details = [schoolName, summary, numOfSatTestTakers, satReadingScore, satMathScore, satWritingScore]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    private let schoolName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NA"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 5
        return label
    }()
    
    private let summary: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NA"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 30
        return label
    }()
    
    private let numOfSatTestTakers: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NA"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let satReadingScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NA"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let satMathScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NA"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let satWritingScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NA"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mainView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.layer.cornerRadius = 10
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 3.5, y: 3.5)
        activityIndicator.transform = transform
        activityIndicator.layer.borderColor = UIColor.black.cgColor
        activityIndicator.backgroundColor = UIColor.white
        return activityIndicator
    }()
    
    let details: [UILabel]
    
    private func setupUI() -> Void {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        scrollView.addSubview(mainView)
        mainView.addSubview(mainStackView)
        
        for i in 0..<viewModel.schoolDetailTitles.count {
            let stackView = createStackView()
            let labelsStackView = createLabelView(title: viewModel.schoolDetailTitles[i])
            mainStackView.addArrangedSubview(stackView)
            stackView.addArrangedSubview(labelsStackView)
            stackView.addArrangedSubview(details[i])
        }
        
        addConstraints()
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }
    
    private func createLabelView(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5),
            mainStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func loadData() {
        activityIndicator.startAnimating()
        viewModel.fetchSchoolDetail { [weak self] success, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.activityIndicator.stopAnimating()
                let schoolDetail = self.viewModel.schoolDetail
                guard error == nil, schoolDetail != nil else {
                    self.showAlert(error?.localizedDescription ?? "Cannot Connect to Server")
                    return
                }
                
                if success {
                    self.schoolName.text = schoolDetail?.schoolName
                    self.summary.text = self.viewModel.getSchoolSummary()
                    self.numOfSatTestTakers.text = schoolDetail?.numOfSatTestTakers
                    self.satWritingScore.text = schoolDetail?.satWritingAvgScore
                    self.satMathScore.text = schoolDetail?.satMathAvgScore
                    self.satReadingScore.text = schoolDetail?.satCriticalReadingAvgScore
                }
            }
        }
    }
    
    private func showAlert(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}
