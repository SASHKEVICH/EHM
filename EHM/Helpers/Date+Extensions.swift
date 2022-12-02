//
//  Date+Extensions.swift
//  EHM
//
//  Created by Александр Бекренев on 02.12.2022.
//

import Foundation

private let dateDefaultFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    return dateFormatter
}()

extension Date {
    var dateString: String { dateDefaultFormatter.string(from: self) }
}
