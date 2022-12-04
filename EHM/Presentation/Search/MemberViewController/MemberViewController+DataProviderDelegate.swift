//
//  MemberViewController+DataProviderDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import Foundation

extension MemberViewController: DataProviderDelegate {
    func didRecieve(data: Any) {
        if let member = data as? Member {
            present(member: member)
        }
        
        view.setNeedsUpdateConstraints()
    }
}
