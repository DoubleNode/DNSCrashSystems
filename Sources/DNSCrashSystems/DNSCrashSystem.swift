//
//  DNSCrashSystem.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCrashSystems
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import DNSProtocols

public enum DNSCrashSystemsError: Error
{
    case notImplemented(domain: String, file: String, line: String, method: String)
}
