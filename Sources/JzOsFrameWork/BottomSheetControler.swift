//
//  BottomSheetControler.swift
//  JzIos_Framework
//
//  Created by Jianzhi.wang on 2020/5/12.
//  Copyright © 2020 王建智. All rights reserved.
//

import UIKit

class BottomSheetControler: UIViewController {
    var tableView: UITableView? = nil
    let fullView: CGFloat = 0
    var controler:UIViewController! = nil
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    func listallView(_ inview:[UIView])->[UIView]{
        var views=[UIView]()
        for view in inview {
            views.append(view)
            if(view.subviews.count>0){
               views.append(contentsOf: listallView(view.subviews))
            }
        }
      return views
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for i in listallView(self.view.subviews){
                   print(i)
                   if(i is UITableView){
                    self.tableView=(i as! UITableView)
                   }
               }
               
               if(tableView != nil){
                   tableView!.bounces=false
               }
               let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetControler.panGesture))
               gesture.delegate = self
               view.addGestureRecognizer(gesture)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.fullView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height )
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: { [weak self] _ in
                if ( velocity.y < 0 ) {
                    if(self?.tableView != nil){
                        self?.tableView!.isScrollEnabled = true
                    }
                }
            })
        }
    }
    
    func open(){
        
    }
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        view.insertSubview(bluredView, at: 0)
    }
    
}



extension BottomSheetControler: UIGestureRecognizerDelegate {
    
    // Solution
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        
        let y = view.frame.minY
        if(tableView != nil){
            if (y == fullView && tableView!.contentOffset.y == 0 && direction > 0) || (y == partialView) {
                tableView!.isScrollEnabled = false
            } else {
                tableView!.isScrollEnabled = true
            }
        }
        return false
    }
}
