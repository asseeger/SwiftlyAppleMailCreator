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
        guard CommandLine.argc >= 5 else { exit(-1) }
        let recipient = CommandLine.arguments[1]
        let subject = CommandLine.arguments[2]
        let body = CommandLine.arguments[3]
        let attmts = Array(CommandLine.arguments[4..<CommandLine.arguments.count])
        SendEmail.send(recipient: recipient, subject: subject, body: body, attachmentPaths: attmts)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    exit(0)
                }
    }
}

class SendEmail: NSObject {
    static func send(recipient: String, subject: String, body: String, attachmentPaths: [String]) {
        guard let service = NSSharingService(named: .composeEmail) else { exit(-1) }
        service.recipients = [recipient]
        service.subject = subject
        
        var items: [Any] = [body]
        items.append(contentsOf: attachmentPaths.map { URL(fileURLWithPath: $0).absoluteURL })
        service.perform(withItems: items)
    }
}

let delegate = AppDelegate()
app.delegate = delegate
app.run()
