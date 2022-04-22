//
//  Then.swift
//  simple-weather
//
//  Created by Cindy Yu on 2022-04-06.
//

import Foundation

public protocol Then { }

extension Then where Self: AnyObject {
    @discardableResult
    public func then(_ closure: (Self) throws -> Void) rethrows -> Self {
        try closure(self)
        return self
    }
}

extension NSObject: Then {}
