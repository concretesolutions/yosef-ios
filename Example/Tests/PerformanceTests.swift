//
//  PerformanceTests.swift
//  Yosef_Tests
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import XCTest

@testable import Yosef

class PerformanceTests: XCTestCase {
    
    var jsonDict: [String: Any]?
    
    override func setUp() {
        super.setUp()
        jsonDict = loadJson("Step2")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParsePerformance() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            guard jsonDict != nil else { XCTFail("JSON dictionary is nil");return }
            startMeasuring()
            let _ = DynamicComponent.parse(dictionary: jsonDict!)
            stopMeasuring()
        }
    }
    
    func testRenderPerformance() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            guard jsonDict != nil else { XCTFail("JSON dictionary is nil");return }
            let comp = DynamicComponent.parse(dictionary: jsonDict!) as DynamicComponent
            let delegate = MockDelegate()
            startMeasuring()
            let _ = DynamicView.createView(dynamicsComponent: comp, actionDelegate: delegate)
            stopMeasuring()
        }
    }
    
    func loadJson(_ name: String) -> [String:Any]? {
        if let path = Bundle(for: type(of: self))
            .path(forResource: name, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                let dict = try (JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any])
                return dict
            } catch {
                return nil
            }
        }
        return nil
    }
}

class MockDelegate: DynamicActionDelegate {
    func callAction(sender: String) {}
}
