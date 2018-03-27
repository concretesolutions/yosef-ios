//
//  DynamicViewTests.swift
//  Yosef_Tests
//
//  Created by Emannuel Carvalho on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import XCTest
import FBSnapshotTestCase

@testable import Yosef

class MockDynamicViewDelegate: DynamicActionDelegate {
    
    var calledAction: String?
    
    func callAction(sender: String) {
        calledAction = sender
    }
    
}

class DynamicViewTests: FBSnapshotTestCase {

    let mocks = ComponentsMocks()
    var view: UIView!
    
    override func setUp() {
        super.setUp()
        recordMode = false
        view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 600))
        view.backgroundColor = .white
    }
    
    // MARK: - Snapshots
    
    func testLabel() {
        let info = mocks.labelMock
        let label = try! DynamicView.createView(dynamicsComponent: info,
                                             actionDelegate: MockDynamicViewDelegate())
        setupView(with: label)
        FBSnapshotVerifyView(view)
    }
    
    func testButton() {
        let info = mocks.buttonMock
        let button = try! DynamicView.createView(dynamicsComponent: info, actionDelegate: MockDynamicViewDelegate())
        setupView(with: button)
        FBSnapshotVerifyView(view)
    }
    
    func testGroup() {
        let info = mocks.elementGroup
        let group = try! DynamicView.createView(dynamicsComponent: info, actionDelegate: MockDynamicViewDelegate())
        setupView(with: group)
        FBSnapshotVerifyView(view)
    }
    
    func testRadioGroup() {
        let info = mocks.radioGroup
        let group = try! DynamicView.createView(dynamicsComponent: info, actionDelegate: MockDynamicViewDelegate())
        setupView(with: group)
        FBSnapshotVerifyView(view)
    }
    
    func testImage() {
        let info = mocks.imageMock
        let image = try! DynamicView.createView(dynamicsComponent: info, actionDelegate: MockDynamicViewDelegate())
        
        setupView(with: image)
        FBSnapshotVerifyView(view)
    }
    
    // MARK: - Actions
    
    func testButtonAction() {
        // TODO: it shouldn't need to access the subviews
        let info = mocks.buttonMock
        let delegate = MockDynamicViewDelegate()
        let button = try! DynamicView
            .createView(dynamicsComponent: info,
                        actionDelegate: delegate)
            .subviews
            .first as? DynamicButton
        
        button?.buttonTapped()
        
        XCTAssertNotNil(button)
        XCTAssertEqual(delegate.calledAction, "closeFlow")
    }
    
    func testRadioGroupAction() {
        // TODO: it shouldn't need to access the subviews
        let info = mocks.radioGroup
        let delegate = MockDynamicViewDelegate()
        let dynamicView = try! DynamicView
            .createView(dynamicsComponent: info,
                        actionDelegate: delegate)
            .subviews // TODO: change structure
            .first
        
        let group = dynamicView?.subviews[1].subviews.first as? RadioGroupView
        
        XCTAssertNotNil(group)
        XCTAssert(group?.delegate === delegate)
        XCTAssertNil(group?.selectedItem)
        
        group?.didSelectRadioItem(RadioItem(title: "A title"))
        XCTAssertEqual(group?.selectedItem, "A title")
        
        group?.confirmButtonTapped()
        XCTAssertEqual(delegate.calledAction, "A title")
        
        group?.didDeselectRadioItem(RadioItem(title: "A title"))
        XCTAssertNil(group?.selectedItem)
        
        
    }
    
}

extension DynamicViewTests {
    
    func setupView(with subview: UIView) {
        view.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}
