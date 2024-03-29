//
//  DNSCrashSystemsCodeLocation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCrashSystems
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSError

public extension DNSCodeLocation {
    typealias crashSystems = DNSCrashSystemsCodeLocation
}
open class DNSCrashSystemsCodeLocation: DNSCodeLocation {
    override open class var domainPreface: String { "com.doublenode.crashSystems." }
}
