import SwiftUI
import SpriteKit

class PlaneRocketsGameScene: SKScene, SKPhysicsContactDelegate {
    
    var time: Int {
        didSet {
            timeLabel.text = formatTime(from: time)
            if time == 0 {
                NotificationCenter.default.post(name: .pubTimeOver, object: nil)
                rocketBossSpawner.invalidate()
                rocketNormalSpawner.invalidate()
                gameTimer.invalidate()
            }
        }
    }
    
    func restartGame(time: Int) -> PlaneRocketsGameScene {
        let gameScene = PlaneRocketsGameScene(time: time)
        view?.presentScene(gameScene)
        return gameScene
    }
    
    func formatTime(from seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        if seconds < 3600 {
            return formatter.string(from: TimeInterval(seconds)) ?? "00:00"
        } else {
            formatter.allowedUnits = [.hour, .minute, .second]
            return formatter.string(from: TimeInterval(seconds)) ?? "00:00"
        }
    }
    
    private let selectedPlane = UserDefaults.standard.string(forKey: "selected_plane") ?? "a101_plane"
    
    private var planeTexture: SKTexture!
    private var plane: SKSpriteNode!
    
    private var moverTexture: SKTexture!
    private var mover: SKSpriteNode!
    
    private var timeLabel: SKLabelNode = SKLabelNode(text: "00:00")
    
    private var creditsLabel: SKLabelNode = SKLabelNode(text: "\(UserDefaults.standard.integer(forKey: "credits"))")
    
    init(time: Int) {
        self.time = time
        super.init(size: CGSize(width: 750, height: 1335))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var rocketNormalSpawner: Timer = Timer()
    private var rocketBossSpawner: Timer = Timer()
    private var gameTimer: Timer = Timer()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        createUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.spawnNormalRocketWithObstacle()
        }
        
