//
//  extensionString.swift
//  ChessForSwift
//
//  Created by 游聖傑 on 2018/1/24.
//  Copyright © 2018年 Zed. All rights reserved.
//

import Foundation



extension String {
    func mid(start: Int, length: Int)->String {
        var temp = ""
        if start - 1 < self.characters.count && start - 1 >= 0 {
            temp = String(self.dropFirst(start - 1))
            temp = String(temp.prefix(length))
        }
        
        return temp
    }
    
    func charToInt(Index: Int, signSub: String)->Int {
        let temp = Int(self.mid(start: Index, length: 1).utf8.min()!) - Int(signSub.utf8.min()!)
        
        return temp
    }
}
