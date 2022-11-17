//
//  BandViewController.swift
//  EHM
//
//  Created by Александр Бекренев on 17.11.2022.
//

import UIKit

class BandViewController: UIViewController {
    private let bandId: Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(bandId: Int) {
        self.bandId = bandId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
}
