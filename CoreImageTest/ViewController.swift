//
//  ViewController.swift
//  CoreImageTest
//
//  Created by David Garcia on 4/2/19.
//  Copyright © 2019 David Garcia. All rights reserved.
//

import Cocoa
import CoreImage

class ViewController: NSViewController {
    @IBOutlet weak var imgView: NSImageView!
    let img = #imageLiteral(resourceName: "vinyltocat.png")
    let context = CIContext()
    override func viewDidLoad() {
        super.viewDidLoad()
        var callback: CIKernelROICallback
        callback = {(num: Int32, rect: CGRect) -> CGRect in
            debugPrint("rect = \(rect)")
            return rect
        }
        guard
            let url = Bundle.main.url(forResource: "default", withExtension: "metallib"),
            let shader = try? Data(contentsOf: url),
            let kernel = try? CIKernel(functionName: "test", fromMetalLibraryData: shader),
            let ciImg = CIImage(contentsOf: Bundle.main.urlForImageResource(img.name()!)!),
            let appliedFilter = kernel.apply(extent: ciImg.extent, roiCallback: callback, arguments: [ciImg]) else {
            return
        }
        

        imgView.image = NSImage(cgImage: context.createCGImage(appliedFilter, from: CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height))!, size: NSSize(width: img.size.width, height: img.size.height))
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

