//
//  WKInterfaceController.swift
//  ZamzamKit
//
//  Created by Basem Emara on 3/17/16.
//  Copyright © 2016 Zamzam. All rights reserved.
//

import Foundation
import WatchKit

public extension WKInterfaceController {
    
    public func alert(
        message: String? = nil,
        title: String = "Alert",
        buttonTitle: String = "OK",
        alertControllerStyle: WKAlertControllerStyle = .Alert,
        additionalActions: [WKAlertAction]? = nil,
        includeCancelAction: Bool = false,
        cancelHandler: (() -> Void)? = nil,
        handler: (() -> Void)? = nil) {
            var actions = [WKAlertAction(
                title: buttonTitle,
                style: .Default) {
                    if let handler = handler {
                        handler()
                    }
                }]
            
            if includeCancelAction {
                actions.append(WKAlertAction(
                    title: "Cancel",
                    style: .Cancel) {
                        if let cancelHandler = cancelHandler {
                            cancelHandler()
                        }
                    })
            }
            
            // Add additional actions if applicable
            if let additionalActions = additionalActions
                where additionalActions.any() {
                    if alertControllerStyle != .SideBySideButtonsAlert {
                        actions += additionalActions
                    } else if actions.count < 2 {
                        // Only two actions are needed for side by side alert
                        actions.append(additionalActions.first!)
                    }
            }
            
            presentAlertControllerWithTitle(title,
                message: message,
                preferredStyle: alertControllerStyle,
                actions: actions)
    }
    
}