[![Platform](https://img.shields.io/badge/平台-%20IOS%20-brightgreen.svg)](https://github.com/sam38124)
[![characteristic](https://img.shields.io/badge/特點-%20輕量級%20%7C%20簡單易用%20%20%7C%20穩定%20-brightgreen.svg)](https://github.com/sam38124)
# JzOsFrameWork
This is a framework base on android architecture so you can very easily bulid android and ios native app no need Logic conversion~

[android版本](https://github.com/sam38124/JzFrameWork)
## List
* [How to introduce to the project?](#Import)
* [Quick Start](#Use)
* [Exposure method](#All)
* [About me](#About)

<a name="Import"></a>
## How to introduce to the project?
> Support Swift Package。 <br/>

#### 1.Open xcode and paste link for Swift Package
+ > ##### https://github.com/sam38124/JzOsFrameWork 

## Quick Start

#### 1.Create ViewController and extend JzActivity
```swift
import UIKit
import JzIos_Framework

class ViewController:JzActivity{

    @IBOutlet var container: UIView!

    override func viewInit() {

        //Set the place where you want to change page and defined to rootview
        rootView=container
        //Set the home page
        JzActivity.getControlInstance.setHome(Page_Home(), "Home")
    }
    override func changePageListener(_ controler: pagemenory) {

        print("Switch\(controler.tag)")

    }
 
}

```
### And use all function like android logic

<a name="All"></a>
```swift
public protocol ControlInstance {
    //Get memory like android SharedPreferences
    func getPro(_ name: String,_ normal:String)->String
    //Get memory like android SharedPreferences
    func getPro(_ name: String,_ normal:Bool)->Bool
    //Get memory like android SharedPreferences
    func getPro(_ name: String,_ normal:Int)->Int
    //Store memory like android SharedPreferences
    func setPro(_ name:String,_ key:String)
    //Store memory like android SharedPreferences
    func setPro(_ name:String,_ key:Bool)
    //Store memory like android SharedPreferences
    func setPro(_ name:String,_ key:Int)
    //Clear memory like android SharedPreferences
    func removePro()
    //Set the home page
    func setHome(_ home:UIViewController,_ tag:String)
    //Go back
    func goBack()
    //Go back to viewController where tag is input value
    func goBack(_ tag:String)
    //ChangePage
    func changePage(_ newViewController: UIViewController,_ tag:String,_ goback:Bool)
    //Change viewController where view area you want to display
    func changeFrage(_ original: UIView,_ newViewController: UIViewController,_ originViewController:UIViewController)
    //Get viewController where tag is input value
    func getPageByTag(_ tag:String) -> UIViewController?
    //Open Dialog
    func openDiaLog(_ newViewController: UIViewController,_ swipe:Bool,_ tag:String)
    //Close all dialog 
    func closeDialLog()
    //Close dialog where tag is input value
    func closeDialLog(_ tag:String)
    //Reback to home page
    func goMenu()
    //Get root controller where extend JzActivity
    func getActivity()->JzActivity
    //Get rootview width
    func getViewWidth() -> Int
    //Get rootview height
    func getViewHeight() -> Int
    //Get something information about device
    func getDeviceInformation() -> deviceInfo
    //Show toast like android
    func toast(_ text:String)
    //Close app
    func closeApp()
    //Get now page tag name 
    func getNowPageTag() -> String
    //Get now page on screen
    func getNowPage() -> UIViewController
    //Set drawer viewController
    func setDrawer(_ newViewController: UIViewController)
    //Open drawer if open
    func openDrawer()
    //Close drawer if open
    func closeDrawer()
    //Get drawer
    func getDrawer()->UIViewController
    //Open drag gesture for drawer
    func canDragDrawer()
    //Close drag gesture for drawer
    func lockDrawer()
    //Get ipa version on appleStore
    func getStoreVersion(_ caller:GetVersion)
    //Remove screen controller 
    func removeController(_ controller:UIViewController)
    //Get controller in Storyboard
    func getNewController(_ name:String,_ id:String) -> UIViewController
    //Go appleStore
    func goAppStore(appid:String)   
}
```

<a name="About"></a>
# About me
#### <font color="#0000dd"> Work for: </font><br /> 
+ ##### <font color="#660000">【Orange Electronic】</font><br /> 
#### <font color="#0000dd"> Position: </font><br /> 
+ ##### Full stack engineer<br/>  
#### <font color="#0000dd"> Main defense range: </font><br /> 
+ ##### Android and IOS(4 years)<br/>  
+ ##### Jsp(2 years)<br/> 
+ ##### Javascript and Jquery and Ktor(1 years)<br /> 
#### <font color="#0000dd"> Contact information: </font><br /> 
+  ##### line:sam38124<br /> 

+  ##### gmail:sam38124@gmail.com

