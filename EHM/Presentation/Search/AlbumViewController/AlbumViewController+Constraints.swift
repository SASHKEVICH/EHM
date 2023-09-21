//
//  AlbumViewController+Constraints.swift
//  EHM
//
//  Created by Александр Бекренев on 01.12.2022.
//

import UIKit

extension AlbumViewController {
    override func updateViewConstraints() {
        updateHeightConstraintFor(views: dynamicViews)
        songsTableView.snp.updateConstraints { make in
            make.height.equalTo(songsTableView.contentSize.height)
        }

        super.updateViewConstraints()
    }

    func setupScrollView() {
        view.addSubview(albumScrollView)
        albumScrollView.makeStandardConstraints()

        albumScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(albumScrollView.contentLayoutGuide.snp.edges)
            make.width.equalTo(albumScrollView.frameLayoutGuide.snp.width)
        }

        contentView.addSubview(albumStackView)
        albumStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(23)
            make.top.equalTo(contentView.snp.top).inset(18)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }

    func setupHeader() {
        albumStackView.addArrangedSubview(headerStackView)

        headerStackView.addSubview(albumCoverImageView)
        headerStackView.addSubview(titleLabel)
        headerStackView.addSubview(bandLabel)

        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(albumStackView.snp.top)
            make.centerX.equalTo(albumStackView.snp.centerX)
            make.width.equalTo(albumStackView.snp.width)
            make.bottom.equalTo(bandLabel.snp.bottom)
        }

        albumCoverImageView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.top)
            make.centerX.equalTo(headerStackView.snp.centerX)
            make.size.equalTo(368)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(albumCoverImageView.snp.bottom).offset(25)
            make.centerX.equalTo(headerStackView.snp.centerX)
            make.height.equalTo(0)
        }

        bandLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(headerStackView.snp.centerX)
            make.height.equalTo(0)
        }
    }

    func setupSongs() {
        albumStackView.addArrangedSubview(songsStackView)

        songsStackView.addSubview(songsLabel)
        songsStackView.addSubview(songsTableView)

        songsStackView.snp.makeConstraints { make in
            make.top.equalTo(songsLabel.snp.top)
            make.leading.equalTo(albumStackView.snp.leading)
            make.bottom.equalTo(songsTableView.snp.bottom)
        }

        songsLabel.snp.makeConstraints { make in
            make.leading.equalTo(songsStackView.snp.leading)
            make.height.equalTo(22)
        }

        songsTableView.snp.makeConstraints { make in
            make.top.equalTo(songsLabel.snp.bottom).offset(10)
            make.leading.equalTo(albumStackView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(0)
        }
    }

    func setupHistory() {
        albumStackView.addArrangedSubview(historyStackView)

        historyStackView.addSubview(historyLabel)
        historyStackView.addSubview(historyTextLabel)

        historyStackView.snp.makeConstraints { make in
            make.top.equalTo(historyLabel.snp.top)
            make.leading.equalTo(albumStackView.snp.leading)
            make.trailing.equalTo(albumStackView.snp.trailing)
            make.bottom.equalTo(historyTextLabel.snp.bottom)
        }

        historyLabel.snp.makeConstraints { make in
            make.leading.equalTo(historyStackView.snp.leading)
            make.height.equalTo(22)
        }

        historyTextLabel.snp.makeConstraints { make in
            make.top.equalTo(historyLabel.snp.bottom).offset(10)
            make.leading.equalTo(historyStackView.snp.leading)
            make.trailing.equalTo(historyStackView.snp.trailing)
            make.height.equalTo(0)
        }
    }

    func setupAdditionalInfo() {
        for view in [albumTypeView, releaseDateView, genresView] {
            albumStackView.addArrangedSubview(view)
            albumStackView.setCustomSpacing(15, after: view)
            view.snp.makeConstraints { make in
                make.leading.equalTo(albumStackView.snp.leading)
                make.trailing.equalTo(albumStackView.snp.trailing)
            }
        }
    }

    func size(labels: [UILabel]?) {
        guard let labels = labels else { return }
        for label in labels {
            label.sizeToFit()
        }
    }

    func updateHeightConstraintFor(views: [UIView]?) {
        guard let views = views else { return }

        for view in views {
            view.snp.updateConstraints { make in
                make.height.equalTo(view.frame.height)
            }
        }
    }
}
