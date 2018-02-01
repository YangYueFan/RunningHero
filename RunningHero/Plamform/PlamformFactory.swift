import SpriteKit


class PlatformFactory: SKNode {
    
    let textureLeft = SKTexture(imageNamed:"platform_l")
    let textureMid = SKTexture(imageNamed:"platform_m")
    let textureRight = SKTexture(imageNamed:"platform_r")
    
    var platforms = [Platform]()
    var sceneWidth : CGFloat = 0.0
    var delegate : ProtocolMainScene?
    
    
    func createPlatform(midNum:Int,x:CGFloat,y:CGFloat,isCreateMoney:Int) {
        let platform = Platform()
        let platform_left   = SKSpriteNode(texture:textureLeft)
        platform_left.anchorPoint = CGPoint.zero
        
        
        let platform_right  = SKSpriteNode(texture:textureRight)
        platform_right.anchorPoint = CGPoint.zero
        
        var arrPlatform = [SKSpriteNode]()
        
        arrPlatform.append(platform_left)
        platform.position = MyPoint.newPoint(x: x, y: y)

        
        for _ in 1...midNum {
            let platform_m = SKSpriteNode.init(texture: textureMid)
            platform_m.anchorPoint = CGPoint.zero
            arrPlatform.append(platform_m)
        }
        arrPlatform.append(platform_right)
        platform.onCreate(arrSprite: arrPlatform)
        self.addChild(platform)
        
        if isCreateMoney == 1 {
            let money = Money()
            money.onCreate()
            money.position = CGPoint.init(x: self.frame.width/2, y: self.frame.height+money.frame.height)
            money.anchorPoint = CGPoint.zero
            self.addChild(money)
        }
        
        platforms.append(platform)
        
        //通用公式：平台长度+X坐标 - 主场景的宽度
        let f :CGFloat = platform.width + x - sceneWidth
        delegate?.onGetData(dist: f)
    }
    
    
    func createPlatormRandom() {
        //随机平台长度
        let midNum : Int = Int(arc4random()%4+1)
        //随机间隔
        let gap : CGFloat = CGFloat(arc4random()%8+1)
        //x坐标
        let x : CGFloat = self.sceneWidth + CGFloat(midNum * 50) + gap + 100
        let y : CGFloat = CGFloat(arc4random()%200+70)
        
        let isCreateMoney = Int(arc4random()%2)
        
        createPlatform(midNum: midNum, x: x, y: y ,isCreateMoney: isCreateMoney)
        
    }
    
    func moves(speed:CGFloat) {
        for p in platforms {
            p.position.x -= speed
        }
        
    }
}
