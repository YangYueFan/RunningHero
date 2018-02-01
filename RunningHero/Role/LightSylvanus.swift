import SpriteKit

enum Status :Int{
    case run = 1,jump,jump2,roll
}

class LightSylvanus: SKSpriteNode {
    
    let runAtlas = SKTextureAtlas.init(named: "run.atlas")
    var runFrames = [SKTexture]()
    
    let jumpAtlas = SKTextureAtlas.init(named: "jump.atlas")
    var jumpFrames = [SKTexture]()
    
    let rollAtlas = SKTextureAtlas.init(named: "roll.atlas")
    var rollFrames = [SKTexture]()
    
    
    var jumpStart : CGFloat = 0.0
    var jumpEnd : CGFloat = 0.0
    
    var status = Status.run
    
    init() {
        let texture = runAtlas.textureNamed("run_1")
        let size = texture.size()
        super.init(texture: texture, color: UIColor.white, size: size)
        
        for index in 0..<runAtlas.textureNames.count {
            let tempName = String.init(format: "run_%d", index+1)
            let runTexture = runAtlas.textureNamed(tempName)
            self.runFrames.append(runTexture)
        }
        
        for index in 0..<jumpAtlas.textureNames.count {
            let tempName = String.init(format: "jump_%d", index+1)
            let runTexture = jumpAtlas.textureNamed(tempName)
            self.jumpFrames.append(runTexture)
        }
        
        for index in 0..<rollAtlas.textureNames.count {
            let tempName = String.init(format: "roll_%d", index+1)
            let runTexture = rollAtlas.textureNamed(tempName)
            self.rollFrames.append(runTexture)
        }
        
        //以人物纹理的大小为物理碰撞体
        self.physicsBody = SKPhysicsBody.init(rectangleOf: texture.size())
        //产生反作用力
        self.physicsBody?.isDynamic = true
        //碰撞后是否产生角度变换
        self.physicsBody?.allowsRotation = false
        //摩擦力
        self.physicsBody?.restitution = 0
        //设置标识
        self.physicsBody?.categoryBitMask = BitMaskType.hero
        //设置与场景产生碰撞
        self.physicsBody?.contactTestBitMask = BitMaskType.scence | BitMaskType.platform | BitMaskType.money
        self.physicsBody?.collisionBitMask = BitMaskType.platform
        
        run()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func run() {
        self.removeAllActions()
        self.status = .run
        self.run(SKAction.repeatForever(SKAction.animate(with: runFrames, timePerFrame: 0.05)))
    }
    
    func jump() {
        self.removeAllActions()
        self.status = .jump
        if self.status != .jump2 {
            self.run(SKAction.animate(with: jumpFrames, timePerFrame: 0.05))
            //向上的速度
            self.physicsBody?.velocity = CGVector.init(dx: 0, dy: 450)
            if self.status == .jump{
                self.status = .jump2
                self.jumpStart = self.position.y
            }else if self.status == .jump2{
                
            }else{
                self.status = .jump
            }
        }
        
        
    }
    
    func roll() {
        self.removeAllActions()
        self.status = .roll
        self.run(SKAction.animate(with: rollFrames, timePerFrame: 0.05)) {
            self.run()
        }
    }
    

}
