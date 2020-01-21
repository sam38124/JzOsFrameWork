//
//  JzAdapter_Protocal.swift
//  JzIos_Framework
//
//  Created by Jianzhi.wang on 2020/1/20.
//  Copyright © 2020 王建智. All rights reserved.
//

import Foundation
import UIKit
public protocol  JzAdapter_Protocal{
    func sizeInit()->Int
    func loadView(_ index:Int)->UITableViewCell
    func setProtocal()->JzAdapter_Protocal
}
