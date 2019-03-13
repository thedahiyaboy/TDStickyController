//
//  TDStickyVC.swift
//  TDStickyController
//
//  Created by MacMini-1 on 2/6/19.
//  Copyright © 2019 TinuDahiya. All rights reserved.
//

import UIKit

class TDStickyVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let stickyView = TDStickyView.instanceFromNib()
        stickyView.viewSetup(self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    
}
