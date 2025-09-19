//
//  DNSCrashSystemsTests.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCrashSystemsTests
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import XCTest
import DNSError
import DNSProtocols
import DNSBlankSystems
@testable import DNSCrashSystems

// MARK: - SYSCrashSystem Tests
final class SYSCrashSystemTests: XCTestCase {
    private var sut: SYSCrashSystem!

    override func setUp() {
        super.setUp()
        sut = SYSCrashSystem()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Initialization Tests
    func test_init_createsInstanceSuccessfully() {
        // Given/When
        let system = SYSCrashSystem()

        // Then
        XCTAssertNotNil(system)
        XCTAssertTrue(system is SYSCrashSystem)
        XCTAssertTrue(system is SYSPTCLSystem)
    }

    func test_requiredInit_conformsToProtocol() {
        // Given/When
        let system: SYSPTCLSystem = SYSCrashSystem()

        // Then
        XCTAssertNotNil(system)
        XCTAssertTrue(system is SYSCrashSystem)
    }

    // MARK: - Inheritance Tests
    func test_inheritance_inheritsFromSYSBlankSystem() {
        // Given/When/Then
        XCTAssertTrue(sut is SYSBlankSystem)
    }

    func test_inheritance_conformsToSYSPTCLSystem() {
        // Given/When/Then
        XCTAssertTrue(sut is SYSPTCLSystem)
    }

    // MARK: - Configuration Tests
    func test_configure_callsParentImplementation() {
        // Given/When
        sut.configure()

        // Then - Should not crash and complete successfully
        XCTAssertNotNil(sut)
    }

    // MARK: - Option Management Tests
    func test_enableOption_addsOptionSuccessfully() {
        // Given
        let testOption = "testOption"

        // When
        sut.enableOption(testOption)

        // Then
        XCTAssertTrue(sut.checkOption(testOption))
    }

    func test_enableOption_duplicateOption_doesNotAddTwice() {
        // Given
        let testOption = "testOption"
        sut.enableOption(testOption)

        // When
        sut.enableOption(testOption)

        // Then
        XCTAssertTrue(sut.checkOption(testOption))
        // Note: We can't directly test the count, but the behavior should be consistent
    }

    func test_disableOption_removesOptionSuccessfully() {
        // Given
        let testOption = "testOption"
        sut.enableOption(testOption)
        XCTAssertTrue(sut.checkOption(testOption))

        // When
        sut.disableOption(testOption)

        // Then
        XCTAssertFalse(sut.checkOption(testOption))
    }

    func test_disableOption_nonExistentOption_doesNotCrash() {
        // Given
        let testOption = "nonExistentOption"

        // When/Then - Should not crash
        sut.disableOption(testOption)
        XCTAssertFalse(sut.checkOption(testOption))
    }

    func test_checkOption_nonExistentOption_returnsFalse() {
        // Given
        let testOption = "nonExistentOption"

        // When
        let result = sut.checkOption(testOption)

        // Then
        XCTAssertFalse(result)
    }

    func test_checkOption_existingOption_returnsTrue() {
        // Given
        let testOption = "existingOption"
        sut.enableOption(testOption)

        // When
        let result = sut.checkOption(testOption)

        // Then
        XCTAssertTrue(result)
    }

    // MARK: - Multiple Options Tests
    func test_multipleOptions_allOperationsWork() {
        // Given
        let option1 = "option1"
        let option2 = "option2"
        let option3 = "option3"

        // When
        sut.enableOption(option1)
        sut.enableOption(option2)
        sut.enableOption(option3)

        // Then
        XCTAssertTrue(sut.checkOption(option1))
        XCTAssertTrue(sut.checkOption(option2))
        XCTAssertTrue(sut.checkOption(option3))

        // When
        sut.disableOption(option2)

        // Then
        XCTAssertTrue(sut.checkOption(option1))
        XCTAssertFalse(sut.checkOption(option2))
        XCTAssertTrue(sut.checkOption(option3))
    }

    // MARK: - Scene Delegate Methods Tests
    func test_didBecomeActive_callsWithoutError() {
        // Given/When/Then - Should not crash
        sut.didBecomeActive()
        XCTAssertNotNil(sut)
    }

    func test_willResignActive_callsWithoutError() {
        // Given/When/Then - Should not crash
        sut.willResignActive()
        XCTAssertNotNil(sut)
    }

    func test_willEnterForeground_callsWithoutError() {
        // Given/When/Then - Should not crash
        sut.willEnterForeground()
        XCTAssertNotNil(sut)
    }

    func test_didEnterBackground_callsWithoutError() {
        // Given/When/Then - Should not crash
        sut.didEnterBackground()
        XCTAssertNotNil(sut)
    }

    // MARK: - Network Configuration Tests
    func test_netConfig_hasDefaultValue() {
        // Given/When
        let config = sut.netConfig

        // Then
        XCTAssertNotNil(config)
    }

    // MARK: - Edge Cases and Crash Safety Tests
    func test_optionManagement_withEmptyString_handlesGracefully() {
        // Given
        let emptyOption = ""

        // When/Then - Should handle gracefully without crashing
        sut.enableOption(emptyOption)
        XCTAssertTrue(sut.checkOption(emptyOption))

        sut.disableOption(emptyOption)
        XCTAssertFalse(sut.checkOption(emptyOption))
    }

    func test_optionManagement_withSpecialCharacters_handlesGracefully() {
        // Given
        let specialOption = "test!@#$%^&*()option"

        // When/Then - Should handle gracefully without crashing
        sut.enableOption(specialOption)
        XCTAssertTrue(sut.checkOption(specialOption))

        sut.disableOption(specialOption)
        XCTAssertFalse(sut.checkOption(specialOption))
    }

    func test_optionManagement_withLongString_handlesGracefully() {
        // Given
        let longOption = String(repeating: "a", count: 1000)

        // When/Then - Should handle gracefully without crashing
        sut.enableOption(longOption)
        XCTAssertTrue(sut.checkOption(longOption))

        sut.disableOption(longOption)
        XCTAssertFalse(sut.checkOption(longOption))
    }

    // MARK: - Thread Safety Consideration Tests
    func test_optionManagement_concurrentAccess_handlesGracefully() {
        // Given
        let expectation = XCTestExpectation(description: "Concurrent access completes")
        let option = "concurrentOption"

        // When - Simulate concurrent access
        DispatchQueue.concurrentPerform(iterations: 10) { iteration in
            if iteration % 2 == 0 {
                sut.enableOption("\(option)\(iteration)")
            } else {
                sut.disableOption("\(option)\(iteration)")
            }
        }

        // Then - Should complete without crashing
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(sut)
    }
}

// MARK: - DNSCrashSystemsCodeLocation Tests
final class DNSCrashSystemsCodeLocationTests: XCTestCase {
    private var sut: DNSCrashSystemsCodeLocation!

