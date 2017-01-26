//
//  ViewController.swift
//  PageTheScroll
//
//  Created by Mohammad Hemani on 1/26/17.
//  Copyright © 2017 Mohammad Hemani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [UIImageView]()
    let MAX_PAGE = 2
    let MIN_PAGE = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        var contentWidth: CGFloat = 0.0
        
        //print("Scrollview width: \(scrollView.frame.width)")
        
        let scrollWidth = scrollView.frame.size.width
    
        for x in 0...2 {
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x) //newX = view.frame.midX + view.frame.size.width * CGFloat(x)
            
            contentWidth += newX //scrollWidth * CGFloat(x)
            
            scrollView.addSubview(imageView)
            
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
        }
        self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.14, y: 1.4)
        
        scrollView.clipsToBounds = false
        
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
    }

    @IBAction func detectSwipe(_ sender: UISwipeGestureRecognizer) {
        if currentPage < MAX_PAGE && sender.direction == UISwipeGestureRecognizerDirection.left {
            moveScrollView(direction: 1)
        }
        
        if currentPage > MIN_PAGE && sender.direction == UISwipeGestureRecognizerDirection.right {
            moveScrollView(direction: -1)
        }
    }
    
    func moveScrollView(direction: Int) {
        currentPage = currentPage + direction
        let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
        
        UIView.animate(withDuration: 0.4) {
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            
            for x in 0..<self.images.count {
                if x != self.currentPage {
                    self.images[x].transform = CGAffineTransform.identity
                }
            }
        }
    }
}

