//
//  SongsTableCell.swift
//  EHM
//
//  Created by Александр Бекренев on 29.11.2022.
//

import Foundation
import UIKit

class SongsTableCell: UITableViewCell {
    private var indexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .ehmGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .ehmRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func set(index: String, title: String, duration: String) {
        indexLabel.text = index
        titleLabel.text = title
        durationLabel.text = duration
        indexLabel.sizeToFit()
        titleLabel.sizeToFit()
        durationLabel.sizeToFit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(indexLabel)
        addSubview(titleLabel)
        addSubview(durationLabel)
        
        let constraints = [
            indexLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: indexLabel.trailingAnchor, constant: 10),
            
            durationLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
