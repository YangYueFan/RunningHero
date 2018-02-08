import SpriteKit


class Money: SKSpriteNode {
    
    var node : SKSpriteNode?
    let moneyAtlas = SKTextureAtlas.init(named: "money.atlas")
    var moneyFrames = [SKTexture]()
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: UIColor.white, size: size)
        self.onCreate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func onCreate() {
        let texture = moneyAtlas.textureNamed("money_1")
        node = SKSpriteNode.init(texture: texture)
        let size = texture.size()
        for index in 0..<self.moneyAtlas.textureNames.count {
            let subTexture = moneyAtlas.textureNamed(String.init(format: "money_%d",index+1))
            self.moneyFrames.append(subTexture)
        }
        //以物体纹理的大小为物理碰撞体
        self.physicsBody = SKPhysicsBody.init(rectangleOf: size)
        //产生反作用力
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = BitMaskType.money
        self.physicsBody?.contactTestBitMask = BitMaskType.hero
        self.addChild(node!)
        
        
    }
    
    func roll()  {
        self.removeAllActions()
        node!.run(SKAction.repeatForever(SKAction.animate(with: moneyFrames, timePerFrame: 0.05)))
        
        print("旋转")
    }
    
}
