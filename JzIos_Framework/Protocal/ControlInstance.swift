//
//  ControlInstance.swift
//  JzIos_Framework
//
//  Created by 王建智 on 2020/1/1.
//  Copyright © 2020 王建智. All rights reserved.
//

import Foundation
import UIKit
public protocol ControlInstance {
    func getPro(_ name:String)->String
    func setPro(_ name:String,_ key:String)
    func setHome(_ home:UIViewController,_ tag:String)
    func goBack()
    func changePage(_ newViewController: UIViewController,_ tag:String,_ goback:Bool)
    func changeFrage(_ original: UIView,_ newViewController: UIViewController)
    func openDiaLog(_ newViewController: UIViewController)
    func closeDialLog()
    func goMenu()
}
