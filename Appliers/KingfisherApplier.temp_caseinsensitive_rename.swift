//
//  KingFisherApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//

import Kingfisher

class KingfisherApplier: PropertyApplier<UIImageView> {
    
    override func apply(value: Any, to: UIImageView) throws -> UIImageView {
        guard let floatValue = value as? CGFloat else {
            throw ParseError.invalidType
        }
        
        
        
        return to
    }
}
