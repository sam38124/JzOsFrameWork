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
    func getPro(_ name: String,_ normal:String)->String
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
    func changeFrage(_ original: UIView,_ newViewController: UIViewController,_ originViewController:UIViewController)
    //取得tag為輸入值的頁面
    func getPageByTag(_ tag:String) -> UIViewController?
    //打開Dialog(only one只能有一個Dialog,新的被舊的取代)
    func openDiaLog(_ newViewController: UIViewController)
    //打開Dialog(multiple可以顯示多個Dialog)
    func openMultiDiaLog(_ newViewController: UIViewController)
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
    //取得現在的頁面
    func getNowPage() -> UIViewController
    //設定側滑選單
    func setDrawer(_ newViewController: UIViewController)
    //打開側滑選單
    func openDrawer()
    //關閉側滑選單
    func closeDrawer()
    //打開拖曳側滑功能
    func canDragDrawer()
    //關閉拖曳側滑功能
    func lockDrawer()
    //取得商店上的版本號
    func getStoreVersion(_ caller:GetVersion)
    //將一個ViewController從螢幕上移除
    func removeController(_ controller:UIViewController)
    //從Storyboard取得一個新的controller實例
    func getNewController(_ name:String,_ id:String) -> UIViewController
}
