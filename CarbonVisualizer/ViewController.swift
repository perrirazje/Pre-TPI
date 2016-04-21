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
    @IBOutlet weak var View1: SCNView!
    @IBOutlet weak var View2: SCNView!
    @IBOutlet weak var View3: SCNView!
    
    let cameraNode = SCNNode()
    var counter = 0
    var timer = NSTimer()
    let spin = CABasicAnimation(keyPath: "rotation")
            let PyraNode1 = SCNNode()
            let PyraNode2 = SCNNode()
                    let PyraNode3 = SCNNode()
    
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
        
        let Random1 = arc4random_uniform(4) + 1;
        let Random2 = arc4random_uniform(4) + 1;
        let Random3 = arc4random_uniform(4) + 1;
        
        var StringRandom = "\(Random3)\(Random1)\(Random2)"
        
        let RandomDone1 : Double = Double(Random1)
        let RandomDone2 : Double = Double(Random2)
        let RandomDone3 : Double = Double(Random3)
        
        // Use from-to to explicitly make a full rotation around z
        spin.fromValue = NSValue(SCNVector4: SCNVector4(x: 0, y: 1, z: 0, w: 0))
        spin.toValue = NSValue(SCNVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float(2 * M_PI)))
        spin.duration = RandomDone1
        PyraNode1.addAnimation(spin, forKey: "spin around")
        
        // Use from-to to explicitly make a full rotation around z
        spin.fromValue = NSValue(SCNVector4: SCNVector4(x: 0, y: 1, z: 0, w: 0))
        spin.toValue = NSValue(SCNVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float(2 * M_PI)))
        spin.duration = RandomDone2
        PyraNode2.addAnimation(spin, forKey: "spin around")
        
        // Use from-to to explicitly make a full rotation around z
        spin.fromValue = NSValue(SCNVector4: SCNVector4(x: 0, y: 1, z: 0, w: 0))
        spin.toValue = NSValue(SCNVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float(2 * M_PI)))
        spin.duration = RandomDone3
        PyraNode3.addAnimation(spin, forKey: "spin around")
        
        NameButton.setTitle(StringRandom, forState: UIControlState.Normal)
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
                sceneSetup1()
        geometryNode = allPyra1()
        View1.scene!.rootNode.addChildNode(geometryNode)
        sceneSetup2()
        geometryNode = allPyra2()
        View2.scene!.rootNode.addChildNode(geometryNode)
        sceneSetup3()
        geometryNode = allPyra3()
        View3.scene!.rootNode.addChildNode(geometryNode)
            }
    
    // MARK: Scene
    func sceneSetup1() {
        // 1
        let scene = SCNScene()
        
        
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 30)
        cameraNode.rotation = SCNVector4Make(0, 0, 1, CFloat( -M_PI_4 ) * 2 )
        cameraNode.eulerAngles.x = Float(-M_PI)
        cameraNode.eulerAngles.y = Float(-2 * -M_PI)
        scene.rootNode.addChildNode(cameraNode)
        //self.view.userInteractionEnabled = false

        
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        View1.addGestureRecognizer(panRecognizer)
        
        // 3
        View1.scene = scene
        
        View1.allowsCameraControl = true
        
    }
    // MARK: Scene
    func sceneSetup2() {
        // 1
        let scene = SCNScene()
        
        
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 30)
        cameraNode.rotation = SCNVector4Make(0, 0, 1, CFloat( -M_PI_4 ) * 2 )
        scene.rootNode.addChildNode(cameraNode)
        //self.view.userInteractionEnabled = false
        
        
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        View2.addGestureRecognizer(panRecognizer)
        
        // 3
        View2.scene = scene
        
        View2.allowsCameraControl = true
        
    }
    // MARK: Scene
    func sceneSetup3() {
        // 1
        let scene = SCNScene()
        
        
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 30)
        cameraNode.rotation = SCNVector4Make(0, 0, 1, CFloat( -M_PI_4 ) * 2 )
        scene.rootNode.addChildNode(cameraNode)
        //self.view.userInteractionEnabled = false
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        View3.addGestureRecognizer(panRecognizer)
        
        // 3
        View3.scene = scene
        
        View3.allowsCameraControl = true
        
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

            geometryNode = allPyra1()
        geometryNode = allPyra3()
        geometryNode = allPyra2()
        
        // 3
        sceneView.scene!.rootNode.addChildNode(geometryNode)
        View2.scene!.rootNode.addChildNode(geometryNode)
        View3.scene!.rootNode.addChildNode(geometryNode)
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
    func allPyra1() -> SCNNode {
        
        let PyramidNode = SCNNode(geometry: Cylinder())
        PyramidNode.position = SCNVector3Make(0, 0, 0)
        


        
        
        PyraNode1.addChildNode(PyramidNode)
        
        // Add texture 1
        PyramidNode.geometry?.firstMaterial!.diffuse.contents="/Users/perrirazje/Downloads/Swift.png"

        
        return PyraNode1
    }
    func allPyra2() -> SCNNode {
        

        
        let PyramidNode = SCNNode(geometry: Cylinder2())
        PyramidNode.position = SCNVector3Make(0, 4, 0)
        
        PyraNode2.addChildNode(PyramidNode)
        
        // Add texture 1
        PyramidNode.geometry?.firstMaterial!.diffuse.contents="/Users/perrirazje/Downloads/Swift.png"
        
        
        return PyraNode2
    }
    func allPyra3() -> SCNNode {
        
        let PyramidNode = SCNNode(geometry: Cylinder3())
        PyramidNode.position = SCNVector3Make(0, -4, 0)
        
        PyraNode3.addChildNode(PyramidNode)
        
        // Add texture 1
        PyramidNode.geometry?.firstMaterial!.diffuse.contents="/Users/perrirazje/Downloads/Swift.png"
        
        
        return PyraNode3
    }
}
