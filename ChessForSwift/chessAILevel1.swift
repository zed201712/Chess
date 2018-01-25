//
//  chessAILevel1.swift
//  ChessForSwift
//
//  Created by 游聖傑 on 2018/1/24.
//  Copyright © 2018年 Zed. All rights reserved.
//

import Foundation
import UIKit

class chessAILevel1: NSObject {
    var vc: ViewController!
    var condition: chessCondition!
    var status: chessStatus!
    var data: chessData!
    
    func AIMain2()->Void {
        var I = 0
        var TPieceA1 = Array<PieceStatus>(repeating: PieceStatus(), count: 3)
        var NowGameIDIndex = 0
        var TempNowStep = 0
        var I3 = 0
        
        I = 0
        while ( I <= 2 ) {
            TPieceA1[I] = data.PieceA1[I];
            I = I + 1
        };
        
        data.AIChoiceC = 0;
        data.AISearchListCount = 0;
        self.AISearchListAdd(S: "");
        
        NowGameIDIndex = 0;
        
        TempNowStep = data.NowStep;
        data.AIColor = TempNowStep % 2;
        
        self.AIExpandStep(); //Step1
        data.AIChoiceC = 0;
        
        I3 = data.AISearchListCount - 1;
        NowGameIDIndex = 1
        while ( NowGameIDIndex <= I3 ) {
            self.AIMoveOneStep(PathS: data.AISearchList[0][NowGameIDIndex]);
            self.AIMoveStrategy(OpponentColor: 1 - data.AIColor, PathS: data.AISearchList[0][NowGameIDIndex]);
            
            vc.PopUndo();
            NowGameIDIndex = NowGameIDIndex + 1
        };
        
        
        while (data.NowStep != TempNowStep) {
            vc.PopUndo();
        };
        
        I = 0
        while ( I <= 2 ) {
            data.PieceA1[I] = TPieceA1[I];
            I = I + 1
        };
    };
    
    func AISearchListAdd(S:String )->Void {
        data.AISearchList[0][data.AISearchListCount] = S
        data.AISearchListCount = data.AISearchListCount + 1
    }
    
    func AIMouseUp(I:Int,J:Int)->Void {
        var Color1 = 0
        var LastMap2Val = 0
        
        var I1 = 0
        
        //I = X / data.PieceWidth;
        //J = Y / data.PieceWidth;
        
        if (condition.InCheckerBoard(X: I, Y: J) == 1 ) {
            
            status.PreCastling();
            LastMap2Val = data.Map2[I][J];
            
            if (LastMap2Val > 0 ) {
                
                vc.PushUndo(X1: data.PieceA1[0].X, Y1: data.PieceA1[0].Y, L1: data.PieceA1[0].Level, X2: I, Y2: J, L2: data.Map1[I][J]);
                
                data.Map1[I][J] = data.PieceA1[0].Level;
                data.Map1[I][J] = data.Map1[data.PieceA1[0].X][data.PieceA1[0].Y];
                
                data.PassantB = 0;
                
                //MovedFlag;
                if (data.PieceA1[0].X == 4 && data.PieceA1[0].Y == 0 ) {
                    data.MovedFlag[0][0] = 1;
                    data.MovedFlag[1][0] = 1;
                    data.MovedFlag[2][0] = 1;
                } else if (data.PieceA1[0].X == 4 && data.PieceA1[0].Y == 7 ) {
                    data.MovedFlag[0][1] = 1;
                    data.MovedFlag[1][1] = 1;
                    data.MovedFlag[2][1] = 1;
                } else if (data.PieceA1[0].X == 0 && data.PieceA1[0].Y == 0 ) {
                    data.MovedFlag[1][0] = 1;
                } else if (data.PieceA1[0].X == 7 && data.PieceA1[0].Y == 0 ) {
                    data.MovedFlag[2][0] = 1;
                } else if (data.PieceA1[0].X == 0 && data.PieceA1[0].Y == 7 ) {
                    data.MovedFlag[1][1] = 1;
                } else if (data.PieceA1[0].X == 7 && data.PieceA1[0].Y == 7 ) {
                    data.MovedFlag[2][1] = 1;
                };
                data.Map1[data.PieceA1[0].X][data.PieceA1[0].Y] = Chess.SpaceNum.rawValue
                
                if (LastMap2Val == 2 ) { //Passant
                    
                    data.PassantB = 1;
                    data.PassantX = I;
                    Color1 = data.Map1[I][J] / 6;
                    if (Color1 == 1 ) {
                        data.PassantY = J + 1;
                    } else {
                        data.PassantY = J - 1;
                    };
                    
                } else if (LastMap2Val == 3 ) { //Passant2
                    
                    Color1 = data.Map1[I][J] / 6;
                    if (Color1 == 1 ) {
                        data.Map1[I][J + 1] = Chess.SpaceNum.rawValue
                    } else {
                        data.Map1[I][J - 1] = Chess.SpaceNum.rawValue
                    };
                    
                } else if (LastMap2Val == 5 ) { //Queening
                    
                    data.QueeningX = I;
                    data.QueeningY = J;
                    
                    Color1 = data.Map1[I][J] / 6;
                    Color1 = Color1 * 6;
                    
                    data.Map1[I][J] = data.Map1[I][J] - 4;
                    
                } else if (LastMap2Val == 6 ) { //Right Castling
                    
                    Color1 = data.Map1[I + 1][J];
                    data.Map1[I - 1][J] = Color1;
                    data.Map1[I + 1][J] = Chess.SpaceNum.rawValue
                    
                    I1 = 3;
                    data.UndoX[I1 + 0][0][data.UndoIndex - 1] = I + 1;
                    data.UndoX[I1 + 1][0][data.UndoIndex - 1] = J;
                    data.UndoX[I1 + 2][0][data.UndoIndex - 1] = Color1;
                    data.UndoX[I1 + 0][1][data.UndoIndex - 1] = I - 1;
                    data.UndoX[I1 + 1][1][data.UndoIndex - 1] = J;
                    data.UndoX[I1 + 2][1][data.UndoIndex - 1] = Chess.SpaceNum.rawValue
                } else if (LastMap2Val == 7 ) { //Left Castling
                    
                    Color1 = data.Map1[I - 2][J];
                    data.Map1[I + 1][J] = Color1;
                    data.Map1[I - 2][J] = Chess.SpaceNum.rawValue
                    
                    I1 = 3;
                    data.UndoX[I1 + 0][0][data.UndoIndex - 1] = I - 2;
                    data.UndoX[I1 + 1][0][data.UndoIndex - 1] = J;
                    data.UndoX[I1 + 2][0][data.UndoIndex - 1] = Color1;
                    data.UndoX[I1 + 0][1][data.UndoIndex - 1] = I + 1;
                    data.UndoX[I1 + 1][1][data.UndoIndex - 1] = J;
                    data.UndoX[I1 + 2][1][data.UndoIndex - 1] = Chess.SpaceNum.rawValue
                };
                data.PieceA1[2].X = I;
                data.PieceA1[2].Y = J;
                data.PieceA1[2].Level = data.Map1[I][J];
                data.PieceA1[1].X = data.PieceA1[0].X;
                data.PieceA1[1].Y = data.PieceA1[0].Y;
                data.PieceA1[1].Level = data.Map1[I][J];
                
                data.Map2[I][J] = 0;
                
                status.PreCastling();
            };
            
            data.PieceA1[0].X = I;
            data.PieceA1[0].Y = J;
            data.PieceA1[0].Level = data.Map1[I][J];
        };
    }
    
