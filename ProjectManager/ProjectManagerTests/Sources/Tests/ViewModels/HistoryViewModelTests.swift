//
//  HistoryViewModelTests.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import XCTest
@testable import ProjectManager

final class HistoryViewModelTests: XCTestCase {

    var sutHistoryViewModel: HistoryViewModel!
    var isUpdated: Bool!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sutHistoryViewModel = HistoryViewModel()
        isUpdated = false

        sutHistoryViewModel.updated = { [weak self] in
            self?.isUpdated = true
        }
    }

    override func tearDownWithError() throws {
        sutHistoryViewModel = nil
        isUpdated = nil
        try super.tearDownWithError()
    }

    func test_history를받아create를호출하면_histories맨앞에삽입된다() {
        let expectedCount: Int = 2
        let expectedFirstHistory: History = TestAsset.dummyMovedHistory

        sutHistoryViewModel.create(history: TestAsset.dummyAddedHistory)
        sutHistoryViewModel.create(history: expectedFirstHistory)

        XCTAssertEqual(sutHistoryViewModel.histories.count, expectedCount)
        XCTAssertEqual(sutHistoryViewModel.histories[0], expectedFirstHistory)
    }

    func test_histories가변경되면_updated가호출된다() {
        sutHistoryViewModel.create(history: TestAsset.dummyAddedHistory)

        XCTAssertTrue(isUpdated)
    }

    func test_added가들어있는_index를받아history를호출하면_view가사용할두문자열을Tuple로반환한다() {
        let expectedTitle: String = "Added '난 더해져요'"
        let expectedSubTitle: String = TestAsset.dummyAddedHistory.date.historyFormat

        sutHistoryViewModel.create(history: TestAsset.dummyAddedHistory)

        XCTAssertEqual(sutHistoryViewModel.history(at: 0)!.title, expectedTitle)
        XCTAssertEqual(sutHistoryViewModel.history(at: 0)!.subtitle, expectedSubTitle)
    }

    func test_removed가들어있는_index를받아history를호출하면_view가사용할두문자열을Tuple로반환한다() {
        let expectedTitle: String = "Removed '난 삭제돼요' from DONE"
        let expectedSubTitle: String = TestAsset.dummyRemovedHistory.date.historyFormat

        sutHistoryViewModel.create(history: TestAsset.dummyRemovedHistory)

        XCTAssertEqual(sutHistoryViewModel.history(at: 0)!.title, expectedTitle)
        XCTAssertEqual(sutHistoryViewModel.history(at: 0)!.subtitle, expectedSubTitle)
    }

    func test_moved가들어있는_index를받아history를호출하면_view가사용할두문자열을Tuple로반환한다() {
        let expectedTitle: String = "Moved '난 움직여요' from TODO to DOING"
        let expectedSubTitle: String = TestAsset.dummyMovedHistory.date.historyFormat

        sutHistoryViewModel.create(history: TestAsset.dummyMovedHistory)

        XCTAssertEqual(sutHistoryViewModel.history(at: 0)!.title, expectedTitle)
        XCTAssertEqual(sutHistoryViewModel.history(at: 0)!.subtitle, expectedSubTitle)
    }

    func test_존재하지않는index로history를호출하면_nil을반환한다() {
        XCTAssertNil(sutHistoryViewModel.history(at: 0))
    }
}

// MARK: - Equatable History

extension History: Equatable {

    public static func == (lhs: History, rhs: History) -> Bool {
        lhs.method == rhs.method
    }
}

extension History.Method: Equatable {

    public static func == (lhs: History.Method, rhs: History.Method) -> Bool {
        switch (lhs, rhs) {
        case let (.added(lhsTitle), .added(rhsTitle)):
            return lhsTitle == rhsTitle
        case let (.moved(lhsTitle, lhsSourceState, lhsDesinationState), .moved(rhsTitle, rhsSourceState, rhsDesinationState)):
            return (lhsTitle == rhsTitle) &&
                   (lhsSourceState == rhsSourceState) &&
                   (lhsDesinationState == rhsDesinationState)
        case let (.removed(lhsTitle, lhsSourceState), .removed(rhsTitle, rhsSourceState)):
            return (lhsTitle == rhsTitle) &&
                   (lhsSourceState == rhsSourceState)
        default:
            return false
        }
    }
}
