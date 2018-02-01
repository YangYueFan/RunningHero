import SpriteKit

class Platform :SKNode {
    var width : CGFloat = 0.0
    var height : CGFloat = 10.0
    
    func onCreate(arrSprite:[SKSpriteNode]) {
        for platform in arrSprite {
            platform.position.x = self.width
                //- UIScreen.main.bounds.size.width/2.0
            self.addChild(platform)
            self.width += platform.size.width
        }
        
        self.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize.init(width: self.width, height: self.height), center: CGPoint.init(x: self.width/2, y: 0))
        self.physicsBody?.categoryBitMask = BitMaskType.platform
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
    }
    
    
}


//坐标系转换
class MyPoint: NSObject {
    
    static func newPoint(x:CGFloat,y:CGFloat) -> CGPoint {
        let x_p = -UIScreen.main.bounds.size.width/2.0
        let y_p = -UIScreen.main.bounds.size.height/2.0
        //左下角 为新原点
        
        return CGPoint.init(x: x_p+x, y: y_p+y)
    }
    
    static func newX(x:CGFloat) -> CGFloat {
        let x_p = -UIScreen.main.bounds.size.width/2.0
        return x_p+x;
    }
    static func newY(x:CGFloat) -> CGFloat {
        let y_p = -UIScreen.main.bounds.size.width/2.0
        return y_p+x;
    }
}
