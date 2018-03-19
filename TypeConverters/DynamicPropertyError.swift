//
//  DynamicPropertyError.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//

enum DynamicPropertyError: Error {
    case invalidJSONFormat
    case invalidValue(type: String, value: Any)
    case unknownType(type: String)
}
