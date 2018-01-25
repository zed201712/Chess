import UIKit

var Sw1: UITapGestureRecognizer?

var dyButton1 = Array<UIButton>(repeating: UIButton(), count: 10)
//AVAudioPlayer *PlayerClick;
var Imag1 = UIImageView()
var ImgMoveX = CoordinateByte(X: 0, Y: 0)
var ImgMouseX = CoordinateByte(X: 0, Y: 0)
var ImgX = CGPoint(x: 0, y: 0)

var RT1Counter = 0;

var Imag2 = Array<UIImageView>(repeating: UIImageView(), count: 12)
var Imag2C = 0


var BackGround1: UIImageView!
var BackGround2: UIImageView!

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


var PieceWidth = 0
var BGshiftY = CGRect.zero

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

var UEEV = [UEE3Val(), UEE3Val()]

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

var AIPsbM2 = AIPsbMap2()
var X1Psb = Array<X1FullPsb>(repeating: X1FullPsb(), count: Chess.EffMapMax.rawValue+1)

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        var i = 0
        var TempS = ""
        var ButtonWidth = 0
        var ButtonShift = 0
        
//        var Mp3Path = [[NSBundle mainBundle] pathForResource:@"Click" ofType:@"wav"];
//        NSData *Mp3Data = [NSData dataWithContentsOfFile:Mp3Path];
//        PlayerClick = [[AVAudioPlayer alloc]initWithData:Mp3Data error:nil];
        
        
        PieceWidth = Int(self.view.frame.size.width / CGFloat(Chess.CheckerBoardGrid.rawValue))
        BGshiftY.origin.x = CGFloat(Chess.CheckerBoardGrid.rawValue / 2)
        BGshiftY.origin.y = CGFloat(PieceWidth * 3)
        BGshiftY.size.width = CGFloat(Chess.CheckerBoardGrid.rawValue)
        BGshiftY.size.height = CGFloat(Chess.CheckerBoardGrid.rawValue / 2)
        
        RT1Counter = 0;
        
        BackGround2 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        BackGround2.image = UIImage(named: "BG1")
        BackGround2.layer.cornerRadius = 10.0;
        self.view.addSubview(BackGround2)
        BackGround1 = UIImageView.init(frame: CGRect(x: BGshiftY.origin.x, y: BGshiftY.origin.y, width: self.view.frame.size.width - BGshiftY.size.width, height: self.view.frame.size.width - BGshiftY.size.height))
        BackGround1.image = UIImage(named: "Background")
        BackGround1.layer.cornerRadius = 10.0;
        self.view.addSubview(BackGround1)
        
        for i in 0...Chess.SpaceNum.rawValue - 1 {
            Imag2[i] = UIImageView.init(frame: CGRect(x: 0, y: i * PieceWidth, width: PieceWidth, height: PieceWidth))
            TempS = String.localizedStringWithFormat("%03d", i)
            Imag2[i].image = UIImage(named: TempS)
            Imag2[i].isHidden = true
            
            self.view.addSubview(Imag2[i])
        }
        
        for i in 0...Chess.CheckerBoardGrid.rawValue-1 {
            for j in 0...Chess.CheckerBoardGrid.rawValue-1 {
                MapMarkImg[i][j] = UIImageView.init(frame: CGRect(x: BGshiftY.origin.x + CGFloat(i * PieceWidth), y: BGshiftY.origin.y + CGFloat(j * PieceWidth), width: CGFloat(PieceWidth), height: CGFloat(PieceWidth)))
                MapMarkImg[i][j].image = UIImage(named:"Mark1")
                MapMarkImg[i][j].isHidden = true
                self.view.addSubview(MapMarkImg[i][j])
                
                MapImg[i][j] = UIImageView.init(frame: CGRect(x: BGshiftY.origin.x + CGFloat(i * PieceWidth), y: BGshiftY.origin.y + CGFloat(j * PieceWidth), width: CGFloat(PieceWidth), height: CGFloat(PieceWidth)))
                MapImg[i][j].isHidden = true
                self.view.addSubview(MapImg[i][j])
            }
        }
        
        ButtonWidth = Int(self.view.frame.size.width / 6 + 10)
        ButtonShift = Int(self.view.frame.size.width / 5)
        
        for i in 0...3 {
            dyButton1[i] = UIButton.init(frame: CGRect(x: 0, y: 0, width: ButtonWidth, height:40))
            dyButton1[i].backgroundColor = UIColor.brown
            dyButton1[i].layer.masksToBounds = true
            dyButton1[i].layer.cornerRadius = 10.0;
            dyButton1[i].setTitleColor(UIColor.white, for: .normal)
            dyButton1[i].setTitleColor(UIColor.black, for: .highlighted)
            dyButton1[i].layer.position = CGPoint(x:ButtonShift * (i + 1),y: 50)
            self.view.addSubview(dyButton1[i])
        }
        i = 0;
        dyButton1[i].setTitle("電腦持黑", for: .normal)
        dyButton1[i].addTarget(self, action: #selector(self.onClickButton1), for: .touchUpInside)
        i = 1;
        dyButton1[i].setTitle("電腦持白", for: .normal)
        dyButton1[i].addTarget(self, action: #selector(self.onClickButton2), for: .touchUpInside)
        i = 2;
        dyButton1[i].setTitle("重新", for: .normal)
        dyButton1[i].addTarget(self, action: #selector(self.onClickButton3), for: .touchUpInside)
        i = 3;
        dyButton1[i].setTitle("悔棋", for: .normal)
        dyButton1[i].addTarget(self, action: #selector(self.stepUndo), for: .touchUpInside)
        
        self.dataInit()
        
        
        // 單指輕點
        Sw1 = UITapGestureRecognizer(
            target:self,
            action:#selector(ViewController.panSingleDown))
        // 點幾下才觸發 設置 2 時 則是要點兩下才會觸發 依此類推
        Sw1!.numberOfTapsRequired = 1
        // 幾根指頭觸發
        Sw1!.numberOfTouchesRequired = 1
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(Sw1!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dataInit()->Void {
        var I = 0

        PassantB = 0;
        UndoIndex = 0;

        PiecePow[0] = 2000;
        PiecePow[1] = 16;
        PiecePow[2] = 11;
        PiecePow[3] = 10;
        PiecePow[4] = 8;
        PiecePow[5] = 1;

        for J in 0...Chess.CheckerBoardGrid.rawValue - 1 {
            for I in 0...Chess.CheckerBoardGrid.rawValue - 1 {
                for W in 0...Chess.EffMapMax.rawValue {
                    X1Psb[W].PointBeAtkC1[I][J] = 0
                }
            }
        }
        for J in 0...Chess.EffMapMax.rawValue {
            X1Psb[J].PsbX1C = 0;
        };


        I = 0
        while (I <= 7) {
            if (Direction8[I].X == 0 ) {
                DirectionKnight8[I].X = -1;
                DirectionKnight8[I].Y = Direction8[I].Y * 2;
                DirectionKnight8[I + 1].X = 1;
                DirectionKnight8[I + 1].Y = Direction8[I].Y * 2;
            } else {
                DirectionKnight8[I].Y = -1;
                DirectionKnight8[I].X = Direction8[I].X * 2;
                DirectionKnight8[I + 1].Y = 1;
                DirectionKnight8[I + 1].X = Direction8[I].X * 2;
            };
            I =  I + 2
        };


        self.readSaveFile()//not implemented yet
        self.RefreshMap1()

        
    }
    
    func RefreshMap1()->Void {
    
        for Y in 0...Chess.CheckerBoardGrid.rawValue - 1 {
            for X in 0...Chess.CheckerBoardGrid.rawValue - 1 {
                self.DrawGrid(X: X, Y: Y)
            };
        };
    
        //for test
        /*
         self.PreCastling();
         self.RefreshMovFlg();
         self.RefreshLPsbMov();
         */
    }
    
    func SetCheckerBoard()->Void {
        var I = 0
        var J = 0
        var K = 0
    
        K = Chess.CheckerBoardGrid.rawValue - 1;
        NowStep = 1;
        AIColor = 3;
    
        I = 0
        while ( I <= 2 ) {
            J = 0
            while (  J <= 1 ) {
                MovedFlag[I][J] = 0;
                J =   J + 1
            };
            I = I + 1
        };
        I = 0
        while ( I <= Chess.PieceStartNum.rawValue ) {
            PieceA1[I].X = 0;
            PieceA1[I].Y = 0;
            PieceA1[I].Level = 0;
            PieceA1[I].Moved = 0;
            I = I + 1
        };
        I = 0
        while ( I <= K ) {
            J = 0
            while ( J <= K ) {
                Map1[I][J] = 12;
                Map2[I][J] = 0;
                J =   J + 1
            };
            I = I + 1
        };
    
        I = 0
        while ( I <= K ) {
            Map1[I][1] = 5;
            I = I + 1//Pawn
        };
        I = 0; //Rook
        J = Chess.CheckerBoardGrid.rawValue - 1;
        Map1[I][0] = 2;
        Map1[J - I][0] = 2;
        I = I + 1; //Knight
        Map1[I][0] = 4;
        Map1[J - I][0] = 4;
        I = I + 1; //Bishop
        Map1[I][0] = 3;
        Map1[J - I][0] = 3;
        I = I + 1; //Queen
        Map1[I][0] = 1;
        I = I + 1; //King
        Map1[I][0] = 0;
    
        PieceA1[0].X = I;
        PieceA1[0].Y = 0;
        PieceA1[0].Level = 0;
    
        I = 0
        while ( I <= K ) {
            Map1[I][K - 1] = 6 + 5;
            I = I + 1//Pawn
        };
        I = 0; //Rook
        J = Chess.CheckerBoardGrid.rawValue - 1;
        Map1[I][J] = 6 + 2;
        Map1[J - I][J] = 6 + 2;
        I = I + 1; //Knight
        Map1[I][J] = 6 + 4;
        Map1[J - I][J] = 6 + 4;
        I = I + 1; //Bishop
        Map1[I][J] = 6 + 3;
        Map1[J - I][J] = 6 + 3;
        I = I + 1; //Queen
        Map1[I][J] = 6 + 1;
        I = I + 1; //King
        Map1[I][J] = 6 + 0;
    };
    
    func DrawGrid(X: Int, Y: Int)->Void {
        if (self.InCheckerBoard(X: X, Y: Y) == 1 ) {
            MapMarkImg[X][Y].isHidden = true
            if (Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                MapImg[X][Y].isHidden = false
                MapImg[X][Y].image = Imag2[Map1[X][Y]].image
            } else {
                MapImg[X][Y].isHidden = true
            }
        };
    }
    
    func DrawMoveGrid(X: Int, Y: Int)->Void {
        if (self.InCheckerBoard(X: X, Y: Y) == 1 ) {
            MapMarkImg[X][Y].isHidden = false
            if (Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                MapImg[X][Y].isHidden = false
                MapImg[X][Y].image = Imag2[Map1[X][Y]].image
            } else {
                MapImg[X][Y].isHidden = true
            }
        };
    }
    
    func InCheckerBoard(X: Int, Y: Int)->Int {
        if (X >= 0 && X < Chess.CheckerBoardGrid.rawValue && Y >= 0 && Y < Chess.CheckerBoardGrid.rawValue ) {
            return 1;
        } else {
            return 0;
        }
    }
    
    func IsSpaceSameColor(X: Int, Y: Int, Level1: Int)->Int {
        var Level2 = 0
    
        if (Map1[X][Y] >= Chess.SpaceNum.rawValue ) {
            return 0;
        } else {
            Level2 = Map1[X][Y];
            if (Level1 / 6 == Level2 / 6 ) {
                return 1;
            } else {
                return 2;
            };
        };
    };
    func MoveOrCls(X: Int, Y: Int, FlagPsbMoveOrCls: Int)->Void {
        if (FlagPsbMoveOrCls == 1 ) {
            self.DrawMoveGrid(X: X, Y: Y)
            Map2[X][Y] = 1;
        } else if (FlagPsbMoveOrCls == 2 ) {
            self.DrawGrid(X: X, Y: Y)
            Map2[X][Y] = 0;
        };
    };
    
    func MarkPsbMov(X:Int,Y:Int)->Void {
        var L = 0
        var PawnD = 0
        var I = 0
        var Passant = 0
        var QueenX = 0
        var QueenY = 0
        var QueenI1 = 0
        var QueenStep = 0
        var C = 0
        var Color1 = 0
    
        L = Map1[X][Y];
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
                if (self.InCheckerBoard(X: X + Direction8[I].X, Y: Y + Direction8[I].Y) == 1 ) {
                    if (self.IsSpaceSameColor(X: X + Direction8[I].X, Y: Y + Direction8[I].Y, Level1: L) != 1 ) {
    
                        self.AddMarkPsb(X: X + Direction8[I].X, Y: Y + Direction8[I].Y, Color1: Color1, Index: 0);
    
                    };
                };
                
                I = I + 1
            };
    
            self.PreCastling();
            if (MovedFlag[0][C] == 0 ) {
    
                if (MovedFlag[2][C] == 0 ) {
                    I = 1
                    while ( I <= 2 ) {
                        if (Map1[X + I][Y] < 12 ) {
                            break;
                        };
                        I = I + 1
                    };
                    if (I == 3 ) {
                        QueenY = 1 - C;
                        I = 0
                        while ( I <= 2 ) {
                            if (PossibleAttackMap[X + I][Y][QueenY] == 1 ) {
                                break;
                            };
                            I = I + 1
                        };
                        if (I == 3 ) {
                            self.AddMarkPsb(X: X + 2, Y: Y, Color1: Color1, Index: 0);
                        };
                    };
                };
    
                if (MovedFlag[1][C] == 0 ) {
                    I = 1
                    while ( I <= 3 ) {
                        if (Map1[X - I][Y] < 12 ) {
                            break;
                        };
                        
                        I = I + 1
                    };
                    if (I == 4 ) {
                        QueenY = 1 - C;
                        I = 0
                        while ( I <= 2 ) {
                            if (PossibleAttackMap[X - I][Y][QueenY] == 1 ) {
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
                while (self.InCheckerBoard(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y) != 0) {
                    if (self.IsSpaceSameColor(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Level1: L) != 1 ) {
    
                        self.AddMarkPsb(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Color1: Color1, Index: 0);
    
                        if (self.IsSpaceSameColor(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Level1: L) == 2 ) {
                            QueenX = -9;
                        };
                        QueenX = QueenX + Direction8[I].X;
                        QueenY = QueenY + Direction8[I].Y;
                    } else {
                        QueenX = -9;
                    };
                };
                I = I + QueenStep
            };
    
        } else if (L % 6 == 4 ) {
            I = 0
            while ( I <= 7 ) {
                if (self.InCheckerBoard(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y) == 1 ) {
                    if (self.IsSpaceSameColor(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y, Level1: L) != 1 ) {
    
                        self.AddMarkPsb(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y, Color1: Color1, Index: 0);
    
                    };
                };
                
                I = I + 1
            };
    
        } else if (L % 6 == 5 ) {
            if (self.InCheckerBoard(X: X, Y: Y + PawnD) == 1 ) {
                if (self.IsSpaceSameColor(X: X, Y: Y + PawnD, Level1: L) == 0 ) {
                    self.AddMarkPsb(X: X, Y: Y + PawnD, Color1: Color1, Index: 0);
                    if ((C == 1 && Y == 6) || (C == 0 && Y == 1) ) {
                        if (self.IsSpaceSameColor(X: X, Y: Y + PawnD + PawnD, Level1: L) == 0 ) {
                            self.AddMarkPsb(X: X, Y: Y + PawnD + PawnD, Color1: Color1, Index: 0);
                        };
                    };
                };
            };
    
            I = -1
            while ( I <= 1 ) {
                if (self.InCheckerBoard(X: X + I, Y: Y + PawnD) == 1 ) {
                    if (self.IsSpaceSameColor(X: X + I, Y: Y + PawnD, Level1: L) == 2 ) {
                        self.AddMarkPsb(X: X + I, Y: Y + PawnD, Color1: Color1, Index: 0);
                    } else if (PassantB == 1 ) {
                        if (X + I == PassantX && Y + PawnD == PassantY ) {
                            if ((Color1 == 1 && PassantY == 1) || (Color1 == 0 && PassantY == 6) ) {
                                self.AddMarkPsb(X: X + I, Y: Y + PawnD, Color1: Color1, Index: 0);
                            };
                        };
                    };
                };
                
                I = I + 2
            };
        };
    };
    
    func PushUndo(X1:Int,Y1:Int,L1:Int,X2:Int,Y2:Int,L2:Int)->Void {
        var I1 = 0
        var I2 = 0
    
        UndoX[0][0][UndoIndex] = X1;
        UndoX[1][0][UndoIndex] = Y1;
        UndoX[2][0][UndoIndex] = L1;
        UndoX[0][1][UndoIndex] = X2;
        UndoX[1][1][UndoIndex] = Y2;
        UndoX[2][1][UndoIndex] = L2;
    
        UndoX[3][0][UndoIndex] = X1;
        UndoX[4][0][UndoIndex] = Y1;
        UndoX[5][0][UndoIndex] = L1;
        UndoX[3][1][UndoIndex] = X2;
        UndoX[4][1][UndoIndex] = Y2;
        UndoX[5][1][UndoIndex] = L2;
    
        UndoPassant[0][UndoIndex] = PassantX;
        UndoPassant[1][UndoIndex] = PassantY;
        UndoPassant[2][UndoIndex] = PassantB;
    
        I1 = 0
        while ( I1 <= 2 ) {
            I2 = 0
            while ( I2 <= 1 ) {
                UndoMovFlag[I1][I2][UndoIndex] = MovedFlag[I1][I2];
                I2 = I2 + 1
            };
            I1 = I1 + 1
        };
    
        UndoIndex = UndoIndex + 1;
    
        NowStep = NowStep + 1;
    };
    
    func PopUndo()->Void {
        var I1 = 0
        var I2 = 0
        
        if (UndoIndex > 0 ) {
            UndoIndex = UndoIndex - 1;
            
            I1 = 0
            while ( I1 <= 3 ) {
                Map1[UndoX[I1 + 0][0][UndoIndex]][UndoX[I1 + 1][0][UndoIndex]] = UndoX[I1 + 2][0][UndoIndex];
                Map1[UndoX[I1 + 0][1][UndoIndex]][UndoX[I1 + 1][1][UndoIndex]] = UndoX[I1 + 2][1][UndoIndex];
                I1 =  I1 + 3
            };
            PassantX = UndoPassant[0][UndoIndex];
            PassantY = UndoPassant[1][UndoIndex];
            PassantB = UndoPassant[2][UndoIndex];
            I1 = 0
            while ( I1 <= 2 ) {
                I2 = 0
                while ( I2 <= 1 ) {
                    MovedFlag[I1][I2] = UndoMovFlag[I1][I2][UndoIndex];
                    I2 = I2 + 1
                };
                I1 = I1 + 1
            };
        };
        
        NowStep = NowStep - 1;
    };
    
    func GameID(Step1:Int)->String {
        var S = ""
        var L = 0
        var I = 0
        var J = 0
        var X = 0
        var Y = 0
    
        S = String(format: "%04d", Step1)
        
        //Passant
        if (PassantB == 0 ) {
            S.append("AA")
        } else {
            S.append(String(format: "%c%c", PassantB * 8 + PassantX + 65, PassantY + 65))
        };
    
        //MovedFlag;
        J = 0
        while ( J <= 1 ) {
            L = 0;
            
            I = 2
            while ( I >= 0 ) {
                L = L * 2 + MovedFlag[I][J];
                I = I - 1
            };
            S.append(String(format: "%c", L + 65))
            
            J = J + 1
        };
    
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                S.append(String(format: "%c", 65 + Map1[X][Y]))
                X = X + 1
            };
            
            Y = Y + 1
        };
    
        return S;
    };
    
    func DecodeGameID(GameIDS:String )->Void {
        var X = 0
        var Y = 0
        var I = 0
        var Loc1 = 0
    
    
        Loc1 = 0;
        NowStep = 0;
        X = 0
        while ( X < Chess.StepSpace.rawValue ) {
            NowStep = NowStep * 10 + Int(GameIDS.mid(start: X, length: 1))!
            X = X + 1
        }
        Loc1 = Loc1 + Chess.StepSpace.rawValue;
        
        I = GameIDS.charToInt(Index: Loc1, signSub: "A")
        if (I / 8 > 0 ) {
            PassantB = 1;
            PassantX = I % 8;
            PassantY = GameIDS.charToInt(Index: Loc1 + 1, signSub: "A")
        } else {
            PassantB = 0;
            PassantX = 0;
            PassantY = 0;
        };
        Loc1 = Loc1 + 2;
    
        Y = 0
        while ( Y <= 1 ) {
            I = GameIDS.charToInt(Index: Loc1 + Y, signSub: "A")
            X = 0
            while ( X <= 2 ) {
                MovedFlag[X][Y] = I % 2;
                I = I / 2;
                X = X + 1
            };
            Y = Y + 1
        };
        Loc1 = Loc1 + 2;
    
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                Map1[X][Y] = GameIDS.charToInt(Index: Loc1, signSub: "A")
                Loc1 = Loc1 + 1;
                X = X + 1
            };
            Y = Y + 1
        };
    
    };
    
    func intToChar(value:Int, signAdd: String)->Character {
        let temp = Character(UnicodeScalar(value + Int(signAdd.mid(start: 1, length: 1).utf8.min()!))!)
        
        return temp
    }
    
//MARK: - Button
    
    
    @objc func stepUndo() {
        var J = 0
    
        if (UndoIndex > 0 ) {
            J = 1;
            if (AIColor == (NowStep - 1) % 2) {
                if (UndoIndex > 1) {
                    J = 2;
                } else {
                    J = 0;
                }
            }
    
            for _ in 0...J - 1 {
                self.PossibleMove(PieceIndex: Map1[PieceA1[0].X][PieceA1[0].Y], FlagPsbMoveOrCls: 2, X: PieceA1[0].X, Y: PieceA1[0].Y); //Cls
                self.PopUndo();
                self.DrawGrid(X: UndoX[0][0][UndoIndex], Y: UndoX[1][0][UndoIndex]);
                self.DrawGrid(X: UndoX[0][1][UndoIndex], Y: UndoX[1][1][UndoIndex]);
                self.DrawGrid(X: UndoX[3][0][UndoIndex], Y: UndoX[4][0][UndoIndex]);
                self.DrawGrid(X: UndoX[3][1][UndoIndex], Y: UndoX[4][1][UndoIndex]);
                PieceA1[0].X = UndoX[0][0][UndoIndex];
                PieceA1[0].Y = UndoX[1][0][UndoIndex];
    
                self.PreCastling();
            }
        };
    }
    
    @objc func onClickButton1(_ sender: UIGestureRecognizer) {
        AIColor = 0;
        if (AIColor == NowStep % 2) {
        self.AI_Run();
        }
    }

    @objc func onClickButton2(_ sender: Any) {
        AIColor = 1;
        if (AIColor == NowStep % 2) {
        self.AI_Run();
        }
    }

    @objc func onClickButton3(_ sender: Any) {
        AIColor = 2;
        UndoIndex = 0;
        self.SetCheckerBoard()
        self.RefreshMap1()
    }
    
    @objc func panSingleDown() {
        let temp = Sw1!.location(in: self.view)
        ImgMoveX.X = Int(temp.x)
        ImgMoveX.Y = Int(temp.y)
        print(Sw1!.state.rawValue)
        if Sw1!.state.rawValue == 3 {
            self.CheckerBoard_MouseUp(Button: 0, Shift: 0, X: ImgMoveX.X, Y: ImgMoveX.Y)
        }
    }
    
    func CheckerBoard_MouseUp(Button:Int,Shift:Int,X:Int,Y:Int)->Void {
        var I = 0
        var J = 0
        var Color1 = 0
        var LastMap2Val = 0
        var LastPIndex = 0
    
        var I1 = 0
        
        I = (X - Int(BGshiftY.origin.x)) / PieceWidth;
        J = (Y - Int(BGshiftY.origin.y)) / PieceWidth;
        print("Click X = \(I), Y = \(J)")
    
        if (self.InCheckerBoard(X: I, Y: J) == 1 ) {
    
            LastMap2Val = Map2[I][J];
            self.PossibleMove(PieceIndex: Map1[PieceA1[0].X][PieceA1[0].Y], FlagPsbMoveOrCls: 2, X: PieceA1[0].X, Y: PieceA1[0].Y); //Cls
    
            if (LastMap2Val > 0 ) {
    
                self.PushUndo(X1: PieceA1[0].X, Y1: PieceA1[0].Y, L1: PieceA1[0].Level, X2: I, Y2: J, L2: Map1[I][J]);
    
                LastPIndex = PieceA1[0].Level;
                Map1[I][J] = PieceA1[0].Level;
                Map1[I][J] = Map1[PieceA1[0].X][PieceA1[0].Y];
    
                PassantB = 0;
    
                //MovedFlag;
                if (PieceA1[0].X == 4 && PieceA1[0].Y == 0 ) {
                    MovedFlag[0][0] = 1;
                    MovedFlag[1][0] = 1;
                    MovedFlag[2][0] = 1;
                } else if (PieceA1[0].X == 4 && PieceA1[0].Y == 7 ) {
                    MovedFlag[0][1] = 1;
                    MovedFlag[1][1] = 1;
                    MovedFlag[2][1] = 1;
                } else if (PieceA1[0].X == 0 && PieceA1[0].Y == 0 ) {
                    MovedFlag[1][0] = 1;
                } else if (PieceA1[0].X == 7 && PieceA1[0].Y == 0 ) {
                    MovedFlag[2][0] = 1;
                } else if (PieceA1[0].X == 0 && PieceA1[0].Y == 7 ) {
                    MovedFlag[1][1] = 1;
                } else if (PieceA1[0].X == 7 && PieceA1[0].Y == 7 ) {
                    MovedFlag[2][1] = 1;
                };
                Map1[PieceA1[0].X][PieceA1[0].Y] = Chess.SpaceNum.rawValue
    
                if (LastMap2Val == 2 ) { //Passant
    
                    PassantB = 1;
                    PassantX = I;
                    Color1 = Map1[I][J] / 6;
                    if (Color1 == 1 ) {
                        PassantY = J + 1;
                    } else {
                        PassantY = J - 1;
                    };
    
                } else if (LastMap2Val == 3 ) { //Passant2
    
                    Color1 = Map1[I][J] / 6;
                    if (Color1 == 1 ) {
                        Map1[I][J + 1] = Chess.SpaceNum.rawValue
                        self.DrawGrid(X: I, Y: J + 1);
                    } else {
                        Map1[I][J - 1] = Chess.SpaceNum.rawValue
                        self.DrawGrid(X: I, Y: J - 1);
                    };
    
                } else if (LastMap2Val == 5 ) { //Queening
    
                    QueeningX = I;
                    QueeningY = J;
    
                    Color1 = Map1[I][J] / 6;
                    Color1 = Color1 * 6;
    
                    self.Piece1_Click(Index: Color1 + 1);
                    //Piece1[Color1 + 1].Left = Form1.ScaleWidth / 2 - Piece1[Color1 + 1].Width;
                    //Piece1[Color1 + 4].Left = Form1.ScaleWidth / 2 + 10;
    
                    //CheckerBoard.Enabled = False;
                    //Piece1[Color1 + 1].Visible = True;
                    //Piece1[Color1 + 4].Visible = True;
                    //Piece1[Color1 + 1].ZOrder 0;
                    //Piece1[Color1 + 4].ZOrder 0;
    
                } else if (LastMap2Val == 6 ) { //Right Castling
    
                    Color1 = Map1[I + 1][J];
                    Map1[I - 1][J] = Color1;
                    Map1[I + 1][J] = Chess.SpaceNum.rawValue;
    
                    self.DrawGrid(X: I - 1, Y: J);
                    self.DrawGrid(X: I + 1, Y: J);
    
                    I1 = 3;
                    UndoX[I1 + 0][0][UndoIndex - 1] = I + 1;
                    UndoX[I1 + 1][0][UndoIndex - 1] = J;
                    UndoX[I1 + 2][0][UndoIndex - 1] = Color1;
                    UndoX[I1 + 0][1][UndoIndex - 1] = I - 1;
                    UndoX[I1 + 1][1][UndoIndex - 1] = J;
                    UndoX[I1 + 2][1][UndoIndex - 1] = Chess.SpaceNum.rawValue;
                } else if (LastMap2Val == 7 ) { //Left Castling
    
                    Color1 = Map1[I - 2][J];
                    Map1[I + 1][J] = Color1;
                    Map1[I - 2][J] = Chess.SpaceNum.rawValue
    
                    self.DrawGrid(X: I - 2, Y: J);
                    self.DrawGrid(X: I + 1, Y: J);
    
                    I1 = 3;
                    UndoX[I1 + 0][0][UndoIndex - 1] = I - 2;
                    UndoX[I1 + 1][0][UndoIndex - 1] = J;
                    UndoX[I1 + 2][0][UndoIndex - 1] = Color1;
                    UndoX[I1 + 0][1][UndoIndex - 1] = I + 1;
                    UndoX[I1 + 1][1][UndoIndex - 1] = J;
                    UndoX[I1 + 2][1][UndoIndex - 1] = Chess.SpaceNum.rawValue
                };
                PieceA1[2].X = I;
                PieceA1[2].Y = J;
                PieceA1[2].Level = Map1[I][J];
                PieceA1[1].X = PieceA1[0].X;
                PieceA1[1].Y = PieceA1[0].Y;
                PieceA1[1].Level = Map1[I][J];
                self.DrawGrid(X: PieceA1[0].X, Y: PieceA1[0].Y); //LastSelect
                //[PlayerClick play];//not implemented yet
    
                Map2[I][J] = 0;
    
                self.PreCastling();
    
                if (NowStep % 2 == AIColor && LastMap2Val != 5 ) {
                    self.AI_Run();//AI_Run;
                };
                if (NowStep % 2 == 1 - AIColor && LastMap2Val == 5 ) {
                    self.Piece1_Click(Index: Color1 + 1);
                };
    
            } else if (Map1[I][J] < Chess.SpaceNum.rawValue ) { //Select
    
                if (Map1[I][J] / 6 == NowStep % 2) {
                    if (Map1[I][J] < Chess.SpaceNum.rawValue ) {
                        self.DrawGrid(X: PieceA1[0].X, Y: PieceA1[0].Y);
                        self.PossibleMove(PieceIndex: Map1[I][J], FlagPsbMoveOrCls: 1, X: I, Y: J); //LastSelect
    
                    };
                }
            };
            PieceA1[0].X = I;
            PieceA1[0].Y = J;
            PieceA1[0].Level = Map1[I][J];
            self.DrawGrid(X: I, Y: J);
    
            if (LastMap2Val > 0 ) {
                self.DrawMoveGrid(X: PieceA1[1].X, Y: PieceA1[1].Y);
                self.DrawMoveGrid(X: PieceA1[2].X, Y: PieceA1[2].Y);
            } else {
                if (Map2[PieceA1[1].X][PieceA1[1].Y] == 0 ) {
                    self.DrawGrid(X: PieceA1[1].X, Y: PieceA1[1].Y);
                };
                if (Map2[PieceA1[2].X][PieceA1[2].Y] == 0 ) {
                    self.DrawGrid(X: PieceA1[2].X, Y: PieceA1[2].Y);
                };
    
            };
    
        };
    }
    
    func readSaveFile()->Void {
//        var FilePath = [NSTemporaryDirectory() stringByAppendingString:@"\\text.txt"];
//        NSError *E;
//        var S = 0
//
//        S = [NSString stringWithContentsOfFile:FilePath encoding:NSUTF8StringEncoding error:&E];
//        //NSLog(@"%@", [E localizedFailureReason]);
//
//        UndoIndex = 0;
//
//        if (S != nil) {
//            self.DecodeGameID(GameIDS: S);
//            self.RefreshMap1()
//            if ([S length] > 72) {
//                AIColor = [S characterAtIndex:72] - '0';
//            }
//        } else {
            self.SetCheckerBoard();
            self.RefreshMap1()
//        }
//        self.RefreshMap1()
    }
    
    //MARK: - Condition
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
        
        if (FlagPsbMoveOrCls == 1 ) {
            self.Etest()
        };
        
        self.PreCastling();
        L = Map1[X][Y];
        
        if (L < Chess.SpaceNum.rawValue ) {
            
            C = L / 6;
            if (C == 0 ) {
                PawnD = 1;
            } else {
                PawnD = -1;
            };
            
            
            if (L % 6 == 0 ) {
                I = 0
                while (  I <= 7 ) {
                    if (self.InCheckerBoard(X: X + Direction8[I].X, Y: Y + Int(Direction8[I].Y)) == 1 ) {
                        if (self.IsSpaceSameColor(X: X + Direction8[I].X, Y: Y + Direction8[I].Y, Level1: L) != 1 ) {
                            
                            self.MoveOrCls(X: X + Direction8[I].X, Y: Y + Direction8[I].Y, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                            
                        };
                    };
                    I = I + 1
                };
                
                if (MovedFlag[0][C] == 0 ) {
                    
                    if (MovedFlag[2][C] == 0 ) {
                        I = 1
                        while ( I <= 2 ) {
                                if (Map1[X + I][Y] < 12 ) {
                                    break;
                                };
                            I = I + 1
                        };
                        if (I == 3 ) {
                            QueenY = 1 - C;
                            I = 0
                            while (  I <= 2 ) {
                                if (PossibleAttackMap[X + I][Y][QueenY] == 1 ) {
                                    break;
                                };
                                I = I + 1
                            };
                            if (I == 3 ) {
                                if (FlagPsbMoveOrCls == 1 ) {
                                    self.DrawMoveGrid(X: X + 2, Y: Y);
                                    Map2[X + 2][Y] = 6;
                                } else if (FlagPsbMoveOrCls == 2 ) {
                                    self.DrawGrid(X: X + 2, Y: Y);
                                    Map2[X + 2][Y] = 0;
                                };
                            };
                        };
                    };
                            
                    if (MovedFlag[1][C] == 0 ) {
                        I = 1
                        while (  I <= 3 ) {
                            if (Map1[X - I][Y] < 12 ) {
                                break;
                            };
                            I = I + 1
                        };
                        if (I == 4 ) {
                            QueenY = 1 - C;
                            I = 0
                            while ( I <= 2 ) {
                                if (PossibleAttackMap[X - I][Y][QueenY] == 1 ) {
                                    break;
                                };
                            I = I + 1
                            };
                            if (I == 3 ) {
                                if (FlagPsbMoveOrCls == 1 ) {
                                    self.DrawMoveGrid(X: X - 2, Y: Y);
                                    Map2[X - 2][Y] = 7;
                                } else if (FlagPsbMoveOrCls == 2 ) {
                                    self.DrawGrid(X: X - 2, Y: Y);
                                    Map2[X - 2][Y] = 0;
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
                    while (self.InCheckerBoard(X: QueenX + Direction8[I].X, Y: QueenY + Int(Direction8[I].Y)) != 0) {
                        if (self.IsSpaceSameColor(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Level1: L) != 1 ) {
                            
                            self.MoveOrCls(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                            
                            if (self.IsSpaceSameColor(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Level1: L) == 2 ) {
                                QueenX = -9;
                            };
                            QueenX = QueenX + Int(Direction8[I].X);
                            QueenY = QueenY + Int(Direction8[I].Y);
                        } else {
                            QueenX = -9;
                        };
                    };
                    I =  I + QueenStep
                };
    
            } else if (L % 6 == 4 ) {
                I = 0
                while ( I <= 7 ) {
                    if (self.InCheckerBoard(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y) == 1 ) {
                        if (self.IsSpaceSameColor(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y, Level1: L) != 1 ) {
                            
                            self.MoveOrCls(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                            
                        };
                    };
                I = I + 1
                };

        } else if (L % 6 == 5 ) {
            if (self.InCheckerBoard(X: X, Y: Y + PawnD) == 1 ) {
                if (self.IsSpaceSameColor(X: X, Y: Y + PawnD, Level1: L) == 0 ) {
                    self.MoveOrCls(X: X, Y: Y + PawnD, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                    if ((Y + PawnD == 0 || Y + PawnD == Chess.CheckerBoardGrid.rawValue - 1) && FlagPsbMoveOrCls == 1 ) { //Queening
                        Map2[X][Y + PawnD] = 5;
                    };
                    if ((C == 1 && Y == 6) || (C == 0 && Y == 1) ) {
                        if (self.IsSpaceSameColor(X: X, Y: Y + PawnD + PawnD, Level1: L) == 0 ) {
                            self.MoveOrCls(X: X, Y: Y + PawnD + PawnD, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                            if (FlagPsbMoveOrCls == 1 ) {
                                Map2[X][Y + PawnD + PawnD] = 2; //Passant
                            };
                        };
                    };
                };
            };

            I = -1
            while (  I <= 1  ) {
                    if (self.InCheckerBoard(X: X + I, Y: Y + PawnD) == 1 ) {
                        if (self.IsSpaceSameColor(X: X + I, Y: Y + PawnD, Level1: L) == 2 ) {
                            self.MoveOrCls(X: X + I, Y: Y + PawnD, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                            if ((Y + PawnD == 0 || Y + PawnD == Chess.CheckerBoardGrid.rawValue - 1) && FlagPsbMoveOrCls == 1 ) { //Queening
                                Map2[X + I][Y + PawnD] = 5;
                            };
                        } else if (PassantB == 1 ) {
                            if (X + I == PassantX && Y + PawnD == PassantY ) {
                                if ((C == 1 && PassantY == 2) || (C == 0 && PassantY == 5) ) {
                                    self.MoveOrCls(X: X + I, Y: Y + PawnD, FlagPsbMoveOrCls: FlagPsbMoveOrCls);
                                    if (FlagPsbMoveOrCls == 1 ) {
                                        Map2[X + I][Y + PawnD] = 3; //Passant
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
        var PawnD = 0
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
                PossibleAttackMap[X][Y][Color1] = 0;
                Y = Y + 1
            };
            X = X + 1
        };
    
    
        X = 0
        while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            Y = 0
            while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                if (Map1[X][Y] < 12 ) {
    
                    L = Map1[X][Y];
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
                                if (self.InCheckerBoard(X: X + Direction8[I].X, Y: Y + Direction8[I].Y) == 1 ) {
                                    if (self.IsSpaceSameColor(X: X + Direction8[I].X, Y: Y + Direction8[I].Y, Level1: L) != 1 ) {
    
                                        PossibleAttackMap[X + Direction8[I].X][Y + Direction8[I].Y][Color1] = 1;
    
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
                                while (self.InCheckerBoard(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y) != 0) {
                                    if (self.IsSpaceSameColor(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Level1: L) != 1 ) {
                                        
                                        PossibleAttackMap[QueenX + Direction8[I].X][QueenY + Direction8[I].Y][Color1] = 1;
    
                                        if (self.IsSpaceSameColor(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Level1: L) == 2 ) {
                                            QueenX = -9;
                                        };
                                        QueenX = QueenX + Direction8[I].X;
                                        QueenY = QueenY + Direction8[I].Y;
                                    } else {
                                        QueenX = -9;
                                    };
                                };
                                I =  I + QueenStep
                            };
    
                        } else if (L % 6 == 4 ) {
                            I = 0
                            while ( I <= 7 ) {
                                if (self.InCheckerBoard(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y) == 1 ) {
                                    if (self.IsSpaceSameColor(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y, Level1: L) != 1 ) {
    
                                        PossibleAttackMap[X + DirectionKnight8[I].X][Y + DirectionKnight8[I].Y][Color1] = 1;
    
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
        if (MovedFlag[0][0] == 0 && (MovedFlag[1][0] == 0 || MovedFlag[2][0] == 0) ) {
            self.PossibleAttack(Color1: 1);
        };
        if (MovedFlag[0][1] == 0 && (MovedFlag[1][1] == 0 || MovedFlag[2][1] == 0) ) {
            self.PossibleAttack(Color1: 0);
        };
    };
    
    func Piece1_Click(Index:Int)->Void {
        var Color1 = 0
    
        Color1 = Index / 6;
        Color1 = Color1 * 6;
    
        Map1[QueeningX][QueeningY] = Index;
        self.DrawGrid(X: QueeningX, Y: QueeningY); //LastSelect
    
        if (NowStep % 2 == AIColor ) {
            self.AI_Run();
        };
    };
    
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
                    C1 = Map1[X][Y] / 6;
                    if (C1 == Color1 ) {
    
                        MarkPsbMovC[Color1][1] = 0;
                        self.MarkPsbAtk(X: X, Y: Y, Color1: Color1);
                        C = C + 1;
                        if (MarkPsbMovC[Color1][1] > 0 ) {
                            I = 0
                            while ( I <= MarkPsbMovC[Color1][1] - 1 ) {
                                if (OpponentKing == Map1[MarkPsbMovX[I][Color1][1].X][MarkPsbMovX[I][Color1][1].Y] ) {
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
    
    //MARK: - Error Test
    func Etest()->Void {
        var I = 0
        var L = 0
        
        while (I <= 7) {
            while (L <= 7) {
                if (Map2[I][L] != 0 ) {
                    break;
                }
                L = L + 1
            }
            if (I < 8 && L < 8) {
                if (Map2[I][L] != 0 ) {
                    break;
                }
            }
            I = I + 1
        };
        
        if (I < 8 || L < 8 ) {
            print("Map2 Error")
        };
    }
    
    func EtestDisplay()->Void {
        
        self.RefreshMap1()
        var  Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            var  X = 0
            while (  X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                if (Map2[X][Y] != 0 ) {
                    self.DrawMoveGrid(X: X, Y: Y)
                };
                X = X + 1
            };
            Y = Y + 1
        };
        
    };
    
    
    //MARK: - AI
    func AI_Run()->Void {
        //var I;
    
        self.AIMain2();
        //self.Etest();
        self.CheckerBoard_MouseUp(Button:0, Shift:0, X:AIChoice[0].X1.X * PieceWidth + Int(BGshiftY.origin.x), Y:AIChoice[0].X1.Y * PieceWidth + Int(BGshiftY.origin.y));
        self.CheckerBoard_MouseUp(Button:0, Shift:0, X:AIChoice[0].X2.X * PieceWidth + Int(BGshiftY.origin.x), Y:AIChoice[0].X2.Y * PieceWidth + Int(BGshiftY.origin.y));
    
        /*
         if (AIChoiceC > 2) {
         I = 0
         while ( I <= 2 ) {
             print("\(AIChoice[I].Value) => \(AIChoice[I].X1.X), \(AIChoice[I].X1.Y) - \(AIChoice[I].X2.X), \(AIChoice[I].X2.Y)")
             I = I + 1
         };
         }
         */
        self.RefreshMap1()
    
    };
    
    
    
    func AIMain2()->Void {
        var I = 0
        var TPieceA1 = Array<PieceStatus>(repeating: PieceStatus(), count: 3)
        var NowGameIDIndex = 0
        var TempNowStep = 0
        var NowColor = 0
        var PathS = ""
        var I3 = 0
        var IsGameOver = 0
    
        I = 0
        while ( I <= 2 ) {
            TPieceA1[I] = PieceA1[I];
            I = I + 1
        };
    
        NowColor = NowStep % 2;
    
        IsGameOver = 0;
        AIChoiceC = 0;
        AISearchListCount = 0;
        self.AISearchListAdd(S: "");
        PathS = ""
    
        NowGameIDIndex = 0;
    
        TempNowStep = NowStep;
        AIColor = TempNowStep % 2;
    
        self.AIExpandStep(); //Step1
        AIChoiceC = 0;
    
        I3 = AISearchListCount - 1;
        NowGameIDIndex = 1
        while ( NowGameIDIndex <= I3 ) {
            self.AIMoveOneStep(PathS: AISearchList[0][NowGameIDIndex]);
            self.AIMoveStrategy(OpponentColor: 1 - AIColor, PathS: AISearchList[0][NowGameIDIndex]);
    
            self.PopUndo();
            NowGameIDIndex = NowGameIDIndex + 1
        };
    
    
        while (NowStep != TempNowStep) {
            self.PopUndo();
        };
    
        I = 0
        while ( I <= 2 ) {
            PieceA1[I] = TPieceA1[I];
             I = I + 1
        };
    };
    
    func AISearchListAdd(S:String )->Void {
        AISearchList[0][AISearchListCount] = S
        AISearchListCount = AISearchListCount + 1
    }

    func AIMouseUp(I:Int,J:Int)->Void {
        var Color1 = 0
        var LastMap2Val = 0
        var LastPIndex = 0
        
        var I1 = 0
        
        //I = X / PieceWidth;
        //J = Y / PieceWidth;
        
        if (self.InCheckerBoard(X: I, Y: J) == 1 ) {
            
            self.PreCastling();
            LastMap2Val = Map2[I][J];
            
            if (LastMap2Val > 0 ) {
                
                self.PushUndo(X1: PieceA1[0].X, Y1: PieceA1[0].Y, L1: PieceA1[0].Level, X2: I, Y2: J, L2: Map1[I][J]);
                
                LastPIndex = PieceA1[0].Level;
                Map1[I][J] = PieceA1[0].Level;
                Map1[I][J] = Map1[PieceA1[0].X][PieceA1[0].Y];
                
                PassantB = 0;
                
                //MovedFlag;
                if (PieceA1[0].X == 4 && PieceA1[0].Y == 0 ) {
                    MovedFlag[0][0] = 1;
                    MovedFlag[1][0] = 1;
                    MovedFlag[2][0] = 1;
                } else if (PieceA1[0].X == 4 && PieceA1[0].Y == 7 ) {
                    MovedFlag[0][1] = 1;
                    MovedFlag[1][1] = 1;
                    MovedFlag[2][1] = 1;
                } else if (PieceA1[0].X == 0 && PieceA1[0].Y == 0 ) {
                    MovedFlag[1][0] = 1;
                } else if (PieceA1[0].X == 7 && PieceA1[0].Y == 0 ) {
                    MovedFlag[2][0] = 1;
                } else if (PieceA1[0].X == 0 && PieceA1[0].Y == 7 ) {
                    MovedFlag[1][1] = 1;
                } else if (PieceA1[0].X == 7 && PieceA1[0].Y == 7 ) {
                    MovedFlag[2][1] = 1;
                };
                Map1[PieceA1[0].X][PieceA1[0].Y] = Chess.SpaceNum.rawValue
                
                if (LastMap2Val == 2 ) { //Passant
                    
                    PassantB = 1;
                    PassantX = I;
                    Color1 = Map1[I][J] / 6;
                    if (Color1 == 1 ) {
                        PassantY = J + 1;
                    } else {
                        PassantY = J - 1;
                    };
                    
                } else if (LastMap2Val == 3 ) { //Passant2
                    
                    Color1 = Map1[I][J] / 6;
                    if (Color1 == 1 ) {
                        Map1[I][J + 1] = Chess.SpaceNum.rawValue
                    } else {
                        Map1[I][J - 1] = Chess.SpaceNum.rawValue
                    };
                    
                } else if (LastMap2Val == 5 ) { //Queening
                    
                    QueeningX = I;
                    QueeningY = J;
                    
                    Color1 = Map1[I][J] / 6;
                    Color1 = Color1 * 6;
                    
                    Map1[I][J] = Map1[I][J] - 4;
                    
                } else if (LastMap2Val == 6 ) { //Right Castling
                    
                    Color1 = Map1[I + 1][J];
                    Map1[I - 1][J] = Color1;
                    Map1[I + 1][J] = Chess.SpaceNum.rawValue
                    
                    I1 = 3;
                    UndoX[I1 + 0][0][UndoIndex - 1] = I + 1;
                    UndoX[I1 + 1][0][UndoIndex - 1] = J;
                    UndoX[I1 + 2][0][UndoIndex - 1] = Color1;
                    UndoX[I1 + 0][1][UndoIndex - 1] = I - 1;
                    UndoX[I1 + 1][1][UndoIndex - 1] = J;
                    UndoX[I1 + 2][1][UndoIndex - 1] = Chess.SpaceNum.rawValue
                } else if (LastMap2Val == 7 ) { //Left Castling
                    
                    Color1 = Map1[I - 2][J];
                    Map1[I + 1][J] = Color1;
                    Map1[I - 2][J] = Chess.SpaceNum.rawValue
                    
                    I1 = 3;
                    UndoX[I1 + 0][0][UndoIndex - 1] = I - 2;
                    UndoX[I1 + 1][0][UndoIndex - 1] = J;
                    UndoX[I1 + 2][0][UndoIndex - 1] = Color1;
                    UndoX[I1 + 0][1][UndoIndex - 1] = I + 1;
                    UndoX[I1 + 1][1][UndoIndex - 1] = J;
                    UndoX[I1 + 2][1][UndoIndex - 1] = Chess.SpaceNum.rawValue
                };
                PieceA1[2].X = I;
                PieceA1[2].Y = J;
                PieceA1[2].Level = Map1[I][J];
                PieceA1[1].X = PieceA1[0].X;
                PieceA1[1].Y = PieceA1[0].Y;
                PieceA1[1].Level = Map1[I][J];
                
                Map2[I][J] = 0;
                
                self.PreCastling();
            };
            
            PieceA1[0].X = I;
            PieceA1[0].Y = J;
            PieceA1[0].Level = Map1[I][J];
        };
    }
    
    func AIMoveOneStep(PathS:String )->Void {
        var I1 = 0
        var I2 = 0
    
        
        PieceA1[0].X = Int(PathS.mid(start: 1, length: 1))!
        PieceA1[0].Y = Int(PathS.mid(start: 2, length: 1))!
        PieceA1[0].Level = Map1[PieceA1[0].X][PieceA1[0].Y];
    
        self.AIPossibleMove(X: PieceA1[0].X, Y: PieceA1[0].Y);
    
        I1 = Int(PathS.mid(start: 3, length: 1))!
        I2 = Int(PathS.mid(start: 4, length: 1))!
        self.AIMouseUp(I: I1, J: I2);
    
        self.AIPsbMap2Cls();
    };
    
    func AIMoveOneStepV(X1:Int,Y1:Int,X2:Int,Y2:Int)->Void {
    
        PieceA1[0].X = X1;
        PieceA1[0].Y = Y1;
        PieceA1[0].Level = Map1[PieceA1[0].X][PieceA1[0].Y];
        self.AIPossibleMove(X: PieceA1[0].X, Y: PieceA1[0].Y);
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
        AtkKing = self.IsCheckmate(Color1: Color1);
        
        X1C = X1Psb[AiEnum.S0C0.rawValue].PsbX1C - 1;
        
        if (X1C < 0 ) {
            
            AICb1.X1.X = Int(PathS.mid(start: 1, length: 1))!
            AICb1.X1.Y = Int(PathS.mid(start: 2, length: 1))!
            AICb1.X2.X = Int(PathS.mid(start: 3, length: 1))!
            AICb1.X2.Y = Int(PathS.mid(start: 4, length: 1))!
            AICb1.Value = PiecePow[0] * 100;
            
            I1 = self.AIAddChoice(IsSameColor: 0);
        } else {
            
            
            
            X1I = 0
            while ( X1I <= X1C ) {
                if (C == 1 ) {
                    break;
                };
                
                X = X1Psb[AiEnum.S0C0.rawValue].PsbX1[X1I].X;
                Y = X1Psb[AiEnum.S0C0.rawValue].PsbX1[X1I].Y;
                
                X2C = X1Psb[AiEnum.S0C0.rawValue].PsbX2C[X1I] - 1;
                X2I = 0
                while ( X2I <= X2C ) {
                    self.AIPossibleMove(X: X, Y: Y);
                    
                    PieceA1[0].X = X;
                    PieceA1[0].Y = Y;
                    PieceA1[0].Level = Map1[X][Y];
                    I1 = X1Psb[AiEnum.S0C0.rawValue].PsbX2[X1I][X2I].X;
                    I2 = X1Psb[AiEnum.S0C0.rawValue].PsbX2[X1I][X2I].Y;
                    
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
                    if (UEEV[0].V[0] > 0 ) {
                        I = UEEV[0].V[0];
                    };
                    if (UEEV[1].V[1] > 0 ) {
                        if ((UEEV[1].X[0] != UEEV[1].X[1] || UEEV[1].Y[0] != UEEV[1].Y[1]) ) {
                            I1 = UEEV[1].V[1];
                        } else if (X1Psb[AiEnum.S1C0A.rawValue].PointBeAtkC1[UEEV[1].X[0]][UEEV[1].Y[0]] == 0 ) {
                            I1 = UEEV[1].V[1];
                        } else if (UEEV[1].V[2] > 0 ) {
                            I1 = UEEV[1].V[2];
                        };
                    };
                    
                    AICb1.X1.X = Int(PathS.mid(start: 1, length: 1))!
                    AICb1.X1.Y = Int(PathS.mid(start: 2, length: 1))!
                    AICb1.X2.X = Int(PathS.mid(start: 3, length: 1))!
                    AICb1.X2.Y = Int(PathS.mid(start: 4, length: 1))!
                    
                    AICb1.Value = self.AIValCount(Color1: AIColor) + ((I - I1) * 100) + (AtkKing * 99);
                    //temptest;
                    //If PathS = "4757 " && X1Psb[AiEnum.S0C0.rawValue].PsbX2[X1I][X2I].X = 5 && X1Psb[AiEnum.S0C0.rawValue].PsbX2[X1I][X2I].Y = 6 Then;
                    // If PathS = "4757 " && AICb1.Value = 1460 Then;
                    // self.RefreshMap1()
                    // PathS = PathS;
                    // End If;
                    //temptest;
                    I1 = self.AIAddChoice(IsSameColor: 0);
                    
                    self.PopUndo();
                    
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
        var NowGameIDIndex = 0
        var NowColor = 0
        var S1 = ""
        var S2 = ""
    
        C = 0;
        Color1 = NowStep % 2;
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
    
                if (C < 16 ) {
                    if (Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                        Color2 = Map1[X][Y] / 6;
                        if (Color1 == Color2 ) {
    
                            MarkPsbMovC[Color1][0] = 0;
                            self.MarkPsbMov(X: X, Y: Y);
                            C1 = MarkPsbMovC[Color1][0];
                            I = 0
                            while ( I <= C1 - 1 ) {
                                AIPsbMovX[I] = MarkPsbMovX[I][Color1][0];
                                I = I + 1
                            };
    
                            if (C1 > 0 ) {
                                self.AIPossibleMove(X: X, Y: Y);
                                I = 0
                                while ( I <= C1 - 1 ) {
                                    PieceA1[0].X = X;
                                    PieceA1[0].Y = Y;
                                    PieceA1[0].Level = Map1[X][Y];
                                    I1 = AIPsbMovX[I].X;
                                    I2 = AIPsbMovX[I].Y;
                                    self.AIMouseUp(I: I1, J: I2);
    
    
                                    if (AISearchListCount < Chess.BSTMax2.rawValue ) {
    
                                        S1 = self.GameID(Step1: NowStep % 2);
                                        if (self.IsCheckmate(Color1: 1 - Color1) == 0 ) {
                                            S2 = String(format: "%d%d%d%d ", X, Y, AIPsbMovX[I].X, AIPsbMovX[I].Y)
                                            AICb1.X1.X = Int(S2.mid(start: 1, length: 1))!
                                            AICb1.X1.Y = Int(S2.mid(start: 2, length: 1))!
                                            AICb1.X2.X = Int(S2.mid(start: 3, length: 1))!
                                            AICb1.X2.Y = Int(S2.mid(start: 4, length: 1))!
                                            AICb1.Value = self.AIValCount(Color1: AIColor);
    
                                            if (Color1 == AIColor ) {
                                                I1 = self.AIAddChoice(IsSameColor: 1);
                                            } else {
                                                I1 = self.AIAddChoice(IsSameColor: 0);
                                            };
    
                                            I1 = 99999;
                                            I2 = NowStep;
                                            if (I2 < I1 ) {
                                                self.AISearchListAdd(S: S2);
                                            };
                                        };
                                    } else {
                                        C = 17;
                                        I = C1;
                                    };
    
    
                                    self.PopUndo();
                                    
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
    
        J = AIPsbM2.X1C - 1;
        I = 0
        while ( I <= J ) {
            Map2[AIPsbM2.X1[I].X][AIPsbM2.X1[I].Y] = 0;
            I = I + 1
        };
        AIPsbM2.X1C = 0;
    };
    
    
    func AIPossibleMove(X:Int,Y:Int)->Void {
        var L = 0
        var PawnD = 0
        var I = 0
        var Passant = 0
        var QueenX = 0
        var QueenY = 0
        var QueenI1 = 0
        var QueenStep = 0
        var C = 0
    
        L = Map1[X][Y];
    
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
                    if (self.InCheckerBoard(X: X + Direction8[I].X, Y: Y + Direction8[I].Y) == 1 ) {
                        if (self.IsSpaceSameColor(X: X + Direction8[I].X, Y: Y + Direction8[I].Y, Level1: L) != 1 ) {
    
                            Map2[X + Direction8[I].X][Y + Direction8[I].Y] = 1;
                            self.AIPsbMap2Add(X: X + Direction8[I].X, Y: Y + Direction8[I].Y);
    
                        };
                    };
                    I = I + 1
                };
    
                self.PreCastling();
                if (MovedFlag[0][C] == 0 ) {
    
                    if (MovedFlag[2][C] == 0 ) {
                        I = 1
                        while ( I <= 2 ) {
                            if (Map1[X + I][Y] < 12 ) {
                                break;
                            };
                            I = I + 1
                        };
                        if (I == 3 ) {
                            QueenY = 1 - C;
                            I = 0
                            while ( I <= 2 ) {
                                if (PossibleAttackMap[X + I][Y][QueenY] == 1 ) {
                                    break;
                                };
                                I = I + 1
                            };
                            if (I == 3 ) {
                                Map2[X + 2][Y] = 6;
                                self.AIPsbMap2Add(X: X + 2, Y: Y);
                            };
                        };
                    };
    
                    if (MovedFlag[1][C] == 0 ) {
                        I = 1
                        while ( I <= 3 ) {
                            if (Map1[X - I][Y] < 12 ) {
                                break;
                            };
                            I = I + 1
                        };
                        if (I == 4 ) {
                            QueenY = 1 - C;
                            I = 0
                            while ( I <= 2 ) {
                                if (PossibleAttackMap[X - I][Y][QueenY] == 1 ) {
                                    break;
                                };
                                I = I + 1
                            };
                            if (I == 3 ) {
                                Map2[X - 2][Y] = 7;
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
                    while (self.InCheckerBoard(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y) != 0) {
                        if (self.IsSpaceSameColor(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Level1: L) != 1 ) {
    
                            Map2[QueenX + Direction8[I].X][QueenY + Direction8[I].Y] = 1;
                            self.AIPsbMap2Add(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y);
    
                            if (self.IsSpaceSameColor(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Level1: L) == 2 ) {
                                QueenX = -9;
                            };
                            QueenX = QueenX + Direction8[I].X;
                            QueenY = QueenY + Direction8[I].Y;
                        } else {
                            QueenX = -9;
                        };
                    };
                    I =  I + QueenStep
                };
    
            } else if (L % 6 == 4 ) {
                I = 0
                while ( I <= 7 ) {
                    if (self.InCheckerBoard(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y) == 1 ) {
                        if (self.IsSpaceSameColor(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y, Level1: L) != 1 ) {
    
                            Map2[X + DirectionKnight8[I].X][Y + DirectionKnight8[I].Y] = 1;
                            self.AIPsbMap2Add(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y);
    
                        };
                    };
                    I = I + 1
                };
    
            } else if (L % 6 == 5 ) {
                if (self.InCheckerBoard(X: X, Y: Y + PawnD) == 1 ) {
                    if (self.IsSpaceSameColor(X: X, Y: Y + PawnD, Level1: L) == 0 ) {
                        Map2[X][Y + PawnD] = 1;
                        self.AIPsbMap2Add(X: X, Y: Y + PawnD);
                        if ((Y + PawnD == 0 || Y + PawnD == Chess.CheckerBoardGrid.rawValue - 1) ) { //Queening
                            Map2[X][Y + PawnD] = 5;
                            self.AIPsbMap2Add(X: X, Y: Y + PawnD);
                        };
                        if ((C == 1 && Y == 6) || (C == 0 && Y == 1) ) {
                            if (self.IsSpaceSameColor(X: X, Y: Y + PawnD + PawnD, Level1: L) == 0 ) {
                                Map2[X][Y + PawnD + PawnD] = 2;
                                self.AIPsbMap2Add(X: X, Y: Y + PawnD + PawnD);
                            };
                        };
                    };
                };
    
                I = -1
                while ( I <= 1  ) {
                    if (self.InCheckerBoard(X: X + I, Y: Y + PawnD) == 1 ) {
                        if (self.IsSpaceSameColor(X: X + I, Y: Y + PawnD, Level1: L) == 2 ) {
                            Map2[X + I][Y + PawnD] = 1;
                            self.AIPsbMap2Add(X: X + I, Y: Y + PawnD);
                            if ((Y + PawnD == 0 || Y + PawnD == Chess.CheckerBoardGrid.rawValue - 1) ) { //Queening
                                Map2[X + I][Y + PawnD] = 5;
                                self.AIPsbMap2Add(X: X + I, Y: Y + PawnD);
                            };
                        } else if (PassantB == 1 ) {
                            if (X + I == PassantX && Y + PawnD == PassantY ) {
                                if ((C == 1 && PassantY == 2) || (C == 0 && PassantY == 5) ) {
                                    Map2[X + I][Y + PawnD] = 3; //Passant
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
        while ( I <= AIChoiceC - 1 ) {
            if (AICb1.X1.X == AIChoice[I].X1.X && AICb1.X1.Y == AIChoice[I].X1.Y && AICb1.X2.X == AIChoice[I].X2.X && AICb1.X2.Y == AIChoice[I].X2.Y ) {
                if (IsSameColor == 0 && AICb1.Value < AIChoice[I].Value ) {
                    RefreshV = 1;
                } else if (IsSameColor == 1 && AICb1.Value > AIChoice[I].Value ) {
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
            while ( I <= AIChoiceC - 1 ) {
                if (AICb1.Value > AIChoice[I].Value ) {
                    break;
                };
                I =   I + 1
            };
    
            AIChoiceC = AIChoiceC + 1;
            if (Chess.AIChoiceMax.rawValue <= AIChoiceC ) {
                AIChoiceC = Chess.AIChoiceMax.rawValue - 1;
            };
            J = AIChoiceC - 1
            while ( J >= I + 1  ) {
                AIChoice[J] = AIChoice[J - 1];
                J =  J - 1
            };
            AIChoice[I] = AICb1;
    
            return I;
        } else if (RefreshV == 1 ) {
            AIChoice[I].Value = AICb1.Value;
    
            K = I;
            J = K
            while ( J >= 1  ) {
                if (AIChoice[J].Value > AIChoice[J - 1].Value ) {
                    TempC = AIChoice[J];
                    AIChoice[J] = AIChoice[J - 1];
                    AIChoice[J - 1] = TempC;
                } else {
                    break;
                };
                J =  J-1
            }
            K = J;
            
            J = K
            while ( J <= AIChoiceC - 2 ) {
                if (AIChoice[J].Value < AIChoice[J + 1].Value ) {
                    TempC = AIChoice[J];
                    AIChoice[J] = AIChoice[J + 1];
                    AIChoice[J + 1] = TempC;
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
        var C1 = 0
        var X = 0
        var Y = 0
    
        C = 0;
        MarkPsbMovC[0][0] = 0;
        MarkPsbMovC[1][0] = 0;
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
    
                if (C < 32 ) {
                    if (Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                        C1 = Map1[X][Y] / 6;
    
                        self.MarkPsbMov(X: X, Y: Y);
                        C = C + 1;
                    };
                };
    
                X = X + 1
            };
            
            Y = Y + 1
        };
    
        if (Color1 == 0 ) {
            return MarkPsbMovC[0][0] - MarkPsbMovC[1][0];
        } else {
            return -(MarkPsbMovC[0][0] - MarkPsbMovC[1][0]);
        };
    };
    
    func AIValPow(Color1:Int)->Int {
        var C = 0
        var C1 = 0
        var L = 0
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
                    if (Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                        C1 = Map1[X][Y] / 6;
                        L = Map1[X][Y] % 6;
    
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
    
        X1Psb[Index].PsbX1C = X1Psb[Index].PsbX1C - 1;
        I = 0
        while ( I <= X1Psb[Index].PsbX1C ) {
            K = X1Psb[Index].PsbX2C[I] - 1;
            J = 0
            while ( J <= K ) {
                X1Psb[Index].PointBeAtkC1[X1Psb[Index].PsbX2[I][J].X][X1Psb[Index].PsbX2[I][J].Y] = 0;
                J = J + 1
            };
            I = I + 1
        };
        X1Psb[Index].PsbX1C = 0;
    };
    
    func X1FPCreat(Index:Int,X1:Int,Y1:Int,X2:Int,Y2:Int)->Int {
        var X1C = 0
    
        X1C = X1Psb[Index].PsbX1C;
        X1Psb[Index].PsbX1[X1C].X = X1;
        X1Psb[Index].PsbX1[X1C].Y = Y1;
    
        X1Psb[Index].PsbX2C[X1C] = 0;
        self.X1FPAdd(Index: Index, X1C: X1C, X2: X2, Y2: Y2);
    
        X1Psb[Index].PsbX1C = X1C + 1;
        if (X1Psb[Index].PsbX1C > 16 ) {
            X1Psb[Index].PsbX1C = 16;
            return -1;
        } else {
            return X1Psb[Index].PsbX1C - 1;
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
                    if (Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                        Color2 = Map1[X][Y] / 6;
                        if (Color1 == Color2 ) {
                            
                            MarkPsbMovC[Color1][0] = 0;
                            self.MarkPsbMov(X: X, Y: Y);
                            C1 = MarkPsbMovC[Color1][0];
                            I = 0
                            while ( I <= C1 - 1 ) {
                                AIPsbMovX[I] = MarkPsbMovX[I][Color1][0];
                                I = I + 1
                            };
                            
                            if (C1 > 0 ) {
                                self.AIPossibleMove(X: X, Y: Y);
                                
                                X1C = -1;
                                I = 0
                                while ( I <= C1 - 1 ) {
                                    PieceA1[0].X = X;
                                    PieceA1[0].Y = Y;
                                    PieceA1[0].Level = Map1[X][Y];
                                    I1 = AIPsbMovX[I].X;
                                    I2 = AIPsbMovX[I].Y;
                                    self.AIMouseUp(I: I1, J: I2);
                                    
                                    if (self.IsCheckmate(Color1: 1 - Color1) == 0 ) {
                                        if (X1C == -1 ) {
                                            BX1 = X;
                                            BX2 = Y;
                                            X1C = self.X1FPCreat(Index: X1FPIndex, X1: BX1, Y1: BX2, X2: AIPsbMovX[I].X, Y2: AIPsbMovX[I].Y);
                                        } else {
                                            self.X1FPAdd(Index: X1FPIndex, X1C: X1C, X2: AIPsbMovX[I].X, Y2: AIPsbMovX[I].Y);
                                        };
                                    };
                                    self.PopUndo();
                                    
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
                    if (Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                        Color2 = Map1[X][Y] / 6;
                        if (Color1 == Color2 ) {
    
                            MarkPsbMovC[Color1][1] = 0;
                            self.MarkPsbAtk(X: X, Y: Y, Color1: Color1);
                            C1 = MarkPsbMovC[Color1][1];
                            I = 0
                            while ( I <= C1 - 1 ) {
                                AIPsbMovX[I] = MarkPsbMovX[I][Color1][1];
                                I = I + 1
                            };
    
                            if (C1 > 0 ) {
    
                                BX1 = X;
                                BX2 = Y;
                                X1C = self.X1FPCreat(Index: X1FPIndex, X1: BX1, Y1: BX2, X2: AIPsbMovX[0].X, Y2: AIPsbMovX[0].Y);
                                I = 1
                                while ( I <= C1 - 1 ) {
                                    self.X1FPAdd(Index: X1FPIndex, X1C: X1C, X2: AIPsbMovX[I].X, Y2: AIPsbMovX[I].Y);
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
    
        X = X1Psb[Index].PsbX1[X1I].X;
        Y = X1Psb[Index].PsbX1[X1I].Y;
        L = Map1[X][Y];
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
                QueenX = X + Direction8[I].X;
                QueenY = Y + Direction8[I].Y;
                C = 0;
    
                while (self.InCheckerBoard(X: QueenX, Y: QueenY) != 0) {
                    if (self.IsSpaceSameColor(X: QueenX, Y: QueenY, Level1: L) != 1 ) {
                        
                        if (self.IsSpaceSameColor(X: QueenX, Y: QueenY, Level1: L) == 2 ) {
                            
                            TempUEEVal = self.UEESub(X1: X, Y1: Y, X2: QueenX, Y2: QueenY, IsX2BeAtkC1: X1Psb[X1FPOpponentI].PointBeAtkC1[QueenX][QueenY]);
                            if (TempUEEVal >= 0 ) {
                                C = C + 1;
                            } else {
                                QueenX = -9;
                            };
                            
                            if (C == 1 ) {
                                I2 = X1Psb[Index].PsbX2C[X1I] - 1;
                                I1 = 0
                                while ( I1 <= I2 ) {
                                    if (QueenX == X1Psb[Index].PsbX2[X1I][I1].X && QueenY == X1Psb[Index].PsbX2[X1I][I1].Y ) {
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
                        QueenX = QueenX + Direction8[I].X;
                        QueenY = QueenY + Direction8[I].Y;
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
    
        X1C = AIPsbM2.X1C;
    
        AIPsbM2.X1[X1C].X = X;
        AIPsbM2.X1[X1C].Y = Y;
        AIPsbM2.X1C = X1C + 1;
    };
    
    func X1FPUnequEx(Index:Int,X1FPOpponentI:Int,UEEVIndex:Int)->Void {
        var L = 0
        var LMod6 = 0
        var I = 0
        var X1 = 0
        var Y1 = 0
        var X2 = 0
        var Y2 = 0
        var I1 = 0
        var I2 = 0
        var C = 0
    
        var X1I = 0
        var X1C = 0
        var TempUEEVal = 0
    
        self.UEEVIni(Index: UEEVIndex);
    
        X1C = X1Psb[Index].PsbX1C - 1;
        X1I = 0
        while ( X1I <= X1C ) {
            X1 = X1Psb[Index].PsbX1[X1I].X;
            Y1 = X1Psb[Index].PsbX1[X1I].Y;
            L = Map1[X1][Y1];
            LMod6 = L % 6;
    
            I2 = X1Psb[Index].PsbX2C[X1I] - 1;
            I = 0
            while ( I <= I2 ) {
    
                X2 = X1Psb[Index].PsbX2[X1I][I].X;
                Y2 = X1Psb[Index].PsbX2[X1I][I].Y;
                if (self.IsSpaceSameColor(X: X2, Y: Y2, Level1: L) == 2 ) {
    
                    TempUEEVal = self.UEESub(X1: X1, Y1: Y1, X2: X2, Y2: Y2, IsX2BeAtkC1: X1Psb[X1FPOpponentI].PointBeAtkC1[X2][Y2]);
                    self.UEEVAdd(Index: UEEVIndex, X: X1, Y: Y1, V: TempUEEVal);
    
                };
                I = I + 1
            };
            self.X1FPQueenUnEquEx(Index: Index, X1FPOpponentI: X1FPOpponentI, UEEVIndex: UEEVIndex, X1I: X1I);
    
            X1I = X1I + 1
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
    
        if (Map1[X][Y] < Chess.SpaceNum.rawValue ) {
    
            L = Map1[X][Y];
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
                        if (self.InCheckerBoard(X: X + Direction8[I].X, Y: Y + Direction8[I].Y) == 1 ) {
                            //If self.IsSpaceSameColor(X: X + Direction8[I].X, Y: Y + Direction8[I].Y, Level1: L) != 1 Then;
    
                            self.AddMarkPsb(X: X + Direction8[I].X, Y: Y + Direction8[I].Y, Color1: Color1, Index: 1);
    
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
                        while (self.InCheckerBoard(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y) != 0) {
                            self.AddMarkPsb(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Color1: Color1, Index: 1);
                            if (self.IsSpaceSameColor(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Level1: L) != 1 ) {
    
                                if (self.IsSpaceSameColor(X: QueenX + Direction8[I].X, Y: QueenY + Direction8[I].Y, Level1: L) == 2 ) {
                                    QueenX = -9;
                                };
                                QueenX = QueenX + Direction8[I].X;
                                QueenY = QueenY + Direction8[I].Y;
                            } else {
                                QueenX = -9;
                            };
                        };
                        
                        I = I + QueenStep
                    };
    
                } else if (L % 6 == 4 ) {
                    I = 0
                    while ( I <= 7 ) {
                        if (self.InCheckerBoard(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y) == 1 ) {
                            //If self.IsSpaceSameColor(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y, Level1: L) != 1 Then;
    
                            self.AddMarkPsb(X: X + DirectionKnight8[I].X, Y: Y + DirectionKnight8[I].Y, Color1: Color1, Index: 1);
    
                            //End If;
                        };
                        
                        I = I + 1
                    };
    
                } else if (L % 6 == 5 ) {
                    I = -1
                    while ( I <= 1 ) {
                        if (self.InCheckerBoard(X: X + I, Y: Y + PawnD) == 1 ) {
                            self.AddMarkPsb(X: X + I, Y: Y + PawnD, Color1: Color1, Index: 1);
                        };
                        
                        I = I + 2
                    };
    
                };
    
            };
    
    
        };
    };
    
    func AddMarkPsb(X:Int,Y:Int,Color1:Int,Index:Int)->Void {
        var I = 0
    
        I = 0
        while ( I <= MarkPsbMovC[Color1][Index] - 1 ) {
            if (MarkPsbMovX[I][Color1][Index].X == X && MarkPsbMovX[I][Color1][Index].Y == Y ) {
                MarkPsbMovX[I][Color1][Index].Counter = MarkPsbMovX[I][Color1][Index].Counter + 1;
                break;
            };
            I = I + 1
        };
        if (MarkPsbMovC[Color1][Index] == I ) {
            MarkPsbMovX[MarkPsbMovC[Color1][Index]][Color1][Index].X = X;
            MarkPsbMovX[MarkPsbMovC[Color1][Index]][Color1][Index].Y = Y;
            MarkPsbMovX[MarkPsbMovC[Color1][Index]][Color1][Index].Counter = 1;
    
            MarkPsbMovC[Color1][Index] = MarkPsbMovC[Color1][Index] + 1;
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
    
        X2C = X1Psb[Index].PsbX2C[X1C];
        X1Psb[Index].PsbX2[X1C][X2C].X = X2;
        X1Psb[Index].PsbX2[X1C][X2C].Y = Y2;
        X1Psb[Index].PsbX2C[X1C] = X2C + 1;
    
        PC1 = X1Psb[Index].PointBeAtkC1[X2][Y2];
        X1Psb[Index].PointBeAtk[X2][Y2][PC1].X = X1Psb[Index].PsbX1[X1C].X;
        X1Psb[Index].PointBeAtk[X2][Y2][PC1].Y = X1Psb[Index].PsbX1[X1C].Y;
        X1Psb[Index].PointBeAtkC1[X2][Y2] = PC1 + 1;
    };
    
    func PiecePowF(X:Int,Y:Int)->Int {
        var L = 0
        var LMod6 = 0
    
        L = Map1[X][Y];
        LMod6 = L % 6;
        if (LMod6 < 5 ) {
            return PiecePow[LMod6];
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
            UEEV[Index].V[J] = -PiecePow[0];
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
        if (TempV > UEEV[Index].V[0] ) {
            TempX2 = TempX;
            TempY2 = TempY;
            TempV2 = TempV;
    
            TempX = UEEV[Index].X[0];
            TempY = UEEV[Index].Y[0];
            TempV = UEEV[Index].V[0];
    
            UEEV[Index].V[0] = TempV2;
            UEEV[Index].X[0] = TempX2;
            UEEV[Index].Y[0] = TempY2;
        };
        if (TempV > UEEV[Index].V[1] ) {
            TempX2 = TempX;
            TempY2 = TempY;
            TempV2 = TempV;
    
            TempX = UEEV[Index].X[1];
            TempY = UEEV[Index].Y[1];
            TempV = UEEV[Index].V[1];
    
            UEEV[Index].V[1] = TempV2;
            UEEV[Index].X[1] = TempX2;
            UEEV[Index].Y[1] = TempY2;
        };
        if (TempV > UEEV[Index].V[2] && (TempX != UEEV[Index].X[0] || TempY != UEEV[Index].Y[0]) ) {
            TempX2 = TempX;
            TempY2 = TempY;
            TempV2 = TempV;
    
            TempX = UEEV[Index].X[2];
            TempY = UEEV[Index].Y[2];
            TempV = UEEV[Index].V[2];
    
            UEEV[Index].V[2] = TempV2;
            UEEV[Index].X[2] = TempX2;
            UEEV[Index].Y[2] = TempY2;
        };
    };
}


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




//
//@implementation ViewController
//{
//    IBOutlet UIPanGestureRecognizer *Sw1;
//}
//
//
//func LogMap1()->Void {
//    var X = 0
//    var Y = 0
//    var TempS = 0
//
//    NSLog(@"LogMap1\n___________________");
//    var Y = 0//will fix
//    while ( Y < 8 ) {//For Loop Convert
//        Y =  Y + 1 //will fix
//        TempS = @"";
//        var X = 0//will fix
//        while ( X < 8 ) {//For Loop Convert
//            X =  X + 1 //will fix
//            if (Map1[X][Y] == 0 || Map1[X][Y] == 6) {
//                TempS = [TempS stringByAppendingString:@"9"];
//            } else {
//                TempS = [TempS stringByAppendingString:[NSString stringWithFormat:@"%d", Map1[X][Y] % 6]];
//            }
//        }
//        NSLog(@"%@", TempS);
//    }
//}
//

//
//
//func AISearchL_Click()->Void {
//    //self.DecodeGameID(GameIDS: AISearchL.List[AISearchL.ListIndex]);
//    self.RefreshMap1()
//
//    //Prvar AISearchL.ListIndex; AISearchL.ListCount;
//};
//
//
//func Command1_Click()->Void {
//    var FilePath = [NSTemporaryDirectory() stringByAppendingString:@"\\text.txt"];
//    NSError *E;
//    var S = 0
//
//
//
//
//    S = self.GameID(Step1: NowStep);
//    S = [S stringByAppendingString:[NSString stringWithFormat:@"%d", AIColor]];
//    [S writeToFile:FilePath atomically:true encoding:NSUTF8StringEncoding error:&E];
//    //NSLog(@"%@", [E localizedFailureReason]);
//};
//
//
//
//func Etest2AIValCount()->Void {
//    var X = 0
//    var Y = 0
//    var I = 0
//
//    var  Y = 0 //will fix
//    while (  Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {//For Loop Convert
//         Y =   Y + 1 //will fix
//        var  X = 0 //will fix
//        while (  X <= Chess.CheckerBoardGrid.rawValue - 1 ) {//For Loop Convert
//             X =   X + 1 //will fix
//
//            ;//MarkL1[Y * Chess.CheckerBoardGrid.rawValue + X].Caption = "";
//            ;//MarkL1[Y * Chess.CheckerBoardGrid.rawValue + X + 64].Caption = "";
//
//        };
//    };
//
//    var  I = AIChoiceC - 1 //will fix
//    while (  I >= 0  ) {//For Loop Convert
//      I =  I-1 //will fix
//        ;//MarkL1[AIChoice[I].X2.Y * Chess.CheckerBoardGrid.rawValue + AIChoice[I].X2.X].Caption = AIChoice[I].Value;
//    };
//};
//
//
//func Command5_Click()->Void {
//    AIColor = 2;
//};
//
//
//
//
//func RefreshLPsbMov()->Void {
//    var C = 0
//    var C1 = 0
//    var X = 0
//    var Y = 0
//    var I = 0
//
//    var MoveorAtk = 0
//
//    MoveorAtk = 0;
//
//    C = 0;
//    MarkPsbMovC[0][MoveorAtk] = 0;
//    MarkPsbMovC[1][MoveorAtk] = 0;
//    var  Y = 0 //will fix
//    while (  Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {//For Loop Convert
//         Y =   Y + 1 //will fix
//        var  X = 0 //will fix
//        while (  X <= Chess.CheckerBoardGrid.rawValue - 1 ) {//For Loop Convert
//             X =   X + 1 //will fix
//
//            //MarkL1[Y * Chess.CheckerBoardGrid.rawValue + X].Caption = "";
//            //MarkL1[Y * Chess.CheckerBoardGrid.rawValue + X + 64].Caption = "";
//            if (C < 32 ) {
//                if (Map1[X][Y] < Chess.SpaceNum.rawValue ) {
//                    C1 = Map1[X][Y] / 6;
//
//                    //self.MarkPsbAtk(X: X, Y: Y, Color1: C1);
//                    self.MarkPsbMov(X: X, Y: Y);
//                    C = C + 1;
//                };
//            };
//
//        };
//    };
//
//};
//
//
//
//func X1FPAlternativePoint(Index:Int,OpponentIndex:Int,X1:Int,Y1:Int)->Int {
//    var Color1 = 0
//    var C1 = 0
//    var X1C = 0
//    var X2C = 0
//    var I = 0
//    var J = 0
//    var K = 0
//    var L = 0
//
//    L = Map1[X1][Y1];
//    Color1 = L / 6;
//    L = L % 6;
//
//    X1C = X1Psb[Index].PsbX1C - 1;
//
//    //Search X1;
//    var  I = 0 //will fix
//    while (  I <= X1C ) {//For Loop Convert
//         I =   I + 1 //will fix
//        if (X1 == X1Psb[Index].PsbX1[I].X && Y1 == X1 == X1Psb[Index].PsbX1[I].Y ) {
//            break;
//        };
//    };
//    //End Search;
//
//    if (I > X1C ) {
//        //I = MsgBox["Alternative Error"];
//        return -1;
//    } else {
//        X1C = I;
//        X2C = X1Psb[Index].PsbX2C[X1C] - 1;
//
//        K = 0;
//        var  I = 0 //will fix
//        while (  I <= X2C ) {//For Loop Convert
//             I =   I + 1 //will fix
//            J = Map1[X1Psb[Index].PsbX2[X1C][I].X][X1Psb[Index].PsbX2[X1C][I].Y];
//            C1 = J / 6;
//            if (C1 != Color1 && L >= (J % 6) ) {
//                K = K + 1;
//                if (K >= 2 ) {
//                    break;
//                };
//            };
//        };
//
//        if (K < 2 ) {
//            return 0;
//        } else if (X1Psb[OpponentIndex].PointBeAtkC1[X1][Y1] > 0 ) {
//            return 1;
//        } else {
//            return 2;
//        };
//    };
//};
//
//
//- (IBAction)PanMove:(UIPanGestureRecognizer *)sender {
//
//    ImgMoveX = [Sw1 locationInView:self.view];
//    switch (Sw1.state) {
//    case 1:
//        self.CheckerBoard_MouseUp(Button:0, Shift:0, X:ImgMoveX.x, Y:ImgMoveX.y);
//        break;
//
//    default:
//        break;
//    }
//}
//
//
//
//
//func viewWillDisappear(animated:BOOL)->Void {
//    [Timer1 invalidate];
//    self.Command1_Click();
//}
//
//            - (IBAction)SingleTouch:(id)sender {
//
//                ImgMoveX = [Sw1 locationInView:self.view];
//                self.CheckerBoard_MouseUp(Button:0, Shift:0, X:ImgMoveX.x - BGshiftY.origin.x, Y:ImgMoveX.y - BGshiftY.origin.y);
//
//                //NSLog([NSString stringWithFormat:@"%d, %d", (int)ImgMoveX.x, (int)ImgMoveX.y]);
//                }
//
//
//
//@end

