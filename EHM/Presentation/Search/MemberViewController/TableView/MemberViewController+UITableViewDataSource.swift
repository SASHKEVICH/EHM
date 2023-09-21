//
//  MemberViewController+UITableViewDataSource.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import UIKit

extension MemberViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bands?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bands = bands else {
            fatalError("something went wrong in cells...")
        }
        let band = bands[indexPath.item]
        let cell = currentBandsTableView.dequeueReusableCell(
            withIdentifier: "BandsTableViewCell"
        ) as? BandsTableViewCell
        cell?.set(index: indexPath.item + 1, name: band.title)
        cell?.accessoryView = UIImageView().redAccessory
        cell?.tintColor = .ehmRed
        return cell ?? UITableViewCell()
    }
}
