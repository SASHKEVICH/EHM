//
//  AdditionalInfoView.swift
//  EHM
//
//  Created by Александр Бекренев on 30.11.2022.
//

import UIKit

class AdditionalInfoView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .ehmGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "default"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        setupLabels()
    }
    
    private func setupLabels() {
        titleLabel.sizeToFit()
        infoLabel.sizeToFit()
        
        addSubview(titleLabel)
        addSubview(infoLabel)
        
        let constraints = [
            heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func set(info: String) {
        infoLabel.text = info
        infoLabel.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
