//
//  ParseError.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

enum ParseError: Error {
    case invalidType(String)
    case invalidTypeValue(String)
    case unknownProperty(String)
}
