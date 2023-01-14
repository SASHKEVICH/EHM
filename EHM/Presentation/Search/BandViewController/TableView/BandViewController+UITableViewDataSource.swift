//
//  BandViewController+UITableViewDataSource.swift
//  EHM
//
//  Created by Александр Бекренев on 03.12.2022.
//

import UIKit

extension BandViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == currentMembersTableView {
            return currentMembers?.count ?? 0
        } else {
            return previousMembers?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == currentMembersTableView {
            guard let currentMembers = currentMembers else { return UITableViewCell() }
            let cell = currentMembersTableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell") as? MemberTableViewCell
            cell?.set(index: indexPath.item + 1, name: currentMembers[indexPath.item].title)
            cell?.accessoryView = UIImageView().redAccessory
            cell?.tintColor = .ehmRed
            return cell ?? UITableViewCell()
        } else {
            guard let previousMembers = previousMembers else { return UITableViewCell() }
            let cell = currentMembersTableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell") as? MemberTableViewCell
            cell?.set(index: indexPath.item + 1, name: previousMembers[indexPath.item].title)
            cell?.accessoryView = UIImageView().redAccessory
            cell?.tintColor = .ehmRed
            return cell ?? UITableViewCell()
        }
    }
}
