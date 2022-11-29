//
//  SearchViewController+UITableViewDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 15.11.2022.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
