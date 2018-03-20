//
//  KingFisherApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//

import Kingfisher

class KingfisherApplier: TypedPropertyApplier {
    typealias ViewType = UIImageView
    
    func apply(value: URL, to: UIImageView) throws -> UIImageView {
        to.kf.setImage(with: value)
        
        return to
    }
    
}
