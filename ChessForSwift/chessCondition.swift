//
//  chessCondition.swift
//  ChessForSwift
//
//  Created by 游聖傑 on 2018/1/24.
//  Copyright © 2018年 Zed. All rights reserved.
//

import Foundation
import UIKit

class chessCondition: NSObject {
    var status: chessStatus!
    var data: chessData!
    
    func IsCheckmate(Color1:Int)->Int {
        var C = 0
        var C1 = 0
        var OpponentKing = 0
        var X = 0
        var Y = 0
        var I = 0
        
        C = 0;
        OpponentKing = (1 - Color1) * 6;
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                
                if (C < 16 ) {
                    C1 = data.Map1[X][Y] / 6;
                    if (C1 == Color1 ) {
                        
                        data.MarkPsbMovC[Color1][1] = 0;
                        status.MarkPsbAtk(X: X, Y: Y, Color1: Color1);
                        C = C + 1;
                        if (data.MarkPsbMovC[Color1][1] > 0 ) {
                            I = 0
                            while ( I <= data.MarkPsbMovC[Color1][1] - 1 ) {
                                if (OpponentKing == data.Map1[data.MarkPsbMovX[I][Color1][1].X][data.MarkPsbMovX[I][Color1][1].Y] ) {
                                    C = 20;
                                    return 1;
                                };
                                I = I + 1
                            };
                        };
                        
                    };
                } else {
                    break;
                };
                
                X = X + 1
            };
            
            Y = Y + 1
        };
        
        return 0;
    };
    
    func InCheckerBoard(X: Int, Y: Int)->Int {
        if (X >= 0 && X < Chess.CheckerBoardGrid.rawValue && Y >= 0 && Y < Chess.CheckerBoardGrid.rawValue ) {
            return 1;
        } else {
            return 0;
        }
    }
    
    func IsSpaceSameColor(X: Int, Y: Int, Level1: Int)->Int {
        var Level2 = 0
        
        if (data.Map1[X][Y] >= Chess.SpaceNum.rawValue ) {
            return 0;
        } else {
            Level2 = data.Map1[X][Y];
            if (Level1 / 6 == Level2 / 6 ) {
                return 1;
            } else {
                return 2;
            };
        };
    };
}
