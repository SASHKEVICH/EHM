//
//  MemberTableViewCell.swift
//  EHM
//
//  Created by Александр Бекренев on 03.12.2022.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    private var indexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .ehmGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(indexLabel)
        addSubview(nameLabel)
        
        indexLabel.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(5)
            make.centerY.equalTo(snp.centerY)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(indexLabel.snp.trailing).offset(10)
            make.centerY.equalTo(snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(index: Int, name: String) {
        indexLabel.text = String(index)
        nameLabel.text = name
        indexLabel.sizeToFit()
        nameLabel.sizeToFit()
    }
}
