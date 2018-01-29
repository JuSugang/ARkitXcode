//
//  ViewController.swift
//  positionObject
//
//  Created by sugang on 2018. 1. 29..
//  Copyright © 2018년 sugang. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addCube(_ sender: Any) {
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.02))
//        cubeNode.position = SCNVector3(0, 0 ,-0.2)
        let cc = getCameraCoordinates(sceneView: sceneView)
        cubeNode.position = SCNVector3(cc.x,cc.y,cc.z)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
        
    }
    struct myCameraCoordinates{
        var x = Float()
        var y = Float()
        var z = Float()
    }
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates{
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinates()
        cc.x=cameraCoordinates.translation.x
        cc.y=cameraCoordinates.translation.y
        cc.z=cameraCoordinates.translation.z
        
        return cc
    }
    @IBAction func addCup(_ sender: Any) {
        let cupNode = SCNNode()
        let cc = getCameraCoordinates(sceneView: sceneView)
        cupNode.position = SCNVector3(cc.x,cc.y,cc.z)
        
        guard let virtualObjectScene = SCNScene(named: "cup.scn", inDirectory: "Models.scnassets/cup") else{
            return
        }
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes{
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        cupNode.addChildNode(wrapperNode)
        sceneView.scene.rootNode.addChildNode(cupNode)
    }
    
}