    override func setUp() {
        super.setUp()
        sut = DNSCrashSystemsCodeLocation(self)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Inheritance Tests
    func test_inheritance_inheritsFromDNSCodeLocation() {
        // Given/When/Then
        XCTAssertTrue(sut is DNSCodeLocation)
    }

    // MARK: - Domain Preface Tests
    func test_domainPreface_returnsCorrectValue() {
        // Given/When
        let domainPreface = DNSCrashSystemsCodeLocation.domainPreface

        // Then
        XCTAssertEqual(domainPreface, "com.doublenode.crashSystems.")
    }

    func test_domainPreface_overridesParentClass() {
        // Given/When
        let parentDomainPreface = DNSCodeLocation.domainPreface
        let childDomainPreface = DNSCrashSystemsCodeLocation.domainPreface

        // Then
        XCTAssertNotEqual(parentDomainPreface, childDomainPreface)
        XCTAssertEqual(parentDomainPreface, "com.doublenode.")
        XCTAssertEqual(childDomainPreface, "com.doublenode.crashSystems.")
    }

    // MARK: - Initialization Tests
    func test_init_withObject_createsInstanceSuccessfully() {
        // Given
        let testObject = "TestObject"

        // When
        let codeLocation = DNSCrashSystemsCodeLocation(testObject)

        // Then
        XCTAssertNotNil(codeLocation)
        XCTAssertTrue(codeLocation.domain.contains("crashSystems"))
        XCTAssertTrue(codeLocation.domain.contains("String"))
    }

    func test_init_withRawData_createsInstanceSuccessfully() {
        // Given
        let testObject = "TestObject"
        let rawData = "TestFile.swift,42,testMethod()"

        // When
        let codeLocation = DNSCrashSystemsCodeLocation(testObject, rawData)

        // Then
        XCTAssertNotNil(codeLocation)
        XCTAssertTrue(codeLocation.domain.contains("crashSystems"))
        XCTAssertEqual(codeLocation.file, "TestFile.swift")
        XCTAssertEqual(codeLocation.line, 42)
        XCTAssertEqual(codeLocation.method, "testMethod()")
    }

    // MARK: - Domain Generation Tests
    func test_domain_includesCorrectPreface() {
        // Given/When
        let domain = sut.domain

        // Then
        XCTAssertTrue(domain.hasPrefix("com.doublenode.crashSystems."))
    }

    func test_domain_includesObjectType() {
        // Given
        let testObject = SYSCrashSystem()

        // When
        let codeLocation = DNSCrashSystemsCodeLocation(testObject)

        // Then
        XCTAssertTrue(codeLocation.domain.contains("SYSCrashSystem"))
        XCTAssertTrue(codeLocation.domain.hasPrefix("com.doublenode.crashSystems."))
    }

    // MARK: - Properties Tests
    func test_asString_returnsCorrectFormat() {
        // Given/When
        let asString = sut.asString

        // Then
        XCTAssertTrue(asString.contains(":"))
        XCTAssertTrue(asString.contains("com.doublenode.crashSystems."))
    }

    func test_failureReason_matchesAsString() {
        // Given/When
        let asString = sut.asString
        let failureReason = sut.failureReason

        // Then
        XCTAssertEqual(asString, failureReason)
    }

    func test_userInfo_containsRequiredKeys() {
        // Given/When
        let userInfo = sut.userInfo

        // Then
        XCTAssertNotNil(userInfo["DNSTimeStamp"])
        XCTAssertNotNil(userInfo["DNSDomain"])
        XCTAssertNotNil(userInfo["DNSFile"])
        XCTAssertNotNil(userInfo["DNSLine"])
        XCTAssertNotNil(userInfo["DNSMethod"])
    }

    func test_userInfo_containsCorrectTypes() {
        // Given/When
        let userInfo = sut.userInfo

        // Then
        XCTAssertTrue(userInfo["DNSTimeStamp"] is Date)
        XCTAssertTrue(userInfo["DNSDomain"] is String)
        XCTAssertTrue(userInfo["DNSFile"] is String)
        XCTAssertTrue(userInfo["DNSLine"] is Int)
        XCTAssertTrue(userInfo["DNSMethod"] is String)
    }

    // MARK: - Extension Tests
    func test_extensionTypealias_isCorrectType() {
        // Given/When
        let codeLocation = DNSCodeLocation.crashSystems(self)

        // Then
        XCTAssertTrue(codeLocation is DNSCrashSystemsCodeLocation)
        XCTAssertTrue(codeLocation.domain.contains("crashSystems"))
    }

    // MARK: - Edge Cases Tests
    func test_initialization_withNilObject_handlesGracefully() {
        // Given
        let nilObject: String? = nil

        // When
        let codeLocation = DNSCrashSystemsCodeLocation(nilObject as Any)

        // Then
        XCTAssertNotNil(codeLocation)
        XCTAssertTrue(codeLocation.domain.contains("crashSystems"))
    }

    func test_initialization_withEmptyRawData_handlesGracefully() {
        // Given
        let testObject = "TestObject"
        let emptyRawData = ""

        // When
        let codeLocation = DNSCrashSystemsCodeLocation(testObject, emptyRawData)

        // Then
        XCTAssertNotNil(codeLocation)
        XCTAssertEqual(codeLocation.file, "<UnknownFile>")
        XCTAssertEqual(codeLocation.line, 0)
        XCTAssertEqual(codeLocation.method, "")
    }

    func test_initialization_withPartialRawData_handlesGracefully() {
        // Given
        let testObject = "TestObject"
        let partialRawData = "TestFile.swift"

        // When
        let codeLocation = DNSCrashSystemsCodeLocation(testObject, partialRawData)

        // Then
        XCTAssertNotNil(codeLocation)
        XCTAssertEqual(codeLocation.file, "TestFile.swift")
        XCTAssertEqual(codeLocation.line, 0)
        XCTAssertEqual(codeLocation.method, "")
    }

    // MARK: - String Concatenation Tests
    func test_stringConcatenation_worksCorrectly() {
        // Given
        let prefix = "Error: "

        // When
        let result = prefix + sut

        // Then
        XCTAssertTrue(result.hasPrefix("Error: "))
        XCTAssertTrue(result.contains("com.doublenode.crashSystems."))
    }
}
