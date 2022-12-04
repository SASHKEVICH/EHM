//
//  BandViewController+UITableViewDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import Foundation
import UIKit

extension BandViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentMembers = currentMembers, let previousMembers = previousMembers else {
            fatalError("something went wrong in cells...")
        }
        let item: Member = tableView == currentMembersTableView ? currentMembers[indexPath.item] : previousMembers[indexPath.item]
        let memberVC = MemberViewController(memberId: item.id, title: item.name)
        navigationController?.pushViewController(memberVC, animated: true)
    }
}
