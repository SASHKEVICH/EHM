//
//  MembersViewController+UITableViewDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import UIKit

extension MemberViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let bands = bands else {
            fatalError("something went wrong in cells...")
        }
        let item = bands[indexPath.item]
        let bandVC = BandViewController(bandId: item.id, title: item.title)
        navigationController?.pushViewController(bandVC, animated: true)
    }
}
