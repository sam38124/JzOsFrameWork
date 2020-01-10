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
    //取得紀錄
    func getPro(_ name:String)->String
    //保存紀錄
    func setPro(_ name:String,_ key:String)
    //設定首頁
    func setHome(_ home:UIViewController,_ tag:String)
    //返回上一頁
    func goBack()
    //返回tag為輸入值的頁面
    func goBack(_ tag:String)
    //頁面切換
    func changePage(_ newViewController: UIViewController,_ tag:String,_ goback:Bool)
    //Frag切換
    func changeFrage(_ original: UIView,_ newViewController: UIViewController)
    //打開Dialog
    func openDiaLog(_ newViewController: UIViewController)
    //關閉Dialog
    func closeDialLog()
    //返回首頁
    func goMenu()
    //取得Viewcontroller
    func getActivity()->JzActivity
    //取得顯示view的寬度
    func getViewWidth() -> Int
    //取得顯示view的高度
    func getViewHeight() -> Int
    //取得裝置資訊
    func getDeviceInformation() -> deviceInfo
    //吐司的顯示
    func toast(_ text:String)
    //關閉整個app
    func closeApp()
    //取得現在顯示的頁面的Tag名稱
    func getNowPageTag() -> String
}
