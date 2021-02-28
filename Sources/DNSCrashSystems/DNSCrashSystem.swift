//
//  DNSCrashSystem.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCrashSystems
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import DNSError
import DNSProtocols

public enum DNSCrashSystemsError: Error
{
    case notImplemented(_ codeLocation: DNSCodeLocation)
}
extension DNSCrashSystemsError: DNSError {
    public static let domain = "CRASHSYSTEMS"
    public enum Code: Int
    {
        case notImplemented = 1001
    }
    
    public var nsError: NSError! {
        switch self {
        case .notImplemented(let codeLocation):
            var userInfo = codeLocation.userInfo
            userInfo[NSLocalizedDescriptionKey] = self.errorString
            return NSError.init(domain: Self.domain,
                                code: Self.Code.notImplemented.rawValue,
                                userInfo: userInfo)
        }
    }
    public var errorDescription: String? {
        return self.errorString
    }
    public var errorString: String {
        switch self {
        case .notImplemented:
            return NSLocalizedString("CRASHSYSTEMS-Not Implemented Error", comment: "")
                + " (\(Self.domain):\(Self.Code.notImplemented.rawValue))"
        }
    }
    public var failureReason: String? {
        switch self {
        case .notImplemented(let codeLocation):
            return codeLocation.failureReason
        }
    }
}