        rocketNormalSpawner = .scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
            self.spawnNormalRocketWithObstacle()
        })
        rocketBossSpawner = .scheduledTimer(withTimeInterval: 30, repeats: true, block: { _ in
            self.spawnBossRocketWithObstacle()
        })
        
        gameTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.time -= 1
        })
    }
    
    private var normalRocketSpawnZone = 200..<500
    
    private func spawnNormalRocketWithObstacle() {
        let rocketNode: SKSpriteNode = .init(imageNamed: "rocket_normal")
        let rocketNodeXPos = CGFloat.random(in: 200..<500)
        rocketNode.position = CGPoint(x: rocketNodeXPos, y: size.height)
        rocketNode.physicsBody = SKPhysicsBody(rectangleOf: rocketNode.size)
        rocketNode.physicsBody?.isDynamic = true
        rocketNode.physicsBody?.affectedByGravity = false
        rocketNode.physicsBody?.categoryBitMask = 2
        rocketNode.physicsBody?.collisionBitMask = 1
        rocketNode.physicsBody?.contactTestBitMask = 1
        addChild(rocketNode)
        
        let obstacle = SKSpriteNode(imageNamed: "obstacle")
        let position: ObstaclePos = [.left, .right, .left].randomElement() ?? .left
        if position == .left {
            obstacle.position = CGPoint(x: rocketNodeXPos - rocketNode.size.width - 100, y: size.height)
            obstacle.size = CGSize(width: rocketNodeXPos - rocketNode.size.width, height: 15)
        } else {
            obstacle.position = CGPoint(x: rocketNodeXPos + (size.width - rocketNodeXPos), y: size.height)
            obstacle.size = CGSize(width: obstacle.size.width, height: 15)
        }
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.isDynamic = true
        obstacle.physicsBody?.affectedByGravity = false
        obstacle.physicsBody?.categoryBitMask = 3
        obstacle.physicsBody?.collisionBitMask = 1
        obstacle.physicsBody?.contactTestBitMask = 1
        addChild(obstacle)
        
        let actionDown = SKAction.move(to: CGPoint(x: rocketNodeXPos, y: -100), duration: 5)
        let actionDownObstacle = SKAction.move(to: CGPoint(x: obstacle.position.x, y: -100), duration: 5)
        rocketNode.run(actionDown) {
            rocketNode.removeFromParent()
        }
        obstacle.run(actionDownObstacle) {
            obstacle.removeFromParent()
        }
    }
    
    private func spawnBossRocketWithObstacle() {
        let rocketNode: SKSpriteNode = .init(imageNamed: "rocket_boss")
        rocketNode.size = CGSize(width: rocketNode.size.width / 1.7, height: rocketNode.size.height / 1.7)
        let rocketNodeXPos = CGFloat.random(in: 200..<500)
        rocketNode.position = CGPoint(x: rocketNodeXPos, y: size.height)
        rocketNode.physicsBody = SKPhysicsBody(rectangleOf: rocketNode.size)
        rocketNode.physicsBody?.isDynamic = true
        rocketNode.physicsBody?.affectedByGravity = false
        rocketNode.physicsBody?.categoryBitMask = 4
        rocketNode.physicsBody?.collisionBitMask = 1
        rocketNode.physicsBody?.contactTestBitMask = 1
        addChild(rocketNode)
        
        let actionDown = SKAction.move(to: CGPoint(x: rocketNodeXPos, y: -100), duration: 5)
        rocketNode.run(actionDown) {
            rocketNode.removeFromParent()
        }
    }
    
    private func createUI() {
        createBackgroundTexture()
        createPlane()
        createHeaderData()
    }
    
    private func createHeaderData() {
        let timeBackground = SKSpriteNode(imageNamed: "balance_background")
        timeBackground.position = CGPoint(x: 150, y: size.height - 110)
        timeBackground.size = CGSize(width: 200, height: 70)
        addChild(timeBackground)
        
        timeLabel.position = CGPoint(x: 150, y: size.height - 120)
        timeLabel.fontName = "PassionOne-Regular"
        timeLabel.fontSize = 42
        timeLabel.fontColor = UIColor.init(red: 36/255, green: 86/255, blue: 171/255, alpha: 1)
        addChild(timeLabel)
        
        let creditsBackground = SKSpriteNode(imageNamed: "balance_background")
        creditsBackground.position = CGPoint(x: 550, y: size.height - 110)
        creditsBackground.size = CGSize(width: 250, height: 70)
        addChild(creditsBackground)
        
        creditsLabel.position = CGPoint(x: 550, y: size.height - 120)
        creditsLabel.fontName = "PassionOne-Regular"
        creditsLabel.fontSize = 42
        creditsLabel.fontColor = UIColor.init(red: 36/255, green: 86/255, blue: 171/255, alpha: 1)
        addChild(creditsLabel)
    }
    
    private func createBackgroundTexture() {
        let texture = SKTexture(imageNamed: "plane_rockets_game_background")
        let background: SKSpriteNode = .init(texture: texture)
        background.size = size
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
    }
    
    private func createPlane() {
        planeTexture = .init(imageNamed: selectedPlane)
        plane = .init(texture: planeTexture)
        plane.position = CGPoint(x: size.width / 2, y: 250)
        plane.name = "plane"
        plane.physicsBody = SKPhysicsBody(rectangleOf: plane.size)
        plane.physicsBody?.isDynamic = false
        plane.physicsBody?.affectedByGravity = false
        plane.physicsBody?.categoryBitMask = 1
        plane.physicsBody?.collisionBitMask = 2 | 3 | 4
        plane.physicsBody?.contactTestBitMask = 2 | 3 | 4 // 2 - rocket normal, 3 - obstacle, 4 - boss rocket
        addChild(plane)
        createPlaneMoveUI()
    }
    
    private func createPlaneMoveUI() {
        let moverArrow: SKSpriteNode = .init(imageNamed: "mover_arrow")
        moverArrow.position = CGPoint(x: size.width / 2, y: 75)
        moverArrow.size = CGSize(width: size.width - 100, height: 70)
        addChild(moverArrow)
        
        moverTexture = .init(imageNamed: "mover")
        mover = .init(texture: moverTexture)
        mover.position = CGPoint(x: size.width / 2, y: 75)
        mover.size = CGSize(width: 75, height: 70)
        mover.name = "mover"
        addChild(mover)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let atPointObject = atPoint(location)
            
            if atPointObject.name == "mover" {
                if location.x > 50 && location.x < size.width - 70 {
                    mover.position.x = location.x
                    plane.position.x = location.x
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == 1 && (bodyB.categoryBitMask == 2 || bodyB.categoryBitMask == 3 || bodyB.categoryBitMask == 4) {
            bodyA.node?.removeFromParent()
            bodyB.node?.removeFromParent()
            
            NotificationCenter.default.post(name: .pubLoseGame, object: nil)
            rocketBossSpawner.invalidate()
            rocketNormalSpawner.invalidate()
            gameTimer.invalidate()
        }
    }
    
}

extension Notification.Name {
    static let pubTimeOver = Notification.Name(.timeOver)
    static let pubLoseGame = Notification.Name(.loseGame)
    static let pubRestartGame = Notification.Name(.restartGame)
    static let pubGoToHome = Notification.Name(.goToHome)
}

extension String {
    static let timeOver = "time_over"
    static let loseGame = "lose_game"
    static let restartGame = "restart_game"
    static let goToHome = "go_to_home"
}

enum ObstaclePos {
    case left, right
}

#Preview {
    VStack {
        SpriteView(scene: PlaneRocketsGameScene(time: 120))
            .ignoresSafeArea()
    }
}
