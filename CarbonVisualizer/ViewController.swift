/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import SceneKit

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}

class ViewController: UIViewController {
    // MARK: Properties

    @IBOutlet weak var NameButton: UIButton!
    
    // UI
    @IBOutlet weak var geometryLabel: UILabel!
    @IBOutlet weak var sceneView: SCNView!
    
    
    let cameraNode = SCNNode()
    var counter = 0
    var timer = NSTimer()
    
    @IBOutlet weak var label: UILabel!
    
    // start timer
    @IBAction func startTimerButtonTapped(sender: UIButton) {
        timer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector(ButtonPressed(NameButton)), userInfo: nil, repeats: true)
        
    }
    
    // stop timer
    @IBAction func cancelTimerButtonTapped(sender: UIButton) {
        timer.invalidate()
    }
    
    func rotateByXForever(x:CGFloat, y:CGFloat, z:CGFloat, duration:NSTimeInterval) -> SCNAction {
        let rotate = SCNAction.rotateByX(x, y: y, z: z, duration: duration)
        return SCNAction.repeatActionForever(rotate)
    }

    
    // called every time interval from the timer
    @IBAction func ButtonPressed(sender: AnyObject) {
        NameButton.setTitle("Play", forState: UIControlState.Normal)
        sceneView.rotate360Degrees(2.0, completionDelegate: self)
        //sceneView.transform = rotateByXForever(0, y: 5, z: 0, duration: 2)
    }
    
    // Geometry
    var geometryNode: SCNNode = SCNNode()
    
    // Gestures
    var currentAngle: Float = 0.0
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
                sceneSetup()
        geometryNode = allPyra()
        sceneView.scene!.rootNode.addChildNode(geometryNode)
    }
    
    // MARK: Scene
    func sceneSetup() {
        // 1
        let scene = SCNScene()
        
        
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 30)
        cameraNode.rotation = SCNVector4Make(0, 0, 1, CFloat( -M_PI_4 ) * 2 )
        scene.rootNode.addChildNode(cameraNode)
        //self.view.userInteractionEnabled = false

        
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        sceneView.addGestureRecognizer(panRecognizer)
        
        // 3
        sceneView.scene = scene
        
        sceneView.allowsCameraControl = true
        
    }
    
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view!)
        var newAngle = (Float)(translation.x)*(Float)(M_PI)/180.0
        newAngle += currentAngle
        
        geometryNode.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
        
        if(sender.state == UIGestureRecognizerState.Ended) {
            currentAngle = newAngle
        }
    }
    
    // MARK: IBActions
    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        // 1
        geometryNode.removeFromParentNode()
        currentAngle = 0.0

            geometryNode = allPyra()
        
        // 3
        sceneView.scene!.rootNode.addChildNode(geometryNode)
    }
    
    // MARK: Style
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: Transition
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        sceneView.stop(nil)
        sceneView.play(nil)
    }
     func Cylinder() -> SCNGeometry {
        // 1
        let Cylinder = SCNCylinder(radius: 2.5, height: 5.0)
        
        // 2
        Cylinder.firstMaterial!.diffuse.contents = UIColor.darkGrayColor()
        
        // 3
        Cylinder.firstMaterial!.specular.contents = UIColor.whiteColor()
        
        // 4
        return Cylinder
    }
     func Cylinder2() -> SCNGeometry {
        // 1
        let Cylinder2 = SCNCylinder(radius: 2.5, height: 5.0)
        
        // 2
        Cylinder2.firstMaterial!.diffuse.contents = UIColor.brownColor()
        
        // 3
        Cylinder2.firstMaterial!.specular.contents = UIColor.whiteColor()
        
        // 4
        return Cylinder2
    }
    func Cylinder3() -> SCNGeometry {
        // 1
        let Cylinder3 = SCNCylinder(radius: 2.5, height: 5.0)
        
        // 2
        Cylinder3.firstMaterial!.diffuse.contents = UIColor.blackColor()
        
        // 3
        Cylinder3.firstMaterial!.specular.contents = UIColor.whiteColor()
        
        // 4
        return Cylinder3
    }
    func allPyra() -> SCNNode {
        
        let PyraNode = SCNNode()
        
        let PyramidNode = SCNNode(geometry: Cylinder())
        PyramidNode.position = SCNVector3Make(0, -5, 0)
        PyraNode.addChildNode(PyramidNode)
        
        // Add texture 1
        PyramidNode.geometry?.firstMaterial!.diffuse.contents="/Users/perrirazje/Downloads/Swift.png"
        
        let Pyramid2Node = SCNNode(geometry: Cylinder2())
        Pyramid2Node.position = SCNVector3Make(0, 0, 0)
        PyraNode.addChildNode(Pyramid2Node)
        
        // Add texture 2
        Pyramid2Node.geometry?.firstMaterial!.diffuse.contents="/Users/perrirazje/Downloads/Swift2.png"
        
        let Pyramid3Node = SCNNode(geometry: Cylinder3())
        Pyramid3Node.position = SCNVector3Make(0, 5, 0)
        PyraNode.addChildNode(Pyramid3Node)
        
        // Add texture 3
        Pyramid3Node.geometry?.firstMaterial!.diffuse.contents="/Users/perrirazje/Downloads/Swift3.png"
        
        return PyraNode
    }
}
