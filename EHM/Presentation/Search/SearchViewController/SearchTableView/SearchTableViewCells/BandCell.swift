//
//  BandCell.swift
//  EHM
//
//  Created by Александр Бекренев on 14.11.2022.
//

import UIKit

final class BandCell: UITableViewCell {
    var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .ehmGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .ehmRed
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    var item: SearchResultViewModelItem? {
        didSet {
            guard let item = item as? BandViewModelItem else { return }
            titleLabel.text = item.title
            bottomLabel.text = "Группа"
            if let cover = item.cover { coverImageView.image = cover }
            titleLabel.sizeToFit()
            bottomLabel.sizeToFit()
            setNeedsLayout()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(bottomLabel)
        addSubview(titleLabel)
        addSubview(coverImageView)
        
        let constraints = [
            coverImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            coverImageView.widthAnchor.constraint(equalToConstant: 60),
            coverImageView.heightAnchor.constraint(equalToConstant: 60),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 17),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 106),
            
            bottomLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 17),
            bottomLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bottomLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 106)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
