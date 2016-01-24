// EnrichedButton
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

let kDRNButtonDefaultHitTestEdgeInsetRatio: CGFloat = 0.2
let kDRNAlphaDRNButtonDefaultHighlight: CGFloat = 0.48
let kDRNAlphaDRNButtonDefaultEnabled: CGFloat = 0.60

@objc(DRNButton)
class RichButton : UIButton {
 
    var hitTestEdgeInsetRatio = kDRNButtonDefaultHitTestEdgeInsetRatio
    var fontsPerStateEnabled = false
    var fadeOnHighlighting = false
    var fadeOnEnabled = false
    
    var hitTestEdgeInsets: UIEdgeInsets {
        get {
            let horizontalInset = frame.size.width * hitTestEdgeInsetRatio;
            let verticalInset = frame.size.height * hitTestEdgeInsetRatio;
            
            return UIEdgeInsetsMake(-verticalInset, -horizontalInset, -verticalInset, -horizontalInset)
        }
    }
    
    override var selected: Bool {
        
        didSet {
            updateTitleFontWithCurrentState()
        }
    }
    
    override var enabled: Bool {
        didSet {
            if fadeOnEnabled {
                alpha = enabled ? 1 : kDRNAlphaDRNButtonDefaultEnabled
            }
        }
    }
    
    override var highlighted: Bool {
        
        didSet {
            updateTitleFontWithCurrentState()
            
            if (fadeOnHighlighting) {
                alpha = (highlighted ? kDRNAlphaDRNButtonDefaultHighlight : 1);
            }
        }
    }
    
    private var titleFontByState = [UInt : UIFont]();
    
    func setTitleFont(font: UIFont?, state: UIControlState) {
        if !fontsPerStateEnabled { return }
        
        guard let font = font else {
            titleFontByState[state.rawValue] = nil
            return
        }
    
        titleFontByState[state.rawValue] = font;
        
        updateTitleFontWithCurrentState()
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {

        if (UIEdgeInsetsEqualToEdgeInsets(hitTestEdgeInsets, UIEdgeInsetsZero) ||
            !self.enabled ||
            self.hidden) {
                return super.pointInside(point, withEvent: event)
        }
        
        let relativeFrame = bounds
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets)
        
        return CGRectContainsPoint(hitFrame, point)
    }
    
    
    func updateTitleFontWithCurrentState() {
        if !fontsPerStateEnabled {
            return
        }
        
        guard let font = titleFontByState[state.rawValue] else {
            titleLabel?.font = titleLabel?.font
            return
        }
        
        titleLabel?.font = font
    }

}
