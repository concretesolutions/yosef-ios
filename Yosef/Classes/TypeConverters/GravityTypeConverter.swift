//
//  GravityTypeConverter.swift
//  Yosef
//
//  Created by kaique.pantosi on 26/03/18.
//

public enum GravityName: String {
    case bottom
    case top
    case center
    case right
    case left
    case centerX
    case centerY
}

enum GravityVertical {
    case top
    case center
    case bottom
}

enum GravityHorizontal {
    case left
    case center
    case right
}

struct Gravity {
    var vertical: GravityVertical
    var horizontal: GravityHorizontal
    
    init(gravityNames: [GravityName]) {
        self.vertical = .top
        self.horizontal = .left
        
        gravityNames.forEach {
            switch $0 {
            case .top:
                self.vertical = .top
            case .bottom:
                self.vertical = .bottom
            case .left:
                self.horizontal = .left
            case .right:
                self.horizontal = .right
            case .centerX:
                self.horizontal = .center
            case .centerY:
                self.vertical = .center
            case .center:
                self.vertical = .center
                self.horizontal = .center
            }
        }
    }
    
    init() {
        self.vertical = .top
        self.horizontal = .left
    }
}

public class GravityTypeConverter: TypeConverter {
    func validate(value: Any) -> Any? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        #if swift(>=4.1)
        let margins = stringValue.split(separator: ",").compactMap({
            return GravityName(rawValue: String($0))
        })
        #else
        let margins = stringValue.split(separator: ",").flatMap({
            return GravityName(rawValue: String($0))
        })
        #endif
        
        return Gravity(gravityNames: margins)
    }
}
