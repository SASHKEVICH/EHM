//
//  MemberViewController+DataProviderDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import Foundation

extension MemberViewController: DataProviderDelegate {
    func didRecieve(item: SearchResultViewModelItem) {
        if let member = item as? MemberViewModelItem {
            bands = member.currentBands
            currentBandsTableView.reloadData()
            present(member: member)
        }

        view.setNeedsUpdateConstraints()
    }

    func didFailToLoadData(error: Error) {
        alertPresenter?.requestPresentAlert(for: error)
    }
}
