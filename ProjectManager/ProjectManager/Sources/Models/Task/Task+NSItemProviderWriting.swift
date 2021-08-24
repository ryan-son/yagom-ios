//
//  Task+NSItemProviderWriting.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/22.
//

import Foundation
import MobileCoreServices

extension Task: NSItemProviderWriting {

    public static var writableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeJSON as String]
    }

    public func loadData(
        withTypeIdentifier typeIdentifier: String,
        forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        if typeIdentifier == kUTTypeJSON as String {
            guard let draggedTask = try? JSONEncoder().encode(self) else {
                completionHandler(nil, PMError.cannotEncodeToJSON(#function))
                return nil
            }
            completionHandler(draggedTask, nil)
        } else {
            completionHandler(nil, PMError.invalidTypeIdentifier)
        }

        return nil
    }
}
