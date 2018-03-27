//
//  KingfisherApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Kingfisher

public class KingfisherApplier: TypedPropertyApplier {
    typealias ViewType = UIImageView
    
    func apply(value: URL, to: UIImageView) throws -> UIImageView {
        to.kf.setImage(with: value)
        return to
    }
}
