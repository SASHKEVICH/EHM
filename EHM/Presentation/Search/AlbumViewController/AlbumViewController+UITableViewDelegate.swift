//
//  AlbumViewController+UITableViewDelegate.swift
//  EHM
//
//  Created by Александр Бекренев on 29.11.2022.
//

import Foundation
import UIKit

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
