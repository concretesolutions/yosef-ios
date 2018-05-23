//
//  CornerTypeConverter.swift
//  iOSSnapshotTestCase
//
//  Created by kaique.pantosi on 23/05/18.
//

import Foundation

struct Corners {
    var topLeft: CGFloat
    var topRight: CGFloat
    var bottomLeft: CGFloat
    var bottomRight: CGFloat
}

public class CornerTypeConverter: TypeConverter {
    func validate(value: Any) -> Any? {
        guard let stringValue = value as? String else {
            return nil
        }
        #if swift(>=4.1)
        let corners = stringValue.split(separator: ",").compactMap({ stringValue -> CGFloat? in
            if let value = NumberFormatter().number(from: String(stringValue)) {
                return CGFloat(truncating: value)
            } else {
                return nil
            }
        })
        #else
        let corners = stringValue.split(separator: ",").flatMap({ stringValue -> CGFloat? in
        if let value = NumberFormatter().number(from: String(stringValue)) {
        return CGFloat(truncating: value)
        } else {
        return nil
        }
        })
        #endif
        if corners.count == 1 {
            return Corners(topLeft: corners[0], topRight: corners[0], bottomLeft: corners[0], bottomRight: corners[0])
        } else if corners.count == 2 {
            return Corners(topLeft: corners[0], topRight: corners[0], bottomLeft: corners[1], bottomRight: corners[1])
        } else if corners.count == 4 {
            return Corners(topLeft: corners[0], topRight: corners[1], bottomLeft: corners[2], bottomRight: corners[3])
        }
        
        return nil
    }
}
