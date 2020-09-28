//
//  main.swift
//  SwiftlyAppleMailCreator
//
//  Created by Andreas Seeger on 28.09.20.
//

import Foundation
import AppKit

let app = NSApplication.shared

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        guard CommandLine.argc == 5 else { fatalError() }
        let recipient = CommandLine.arguments[1]
        let subject = CommandLine.arguments[2]
        let body = CommandLine.arguments[3]
        let attachmentPath = CommandLine.arguments[4]
        SendEmail.send(recipient: recipient, subject: subject, body: body, attachmentPath: attachmentPath)
    }
}

class SendEmail: NSObject {
    static func send(recipient: String, subject: String, body: String, attachmentPath: String) {
        guard let service = NSSharingService(named: .composeEmail) else { fatalError() }
        service.recipients = [recipient]
        service.subject = subject
        
        let attmtUrl = URL(fileURLWithPath: attachmentPath).absoluteURL
        
        service.perform(withItems: [body, attmtUrl as URL])
    }
}

let delegate = AppDelegate()
app.delegate = delegate
app.run()
