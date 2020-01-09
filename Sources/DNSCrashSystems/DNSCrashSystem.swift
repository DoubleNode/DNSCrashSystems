//
//  DNSCrashSystem.swift
//  DoubleNode Core - DNSCrashSystems
//
//  Created by Darren Ehlers on 2019/08/12.
//  Copyright © 2019 - 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

import DNSProtocols

public enum DNSCrashSystemsError: Error
{
    case notImplemented(domain: String, file: String, line: String, method: String)
}
