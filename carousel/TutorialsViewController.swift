//
//  TutorialsViewController.swift
//  carousel
//
//  Created by Tony Yeung on 5/30/16.
//  Copyright © 2016 Tony Yeung. All rights reserved.
//

import UIKit

class TutorialsViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: 1280, height: 568)
        scrollView.delegate = self
        button.alpha = 0
        button.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        
        // Get the current page based on the scroll offset
        let page : Int = Int(round(scrollView.contentOffset.x / 320))
        print("current scroll page is ")
        print(page)
        
        if page == 3 {
            pageControl.hidden = true
            self.button.hidden = false
            
            UIView.animateWithDuration(0.3) { () -> Void in
                // Set the alpha properties of the views to fully opaque
                self.button.alpha = 1
            }
        } else {
            pageControl.hidden = false
            self.button.hidden = true
            self.button.alpha = 0
        }
        
        // Set the current page, so the dots will update
        pageControl.currentPage = page


    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
