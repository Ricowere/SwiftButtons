// BounceButton
// Copyright (c) 2016 David Rico
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

let kDRNUIViewDRNBounceButtonDefaultShrinkAnimationDuration: NSTimeInterval = 0.25
let kDRNUIViewDRNBounceButtonDefaultShrinkRatioDefault: Float = 0.8

let kDRNUIViewDRNBounceButtonDefaultDampingAnimationDuration: Float = 0.65
let kDRNUIViewDRNBounceButtonDefaultDampingValueAnimation: Float = 0.3


@objc(DRNBounceButton)
class BounceButton : RichButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action:"buttonTapped:event:", forControlEvents: .AllEvents)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addTarget(self, action:"buttonTapped:event:", forControlEvents: .AllEvents)
    }
    
    func animateToShrink() {
        UIView.animateWithDuration(kDRNUIViewDRNBounceButtonDefaultShrinkAnimationDuration,
            delay: 0,
            options: .BeginFromCurrentState,
            animations: { () -> Void in
                let affineTransform = CGAffineTransformMakeScale(CGFloat( kDRNUIViewDRNBounceButtonDefaultShrinkRatioDefault), CGFloat(kDRNUIViewDRNBounceButtonDefaultShrinkRatioDefault))
                
                self.layer.setAffineTransform(affineTransform)
            },
            completion: nil)
    }
    
    func animateToNormalSize() {
        UIView.animateWithDuration(kDRNUIViewDRNBounceButtonDefaultShrinkAnimationDuration,
            delay: 0,
            usingSpringWithDamping:CGFloat(kDRNUIViewDRNBounceButtonDefaultDampingValueAnimation),
            initialSpringVelocity:0,
            options: .BeginFromCurrentState,
            animations: { () -> Void in
                
                self.layer.setAffineTransform(CGAffineTransformIdentity)
            }, completion: nil)
    }
    
    func cancelAnimation() {
        UIView.animateWithDuration(kDRNUIViewDRNBounceButtonDefaultShrinkAnimationDuration,
            delay: 0,
            options: .BeginFromCurrentState,
            animations: { () -> Void in
                
                self.layer.setAffineTransform(CGAffineTransformIdentity)
            },
            completion: nil)
    }
    
    func buttonTapped(button: UIButton, event: UIEvent) {
        if let touch = event.allTouches()?.first {
            switch touch.phase {
            case .Began: animateToShrink()
            case .Moved: cancelAnimation()
            case .Ended: animateToNormalSize()
            default: break
            }
        }
    }
}
