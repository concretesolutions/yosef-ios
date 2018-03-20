//
//  DynamicPropertyError.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

public enum DynamicPropertyError: Error {
    case invalidJSONFormat
    case invalidValue(type: String, value: Any)
    case unknownType(type: String)
}
