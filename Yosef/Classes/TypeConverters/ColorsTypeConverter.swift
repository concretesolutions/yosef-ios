//
//  ColorsTypeConverter.swift
//  Yosef
//
//  Created by kaique.pantosi on 04/05/18.
//

import Foundation

struct Color {
    let r: Int
    let g: Int
    let b: Int
    let alpha: Int
    
    func getColor() -> UIColor {
        let r = CGFloat(integerLiteral: self.r) / 255.0
        let g = CGFloat(integerLiteral: self.g) / 255.0
        let b = CGFloat(integerLiteral: self.b) / 255.0
        let alpha = CGFloat(integerLiteral: self.alpha) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}

public class ColorsTypeConverter: TypedTypeConverter {
    typealias Model = [CGColor]
    
    func validateForType(value: Any) -> [CGColor]? {
        guard let str = value as? String else {
            return nil
        }
        
        let components = str.split(separator: ",").compactMap { stringValue -> String in
            return String(stringValue)
        }
        
        var colors = [CGColor]()
        
        for component in components {
            let color = component.replacingOccurrences(of: " ", with: "").split(separator: ".").compactMap { stringValue -> Int? in
                if let intValue = Int(stringValue) {
                    return intValue
                }
                return nil
            }
            
            colors.append(Color(r: color[0], g: color[1], b: color[2], alpha: color[3]).getColor().cgColor)
        }
        
        return colors
    }
}
