//
//  BandViewController+Constraints.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import UIKit
import SnapKit

extension BandViewController {
    override func updateViewConstraints() {
        updateHeightFor(views: [historyTextLabel, titleLabel])
        updateHeightFor(tableViews: [currentMembersTableView])
        super.updateViewConstraints()
    }
    
    func setupScrollView() {
        view.addSubview(bandScrollView)
        bandScrollView.makeStandardConstraints()
        
        bandScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(bandScrollView.contentLayoutGuide.snp.edges)
            make.width.equalTo(bandScrollView.frameLayoutGuide.snp.width)
        }
        
        contentView.addSubview(bandStackView)
        bandStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(23)
            make.top.equalTo(contentView.snp.top).inset(30)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    func setupHeader() {
        bandStackView.addArrangedSubview(headerStackView)
        
        headerStackView.addSubview(bandImageView)
        headerStackView.addSubview(titleLabel)
        
        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(bandStackView.snp.top)
            make.centerX.equalTo(bandStackView.snp.centerX)
            make.width.equalTo(bandStackView.snp.width)
            make.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        bandImageView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.top)
            make.centerX.equalTo(headerStackView.snp.centerX)
            make.size.equalTo(368)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bandImageView.snp.bottom).offset(20)
            make.centerX.equalTo(headerStackView.snp.centerX)
            make.height.equalTo(0)
        }
    }
    
    func setupDiscography() {
        bandStackView.addArrangedSubview(discographyStackView)
        discographyStackView.addSubview(discographyLabel)
        discographyStackView.addSubview(discographyCollectionView)
        
        discographyStackView.snp.makeConstraints { make in
            make.leading.equalTo(bandStackView)
            make.bottom.equalTo(discographyCollectionView.snp.bottom)
        }
        
        discographyLabel.snp.makeConstraints { make in
            make.top.equalTo(discographyStackView.snp.top)
            make.leading.equalTo(discographyStackView.snp.leading)
            make.height.equalTo(22)
        }
        
        discographyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(discographyLabel.snp.bottom).offset(15)
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(177)
        }
    }
    
    func setupHistory() {
        bandStackView.addArrangedSubview(historyStackView)
        historyStackView.addSubview(historyLabel)
        historyStackView.addSubview(historyTextLabel)
        
        historyStackView.snp.makeConstraints { make in
            make.leading.equalTo(bandStackView)
            make.bottom.equalTo(historyTextLabel.snp.bottom)
        }
        
        historyLabel.snp.makeConstraints { make in
            make.top.equalTo(historyStackView.snp.top)
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
    
    func setupCurrentMembers() {
        bandStackView.addArrangedSubview(currentMembersStackView)
        currentMembersStackView.addSubview(currentMembersLabel)
        currentMembersStackView.addSubview(currentMembersTableView)
        
        currentMembersStackView.snp.makeConstraints { make in
            make.leading.equalTo(bandStackView)
            make.bottom.equalTo(currentMembersTableView.snp.bottom)
        }
        
        currentMembersLabel.snp.makeConstraints { make in
            make.top.equalTo(currentMembersStackView.snp.top)
            make.leading.equalTo(currentMembersStackView.snp.leading)
            make.height.equalTo(22)
        }
        
        currentMembersTableView.snp.makeConstraints { make in
            make.top.equalTo(currentMembersLabel.snp.bottom).offset(10)
            make.leading.equalTo(currentMembersStackView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(0)
        }
    }
    
    func setupAdditionalInfo() {
        for view in [originCityView, yearsView, genresView] {
            bandStackView.addArrangedSubview(view)
            bandStackView.setCustomSpacing(15, after: view)
            view.snp.makeConstraints { make in
                make.leading.equalTo(bandStackView.snp.leading)
                make.trailing.equalTo(bandStackView.snp.trailing)
            }
        }
    }
    
    func size(labels: [UILabel]?) {
        guard let labels = labels else { return }
        for label in labels {
            label.sizeToFit()
        }
    }
    
    private func updateHeightFor(views: [UIView]) {
        for view in views {
            view.snp.updateConstraints { make in
                make.height.equalTo(view.frame.height)
            }
        }
    }
    
    private func updateHeightFor(tableViews: [UITableView]) {
        for tableView in tableViews  {
            tableView.snp.updateConstraints { make in
                make.height.equalTo(tableView.contentSize.height)
            }
        }
    }
}
