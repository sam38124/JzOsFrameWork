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
        addChild(newViewController)
        self.rootView.addSubview(newViewController.view)
        newViewController.view.frame = rootView.bounds
        newViewController.didMove(toParent: self)
        self.Fraging = newViewController
        if(goback){
            let a=pagemenory()
            a.page=newViewController
            a.tag=tag
            Pagememory.append(a)
            changePageListener(a)
        }
    }
    
   public func changeFrage(_ original: UIView,_ newViewController: UIViewController)
    {
        addChild(newViewController)
        original.addSubview(newViewController.view)
        newViewController.view.frame = original.bounds
        newViewController.didMove(toParent: self)
    }
    
   public func getPro(_ name: String) -> String {
        let preferences = UserDefaults.standard
        let currentLevelKey = name
        if preferences.object(forKey: currentLevelKey) == nil {
            return "nodata"
        } else {
            let currentLevel = preferences.string(forKey: currentLevelKey)!
            return currentLevel
        }
    }
    
   public func setPro(_ name: String, _ key: String) {
        let preferences = UserDefaults.standard
        preferences.set(name,forKey: key)
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
   public func openDiaLog(_ newViewController: UIViewController) {
        addChild(newViewController)
        self.view.addSubview(newViewController.view)
        newViewController.view.frame = self.view.bounds
        newViewController.didMove(toParent: self)
        Swipage=newViewController
    }
    
   public func closeDialLog() {
        Swipage!.willMove(toParent: nil)
        Swipage!.view.removeFromSuperview()
        Swipage!.removeFromParent()
        Swipage!.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    var Swipage:UIViewController? = nil
    public static var getControlInstance:ControlInstance!
    open var Pagememory=[pagemenory]()
    open var Fraging: UIViewController!
    open var rootView: UIView!
    override open func viewDidLoad() {
        super.viewDidLoad()
        JzActivity.getControlInstance=self
        viewInit()
    }
    open func viewInit(){
        
    }
    open func changePageListener(_ controler: pagemenory) {
        print("switch\(controler.tag)")
    }
}

public extension String{
      public func replace(_ target: String, _ withString: String) -> String
      {
          return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
      }
  }
