//
//  SKStickerView.swift
//  StickerKit-iMessage-Example-App
//
//  Created by Admin on 2016-09-03.
//  Copyright © 2016 StickerKit. All rights reserved.
//

import Foundation
import Messages

class SKStickerView : MSStickerView {
    
    var SKSticker: Sticker?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupTapRecognizer()
        
    }
    
    func tapGestureRecognized() {
        if let s = SKSticker{
            SKEvent.track(event: .sentSticker, sticker: s)
        }
    }
    
    class GestureRecognizerReceiver : NSObject, UIGestureRecognizerDelegate{
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
    let _recognizerDelegate = GestureRecognizerReceiver()
    
    weak var _recognizer: UITapGestureRecognizer? = nil
    func setupTapRecognizer(){
        if _recognizer == nil {
            let r = UITapGestureRecognizer(target: self, action: #selector(SKStickerView.tapGestureRecognized))
            r.numberOfTapsRequired = 1
            r.numberOfTouchesRequired = 1
            r.cancelsTouchesInView = false
            r.delaysTouchesBegan = true
            r.delegate = _recognizerDelegate
            addGestureRecognizer(r)
            _recognizer = r
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let s = SKSticker{
            SKEvent.track(event: .sentSticker, sticker: s)
        }
    }
    
}
