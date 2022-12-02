//
//  BandViewController+Constraints.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import Foundation

extension BandViewController {
    func setupScrollView() {
        view.addSubview(bandScrollView)
        bandScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
    
    func setupAlbumCollection() {
        bandStackView.addArrangedSubview(discographyLabel)
        discographyLabel.snp.makeConstraints { make in
            make.top.equalTo(bandStackView.snp.top)
            make.height.equalTo(22)
        }
    }
    
    func setupHistory() {
        bandStackView.addArrangedSubview(historyStackView)
        historyStackView.addSubview(historyLabel)
        historyStackView.addSubview(historyTextLabel)
        
        historyStackView.snp.makeConstraints { make in
            make.leading.equalTo(bandStackView.snp.leading)
            make.centerX.equalTo(bandStackView.snp.centerX)
            make.width.equalTo(bandStackView.snp.width)
            make.bottom.equalTo(historyTextLabel.snp.bottom)
        }
        
        historyLabel.snp.makeConstraints { make in
            make.leading.equalTo(historyStackView.snp.leading)
            make.height.equalTo(22)
        }
        
        historyTextLabel.snp.makeConstraints { make in
            make.top.equalTo(historyLabel.snp.bottom).offset(10)
            make.leading.equalTo(historyStackView.snp.leading)
            make.height.equalTo(0)
        }
    }
}
