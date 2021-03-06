//
//  ViewController.swift
//  SlideshowApp
//
//  Created by macpc on 2016/07/15.
//  Copyright © 2016年 h.ohara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // data
    var id:Int = 1
    let images = [1:"patents-796x473.jpg", 2:"valve-gambling-websites-796x448.jpg", 3:"TNW-Digital-SLR-Photography-for-Dummies-796x398.jpg"]
    
    // play
    var isPlay:Bool = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var forward: UIButton!
    @IBOutlet weak var backward: UIButton!
    @IBOutlet weak var play: UIButton!
    
    @IBAction func forward(sender: AnyObject) {
        id += 1
        if id>3 { id = 1 }
        flashImageView()
    }
    @IBAction func backward(sender: AnyObject) {
        id -= 1
        if id<1 { id = 3 }
        flashImageView()
    }
    @IBAction func play(sender: AnyObject) {
        if isPlay == true {
            isPlay = false
            stopTimer()
        }
        else {
            isPlay = true
            startTimer()
        }
    }
    
    var timer: NSTimer = NSTimer()
    private func startTimer() {
        
        stoppedButton(forward)
        stoppedButton(backward)
        play.setTitle("停止", forState: .Normal)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.forward(_:)), userInfo: nil, repeats: true)
    }
    private func stopTimer() {

        defaultButton(forward)
        defaultButton(backward)
        play.setTitle("再生", forState: .Normal)

        timer.invalidate()
    }
    
    func defaultButton(btn:UIButton) {
        btn.enabled = true // 使用可能
    }
    func stoppedButton(btn:UIButton) {
        btn.enabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        flashImageView()
        
        self.imageView.userInteractionEnabled = true
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ViewController.imageTap))
        self.imageView.addGestureRecognizer(tapGesture)
        
    }
    func imageTap() {
        print("imageTap")
        performSegueWithIdentifier("toDetail", sender: nil)
    }
    
    private func flashImageView() {
        let currentImage = UIImage(named: images[id]!)
        imageView.image = currentImage
        
        print(id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toDetail") {
            let detailView: DetailViewController = (segue.destinationViewController as? DetailViewController)!
            detailView.selectedImage = imageView.image
            
            stopTimer()
        }
    }

}

