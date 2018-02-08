//
//  GameScene.swift
//  RunningHero
//
//  Created by 科技部iOS on 2018/1/30.
//  Copyright © 2018年 科技部iOS. All rights reserved.
//
//
//  SKNode的子类列表
//  SKNode大致包含几个大类,如下图表所示.

//  类名称               功能简介
//  SKSpriteNode      用于绘制精灵纹理
//  SKVideoNode       用于播放视频
//  SKLabelNode       用于渲染文本
//  SKShapeNode       用于渲染基于Core Graphics 路径的形状
//  SKEmitterNode     用于创建和渲染粒子系统
//  SKCropNode        用于使用遮罩来裁剪子结点
//  SKEffectNode      用于在子结点上使用Core Image滤镜

import SpriteKit
//import GameplayKit

class GameScene: SKScene ,ProtocolMainScene ,SKPhysicsContactDelegate{

    lazy var ls = LightSylvanus()
    lazy var platformFactory = PlatformFactory()
    lazy var backGround = BackGround()
    lazy var reSetBtn = ReSetBtn()
    //移动速度
    var moreSpeed : CGFloat = 8
    var lastDis :CGFloat = 0.0
    
    
    

    
    
    override func didMove(to view: SKView) {
        
        let skyColor = SKColor.init(red: 113.0/255, green: 197.0/255, blue: 207.0/255, alpha: 1)
        self.backgroundColor = skyColor;
        
        self.addChild(self.backGround)
        
        
        ls.position = MyPoint.newPoint(x: 50, y: 70)
        ls.anchorPoint = CGPoint.zero
        ls.zPosition = 50
        self.addChild(ls)
        
        reSetBtn.position = CGPoint.zero
        reSetBtn.zPosition = 100;
        
        reSetBtn.isHidden = true
        reSetBtn.name = "reSetBtn"
        self.addChild(reSetBtn)
        
        
        self.addChild(platformFactory)
        platformFactory.delegate = self
        platformFactory.sceneWidth = self.frame.size.width
        platformFactory.zPosition = 20
        platformFactory.createPlatform(midNum: 10, x: 0, y: 10)
        
        
        //设置物理碰撞检测代理
        self.physicsWorld.contactDelegate = self;
        //设置重力向下
        self.physicsWorld.gravity = CGVector.init(dx: 0, dy: -20)
        //设置物理碰撞检测范围
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        //设置碰撞后作用力
        self.physicsBody!.isDynamic = false
        // 设置标识
        self.physicsBody?.categoryBitMask = BitMaskType.scence
 
    }
    
     func reSetGame()  {
        ls.position = MyPoint.newPoint(x: 50, y: 70)
        platformFactory.reSet()
        platformFactory.createPlatform(midNum: 10, x: 0, y: 10)
        moreSpeed = 5
        reSetBtn.isHidden = true;
        NotificationCenter.default.post(name: NSNotification.Name.init("reSetGame"), object: nil)
    }
    
    //物理碰撞代理(开始碰撞)
    func didBegin(_ contact: SKPhysicsContact) {
        
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) ==
            (BitMaskType.hero | BitMaskType.scence) {
            //人物掉到场景外了
            print("游戏结束")
            
            reSetBtn.isHidden = false
            self.moreSpeed = 0
        }else if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) ==
            (BitMaskType.hero | BitMaskType.platform) {
            ls.run()
            ls.jumpEnd = ls.position.y
            if ls.jumpEnd - ls.jumpStart <= 70{
                ls.roll()
            }
            
        }else if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) ==
        (BitMaskType.hero | BitMaskType.money){
            if contact.bodyA.categoryBitMask == BitMaskType.money {
                contact.bodyA.node?.isHidden = true
            }else{
                contact.bodyB.node?.isHidden = true
            }
            NotificationCenter.default.post(name: NSNotification.Name.init("money"), object: nil)
        }
    }
    
    //物理碰撞代理(离开碰撞)
    func didEnd(_ contact: SKPhysicsContact) {
        ls.jumpStart = ls.position.y
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.location(in: self)
            if let sp = atPoint(location) as? SKSpriteNode{
                if sp.name == "reSetBtn" {
                    reSetGame()
                }
            }
        }
        ls.jump()
    }
    
    
    
    func onGetData(dist: CGFloat) {
        self.lastDis = dist
//        print("lastDis = \(lastDis)")
    }

    //每一帧 都执行一次
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        backGround.moves(speed: self.moreSpeed)
        lastDis -= moreSpeed
        if lastDis <= 0 {
//            print("生成新的平台")
            platformFactory.createPlatormRandom()
        }
        platformFactory.moves(speed: self.moreSpeed)
    }
}


//协议 平台工厂回传
protocol ProtocolMainScene {
    func onGetData(dist:CGFloat)
    
}
