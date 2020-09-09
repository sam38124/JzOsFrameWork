//
//  JzAdapter.swift
//  JzIos_Framework
//
//  Created by Jianzhi.wang on 2020/1/15.
//  Copyright © 2020 王建智. All rights reserved.
//

import Foundation
import UIKit
open  class JzAdapter:NSObject, UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    var tb:UITableView! = nil
    var protocal:JzAdapter_Protocal! = nil
    
   public init(_ tb:UITableView,_ model:NSObject){
        super.init()
        self.tb=tb
        tb.delegate=self
        protocal=setProtocal()
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return protocal.sizeInit();
      }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return protocal.loadView(indexPath.row)
    }
    
    public func notifyDataSetChange(){tb.reloadData()}
    
    public func setProtocal()->JzAdapter_Protocal{
        return protocal
    }
    
}