    func AIMoveOneStep(PathS:String )->Void {
        var I1 = 0
        var I2 = 0
        
        
        data.PieceA1[0].X = Int(PathS.mid(start: 1, length: 1))!
        data.PieceA1[0].Y = Int(PathS.mid(start: 2, length: 1))!
        data.PieceA1[0].Level = data.Map1[data.PieceA1[0].X][data.PieceA1[0].Y];
        
        self.AIPossibleMove(X: data.PieceA1[0].X, Y: data.PieceA1[0].Y);
        
        I1 = Int(PathS.mid(start: 3, length: 1))!
        I2 = Int(PathS.mid(start: 4, length: 1))!
        self.AIMouseUp(I: I1, J: I2);
        
        self.AIPsbMap2Cls();
    };
    
    func AIMoveOneStepV(X1:Int,Y1:Int,X2:Int,Y2:Int)->Void {
        
        data.PieceA1[0].X = X1;
        data.PieceA1[0].Y = Y1;
        data.PieceA1[0].Level = data.Map1[data.PieceA1[0].X][data.PieceA1[0].Y];
        self.AIPossibleMove(X: data.PieceA1[0].X, Y: data.PieceA1[0].Y);
        self.AIMouseUp(I: X2, J: Y2);
        
        self.AIPsbMap2Cls();
    };
    
