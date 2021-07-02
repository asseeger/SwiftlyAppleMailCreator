//
//  main.swift
//  SwiftlyAppleMailCreator
//
//  Created by Andreas Seeger on 28.09.20.
//

import Foundation
import AppKit

let app = NSApplication.shared
let VERSION_NUMBER_STRING = "1.2.1"

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if(CommandLine.argc==2) {
            guard CommandLine.arguments[1] == "--version" else { exit(2) }
            Interface.printVersion()
        } else {
            guard CommandLine.argc >= 5 else { exit(1) }
            let recipient = CommandLine.arguments[1]
            let subject = CommandLine.arguments[2]
            let body = CommandLine.arguments[3]
            let attmts = Array(CommandLine.arguments[4..<CommandLine.arguments.count])
            Interface.send(recipient: recipient, subject: subject, body: body, attachmentPaths: attmts)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(EXIT_SUCCESS)
        }
    }
}

class Interface: NSObject {
    static func printVersion() {
        print(VERSION_NUMBER_STRING)
    }
    
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
