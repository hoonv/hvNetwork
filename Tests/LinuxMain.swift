import XCTest

import hvNetworkTests

var tests = [XCTestCaseEntry]()
tests += hvNetworkTests.allTests()
XCTMain(tests)