    func AIMoveStrategy(OpponentColor:Int,PathS:String )->Void {
        var I = 0
        var Color1 = 0
        var X = 0
        var Y = 0
        var I1 = 0
        var I2 = 0
        var C = 0
        var X1C = 0
        var X2C = 0
        var X1I = 0
        var X2I = 0
        
        var AtkKing = 0
        
        C = 0;
        Color1 = 1 - OpponentColor;
        self.X1FPCal(Color1: OpponentColor, X1FPIndex: AiEnum.S0C0.rawValue);
        AtkKing = condition.IsCheckmate(Color1: Color1);
        
        X1C = data.X1Psb[AiEnum.S0C0.rawValue].PsbX1C - 1;
        
        if (X1C < 0 ) {
            
            data.AICb1.X1.X = Int(PathS.mid(start: 1, length: 1))!
            data.AICb1.X1.Y = Int(PathS.mid(start: 2, length: 1))!
            data.AICb1.X2.X = Int(PathS.mid(start: 3, length: 1))!
            data.AICb1.X2.Y = Int(PathS.mid(start: 4, length: 1))!
            data.AICb1.Value = data.PiecePow[0] * 100;
            
            I1 = self.AIAddChoice(IsSameColor: 0);
        } else {
            
            
            
            X1I = 0
            while ( X1I <= X1C ) {
                if (C == 1 ) {
                    break;
                };
                
                X = data.X1Psb[AiEnum.S0C0.rawValue].PsbX1[X1I].X;
                Y = data.X1Psb[AiEnum.S0C0.rawValue].PsbX1[X1I].Y;
                
                X2C = data.X1Psb[AiEnum.S0C0.rawValue].PsbX2C[X1I] - 1;
                X2I = 0
                while ( X2I <= X2C ) {
                    self.AIPossibleMove(X: X, Y: Y);
                    
                    data.PieceA1[0].X = X;
                    data.PieceA1[0].Y = Y;
                    data.PieceA1[0].Level = data.Map1[X][Y];
                    I1 = data.X1Psb[AiEnum.S0C0.rawValue].PsbX2[X1I][X2I].X;
                    I2 = data.X1Psb[AiEnum.S0C0.rawValue].PsbX2[X1I][X2I].Y;
                    
                    self.AIMouseUp(I: I1, J: I2);
                    self.AIPsbMap2Cls();
                    
                    self.X1FPCal(Color1: Color1, X1FPIndex: AiEnum.S1C0.rawValue);
                    self.X1FPCal(Color1: OpponentColor, X1FPIndex: AiEnum.S1C1.rawValue);
                    self.X1FPAddAtkPoint(Color1: Color1, X1FPIndex: AiEnum.S1C0A.rawValue);
                    self.X1FPAddAtkPoint(Color1: OpponentColor, X1FPIndex: AiEnum.S1C1A.rawValue);
                    self.X1FPUnequEx(Index: AiEnum.S1C0.rawValue, X1FPOpponentI: AiEnum.S1C1A.rawValue, UEEVIndex: 0);
                    self.X1FPUnequEx(Index: AiEnum.S1C1.rawValue, X1FPOpponentI: AiEnum.S1C0A.rawValue, UEEVIndex: 1);
                    
                    I = 0;
                    I1 = 0;
                    if (data.UEEV[0].V[0] > 0 ) {
                        I = data.UEEV[0].V[0];
                    };
                    if (data.UEEV[1].V[1] > 0 ) {
                        if ((data.UEEV[1].X[0] != data.UEEV[1].X[1] || data.UEEV[1].Y[0] != data.UEEV[1].Y[1]) ) {
                            I1 = data.UEEV[1].V[1];
                        } else if (data.X1Psb[AiEnum.S1C0A.rawValue].PointBeAtkC1[data.UEEV[1].X[0]][data.UEEV[1].Y[0]] == 0 ) {
                            I1 = data.UEEV[1].V[1];
                        } else if (data.UEEV[1].V[2] > 0 ) {
                            I1 = data.UEEV[1].V[2];
                        };
                    };
                    
                    data.AICb1.X1.X = Int(PathS.mid(start: 1, length: 1))!
                    data.AICb1.X1.Y = Int(PathS.mid(start: 2, length: 1))!
                    data.AICb1.X2.X = Int(PathS.mid(start: 3, length: 1))!
                    data.AICb1.X2.Y = Int(PathS.mid(start: 4, length: 1))!
                    
                    data.AICb1.Value = self.AIValCount(Color1: data.AIColor) + ((I - I1) * 100) + (AtkKing * 99);
                    //temptest;
                    //If PathS = "4757 " && data.X1Psb[AiEnum.S0C0.rawValue].PsbX2[X1I][X2I].X = 5 && data.X1Psb[AiEnum.S0C0.rawValue].PsbX2[X1I][X2I].Y = 6 Then;
                    // If PathS = "4757 " && data.AICb1.Value = 1460 Then;
                    // self.RefreshMap1()
                    // PathS = PathS;
                    // End If;
                    //temptest;
                    I1 = self.AIAddChoice(IsSameColor: 0);
                    
                    vc.PopUndo();
                    
                    X2I = X2I + 1
                };
                
                X1I = X1I + 1
            };
            
            
        }; //If X1C < 0 Then;
    };
    
