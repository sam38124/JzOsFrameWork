[![Platform](https://img.shields.io/badge/平台-%20IOS%20-brightgreen.svg)](https://github.com/sam38124)
[![characteristic](https://img.shields.io/badge/特點-%20輕量級%20%7C%20簡單易用%20%20%7C%20穩定%20-brightgreen.svg)](https://github.com/sam38124)
# JzOsFrameWork
這是一套基於Android邏輯概念的IOS開發框架，讓開發者能迅速完成Android與IOS的原生APP開發，而不需要進行邏輯上的切換~

[android版本](https://github.com/sam38124/JzFrameWork)
## 目錄
* [如何導入到專案](#Import)
* [如何使用](#Use)
* [所有對外暴露方法](#All)
* [關於我](#About)

<a name="Import"></a>
## 如何導入到項目
> 支持framework導入。 <br/>

#### 1.首先將framework拉入要導入的Project當中
<img src="https://github.com/sam38124/JzOsFrameWork/blob/master/i2.png" width = "800"  alt="i1" /><a name="Use"></a>
#### 2.將三個選項打勾
<img src="https://github.com/sam38124/JzOsFrameWork/blob/master/i1.png" width = "800"  alt="i1" /><a name="Use"></a>
#### 3.選擇Embed and signed
<img src="https://github.com/sam38124/JzOsFrameWork/blob/master/i3.png" width = "800"  alt="i1" /><a name="Use"></a>
<a name="Use"></a>
## 如何使用

#### 1.創建ViewController並且繼承JzActivity
```swift
import UIKit
import JzIos_Framework

class ViewController:JzActivity{

    @IBOutlet var container: UIView!

    override func viewInit() {

        //設定要切換頁面的rootview
        rootView=container

        //設定要成為首頁的Controller
        let a=PeaceDefine().Page_Home

        JzActivity.getControlInstance.setHome(a, "Home")
    }
    override func changePageListener(_ controler: pagemenory) {

        print("Switch\(controler.tag)")

    }
 
}

```
### 在任何地方進行使用

<a name="All"></a>
```swift
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
```

<a name="About"></a>
### 關於我
橙的電子android and ios developer

*line:sam38124

*gmail:sam38124@gmail.com
