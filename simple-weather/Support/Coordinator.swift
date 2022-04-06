//
//  Coordinator.swift
//  simple-weather
//
//  Created by Cindy Yu on 2022-04-06.
//

import Foundation

/**
*  Coordinators are objects "whose role is to marshal and manage all the view controllers in its purview."
*
*  The pattern is described in
*  http://khanlou.com/2015/01/the-coordinator/
*  http://khanlou.com/2015/10/coordinators-redux/
*
*  It is important that you maintain a reference to any child coordinators.
*/
@objc public protocol Coordinator: AnyObject {
    /**
    Start is the entry point for every coordinator. This is used to kick off the process that the coordinator manages.
    */
    @objc(startAnimated:)
    func start(animated: Bool)

    /// A delegate to notify when the coordinator finishes its job and can be released.
    /// i.e. If the `start()` method of the coordinator presents a UIViewController, this delegate
    /// should get called when the view controller gets dismissed.
    weak var coordinatorDelegate: CoordinatorDelegate? { get set }
}

public extension Coordinator {
    /// Notifies the navigation delegate that the coordinator has finished.
    func finish() {
        coordinatorDelegate?.coordinatorDidFinish(self)
    }
}

@objc public protocol CoordinatorDelegate: AnyObject {
    /// Notifies the delegate that the coordinator finished its job.
    ///
    /// - Parameter coordinator: The coordinator.
    func coordinatorDidFinish(_ coordinator: Coordinator)
}