    func AIExpandStep()->Void {
        var I = 0
        var Color1 = 0
        var Color2 = 0
        var X = 0
        var Y = 0
        var I1 = 0
        var I2 = 0
        var C = 0
        var C1 = 0
        var S2 = ""
        
        C = 0;
        Color1 = data.NowStep % 2;
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                
                if (C < 16 ) {
                    if (data.Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                        Color2 = data.Map1[X][Y] / 6;
                        if (Color1 == Color2 ) {
                            
                            data.MarkPsbMovC[Color1][0] = 0;
                            status.MarkPsbMov(X: X, Y: Y);
                            C1 = data.MarkPsbMovC[Color1][0];
                            I = 0
                            while ( I <= C1 - 1 ) {
                                data.AIPsbMovX[I] = data.MarkPsbMovX[I][Color1][0];
                                I = I + 1
                            };
                            
                            if (C1 > 0 ) {
                                self.AIPossibleMove(X: X, Y: Y);
                                I = 0
                                while ( I <= C1 - 1 ) {
                                    data.PieceA1[0].X = X;
                                    data.PieceA1[0].Y = Y;
                                    data.PieceA1[0].Level = data.Map1[X][Y];
                                    I1 = data.AIPsbMovX[I].X;
                                    I2 = data.AIPsbMovX[I].Y;
                                    self.AIMouseUp(I: I1, J: I2);
                                    
                                    
                                    if (data.AISearchListCount < Chess.BSTMax2.rawValue ) {
                                        
                                        if (condition.IsCheckmate(Color1: 1 - Color1) == 0 ) {
                                            S2 = String(format: "%d%d%d%d ", X, Y, data.AIPsbMovX[I].X, data.AIPsbMovX[I].Y)
                                            data.AICb1.X1.X = Int(S2.mid(start: 1, length: 1))!
                                            data.AICb1.X1.Y = Int(S2.mid(start: 2, length: 1))!
                                            data.AICb1.X2.X = Int(S2.mid(start: 3, length: 1))!
                                            data.AICb1.X2.Y = Int(S2.mid(start: 4, length: 1))!
                                            data.AICb1.Value = self.AIValCount(Color1: data.AIColor);
                                            
                                            if (Color1 == data.AIColor ) {
                                                I1 = self.AIAddChoice(IsSameColor: 1);
                                            } else {
                                                I1 = self.AIAddChoice(IsSameColor: 0);
                                            };
                                            
                                            I1 = 99999;
                                            I2 = data.NowStep;
                                            if (I2 < I1 ) {
                                                self.AISearchListAdd(S: S2);
                                            };
                                        };
                                    } else {
                                        C = 17;
                                        I = C1;
                                    };
                                    
                                    
                                    vc.PopUndo();
                                    
                                    I = I + 1
                                };
                            };
                            self.AIPsbMap2Cls();
                            
                            C = C + 1;
                        };
                    };
                } else {
                    break;
                };
                
                X = X + 1
            };
            Y = Y + 1
        };
    };
    
    func AIPsbMap2Cls()->Void {
        var I = 0
        var J = 0
        
        J = data.AIPsbM2.X1C - 1;
        I = 0
        while ( I <= J ) {
            data.Map2[data.AIPsbM2.X1[I].X][data.AIPsbM2.X1[I].Y] = 0;
            I = I + 1
        };
        data.AIPsbM2.X1C = 0;
    };
    
    
    func AIPossibleMove(X:Int,Y:Int)->Void {
        var L = 0
        var PawnD = 0
        var I = 0
        var QueenX = 0
        var QueenY = 0
        var QueenI1 = 0
        var QueenStep = 0
        var C = 0
        
        L = data.Map1[X][Y];
        
        if (L < Chess.SpaceNum.rawValue ) {
            
            C = L / 6;
            if (C == 0 ) {
                PawnD = 1;
            } else {
                PawnD = -1;
            };
            
            
            if (L % 6 == 0 ) {
                I = 0
                while ( I <= 7 ) {
                    if (condition.InCheckerBoard(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y) == 1 ) {
                        if (condition.IsSpaceSameColor(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y, Level1: L) != 1 ) {
                            
                            data.Map2[X + data.Direction8[I].X][Y + data.Direction8[I].Y] = 1;
                            self.AIPsbMap2Add(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y);
                            
                        };
                    };
                    I = I + 1
                };
                
                status.PreCastling();
                if (data.MovedFlag[0][C] == 0 ) {
                    
                    if (data.MovedFlag[2][C] == 0 ) {
                        I = 1
                        while ( I <= 2 ) {
                            if (data.Map1[X + I][Y] < 12 ) {
                                break;
                            };
                            I = I + 1
                        };
                        if (I == 3 ) {
                            QueenY = 1 - C;
                            I = 0
                            while ( I <= 2 ) {
                                if (data.PossibleAttackMap[X + I][Y][QueenY] == 1 ) {
                                    break;
                                };
                                I = I + 1
                            };
                            if (I == 3 ) {
                                data.Map2[X + 2][Y] = 6;
                                self.AIPsbMap2Add(X: X + 2, Y: Y);
                            };
                        };
                    };
                    
                    if (data.MovedFlag[1][C] == 0 ) {
                        I = 1
                        while ( I <= 3 ) {
                            if (data.Map1[X - I][Y] < 12 ) {
                                break;
                            };
                            I = I + 1
                        };
                        if (I == 4 ) {
                            QueenY = 1 - C;
                            I = 0
                            while ( I <= 2 ) {
                                if (data.PossibleAttackMap[X - I][Y][QueenY] == 1 ) {
                                    break;
                                };
                                I = I + 1
                            };
                            if (I == 3 ) {
                                data.Map2[X - 2][Y] = 7;
                                self.AIPsbMap2Add(X: X - 2, Y: Y);
                            };
                        };
                    };
                    
                };
            } else if (L % 6 >= 1 && L % 6 <= 3 ) {
                if (L % 6 == 1 ) {
                    QueenI1 = 0;
                    QueenStep = 1;
                } else if (L % 6 == 2 ) {
                    QueenI1 = 0;
                    QueenStep = 2;
                } else if (L % 6 == 3 ) {
                    QueenI1 = 1;
                    QueenStep = 2;
                };
                I = QueenI1
                while ( I <= 7 ) {
                    QueenX = X;
                    QueenY = Y;
                    while (condition.InCheckerBoard(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y) != 0) {
                        if (condition.IsSpaceSameColor(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, Level1: L) != 1 ) {
                            
                            data.Map2[QueenX + data.Direction8[I].X][QueenY + data.Direction8[I].Y] = 1;
                            self.AIPsbMap2Add(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y);
                            
                            if (condition.IsSpaceSameColor(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, Level1: L) == 2 ) {
                                QueenX = -9;
                            };
                            QueenX = QueenX + data.Direction8[I].X;
                            QueenY = QueenY + data.Direction8[I].Y;
                        } else {
                            QueenX = -9;
                        };
                    };
                    I =  I + QueenStep
                };
                
            } else if (L % 6 == 4 ) {
                I = 0
                while ( I <= 7 ) {
                    if (condition.InCheckerBoard(X: X + data.DirectionKnight8[I].X, Y: Y + data.DirectionKnight8[I].Y) == 1 ) {
                        if (condition.IsSpaceSameColor(X: X + data.DirectionKnight8[I].X, Y: Y + data.DirectionKnight8[I].Y, Level1: L) != 1 ) {
                            
                            data.Map2[X + data.DirectionKnight8[I].X][Y + data.DirectionKnight8[I].Y] = 1;
                            self.AIPsbMap2Add(X: X + data.DirectionKnight8[I].X, Y: Y + data.DirectionKnight8[I].Y);
                            
                        };
                    };
                    I = I + 1
                };
                
            } else if (L % 6 == 5 ) {
                if (condition.InCheckerBoard(X: X, Y: Y + PawnD) == 1 ) {
                    if (condition.IsSpaceSameColor(X: X, Y: Y + PawnD, Level1: L) == 0 ) {
                        data.Map2[X][Y + PawnD] = 1;
                        self.AIPsbMap2Add(X: X, Y: Y + PawnD);
                        if ((Y + PawnD == 0 || Y + PawnD == Chess.CheckerBoardGrid.rawValue - 1) ) { //Queening
                            data.Map2[X][Y + PawnD] = 5;
                            self.AIPsbMap2Add(X: X, Y: Y + PawnD);
                        };
                        if ((C == 1 && Y == 6) || (C == 0 && Y == 1) ) {
                            if (condition.IsSpaceSameColor(X: X, Y: Y + PawnD + PawnD, Level1: L) == 0 ) {
                                data.Map2[X][Y + PawnD + PawnD] = 2;
                                self.AIPsbMap2Add(X: X, Y: Y + PawnD + PawnD);
                            };
                        };
                    };
                };
                
                I = -1
                while ( I <= 1  ) {
                    if (condition.InCheckerBoard(X: X + I, Y: Y + PawnD) == 1 ) {
                        if (condition.IsSpaceSameColor(X: X + I, Y: Y + PawnD, Level1: L) == 2 ) {
                            data.Map2[X + I][Y + PawnD] = 1;
                            self.AIPsbMap2Add(X: X + I, Y: Y + PawnD);
                            if ((Y + PawnD == 0 || Y + PawnD == Chess.CheckerBoardGrid.rawValue - 1) ) { //Queening
                                data.Map2[X + I][Y + PawnD] = 5;
                                self.AIPsbMap2Add(X: X + I, Y: Y + PawnD);
                            };
                        } else if (data.PassantB == 1 ) {
                            if (X + I == data.PassantX && Y + PawnD == data.PassantY ) {
                                if ((C == 1 && data.PassantY == 2) || (C == 0 && data.PassantY == 5) ) {
                                    data.Map2[X + I][Y + PawnD] = 3; //Passant
                                    self.AIPsbMap2Add(X: X + I, Y: Y + PawnD);
                                };
                            };
                        };
                    };
                    I =  I + 2
                };
            };
            
        };
    };
    
    func AIAddChoice(IsSameColor:Int)->Int {
        var I = 0
        var J = 0
        var K = 0
        var RefreshV = 0
        var TempC = CoordinateByte3()
        
        RefreshV = 0;
        I = 0
        while ( I <= data.AIChoiceC - 1 ) {
            if (data.AICb1.X1.X == data.AIChoice[I].X1.X && data.AICb1.X1.Y == data.AIChoice[I].X1.Y && data.AICb1.X2.X == data.AIChoice[I].X2.X && data.AICb1.X2.Y == data.AIChoice[I].X2.Y ) {
                if (IsSameColor == 0 && data.AICb1.Value < data.AIChoice[I].Value ) {
                    RefreshV = 1;
                } else if (IsSameColor == 1 && data.AICb1.Value > data.AIChoice[I].Value ) {
                    RefreshV = 1;
                } else {
                    RefreshV = 2;
                    
                    return -1;
                };
                break;
            };
            I = I + 1
        };
        
        if (RefreshV == 0 ) {
            I = 0
            while ( I <= data.AIChoiceC - 1 ) {
                if (data.AICb1.Value > data.AIChoice[I].Value ) {
                    break;
                };
                I =   I + 1
            };
            
            data.AIChoiceC = data.AIChoiceC + 1;
            if (Chess.AIChoiceMax.rawValue <= data.AIChoiceC ) {
                data.AIChoiceC = Chess.AIChoiceMax.rawValue - 1;
            };
            J = data.AIChoiceC - 1
            while ( J >= I + 1  ) {
                data.AIChoice[J] = data.AIChoice[J - 1];
                J =  J - 1
            };
            data.AIChoice[I] = data.AICb1;
            
            return I;
        } else if (RefreshV == 1 ) {
            data.AIChoice[I].Value = data.AICb1.Value;
            
            K = I;
            J = K
            while ( J >= 1  ) {
                if (data.AIChoice[J].Value > data.AIChoice[J - 1].Value ) {
                    TempC = data.AIChoice[J];
                    data.AIChoice[J] = data.AIChoice[J - 1];
                    data.AIChoice[J - 1] = TempC;
                } else {
                    break;
                };
                J =  J-1
            }
            K = J;
            
            J = K
            while ( J <= data.AIChoiceC - 2 ) {
                if (data.AIChoice[J].Value < data.AIChoice[J + 1].Value ) {
                    TempC = data.AIChoice[J];
                    data.AIChoice[J] = data.AIChoice[J + 1];
                    data.AIChoice[J + 1] = TempC;
                } else {
                    break;
                };
                J = J + 1
            };
            
            return J;
        };
        
        return 0;
    };
    
    func AIValPsbMov(Color1:Int)->Int {
        var C = 0
        var X = 0
        var Y = 0
        
        C = 0;
        data.MarkPsbMovC[0][0] = 0;
        data.MarkPsbMovC[1][0] = 0;
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                
                if (C < 32 ) {
                    if (data.Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                        status.MarkPsbMov(X: X, Y: Y);
                        C = C + 1;
                    };
                };
                
                X = X + 1
            };
            
            Y = Y + 1
        };
        
        if (Color1 == 0 ) {
            return data.MarkPsbMovC[0][0] - data.MarkPsbMovC[1][0];
        } else {
            return -(data.MarkPsbMovC[0][0] - data.MarkPsbMovC[1][0]);
        };
    };
    
    func AIValPow(Color1:Int)->Int {
        var C = 0
        var C1 = 0
        var X = 0
        var Y = 0
        var P1 = [0, 0]
        
        C = 0;
        P1[0] = 0;
        P1[1] = 0;
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                
                if (C < 32 ) {
                    if (data.Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                        C1 = data.Map1[X][Y] / 6;
                        
                        P1[C1] = P1[C1] + self.PiecePowF(X: X, Y: Y);
                        C = C + 1;
                    };
                };
                
                X = X + 1
            };
            
            Y = Y + 1
        };
        
        
        if (Color1 == 1 ) {
            return -(P1[0] - P1[1]);
        } else {
            return P1[0] - P1[1];
        }
    };
    
    func X1FPIni(Index:Int)->Void {
        var I = 0
        var J = 0
        var K = 0
        
        data.X1Psb[Index].PsbX1C = data.X1Psb[Index].PsbX1C - 1;
        I = 0
        while ( I <= data.X1Psb[Index].PsbX1C ) {
            K = data.X1Psb[Index].PsbX2C[I] - 1;
            J = 0
            while ( J <= K ) {
                data.X1Psb[Index].PointBeAtkC1[data.X1Psb[Index].PsbX2[I][J].X][data.X1Psb[Index].PsbX2[I][J].Y] = 0;
                J = J + 1
            };
            I = I + 1
        };
        data.X1Psb[Index].PsbX1C = 0;
    };
    
    func X1FPCreat(Index:Int,X1:Int,Y1:Int,X2:Int,Y2:Int)->Int {
        var X1C = 0
        
        X1C = data.X1Psb[Index].PsbX1C;
        data.X1Psb[Index].PsbX1[X1C].X = X1;
        data.X1Psb[Index].PsbX1[X1C].Y = Y1;
        
        data.X1Psb[Index].PsbX2C[X1C] = 0;
        self.X1FPAdd(Index: Index, X1C: X1C, X2: X2, Y2: Y2);
        
        data.X1Psb[Index].PsbX1C = X1C + 1;
        if (data.X1Psb[Index].PsbX1C > 16 ) {
            data.X1Psb[Index].PsbX1C = 16;
            return -1;
        } else {
            return data.X1Psb[Index].PsbX1C - 1;
        };
    };
    
    func X1FPCal(Color1:Int,X1FPIndex:Int)->Void {
        var I = 0
        var Color2 = 0
        var X = 0
        var Y = 0
        var I1 = 0
        var I2 = 0
        var C = 0
        var C1 = 0
        var BX1 = 0
        var BX2 = 0
        var X1C = 0
        
        self.X1FPIni(Index: X1FPIndex);
        
        C = 0;
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                
                if (C < 16 ) {
                    if (data.Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                        Color2 = data.Map1[X][Y] / 6;
                        if (Color1 == Color2 ) {
                            
                            data.MarkPsbMovC[Color1][0] = 0;
                            status.MarkPsbMov(X: X, Y: Y);
                            C1 = data.MarkPsbMovC[Color1][0];
                            I = 0
                            while ( I <= C1 - 1 ) {
                                data.AIPsbMovX[I] = data.MarkPsbMovX[I][Color1][0];
                                I = I + 1
                            };
                            
                            if (C1 > 0 ) {
                                self.AIPossibleMove(X: X, Y: Y);
                                
                                X1C = -1;
                                I = 0
                                while ( I <= C1 - 1 ) {
                                    data.PieceA1[0].X = X;
                                    data.PieceA1[0].Y = Y;
                                    data.PieceA1[0].Level = data.Map1[X][Y];
                                    I1 = data.AIPsbMovX[I].X;
                                    I2 = data.AIPsbMovX[I].Y;
                                    self.AIMouseUp(I: I1, J: I2);
                                    
                                    if (condition.IsCheckmate(Color1: 1 - Color1) == 0 ) {
                                        if (X1C == -1 ) {
                                            BX1 = X;
                                            BX2 = Y;
                                            X1C = self.X1FPCreat(Index: X1FPIndex, X1: BX1, Y1: BX2, X2: data.AIPsbMovX[I].X, Y2: data.AIPsbMovX[I].Y);
                                        } else {
                                            self.X1FPAdd(Index: X1FPIndex, X1C: X1C, X2: data.AIPsbMovX[I].X, Y2: data.AIPsbMovX[I].Y);
                                        };
                                    };
                                    vc.PopUndo();
                                    
                                    I = I + 1
                                };
                                self.AIPsbMap2Cls();
                                
                            };
                            
                            C = C + 1;
                        };
                    };
                } else {
                    break;
                };
                
                X = X + 1
            };
            Y =   Y + 1
        };
    };
    
    func X1FPAddAtkPoint(Color1:Int,X1FPIndex:Int)->Void {
        var I = 0
        var Color2 = 0
        var X = 0
        var Y = 0
        var C = 0
        var C1 = 0
        var BX1 = 0
        var BX2 = 0
        var X1C = 0
        
        self.X1FPIni(Index: X1FPIndex);
        
        C = 0;
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                
                if (C < 16 ) {
                    if (data.Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                        Color2 = data.Map1[X][Y] / 6;
                        if (Color1 == Color2 ) {
                            
                            data.MarkPsbMovC[Color1][1] = 0;
                            status.MarkPsbAtk(X: X, Y: Y, Color1: Color1);
                            C1 = data.MarkPsbMovC[Color1][1];
                            I = 0
                            while ( I <= C1 - 1 ) {
                                data.AIPsbMovX[I] = data.MarkPsbMovX[I][Color1][1];
                                I = I + 1
                            };
                            
                            if (C1 > 0 ) {
                                
                                BX1 = X;
                                BX2 = Y;
                                X1C = self.X1FPCreat(Index: X1FPIndex, X1: BX1, Y1: BX2, X2: data.AIPsbMovX[0].X, Y2: data.AIPsbMovX[0].Y);
                                I = 1
                                while ( I <= C1 - 1 ) {
                                    self.X1FPAdd(Index: X1FPIndex, X1C: X1C, X2: data.AIPsbMovX[I].X, Y2: data.AIPsbMovX[I].Y);
                                    I = I + 1
                                };
                                
                            };
                            
                            C = C + 1;
                        };
                    };
                } else {
                    break;
                };
                
                X = X + 1
            };
            
            Y = Y + 1
        };
    };
    
    func X1FPQueenUnEquEx(Index:Int,X1FPOpponentI:Int,UEEVIndex:Int,X1I:Int)->Void {
        var L = 0
        var LMod6 = 0
        var I = 0
        var QueenX = 0
        var QueenY = 0
        var QueenI1 = 0
        var QueenStep = 0
        var I1 = 0
        var I2 = 0
        var C = 0
        
        var X = 0
        var Y = 0
        var TempMinV = 0
        var TempUEEVal = 0
        
        X = data.X1Psb[Index].PsbX1[X1I].X;
        Y = data.X1Psb[Index].PsbX1[X1I].Y;
        L = data.Map1[X][Y];
        LMod6 = L % 6;
        
        
        if (L < Chess.SpaceNum.rawValue && LMod6 >= 1 && LMod6 <= 3 ) {
            if (LMod6 == 1 ) {
                QueenI1 = 0;
                QueenStep = 1;
            } else if (LMod6 == 2 ) {
                QueenI1 = 0;
                QueenStep = 2;
            } else if (LMod6 == 3 ) {
                QueenI1 = 1;
                QueenStep = 2;
            };
            I = QueenI1
            while ( I <= 7 ) {
                QueenX = X + data.Direction8[I].X;
                QueenY = Y + data.Direction8[I].Y;
                C = 0;
                
                while (condition.InCheckerBoard(X: QueenX, Y: QueenY) != 0) {
                    if (condition.IsSpaceSameColor(X: QueenX, Y: QueenY, Level1: L) != 1 ) {
                        
                        if (condition.IsSpaceSameColor(X: QueenX, Y: QueenY, Level1: L) == 2 ) {
                            
                            TempUEEVal = self.UEESub(X1: X, Y1: Y, X2: QueenX, Y2: QueenY, IsX2BeAtkC1: data.X1Psb[X1FPOpponentI].PointBeAtkC1[QueenX][QueenY]);
                            if (TempUEEVal >= 0 ) {
                                C = C + 1;
                            } else {
                                QueenX = -9;
                            };
                            
                            if (C == 1 ) {
                                I2 = data.X1Psb[Index].PsbX2C[X1I] - 1;
                                I1 = 0
                                while ( I1 <= I2 ) {
                                    if (QueenX == data.X1Psb[Index].PsbX2[X1I][I1].X && QueenY == data.X1Psb[Index].PsbX2[X1I][I1].Y ) {
                                        break;
                                    };
                                    I1 = I1 + 1
                                };
                                if (I1 <= I2 ) {
                                    TempMinV = TempUEEVal;
                                } else {
                                    QueenX = -9;
                                };
                            } else if (C >= 2 ) {
                                QueenX = -9;
                                
                                if (TempUEEVal < TempMinV ) {
                                    self.UEEVAdd(Index: UEEVIndex, X: X, Y: Y, V: TempUEEVal);
                                };
                                //self.UEEVAdd(Index: UEEVIndex, X: X, Y: Y, V: TempMinV);
                            };
                        };
                        QueenX = QueenX + data.Direction8[I].X;
                        QueenY = QueenY + data.Direction8[I].Y;
                    } else {
                        QueenX = -9;
                    };
                };
                
                I = I + QueenStep
            };
            
        }; //If L < Chess.SpaceNum.rawValue && LMod6 >= 1 && LMod6 <= 3 Then
        
    };
    
    
    func AIPsbMap2Add(X:Int,Y:Int)->Void {
        var X1C = 0
        
        X1C = data.AIPsbM2.X1C;
        
        data.AIPsbM2.X1[X1C].X = X;
        data.AIPsbM2.X1[X1C].Y = Y;
        data.AIPsbM2.X1C = X1C + 1;
    };
    
    func X1FPUnequEx(Index:Int,X1FPOpponentI:Int,UEEVIndex:Int)->Void {
        var L = 0
        var I = 0
        var X1 = 0
        var Y1 = 0
        var X2 = 0
        var Y2 = 0
        var I2 = 0
        
        var X1I = 0
        var X1C = 0
        var TempUEEVal = 0
        
        self.UEEVIni(Index: UEEVIndex);
        
        X1C = data.X1Psb[Index].PsbX1C - 1;
        X1I = 0
        while ( X1I <= X1C ) {
            X1 = data.X1Psb[Index].PsbX1[X1I].X;
            Y1 = data.X1Psb[Index].PsbX1[X1I].Y;
            L = data.Map1[X1][Y1];
            
            I2 = data.X1Psb[Index].PsbX2C[X1I] - 1;
            I = 0
            while ( I <= I2 ) {
                
                X2 = data.X1Psb[Index].PsbX2[X1I][I].X;
                Y2 = data.X1Psb[Index].PsbX2[X1I][I].Y;
                if (condition.IsSpaceSameColor(X: X2, Y: Y2, Level1: L) == 2 ) {
                    
                    TempUEEVal = self.UEESub(X1: X1, Y1: Y1, X2: X2, Y2: Y2, IsX2BeAtkC1: data.X1Psb[X1FPOpponentI].PointBeAtkC1[X2][Y2]);
                    self.UEEVAdd(Index: UEEVIndex, X: X1, Y: Y1, V: TempUEEVal);
                    
                };
                I = I + 1
            };
            self.X1FPQueenUnEquEx(Index: Index, X1FPOpponentI: X1FPOpponentI, UEEVIndex: UEEVIndex, X1I: X1I);
            
            X1I = X1I + 1
        };
    };
    
    func AIValCount(Color1:Int)->Int {
        var I = 0
        var Sum = 0
        
        Sum = self.AIValPsbMov(Color1: Color1);
        Sum = Sum +  50;
        if (Sum > 99 ) {
            return 99;
        } else if (Sum < 0 ) {
            return 0;
        };
        
        I = self.AIValPow(Color1: Color1);
        return Sum + (I * 100);
        //return [I * 100];
    };
    
    func X1FPAdd(Index:Int,X1C:Int,X2:Int,Y2:Int)->Void {
        var X2C = 0
        var PC1 = 0
        
        X2C = data.X1Psb[Index].PsbX2C[X1C];
        data.X1Psb[Index].PsbX2[X1C][X2C].X = X2;
        data.X1Psb[Index].PsbX2[X1C][X2C].Y = Y2;
        data.X1Psb[Index].PsbX2C[X1C] = X2C + 1;
        
        PC1 = data.X1Psb[Index].PointBeAtkC1[X2][Y2];
        data.X1Psb[Index].PointBeAtk[X2][Y2][PC1].X = data.X1Psb[Index].PsbX1[X1C].X;
        data.X1Psb[Index].PointBeAtk[X2][Y2][PC1].Y = data.X1Psb[Index].PsbX1[X1C].Y;
        data.X1Psb[Index].PointBeAtkC1[X2][Y2] = PC1 + 1;
    };
    
    func PiecePowF(X:Int,Y:Int)->Int {
        var L = 0
        var LMod6 = 0
        
        L = data.Map1[X][Y];
        LMod6 = L % 6;
        if (LMod6 < 5 ) {
            return data.PiecePow[LMod6];
        } else {
            if (L / 6 == 0 ) {
                return Y;
            } else {
                return 7 - Y;
            };
        };
    };
    
    func UEEVIni(Index:Int)->Void {
        var J = 0
        while ( J <= 2 ) {
            data.UEEV[Index].V[J] = -data.PiecePow[0];
            J = J + 1
        };
    };
    
    func UEESub(X1:Int,Y1:Int,X2:Int,Y2:Int,IsX2BeAtkC1:Int)->Int {
        
        if (IsX2BeAtkC1 == 0 ) {
            return self.PiecePowF(X: X2, Y: Y2);
        } else {
            return self.PiecePowF(X: X2, Y: Y2) - self.PiecePowF(X: X1, Y: Y1)
        };
    };
    
    func UEEVAdd(Index:Int,X:Int,Y:Int,V:Int)->Void {
        var TempX = 0
        var TempY = 0
        var TempV = 0
        var TempX2 = 0
        var TempY2 = 0
        var TempV2 = 0
        
        TempX = X;
        TempY = Y;
        TempV = V;
        if (TempV > data.UEEV[Index].V[0] ) {
            TempX2 = TempX;
            TempY2 = TempY;
            TempV2 = TempV;
            
            TempX = data.UEEV[Index].X[0];
            TempY = data.UEEV[Index].Y[0];
            TempV = data.UEEV[Index].V[0];
            
            data.UEEV[Index].V[0] = TempV2;
            data.UEEV[Index].X[0] = TempX2;
            data.UEEV[Index].Y[0] = TempY2;
        };
        if (TempV > data.UEEV[Index].V[1] ) {
            TempX2 = TempX;
            TempY2 = TempY;
            TempV2 = TempV;
            
            TempX = data.UEEV[Index].X[1];
            TempY = data.UEEV[Index].Y[1];
            TempV = data.UEEV[Index].V[1];
            
            data.UEEV[Index].V[1] = TempV2;
            data.UEEV[Index].X[1] = TempX2;
            data.UEEV[Index].Y[1] = TempY2;
        };
        if (TempV > data.UEEV[Index].V[2] && (TempX != data.UEEV[Index].X[0] || TempY != data.UEEV[Index].Y[0]) ) {
            TempX2 = TempX;
            TempY2 = TempY;
            TempV2 = TempV;
            
            TempX = data.UEEV[Index].X[2];
            TempY = data.UEEV[Index].Y[2];
            TempV = data.UEEV[Index].V[2];
            
            data.UEEV[Index].V[2] = TempV2;
            data.UEEV[Index].X[2] = TempX2;
            data.UEEV[Index].Y[2] = TempY2;
        };
    };
}

