//
//  chessData.swift
//  ChessForSwift
//
//  Created by 游聖傑 on 2018/1/24.
//  Copyright © 2018年 Zed. All rights reserved.
//

import Foundation
import UIKit


enum Chess: Int {
    case CheckerBoardGrid = 8
    case PieceA1Max = 43
    case BSTMax2 = 59500
    case PieceStartNum = 10
    case SpaceNum = 12
    case AIChoiceMax = 99
    case StepSpace = 4
    case EffMapMax = 6
}

struct Coordinate{
    var X = 0
    var Y = 0
};

struct CoordinateByte{
    var X = 0
    var Y = 0
};

struct CoordinateByte2{
    var X = 0
    var Y = 0
    var Counter = 0
};

struct CoordinateByte3{
    var X1 = CoordinateByte()
    var X2 = CoordinateByte()
    var Value = 0
};

struct PieceStatus{
    var X = 0
    var Y = 0
    
    var Level = 0
    
    var Moved = 0
    var Color = 0
};

//Step I Color I;
enum AiEnum: Int {
    case S0C0 = 0
    case S0C1 = 1
    case S1C0 = 2
    case S1C1 = 3
    case S1C0A = 4
    case S1C1A = 5
}


struct UEE3Val{
    var V = [0, 0, 0]
    var X = [0, 0, 0]
    var Y = [0, 0, 0]
    var X2LMod6 = [0, 0, 0]
};

struct X1FullPsb{
    var PsbX1 = Array<CoordinateByte>(repeating:CoordinateByte(X: 0, Y: 0), count:16)//[16];
    var PsbX1C = 0 //Counter
    var PsbX2 = Array<[CoordinateByte]>(repeating: Array<CoordinateByte>(repeating:CoordinateByte(X: 0, Y: 0), count:28),count: 16)
    var PsbX2C = Array<Int>(repeating: 0, count: 16)
    
    var PointBeAtk = Array<[[CoordinateByte]]>(repeating: Array<[CoordinateByte]>(repeating: Array<CoordinateByte>(repeating:CoordinateByte(X: 0, Y: 0), count:16),count: Chess.CheckerBoardGrid.rawValue), count:Chess.CheckerBoardGrid.rawValue)
    var PointBeAtkC1 = Array<[Int]>(repeating: Array<Int>(repeating:0, count:Chess.CheckerBoardGrid.rawValue),count: Chess.CheckerBoardGrid.rawValue)
};

struct AIPsbMap2{
    var X1 = Array<CoordinateByte>(repeating:CoordinateByte(X: 0, Y: 0), count:28)
    var X1C = 0
};


class chessData: NSObject {
    var PieceWidth = 0
    var BGshiftY = CGRect.zero
    
    var Imag1 = UIImageView()
    var ImgMoveX = CoordinateByte(X: 0, Y: 0)
    var ImgMouseX = CoordinateByte(X: 0, Y: 0)
    var ImgX = CGPoint(x: 0, y: 0)
    
    var Imag2 = Array<UIImageView>(repeating: UIImageView(), count: 12)
    var Imag2C = 0

    //PieceIndex [Chess.CheckerBoardGrid][Chess.CheckerBoardGrid];
    var Map1 = Array<[Int]>(repeating: Array<Int>(repeating:0, count:Chess.CheckerBoardGrid.rawValue),count: Chess.CheckerBoardGrid.rawValue)

    //PossibleMoveMap [Chess.CheckerBoardGrid][Chess.CheckerBoardGrid];
    var Map2 = Array<[Int]>(repeating: Array<Int>(repeating:0, count:Chess.CheckerBoardGrid.rawValue),count: Chess.CheckerBoardGrid.rawValue)

    //For Castling [Chess.CheckerBoardGrid][Chess.CheckerBoardGrid][2];
    var PossibleAttackMap = Array<[[Int]]>(repeating: Array<[Int]>(repeating: Array<Int>(repeating:0, count:2),count: Chess.CheckerBoardGrid.rawValue), count:Chess.CheckerBoardGrid.rawValue)

    var MapImg = Array<[UIImageView]>(repeating: Array<UIImageView>(repeating: UIImageView(), count: Chess.CheckerBoardGrid.rawValue), count: Chess.CheckerBoardGrid.rawValue)
    var MapMarkImg = Array<[UIImageView]>(repeating: Array<UIImageView>(repeating: UIImageView(), count: Chess.CheckerBoardGrid.rawValue), count: Chess.CheckerBoardGrid.rawValue)


    var MovedFlag = Array<[Int]>(repeating: Array<Int>(repeating:0, count:2),count: 3)
    //MovedFlag
    //Index, Color;
    //Index 0 King 1 LeftRook 2 RightRook;

    var Direction8 = [CoordinateByte(X: 0, Y: 1), CoordinateByte(X: 1, Y: 1), CoordinateByte(X: 1, Y: 0), CoordinateByte(X: 1, Y: -1),
                      CoordinateByte(X: 0, Y: -1), CoordinateByte(X: -1, Y: -1), CoordinateByte(X: -1, Y: 0), CoordinateByte(X: -1, Y: 1)]
    var DirectionKnight8 = Array<CoordinateByte>(repeating:CoordinateByte(X: 0, Y: 0), count:8)

    var AISearchList = Array<[String]>(repeating: Array<String>(repeating:"", count:1000),count: 2)
    var AISearchListCount = 0

    var PassantX = 0
    var PassantY = 0
    var PassantB = 0
    var QueeningX = 0
    var QueeningY = 0

    //Index 0 for Button 1 for AI;
    var UndoIndex = 0
    var UndoX = Array<[[Int]]>(repeating: Array<[Int]>(repeating: Array<Int>(repeating:0, count:599),count: 2), count:6)
    var UndoPassant = Array<[Int]>(repeating: Array<Int>(repeating:0, count:599),count: 3)
    var UndoMovFlag = Array<[[Int]]>(repeating: Array<[Int]>(repeating: Array<Int>(repeating:0, count:599),count: 2), count:3)


    //Map PsbMov;
    //Coordinate Color Index;
    //Index 0 for PsbMov 1 for PsbAtk;
    var MarkPsbMovX = Array<[[CoordinateByte2]]>(repeating: Array<[CoordinateByte2]>(repeating: Array<CoordinateByte2>(repeating: CoordinateByte2(), count:2),count: 2), count:64)
    var MarkPsbMovC = Array<[Int]>(repeating: Array<Int>(repeating:0, count:2),count: 2)

    var PieceA1 = Array<PieceStatus>(repeating: PieceStatus(), count:Chess.PieceA1Max.rawValue)
    //PieceA1[0] LastMouseDown;
    //PieceA1[0].Level PieceA1Index;

    //PieceA1[1] LastPieceLocation1;
    //PieceA1[2] LastPieceLocation2;

    var NowStep = 0

    var AICb1 = CoordinateByte3()
    var AIChoice = Array<CoordinateByte3>(repeating: CoordinateByte3(), count:Chess.AIChoiceMax.rawValue)
    var AIChoiceC = 0

    var AIPsbMovX = Array<CoordinateByte2>(repeating: CoordinateByte2(), count:64)

    var PiecePow = Array<Int>(repeating:0, count:6)

    var AIColor = 0



    var UEEV = [UEE3Val(), UEE3Val()]

    var AIPsbM2 = AIPsbMap2()
    var X1Psb = Array<X1FullPsb>(repeating: X1FullPsb(), count: Chess.EffMapMax.rawValue+1)
}
