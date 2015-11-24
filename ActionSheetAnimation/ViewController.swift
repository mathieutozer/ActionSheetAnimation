//
//  ViewController.swift
//  ActionSheetAnimation
//
//  Created by Mathieu Tozer on 11/23/15.
//

import UIKit

class ViewController: UIViewController {
  
  var sheet: UIView
  var sheetVisible: Bool
  
  var duration: NSTimeInterval
  var springDamping: CGFloat
  var initialSpringVelocity: CGFloat
  let sheetHeight = 400.0 as CGFloat;

  @IBOutlet var durationSlider: UISlider?
  @IBOutlet var springDampingSlider: UISlider?
  @IBOutlet var initialSpringVelocitySlider: UISlider?
  
  @IBOutlet var durationLabel: UILabel?
  @IBOutlet var dampingLabel: UILabel?
  @IBOutlet var velocityLabel: UILabel?

  override func viewDidLoad() {
    super.viewDidLoad()
    sheet.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "sheetTapped:"))
    sheet.backgroundColor = UIColor.grayColor()
    view.addSubview(sheet)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    self.sheet = UIView(frame: CGRect.zero)
    self.sheetVisible = false
    self.duration = 0.3;
    self.springDamping = 1;
    self.initialSpringVelocity = 0;
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    self.sheet = UIView(frame: CGRect.zero)
    self.sheetVisible = false
    self.duration = 0.3;
    self.springDamping = 1;
    self.initialSpringVelocity = 0;

    super.init(coder: aDecoder)
  }
  
  func openSheetFrame(bounds: CGRect) -> CGRect {
     return CGRectMake(CGRectGetMinX(bounds), CGRectGetMaxY(bounds) - sheetHeight, CGRectGetWidth(bounds), sheetHeight)
  }
  
  func closedSheetFrame(bounds: CGRect) -> CGRect {
    return CGRectMake(CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetWidth(bounds), sheetHeight)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let bounds = view.bounds
    if (sheetVisible) {
      sheet.frame = openSheetFrame(bounds)
    } else {
      sheet.frame = closedSheetFrame(bounds)
    }
  }
  
  func sheetTapped(tap: UITapGestureRecognizer?) {
    if (sheetVisible) {
      sheetVisible = !sheetVisible
      UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: initialSpringVelocity, options:UIViewAnimationOptions.AllowUserInteraction, animations:{
        self.sheet.frame = self.closedSheetFrame(self.view.bounds)
        
      }, completion: nil)
      
    } else {
      sheetVisible = !sheetVisible
      UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: initialSpringVelocity, options:UIViewAnimationOptions.AllowUserInteraction, animations:{
              self.sheet.frame = self.openSheetFrame(self.view.bounds)
        
        }, completion: nil)
    }
  }
  
  @IBAction func durationSliderChanged(sender: UISlider) {
    duration = NSTimeInterval(sender.value)
    durationLabel?.text = String(format: "%.1f", duration)
  }
  
  @IBAction func dampingSliderChanged(sender: UISlider) {
    springDamping = CGFloat(sender.value)
    dampingLabel?.text = String(format: "%.1f", springDamping)
  }
  
  @IBAction func velocitySliderChanged(sender: UISlider) {
    initialSpringVelocity = CGFloat(sender.value)
    velocityLabel?.text = String(format: "%.1f", initialSpringVelocity)
  }
  
  @IBAction func toggleSheet(sender: UIButton) {
    sheetTapped(nil)
    if (sheetVisible) {
      sender.setTitle("Close Sheet", forState: UIControlState.Normal)
    } else {
      sender.setTitle("Open Sheet", forState: UIControlState.Normal)
    }
  }

}

