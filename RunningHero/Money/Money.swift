import SpriteKit


class Money: SKSpriteNode {
    
    let moneyAtlas = SKTextureAtlas.init(named: "money.atlas")
    var moneyFrames = [SKTexture]()
    
    
    func onCreate() {
        let texture = moneyAtlas.textureNamed("money_1")
        let size = texture.size()
        for index in 0..<self.moneyAtlas.textureNames.count {
            let texture = SKTexture.init(imageNamed: String.init(format: "money_%d",index+1))
            moneyFrames.append(texture)
        }
        //以人物纹理的大小为物理碰撞体
        self.physicsBody = SKPhysicsBody.init(rectangleOf: size)
        //产生反作用力
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskType.money
        self.physicsBody?.contactTestBitMask = BitMaskType.hero
        
        self.roll()
    }
    
    func roll()  {
        self.removeAllActions()
        self.run(SKAction.repeatForever(SKAction.animate(with: self.moneyFrames, timePerFrame: 0.05)))
    }
    
}
