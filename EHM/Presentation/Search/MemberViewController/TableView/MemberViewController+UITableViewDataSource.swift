//
//  MemberViewController+UITableViewDataSource.swift
//  EHM
//
//  Created by Александр Бекренев on 04.12.2022.
//

import Foundation
import UIKit

extension MemberViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
