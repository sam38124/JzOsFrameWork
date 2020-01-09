//
//  devicInfo.swift
//  JzIos_Framework
//
//  Created by Jianzhi.wang on 2020/1/8.
//  Copyright © 2020 王建智. All rights reserved.
//

import Foundation
import UIKit
public class deviceInfo{
    //系統版本
    let systemVersion = UIDevice.current.systemVersion
    //裝置UDID
    let identifierNumber = UIDevice.current.identifierForVendor?.uuidString
    //裝置名稱
    let systemName = UIDevice.current.systemName
    //裝置型號
    let model = UIDevice.current.model
    //裝置具體型號（下邊列出）
    let modelName = UIDevice.current.modelName
    //裝置區域化型號如A1533
    let localizedModel = UIDevice.current.localizedModel
}
