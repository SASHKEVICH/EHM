//
//  MemberViewController+Constraints.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import Foundation
import UIKit

extension MemberViewController {
    override func updateViewConstraints() {
        updateHeightConstraintFor(views: [nameLabel, yearsLabel, biographyTextLabel])
        currentBandsTableView.snp.updateConstraints { make in
            make.height.equalTo(currentBandsTableView.contentSize.height)
        }
        
        super.updateViewConstraints()
    }
    
    func setupScrollView() {
        view.addSubview(memberScrollView)
        memberScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        memberScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(memberScrollView.contentLayoutGuide.snp.edges)
            make.width.equalTo(memberScrollView.frameLayoutGuide.snp.width)
        }
        
        contentView.addSubview(memberStackView)
        memberStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(23)
            make.top.equalTo(contentView.snp.top).inset(18)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    func setupHeader() {
        memberStackView.addArrangedSubview(headerStackView)
        
        headerStackView.addSubview(memberImageView)
        headerStackView.addSubview(nameLabel)
        headerStackView.addSubview(yearsLabel)
        
        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(memberStackView.snp.top)
            make.centerX.equalTo(memberStackView.snp.centerX)
            make.width.equalTo(memberStackView.snp.width)
            make.bottom.equalTo(yearsLabel.snp.bottom)
        }
        
        memberImageView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.top)
            make.centerX.equalTo(headerStackView.snp.centerX)
            make.size.equalTo(368)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(memberImageView.snp.bottom).offset(25)
            make.centerX.equalTo(headerStackView.snp.centerX)
            make.height.equalTo(0)
        }
        
        yearsLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalTo(headerStackView.snp.centerX)
            make.height.equalTo(0)
        }
    }
    
    func setupBiography() {
        memberStackView.addArrangedSubview(biographyStackView)
        
        biographyStackView.addSubview(biographyLabel)
        biographyStackView.addSubview(biographyTextLabel)
        
        biographyStackView.snp.makeConstraints { make in
            make.top.equalTo(biographyLabel.snp.top)
            make.leading.equalTo(memberStackView.snp.leading)
            make.trailing.equalTo(memberStackView.snp.trailing)
            make.bottom.equalTo(biographyTextLabel.snp.bottom)
        }
        
        biographyLabel.snp.makeConstraints { make in
            make.leading.equalTo(biographyStackView.snp.leading)
            make.height.equalTo(22)
        }
        
        biographyTextLabel.snp.makeConstraints { make in
            make.top.equalTo(biographyLabel.snp.bottom).offset(10)
            make.leading.equalTo(biographyStackView.snp.leading)
            make.trailing.equalTo(biographyStackView.snp.trailing)
            make.height.equalTo(0)
        }
    }
    
    func setupCurrentBands() {
        memberStackView.addArrangedSubview(currentBandsStackView)
        
        currentBandsStackView.addSubview(currentBandsLabel)
        currentBandsStackView.addSubview(currentBandsTableView)
        
        currentBandsStackView.snp.makeConstraints { make in
            make.top.equalTo(currentBandsLabel.snp.top)
            make.leading.equalTo(currentBandsStackView.snp.leading)
            make.bottom.equalTo(currentBandsTableView.snp.bottom)
        }
        
        currentBandsLabel.snp.makeConstraints { make in
            make.leading.equalTo(currentBandsStackView.snp.leading)
            make.height.equalTo(22)
        }
    
        currentBandsTableView.snp.makeConstraints { make in
            make.top.equalTo(currentBandsLabel.snp.bottom).offset(10)
            make.leading.equalTo(currentBandsStackView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(0)
        }
    }
    
    func setupAdditionalInfo() {
        for view in [originCityView] {
            memberStackView.addArrangedSubview(view)
            memberStackView.setCustomSpacing(15, after: view)
            view.snp.makeConstraints { make in
                make.leading.equalTo(memberStackView.snp.leading)
                make.trailing.equalTo(memberStackView.snp.trailing)
            }
        }
    }
    
    func size(labels: [UILabel]) {
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
