//
//  SchoolCell.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/3/22.
//

import Foundation
import UIKit

class SchoolCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    let schoolNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.numberOfLines = 2;
        return label
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.numberOfLines = 2;
        return label
    }()
    
    let studentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    
    let websiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .blue
        label.attributedText = NSAttributedString(string: "www.underline.com", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(schoolNameLabel)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(studentsLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(websiteLabel)
        
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSchoolLink(_:)))
        websiteLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: 5),
            schoolNameLabel.leftAnchor
                .constraint(equalTo: contentView.leftAnchor,
                           constant: 10),
            schoolNameLabel.rightAnchor
                .constraint(equalTo: contentView.rightAnchor,
                           constant: 10),
            
            summaryLabel.topAnchor
                .constraint(equalTo: schoolNameLabel.bottomAnchor,
                           constant: 5),
            summaryLabel.leftAnchor
                .constraint(equalTo: contentView.leftAnchor,
                           constant: 10),
            summaryLabel.rightAnchor
                .constraint(equalTo: contentView.rightAnchor,
                           constant: 10),
            
            studentsLabel.topAnchor
                .constraint(equalTo: summaryLabel.bottomAnchor,
                           constant: 5),
            studentsLabel.leftAnchor
                .constraint(equalTo: contentView.leftAnchor,
                           constant: 10),
            studentsLabel.rightAnchor
                .constraint(equalTo: contentView.rightAnchor,
                           constant: 10),

            locationLabel.topAnchor
                .constraint(equalTo: studentsLabel.bottomAnchor,
                           constant: 5),
            locationLabel.leftAnchor
                .constraint(equalTo: contentView.leftAnchor,
                           constant: 10),
            locationLabel.rightAnchor
                .constraint(equalTo: contentView.rightAnchor,
                           constant: 10),

            phoneLabel.topAnchor
                .constraint(equalTo: locationLabel.bottomAnchor,
                           constant: 5),
            phoneLabel.leftAnchor
                .constraint(equalTo: contentView.leftAnchor,
                           constant: 10),
            phoneLabel.rightAnchor
                .constraint(equalTo: contentView.rightAnchor,
                           constant: 10),

            websiteLabel.topAnchor
                .constraint(equalTo: phoneLabel.bottomAnchor,
                           constant: 5),
            websiteLabel.leftAnchor
                .constraint(equalTo: contentView.leftAnchor,
                           constant: 10),
            websiteLabel.rightAnchor
                .constraint(equalTo: contentView.rightAnchor,
                           constant: 10),
            websiteLabel.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor,
                           constant: -10)
        ])
    }

    @objc func tapSchoolLink(_ gesture: UITapGestureRecognizer) -> Void {
        guard let label = gesture.view as? UILabel, let websiteLink = label.text else {
            return
        }
        
        if let url = URL(string: "https://\(websiteLink)") {
            UIApplication.shared.open(url)
        }
    }
}
