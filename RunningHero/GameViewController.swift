//
//  GameViewController.swift
//  RunningHero
//
//  Created by 科技部iOS on 2018/1/30.
//  Copyright © 2018年 科技部iOS. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var moneyNum: UILabel!
    var money = 0
    
    @IBOutlet weak var stateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addMoney), name: NSNotification.Name.init("money"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reSetMoney), name: NSNotification.Name.init("reSetGame"), object: nil)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    @objc func addMoney() {
        self.money += 1;
        self.moneyNum.text = "\(self.money)";
    }
    
    @objc func reSetMoney() {
        self.money = 0;
        self.moneyNum.text = "\(self.money)";
    }

    

    
    
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
