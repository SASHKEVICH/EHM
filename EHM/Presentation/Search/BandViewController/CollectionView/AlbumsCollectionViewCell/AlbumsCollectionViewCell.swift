//
//  AlbumsCollectionViewCell.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import UIKit

final class AlbumsCollectionViewCell: UICollectionViewCell {
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .ehmRed
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func set(cover: UIImage?, title: String) {
        if let cover = cover { coverImageView.image = cover }
        titleLabel.text = title
        titleLabel.sizeToFit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(coverImageView)
        addSubview(titleLabel)

        coverImageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.centerX.equalTo(snp.centerX)
            make.size.equalTo(150)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(5)
            make.leading.equalTo(snp.leading)
            make.height.equalTo(22)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
