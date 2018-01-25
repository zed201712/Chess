//
//  chessStatus.swift
//  ChessForSwift
//
//  Created by 游聖傑 on 2018/1/24.
//  Copyright © 2018年 Zed. All rights reserved.
//

import Foundation
import UIKit

class chessStatus: NSObject {
    var condition: chessCondition!
    var vc: ViewController!
    var data: chessData!
    
    //FlagPsbMoveOrCls;
    //0 Disable;
    //1 PsbMove;
    //2 Cls;
    
    //Change Map2 Value;
    
    //Refresh CheckerBoard;
    func PossibleMove(PieceIndex: Int, FlagPsbMoveOrCls: Int, X: Int, Y: Int)->Void {
        var L = 0
        var PawnD = 0
        var I = 0
        var QueenX = 0
        var QueenY = 0
        var QueenI1 = 0
        var QueenStep = 0
        var C = 0
        
//        if (FlagPsbMoveOrCls == 1 ) {
//            self.Etest()
//        };
        
        self.PreCastling();
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
                    if (condition.InCheckerBoard(X: X + data.Direction8[I].X, Y: Y + Int(data.Direction8[I].Y)) == 1 ) {
                        if (condition.IsSpaceSameColor(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y, Level1: L) != 1 ) {
                            
                            vc.MoveOrCls(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                            
                        };
                    };
                    I = I + 1
                };
                
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
                            while (  I <= 2 ) {
                                if (data.PossibleAttackMap[X + I][Y][QueenY] == 1 ) {
                                    break;
                                };
                                I = I + 1
                            };
                            if (I == 3 ) {
                                if (FlagPsbMoveOrCls == 1 ) {
                                    vc.DrawMoveGrid(X: X + 2, Y: Y);
                                    data.Map2[X + 2][Y] = 6;
                                } else if (FlagPsbMoveOrCls == 2 ) {
                                    vc.DrawGrid(X: X + 2, Y: Y);
                                    data.Map2[X + 2][Y] = 0;
                                };
                            };
                        };
                    };
                    
                    if (data.MovedFlag[1][C] == 0 ) {
                        I = 1
                        while (  I <= 3 ) {
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
                                if (FlagPsbMoveOrCls == 1 ) {
                                    vc.DrawMoveGrid(X: X - 2, Y: Y);
                                    data.Map2[X - 2][Y] = 7;
                                } else if (FlagPsbMoveOrCls == 2 ) {
                                    vc.DrawGrid(X: X - 2, Y: Y);
                                    data.Map2[X - 2][Y] = 0;
                                };
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
                while ( I <= 7  ) {
                    QueenX = X;
                    QueenY = Y;
                    while (condition.InCheckerBoard(X: QueenX + data.Direction8[I].X, Y: QueenY + Int(data.Direction8[I].Y)) != 0) {
                        if (condition.IsSpaceSameColor(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, Level1: L) != 1 ) {
                            
                            vc.MoveOrCls(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                            
                            if (condition.IsSpaceSameColor(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, Level1: L) == 2 ) {
                                QueenX = -9;
                            };
                            QueenX = QueenX + Int(data.Direction8[I].X);
                            QueenY = QueenY + Int(data.Direction8[I].Y);
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
                            
                            vc.MoveOrCls(X: X + data.DirectionKnight8[I].X, Y: Y + data.DirectionKnight8[I].Y, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                            
                        };
                    };
                    I = I + 1
                };
                
            } else if (L % 6 == 5 ) {
                if (condition.InCheckerBoard(X: X, Y: Y + PawnD) == 1 ) {
                    if (condition.IsSpaceSameColor(X: X, Y: Y + PawnD, Level1: L) == 0 ) {
                        vc.MoveOrCls(X: X, Y: Y + PawnD, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                        if ((Y + PawnD == 0 || Y + PawnD == Chess.CheckerBoardGrid.rawValue - 1) && FlagPsbMoveOrCls == 1 ) { //Queening
                            data.Map2[X][Y + PawnD] = 5;
                        };
                        if ((C == 1 && Y == 6) || (C == 0 && Y == 1) ) {
                            if (condition.IsSpaceSameColor(X: X, Y: Y + PawnD + PawnD, Level1: L) == 0 ) {
                                vc.MoveOrCls(X: X, Y: Y + PawnD + PawnD, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                                if (FlagPsbMoveOrCls == 1 ) {
                                    data.Map2[X][Y + PawnD + PawnD] = 2; //Passant
                                };
                            };
                        };
                    };
                };
                
                I = -1
                while (  I <= 1  ) {
                    if (condition.InCheckerBoard(X: X + I, Y: Y + PawnD) == 1 ) {
                        if (condition.IsSpaceSameColor(X: X + I, Y: Y + PawnD, Level1: L) == 2 ) {
                            vc.MoveOrCls(X: X + I, Y: Y + PawnD, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                            if ((Y + PawnD == 0 || Y + PawnD == Chess.CheckerBoardGrid.rawValue - 1) && FlagPsbMoveOrCls == 1 ) { //Queening
                                data.Map2[X + I][Y + PawnD] = 5;
                            };
                        } else if (data.PassantB == 1 ) {
                            if (X + I == data.PassantX && Y + PawnD == data.PassantY ) {
                                if ((C == 1 && data.PassantY == 2) || (C == 0 && data.PassantY == 5) ) {
                                    vc.MoveOrCls(X: X + I, Y: Y + PawnD, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                                    if (FlagPsbMoveOrCls == 1 ) {
                                        data.Map2[X + I][Y + PawnD] = 3; //Passant
                                    }
                                }
                            }
                        }
                    }
                    I = I + 2
                }
            }
            
        }
    }
    
    func PossibleAttack(Color1:Int)->Void {
        var X = 0
        var Y = 0
        var L = 0
        var I = 0
        var QueenX = 0
        var QueenY = 0
        var QueenI1 = 0
        var QueenStep = 0
        var C = 0
        
        
        X = 0
        while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            Y = 0
            while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                data.PossibleAttackMap[X][Y][Color1] = 0;
                Y = Y + 1
            };
            X = X + 1
        };
        
        
        X = 0
        while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            Y = 0
            while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                if (data.Map1[X][Y] < 12 ) {
                    
                    L = data.Map1[X][Y];
                    C = L / 6;
                    if (C == Color1 ) {
                        
                        if (L % 6 == 0 ) {
                            I = 0
                            while ( I <= 7 ) {
                                if (condition.InCheckerBoard(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y) == 1 ) {
                                    if (condition.IsSpaceSameColor(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y, Level1: L) != 1 ) {
                                        
                                        data.PossibleAttackMap[X + data.Direction8[I].X][Y + data.Direction8[I].Y][Color1] = 1;
                                        
                                    };
                                };
                                I = I + 1
                            };
                            
                        } else if (L % 6 >= 1 && L % 6 <= 3 ) {
                            QueenI1 = 0;
                            QueenStep = 0;
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
                            while ( I <= 7  ) {
                                QueenX = X;
                                QueenY = Y;
                                while (condition.InCheckerBoard(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y) != 0) {
                                    if (condition.IsSpaceSameColor(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, Level1: L) != 1 ) {
                                        
                                        data.PossibleAttackMap[QueenX + data.Direction8[I].X][QueenY + data.Direction8[I].Y][Color1] = 1;
                                        
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
                                        
                                        data.PossibleAttackMap[X + data.DirectionKnight8[I].X][Y + data.DirectionKnight8[I].Y][Color1] = 1;
                                        
                                    };
                                };
                                I = I + 1
                            };
                            
                        };
                        
                    };
                    
                    
                };
                Y = Y + 1
            };
            X = X + 1
        };
        
    };
    
    func PreCastling()->Void {
        if (data.MovedFlag[0][0] == 0 && (data.MovedFlag[1][0] == 0 || data.MovedFlag[2][0] == 0) ) {
            self.PossibleAttack(Color1: 1);
        };
        if (data.MovedFlag[0][1] == 0 && (data.MovedFlag[1][1] == 0 || data.MovedFlag[2][1] == 0) ) {
            self.PossibleAttack(Color1: 0);
        };
    };
    
    
    func AddMarkPsb(X:Int,Y:Int,Color1:Int,Index:Int)->Void {
        var I = 0
        
        I = 0
        while ( I <= data.MarkPsbMovC[Color1][Index] - 1 ) {
            if (data.MarkPsbMovX[I][Color1][Index].X == X && data.MarkPsbMovX[I][Color1][Index].Y == Y ) {
                data.MarkPsbMovX[I][Color1][Index].Counter = data.MarkPsbMovX[I][Color1][Index].Counter + 1;
                break;
            };
            I = I + 1
        };
        if (data.MarkPsbMovC[Color1][Index] == I ) {
            data.MarkPsbMovX[data.MarkPsbMovC[Color1][Index]][Color1][Index].X = X;
            data.MarkPsbMovX[data.MarkPsbMovC[Color1][Index]][Color1][Index].Y = Y;
            data.MarkPsbMovX[data.MarkPsbMovC[Color1][Index]][Color1][Index].Counter = 1;
            
            data.MarkPsbMovC[Color1][Index] = data.MarkPsbMovC[Color1][Index] + 1;
        };
    };
    
    func MarkPsbAtk(X:Int,Y:Int,Color1:Int)->Void {
        var L = 0
        var PawnD = 0
        var I = 0
        var QueenX = 0
        var QueenY = 0
        var QueenI1 = 0
        var QueenStep = 0
        var C = 0
        
        if (data.Map1[X][Y] < Chess.SpaceNum.rawValue ) {
            
            L = data.Map1[X][Y];
            C = L / 6;
            if (C == Color1 ) {
                
                
                if (C == 0 ) {
                    PawnD = 1;
                } else {
                    PawnD = -1;
                };
                
                if (L % 6 == 0 ) {
                    I = 0
                    while ( I <= 7 ) {
                        if (condition.InCheckerBoard(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y) == 1 ) {
                            //If condition.IsSpaceSameColor(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y, Level1: L) != 1 Then;
                            
                            self.AddMarkPsb(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y, Color1: Color1, Index: 1);
                            
                            //End If;
                        };
                        I = I + 1
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
                            self.AddMarkPsb(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, Color1: Color1, Index: 1);
                            if (condition.IsSpaceSameColor(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, Level1: L) != 1 ) {
                                
                                if (condition.IsSpaceSameColor(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, Level1: L) == 2 ) {
                                    QueenX = -9;
                                };
                                QueenX = QueenX + data.Direction8[I].X;
                                QueenY = QueenY + data.Direction8[I].Y;
                            } else {
                                QueenX = -9;
                            };
                        };
                        
                        I = I + QueenStep
                    };
                    
                } else if (L % 6 == 4 ) {
                    I = 0
                    while ( I <= 7 ) {
                        if (condition.InCheckerBoard(X: X + data.DirectionKnight8[I].X, Y: Y + data.DirectionKnight8[I].Y) == 1 ) {
                            //If condition.IsSpaceSameColor(X: X + data.DirectionKnight8[I].X, Y: Y + data.DirectionKnight8[I].Y, Level1: L) != 1 Then;
                            
                            self.AddMarkPsb(X: X + data.DirectionKnight8[I].X, Y: Y + data.DirectionKnight8[I].Y, Color1: Color1, Index: 1);
                            
                            //End If;
                        };
                        
                        I = I + 1
                    };
                    
                } else if (L % 6 == 5 ) {
                    I = -1
                    while ( I <= 1 ) {
                        if (condition.InCheckerBoard(X: X + I, Y: Y + PawnD) == 1 ) {
                            self.AddMarkPsb(X: X + I, Y: Y + PawnD, Color1: Color1, Index: 1);
                        };
                        
                        I = I + 2
                    };
                    
                };
                
            };
            
            
        };
    };
    
    func MarkPsbMov(X:Int,Y:Int)->Void {
        var L = 0
        var PawnD = 0
        var I = 0
        var QueenX = 0
        var QueenY = 0
        var QueenI1 = 0
        var QueenStep = 0
        var C = 0
        var Color1 = 0
        
        L = data.Map1[X][Y];
        C = L / 6;
        Color1 = C;
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
                        
                        self.AddMarkPsb(X: X + data.Direction8[I].X, Y: Y + data.Direction8[I].Y, Color1: Color1, Index: 0);
                        
                    };
                };
                
                I = I + 1
            };
            
            self.PreCastling();
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
                            self.AddMarkPsb(X: X + 2, Y: Y, Color1: Color1, Index: 0);
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
                            self.AddMarkPsb(X: X - 2, Y: Y, Color1: Color1, Index: 0);
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
                        
                        self.AddMarkPsb(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, Color1: Color1, Index: 0);
                        
                        if (condition.IsSpaceSameColor(X: QueenX + data.Direction8[I].X, Y: QueenY + data.Direction8[I].Y, Level1: L) == 2 ) {
                            QueenX = -9;
                        };
                        QueenX = QueenX + data.Direction8[I].X;
                        QueenY = QueenY + data.Direction8[I].Y;
                    } else {
                        QueenX = -9;
                    };
                };
                I = I + QueenStep
            };
            
        } else if (L % 6 == 4 ) {
            I = 0
            while ( I <= 7 ) {
                if (condition.InCheckerBoard(X: X + data.DirectionKnight8[I].X, Y: Y + data.DirectionKnight8[I].Y) == 1 ) {
                    if (condition.IsSpaceSameColor(X: X + data.DirectionKnight8[I].X, Y: Y + data.DirectionKnight8[I].Y, Level1: L) != 1 ) {
                        
                        self.AddMarkPsb(X: X + data.DirectionKnight8[I].X, Y: Y + data.DirectionKnight8[I].Y, Color1: Color1, Index: 0);
                        
                    };
                };
                
                I = I + 1
            };
            
        } else if (L % 6 == 5 ) {
            if (condition.InCheckerBoard(X: X, Y: Y + PawnD) == 1 ) {
                if (condition.IsSpaceSameColor(X: X, Y: Y + PawnD, Level1: L) == 0 ) {
                    self.AddMarkPsb(X: X, Y: Y + PawnD, Color1: Color1, Index: 0);
                    if ((C == 1 && Y == 6) || (C == 0 && Y == 1) ) {
                        if (condition.IsSpaceSameColor(X: X, Y: Y + PawnD + PawnD, Level1: L) == 0 ) {
                            self.AddMarkPsb(X: X, Y: Y + PawnD + PawnD, Color1: Color1, Index: 0);
                        };
                    };
                };
            };
            
            I = -1
            while ( I <= 1 ) {
                if (condition.InCheckerBoard(X: X + I, Y: Y + PawnD) == 1 ) {
                    if (condition.IsSpaceSameColor(X: X + I, Y: Y + PawnD, Level1: L) == 2 ) {
                        self.AddMarkPsb(X: X + I, Y: Y + PawnD, Color1: Color1, Index: 0);
                    } else if (data.PassantB == 1 ) {
                        if (X + I == data.PassantX && Y + PawnD == data.PassantY ) {
                            if ((Color1 == 1 && data.PassantY == 1) || (Color1 == 0 && data.PassantY == 6) ) {
                                self.AddMarkPsb(X: X + I, Y: Y + PawnD, Color1: Color1, Index: 0);
                            };
                        };
                    };
                };
                
                I = I + 2
            };
        };
    };
}
