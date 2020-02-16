//
//  JzActivity.swift
//  JzIos_Framework
//
//  Created by 王建智 on 2020/1/1.
//  Copyright © 2020 王建智. All rights reserved.
//

import Foundation
import UIKit
open class JzActivity:UIViewController,ControlInstance {
    
    
    public func closeDialLog(_ tag: String) {
        var memory=[pagemenory]()
        for i in AllDialog{
            if(i.tag==tag){
                i.page.willMove(toParent: nil)
                i.page.view.removeFromSuperview()
                i.page.removeFromParent()
                i.page.dismiss(animated: true, completion: nil)
                i.page=nil
            }else{
                memory.append(i)
            }
        }
    AllDialog=memory
    }
    
    public func getDrawer()->UIViewController {
        return drawer
    }
    
    
    
    var backview=UIView()
    public func getPageByTag(_ tag: String) -> UIViewController? {
        for i in Pagememory{
            if(i.tag == tag){
                return i.page
            }
        }
        return nil
    }
    
    public func getNewController(_ name: String, _ id: String) -> UIViewController {
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: id)
    }
    
    public func removeController(_ controller: UIViewController) {
        controller.didMove(toParent: nil)
        controller.removeFromParent()
        controller.view.removeFromSuperview()
    }
    
    
    
    public func getNowPage() -> UIViewController {
        return Fraging
    }
    
    public func getStoreVersion(_ caller: GetVersion) {
        let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(Bundle.main.bundleIdentifier ?? "")")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                caller.versionBack(nil)
                return }
            let DaS=String(data: data, encoding: .utf8)!
            let NewVersion=DaS.components(separatedBy: "\"version\"")[1].components(separatedBy:"\"")[1]
            caller.versionBack(NewVersion)
        }
        task.resume()
    }
    
    
    public func canDragDrawer() {
        lockdrawer=false
    }
    
    public func lockDrawer() {
        lockdrawer=true
    }
    
    public func openDrawer() {
        UIView.animate(withDuration: 0.3) {
            self.Fraging.view.isUserInteractionEnabled=false
            self.drawer.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width*0.8,height: self.view.bounds.height)
            self.Fraging.view.frame=self.Fraging.view.frame
            self.Fraging.view.addSubview(self.backview)
        }
    }
    
    public func closeDrawer() {
        UIView.animate(withDuration: 0.3) {
            self.backview.removeFromSuperview()
            self.Fraging.view.isUserInteractionEnabled=true
            self.drawer.view.frame = CGRect(x: 0-self.view.bounds.width*0.8, y: 0, width: self.view.bounds.width*0.8,height: self.view.bounds.height)
        }
    }
    
    public func setDrawer(_ newViewController: UIViewController) {
        if(drawer != nil){
            drawer.willMove(toParent: nil)
            drawer.view.removeFromSuperview()
            drawer.removeFromParent()
        }
        newViewController.view.frame = CGRect(x: 0-view.bounds.width*0.8, y: 0, width: view.bounds.width*0.8,height: view.bounds.height)
        newViewController.didMove(toParent: self)
        addChild(newViewController)
        view.addSubview(newViewController.view)
        drawer=newViewController
    }
    public func getNowPageTag() -> String {
        return Pagememory[Pagememory.count-1].tag
    }
    
    public func closeApp() {
        self.dismiss(animated: false, completion: nil)
    }
    
    public func goBack(_ tag: String) {
        for i in 0..<Pagememory.count{
            if(Pagememory[i].tag==tag){
                if(Pagememory.count<2){return}
                let newViewController=Pagememory[i];
                if Fraging != nil {
                    Fraging.willMove(toParent: nil)
                    Fraging.view.removeFromSuperview()
                    Fraging.removeFromParent()
                }
                addChild(newViewController.page)
                self.rootView.addSubview(newViewController.page.view)
                newViewController.page.view.frame = rootView.bounds
                newViewController.page.didMove(toParent: self)
                self.Fraging = newViewController.page
                while(Pagememory.count != i+1){
                    Pagememory.remove(at: Pagememory.count-1)
                }
                changePageListener(newViewController)
                return
            }
        }
    }
    public func getDeviceInformation() -> deviceInfo {
        return deviceInfo()
    }
    
    public func toast(_ a: String) {
        view.showToast(a)
    }
    
    public func getViewWidth() -> Int{
        return Int(view.frame.width)
    }
    
    public func getViewHeight()->Int {
        return Int(view.frame.height)
    }
    
    public func getActivity() -> JzActivity {
        return self
    }
    
    
    public func goMenu() {
        let a=Pagememory[0]
        Pagememory.removeAll()
        changePage(a.page,a.tag,true)
    }
    
    public func changePage(_ newViewController: UIViewController,_ tag: String,_ goback:Bool) {
        if Fraging != nil {
            Fraging.willMove(toParent: nil)
            Fraging.view.removeFromSuperview()
            Fraging.removeFromParent()
        }
        if(goback){
            let a=pagemenory()
            a.page=newViewController
            a.tag=tag
            Pagememory.append(a)
            changePageListener(a)
        }
        addChild(newViewController)
        self.rootView.addSubview(newViewController.view)
        newViewController.view.frame = rootView.bounds
        newViewController.didMove(toParent: self)
        self.Fraging = newViewController
    }
    
    public func changeFrage(_ original: UIView,_ newViewController: UIViewController,_ originViewController:UIViewController)
    {
        originViewController.addChild(newViewController)
        original.addSubview(newViewController.view)
        newViewController.view.frame = original.bounds
        newViewController.didMove(toParent: originViewController)
    }
    
    public func getPro(_ name: String,_ normal:String) -> String {
        let preferences = UserDefaults.standard
        let currentLevelKey = name
        if preferences.object(forKey: currentLevelKey) == nil {
            return normal
        } else {
            let currentLevel = preferences.string(forKey: currentLevelKey)!
            return currentLevel
        }
    }
    
    public func setPro(_ name: String, _ key: String) {
        let preferences = UserDefaults.standard
        preferences.set(key,forKey: name)
        let didSave = preferences.synchronize()
        if !didSave {
            print("saverror")
        }
    }
    
    public func setHome(_ home: UIViewController,_ tag:String) {
        Pagememory.removeAll()
        changePage(home,tag,true)
    }
    
    public func goBack() {
        if(Pagememory.count<2){return}
        let newViewController=Pagememory[Pagememory.count-2];
        if Fraging != nil {
            Fraging.willMove(toParent: nil)
            Fraging.view.removeFromSuperview()
            Fraging.removeFromParent()
        }
        addChild(newViewController.page)
        self.rootView.addSubview(newViewController.page.view)
        newViewController.page.view.frame = rootView.bounds
        newViewController.page.didMove(toParent: self)
        self.Fraging = newViewController.page
        Pagememory.remove(at: Pagememory.count-1)
        changePageListener(newViewController)
    }
    public func openDiaLog(_ newViewController: UIViewController,_ swipe:Bool,_ tag:String) {
        if(swipe){
            newViewController.view.backgroundColor = .none
        }else{
            newViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
        let page=pagemenory()
        page.page=newViewController
        page.tag=tag
        addChild(newViewController)
        self.view.addSubview(newViewController.view)
        newViewController.view.frame = self.view.bounds
        newViewController.didMove(toParent: self)
        AllDialog.append(page)
    }
    
    public func closeDialLog() {
        for i in AllDialog{
            i.page.willMove(toParent: nil)
            i.page.view.removeFromSuperview()
            i.page.removeFromParent()
            i.page.dismiss(animated: true, completion: nil)
            i.page=nil
        }
        AllDialog.removeAll()
    }
    
    var lockdrawer=false
    var candrag=false
    open var drawer: UIViewController!
    open var rootView: UIView!
    open var AllDialog=[pagemenory]()
    public static var getControlInstance:ControlInstance!
    open var Pagememory=[pagemenory]()
    open var Fraging: UIViewController!
    override open func viewDidLoad() {
        backview.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        JzActivity.getControlInstance=self
        viewInit()
        let pan = UIPanGestureRecognizer(
            target:self,
            action:#selector(swipe(_:)))
        pan.minimumNumberOfTouches = 1
        self.rootView.addGestureRecognizer(pan)
    }
    open func viewInit(){
        
    }
    open func changePageListener(_ controler: pagemenory) {
        print("switch\(controler.tag)")
    }
    @objc func swipe(_ recognizer:UISwipeGestureRecognizer){
        if(drawer == nil||lockdrawer){return}
        let point=recognizer.location(in: self.view)
        if(recognizer.state == .began){
            candrag=point.x<50 || self.drawer.view.frame.maxX>1
        }
        //这个点是滑动的起点
        
        if( point.x<self.view.bounds.width*0.8 && candrag){
            self.drawer.view.frame = CGRect(x: self.drawer.view.bounds.minX + point.x-self.view.bounds.width*0.8, y: 0, width: self.view.bounds.width*0.8, height: self.view.bounds.height)
        }
        if(recognizer.state == .ended && self.drawer.view.frame.maxX<self.view.bounds.width*0.6){
            closeDrawer()
        }else{
            if(recognizer.state == .ended){openDrawer()}
        }
    }
}

public extension String{
    func replace(_ target: String, _ withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
