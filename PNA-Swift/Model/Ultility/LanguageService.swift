//
//  LanguageService.swift
//  PNA-Swift
//
//  Created by An on 4/26/18.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit
import SSZipArchive
class LanguageService: NSObject{
    static let sharedInstance = LanguageService()
    override fileprivate init() {
    }
    func getLanguage(_ key: String) -> String{
        let filePath:String = "\(NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0])/Caches/language/\(Global.LANG_FILE_NAME)"
        if FileManager.default.fileExists(atPath: filePath) {
            if Global.LANG_JSON.isEmpty {
                let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
                Global.LANG_JSON = try! JSONSerialization.jsonObject(with: data!) as! [AnyHashable : Any]
            }
            return Global.LANG_JSON[key] == nil ? "No Text" : Global.LANG_JSON[key] as! String
        }
        return ""
    }
    func saveLangague (_ _data: NSData) {
        let dirPath:String = "\(NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0])/Caches/language"
        let zipPath:String = "\(NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0])/Caches/language.zip"
        
        try? FileManager.default.removeItem(atPath: zipPath)
        try? FileManager.default.removeItem(atPath: dirPath)
        _data.write(toFile: zipPath, atomically: true)
        
        let zip: Bool = SSZipArchive.unzipFile(atPath: zipPath, toDestination: dirPath)
        if zip {
            try? FileManager.default.removeItem(atPath: zipPath)
        }
    }
}
