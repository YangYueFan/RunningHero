//
//  ReSetBtn.swift
//  RunningHero
//
//  Created by 科技部iOS on 2018/2/8.
//  Copyright © 2018年 科技部iOS. All rights reserved.
//
import SpriteKit


class ReSetBtn: SKSpriteNode {
    
    init() {
        let texture = SKTexture.init(image: UIImage.init(named: "GameOver")!)
        let size = texture.size()
        super.init(texture: texture, color: UIColor.white, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
