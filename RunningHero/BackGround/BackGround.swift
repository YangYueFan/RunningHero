import SpriteKit

class BackGround: SKNode {
    
    
    var arrMountain = [SKSpriteNode]()
    var arrBg = [SKSpriteNode]()
//    var bgViewWidth : CGFloat = 0.0
    
    
    override init() {
        super.init()
        
        
        let farTexture = SKTexture.init(imageNamed: "bg_tree")
//        let size = farTexture.size();
        let farBg0 = SKSpriteNode.init(texture: farTexture)
//        bgViewWidth = (size.width * UIScreen.main.bounds.size.height)/size.height
//        farBg0.size = CGSize.init(width: bgViewWidth, height: UIScreen.main.bounds.size.height)
        farBg0.anchorPoint = CGPoint.zero
        farBg0.position = MyPoint.newPoint(x: 0, y: 70)
        farBg0.zPosition = 15
        
        let farBg1 = SKSpriteNode.init(texture: farTexture)
        farBg1.anchorPoint = CGPoint.zero
        farBg1.position = MyPoint.newPoint(x: farBg0.size.width, y: 70)
        farBg1.zPosition = 15
//        farBg1.size = CGSize.init(width: bgViewWidth, height: UIScreen.main.bounds.size.height)
        
        let farBg2 = SKSpriteNode.init(texture: farTexture)
        farBg2.anchorPoint = CGPoint.zero
        farBg2.position = MyPoint.newPoint(x: farBg0.size.width*2, y: 70)
        farBg2.zPosition = 15
//        farBg2.size = CGSize.init(width:bgViewWidth, height: UIScreen.main.bounds.size.height)
        
        self.addChild(farBg0)
        self.addChild(farBg1)
        self.addChild(farBg2)
        arrMountain.append(farBg0)
        arrMountain.append(farBg1)
        arrMountain.append(farBg2)
        
        let texture = SKTexture.init(imageNamed: "bg_mountain")
        let  tree0 = SKSpriteNode.init(texture: texture)
        tree0.anchorPoint = CGPoint.zero
        tree0.position = MyPoint.newPoint(x: 0, y: 0)
        tree0.zPosition = 16
        let  tree1 = SKSpriteNode.init(texture: texture)
        tree1.anchorPoint = CGPoint.zero
        tree1.position = MyPoint.newPoint(x: tree0.frame.width, y: 0)
        tree1.zPosition = 16
        self.addChild(tree0)
        self.addChild(tree1)
        arrBg.append(tree0)
        arrBg.append(tree1)
    }
    
    func moves(speed:CGFloat) {
        for bg in arrBg {
            bg.position.x -= speed
        }

        if  arrBg[0].position.x + arrBg[0].size.width < speed - UIScreen.main.bounds.size.width/2{
            arrBg[0].position.x = MyPoint.newX(x: 0)
            arrBg[1].position.x = MyPoint.newX(x: arrBg[0].frame.width)
        }
        
        for bg in arrMountain {
            bg.position.x -= speed/4
        }
        
        if  arrMountain[0].position.x + arrMountain[0].size.width < speed/4 - UIScreen.main.bounds.size.width/2{
            arrMountain[0].position.x = MyPoint.newX(x: 0)
            arrMountain[1].position.x = MyPoint.newX(x: arrMountain[0].size.width)
            arrMountain[2].position.x = MyPoint.newX(x: arrMountain[0].size.width*2)
//            arrMountain = [arrMountain[1],arrMountain[2],arrMountain[0]]
        }
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
