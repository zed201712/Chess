import UIKit

class ViewController: UIViewController {

    let AILevel1 = chessAILevel1()
    let condition = chessCondition()
    let status = chessStatus()
    let data = chessData()
    
    
    
    var Sw1: UITapGestureRecognizer?
    var dyButton1 = Array<UIButton>(repeating: UIButton(), count: 10)
    //AVAudioPlayer *PlayerClick;
    var BackGround1: UIImageView!
    var BackGround2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var i = 0
        var TempS = ""
        var ButtonWidth = 0
        var ButtonShift = 0
        
        AILevel1.vc = self
        AILevel1.condition = condition
        AILevel1.status = status
        AILevel1.data = data
        
        status.vc = self
        status.condition = condition
        status.data = data
        
        condition.status = status
        condition.data = data
        
//        var Mp3Path = [[NSBundle mainBundle] pathForResource:@"Click" ofType:@"wav"];
//        NSData *Mp3Data = [NSData dataWithContentsOfFile:Mp3Path];
//        PlayerClick = [[AVAudioPlayer alloc]initWithData:Mp3Data error:nil];
        
        
        data.PieceWidth = Int(self.view.frame.size.width / CGFloat(Chess.CheckerBoardGrid.rawValue))
        data.BGshiftY.origin.x = CGFloat(Chess.CheckerBoardGrid.rawValue / 2)
        data.BGshiftY.origin.y = CGFloat(data.PieceWidth * 3)
        data.BGshiftY.size.width = CGFloat(Chess.CheckerBoardGrid.rawValue)
        data.BGshiftY.size.height = CGFloat(Chess.CheckerBoardGrid.rawValue / 2)
        
        BackGround2 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        BackGround2.image = UIImage(named: "BG1")
        BackGround2.layer.cornerRadius = 10.0;
        self.view.addSubview(BackGround2)
        BackGround1 = UIImageView.init(frame: CGRect(x: data.BGshiftY.origin.x, y: data.BGshiftY.origin.y, width: self.view.frame.size.width - data.BGshiftY.size.width, height: self.view.frame.size.width - data.BGshiftY.size.height))
        BackGround1.image = UIImage(named: "Background")
        BackGround1.layer.cornerRadius = 10.0;
        self.view.addSubview(BackGround1)
        
        for i in 0...Chess.SpaceNum.rawValue - 1 {
            data.Imag2[i] = UIImageView.init(frame: CGRect(x: 0, y: i * data.PieceWidth, width: data.PieceWidth, height: data.PieceWidth))
            TempS = String.localizedStringWithFormat("%03d", i)
            data.Imag2[i].image = UIImage(named: TempS)
            data.Imag2[i].isHidden = true
            
            self.view.addSubview(data.Imag2[i])
        }
        
        for i in 0...Chess.CheckerBoardGrid.rawValue-1 {
            for j in 0...Chess.CheckerBoardGrid.rawValue-1 {
                data.MapMarkImg[i][j] = UIImageView.init(frame: CGRect(x: data.BGshiftY.origin.x + CGFloat(i * data.PieceWidth), y: data.BGshiftY.origin.y + CGFloat(j * data.PieceWidth), width: CGFloat(data.PieceWidth), height: CGFloat(data.PieceWidth)))
                data.MapMarkImg[i][j].image = UIImage(named:"Mark1")
                data.MapMarkImg[i][j].isHidden = true
                self.view.addSubview(data.MapMarkImg[i][j])
                
                data.MapImg[i][j] = UIImageView.init(frame: CGRect(x: data.BGshiftY.origin.x + CGFloat(i * data.PieceWidth), y: data.BGshiftY.origin.y + CGFloat(j * data.PieceWidth), width: CGFloat(data.PieceWidth), height: CGFloat(data.PieceWidth)))
                data.MapImg[i][j].isHidden = true
                self.view.addSubview(data.MapImg[i][j])
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
        dyButton1[i].setTitle("AI持黑", for: .normal)
        dyButton1[i].addTarget(self, action: #selector(self.ClickButtonAISetBlack), for: .touchUpInside)
        i = 1;
        dyButton1[i].setTitle("AI持白", for: .normal)
        dyButton1[i].addTarget(self, action: #selector(self.ClickButtonAISetWhite), for: .touchUpInside)
        i = 2;
        dyButton1[i].setTitle("重新", for: .normal)
        dyButton1[i].addTarget(self, action: #selector(self.ClickButtonReset), for: .touchUpInside)
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

        data.PassantB = 0;
        data.UndoIndex = 0;

        data.PiecePow[0] = 2000;
        data.PiecePow[1] = 16;
        data.PiecePow[2] = 11;
        data.PiecePow[3] = 10;
        data.PiecePow[4] = 8;
        data.PiecePow[5] = 1;

        for J in 0...Chess.CheckerBoardGrid.rawValue - 1 {
            for I in 0...Chess.CheckerBoardGrid.rawValue - 1 {
                for W in 0...Chess.EffMapMax.rawValue {
                    data.X1Psb[W].PointBeAtkC1[I][J] = 0
                }
            }
        }
        for J in 0...Chess.EffMapMax.rawValue {
            data.X1Psb[J].PsbX1C = 0;
        };


        I = 0
        while (I <= 7) {
            if (data.Direction8[I].X == 0 ) {
                data.DirectionKnight8[I].X = -1;
                data.DirectionKnight8[I].Y = data.Direction8[I].Y * 2;
                data.DirectionKnight8[I + 1].X = 1;
                data.DirectionKnight8[I + 1].Y = data.Direction8[I].Y * 2;
            } else {
                data.DirectionKnight8[I].Y = -1;
                data.DirectionKnight8[I].X = data.Direction8[I].X * 2;
                data.DirectionKnight8[I + 1].Y = 1;
                data.DirectionKnight8[I + 1].X = data.Direction8[I].X * 2;
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
         status.PreCastling();
         self.RefreshMovFlg();
         self.RefreshLPsbMov();
         */
    }
    
    func SetCheckerBoard()->Void {
        var I = 0
        var J = 0
        var K = 0
    
        K = Chess.CheckerBoardGrid.rawValue - 1;
        data.NowStep = 1;
        data.AIColor = 3;
    
        I = 0
        while ( I <= 2 ) {
            J = 0
            while (  J <= 1 ) {
                data.MovedFlag[I][J] = 0;
                J =   J + 1
            };
            I = I + 1
        };
        I = 0
        while ( I <= Chess.PieceStartNum.rawValue ) {
            data.PieceA1[I].X = 0;
            data.PieceA1[I].Y = 0;
            data.PieceA1[I].Level = 0;
            data.PieceA1[I].Moved = 0;
            I = I + 1
        };
        I = 0
        while ( I <= K ) {
            J = 0
            while ( J <= K ) {
                data.Map1[I][J] = 12;
                data.Map2[I][J] = 0;
                J =   J + 1
            };
            I = I + 1
        };
    
        I = 0
        while ( I <= K ) {
            data.Map1[I][1] = 5;
            I = I + 1//Pawn
        };
        I = 0; //Rook
        J = Chess.CheckerBoardGrid.rawValue - 1;
        data.Map1[I][0] = 2;
        data.Map1[J - I][0] = 2;
        I = I + 1; //Knight
        data.Map1[I][0] = 4;
        data.Map1[J - I][0] = 4;
        I = I + 1; //Bishop
        data.Map1[I][0] = 3;
        data.Map1[J - I][0] = 3;
        I = I + 1; //Queen
        data.Map1[I][0] = 1;
        I = I + 1; //King
        data.Map1[I][0] = 0;
    
        data.PieceA1[0].X = I;
        data.PieceA1[0].Y = 0;
        data.PieceA1[0].Level = 0;
    
        I = 0
        while ( I <= K ) {
            data.Map1[I][K - 1] = 6 + 5;
            I = I + 1//Pawn
        };
        I = 0; //Rook
        J = Chess.CheckerBoardGrid.rawValue - 1;
        data.Map1[I][J] = 6 + 2;
        data.Map1[J - I][J] = 6 + 2;
        I = I + 1; //Knight
        data.Map1[I][J] = 6 + 4;
        data.Map1[J - I][J] = 6 + 4;
        I = I + 1; //Bishop
        data.Map1[I][J] = 6 + 3;
        data.Map1[J - I][J] = 6 + 3;
        I = I + 1; //Queen
        data.Map1[I][J] = 6 + 1;
        I = I + 1; //King
        data.Map1[I][J] = 6 + 0;
    };
    
    func DrawGrid(X: Int, Y: Int)->Void {
        if (condition.InCheckerBoard(X: X, Y: Y) == 1 ) {
            data.MapMarkImg[X][Y].isHidden = true
            if (data.Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                data.MapImg[X][Y].isHidden = false
                data.MapImg[X][Y].image = data.Imag2[data.Map1[X][Y]].image
            } else {
                data.MapImg[X][Y].isHidden = true
            }
        };
    }
    
    func DrawMoveGrid(X: Int, Y: Int)->Void {
        if (condition.InCheckerBoard(X: X, Y: Y) == 1 ) {
            data.MapMarkImg[X][Y].isHidden = false
            if (data.Map1[X][Y] < Chess.SpaceNum.rawValue ) {
                data.MapImg[X][Y].isHidden = false
                data.MapImg[X][Y].image = data.Imag2[data.Map1[X][Y]].image
            } else {
                data.MapImg[X][Y].isHidden = true
            }
        };
    }
    
    func MoveOrCls(X: Int, Y: Int, FlagPsbMoveOrCls: Int)->Void {
        if (FlagPsbMoveOrCls == 1 ) {
            self.DrawMoveGrid(X: X, Y: Y)
            data.Map2[X][Y] = 1;
        } else if (FlagPsbMoveOrCls == 2 ) {
            self.DrawGrid(X: X, Y: Y)
            data.Map2[X][Y] = 0;
        };
    };
    
    func PushUndo(X1:Int,Y1:Int,L1:Int,X2:Int,Y2:Int,L2:Int)->Void {
        var I1 = 0
        var I2 = 0
    
        data.UndoX[0][0][data.UndoIndex] = X1;
        data.UndoX[1][0][data.UndoIndex] = Y1;
        data.UndoX[2][0][data.UndoIndex] = L1;
        data.UndoX[0][1][data.UndoIndex] = X2;
        data.UndoX[1][1][data.UndoIndex] = Y2;
        data.UndoX[2][1][data.UndoIndex] = L2;
    
        data.UndoX[3][0][data.UndoIndex] = X1;
        data.UndoX[4][0][data.UndoIndex] = Y1;
        data.UndoX[5][0][data.UndoIndex] = L1;
        data.UndoX[3][1][data.UndoIndex] = X2;
        data.UndoX[4][1][data.UndoIndex] = Y2;
        data.UndoX[5][1][data.UndoIndex] = L2;
    
        data.UndoPassant[0][data.UndoIndex] = data.PassantX;
        data.UndoPassant[1][data.UndoIndex] = data.PassantY;
        data.UndoPassant[2][data.UndoIndex] = data.PassantB;
    
        I1 = 0
        while ( I1 <= 2 ) {
            I2 = 0
            while ( I2 <= 1 ) {
                data.UndoMovFlag[I1][I2][data.UndoIndex] = data.MovedFlag[I1][I2]
                I2 = I2 + 1
            };
            I1 = I1 + 1
        };
    
        data.UndoIndex = data.UndoIndex + 1;
    
        data.NowStep = data.NowStep + 1;
    };
    
    func PopUndo()->Void {
        var I1 = 0
        var I2 = 0
        
        if (data.UndoIndex > 0 ) {
            data.UndoIndex = data.UndoIndex - 1;
            
            I1 = 0
            while ( I1 <= 3 ) {
                data.Map1[data.UndoX[I1 + 0][0][data.UndoIndex]][data.UndoX[I1 + 1][0][data.UndoIndex]] = data.UndoX[I1 + 2][0][data.UndoIndex];
                data.Map1[data.UndoX[I1 + 0][1][data.UndoIndex]][data.UndoX[I1 + 1][1][data.UndoIndex]] = data.UndoX[I1 + 2][1][data.UndoIndex];
                I1 =  I1 + 3
            };
            data.PassantX = data.UndoPassant[0][data.UndoIndex];
            data.PassantY = data.UndoPassant[1][data.UndoIndex];
            data.PassantB = data.UndoPassant[2][data.UndoIndex];
            I1 = 0
            while ( I1 <= 2 ) {
                I2 = 0
                while ( I2 <= 1 ) {
                    data.MovedFlag[I1][I2] = data.UndoMovFlag[I1][I2][data.UndoIndex]
                    I2 = I2 + 1
                };
                I1 = I1 + 1
            };
        };
        
        data.NowStep = data.NowStep - 1;
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
        if (data.PassantB == 0 ) {
            S.append("AA")
        } else {
            S.append(String(format: "%c%c", data.PassantB * 8 + data.PassantX + 65, data.PassantY + 65))
        };
    
        //MovedFlag;
        J = 0
        while ( J <= 1 ) {
            L = 0;
            
            I = 2
            while ( I >= 0 ) {
                L = L * 2 + data.MovedFlag[I][J];
                I = I - 1
            };
            S.append(String(format: "%c", L + 65))
            
            J = J + 1
        };
    
        Y = 0
        while ( Y <= Chess.CheckerBoardGrid.rawValue - 1 ) {
            X = 0
            while ( X <= Chess.CheckerBoardGrid.rawValue - 1 ) {
                S.append(String(format: "%c", 65 + data.Map1[X][Y]))
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
        data.NowStep = 0;
        X = 0
        while ( X < Chess.StepSpace.rawValue ) {
            data.NowStep = data.NowStep * 10 + Int(GameIDS.mid(start: X, length: 1))!
            X = X + 1
        }
        Loc1 = Loc1 + Chess.StepSpace.rawValue;
        
        I = GameIDS.charToInt(Index: Loc1, signSub: "A")
        if (I / 8 > 0 ) {
            data.PassantB = 1;
            data.PassantX = I % 8;
            data.PassantY = GameIDS.charToInt(Index: Loc1 + 1, signSub: "A")
        } else {
            data.PassantB = 0;
            data.PassantX = 0;
            data.PassantY = 0;
        };
        Loc1 = Loc1 + 2;
    
        Y = 0
        while ( Y <= 1 ) {
            I = GameIDS.charToInt(Index: Loc1 + Y, signSub: "A")
            X = 0
            while ( X <= 2 ) {
                data.MovedFlag[X][Y] = I % 2;
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
                data.Map1[X][Y] = GameIDS.charToInt(Index: Loc1, signSub: "A")
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
    
        if (data.UndoIndex > 0 ) {
            J = 1;
            if (data.AIColor == (data.NowStep - 1) % 2) {
                if (data.UndoIndex > 1) {
                    J = 2;
                } else {
                    J = 0;
                }
            }
    
            for _ in 0...J - 1 {
                status.PossibleMove(PieceIndex: data.Map1[data.PieceA1[0].X][data.PieceA1[0].Y], FlagPsbMoveOrCls: 2, X: data.PieceA1[0].X, Y: data.PieceA1[0].Y); //Cls
                self.PopUndo();
                self.DrawGrid(X: data.UndoX[0][0][data.UndoIndex], Y: data.UndoX[1][0][data.UndoIndex]);
                self.DrawGrid(X: data.UndoX[0][1][data.UndoIndex], Y: data.UndoX[1][1][data.UndoIndex]);
                self.DrawGrid(X: data.UndoX[3][0][data.UndoIndex], Y: data.UndoX[4][0][data.UndoIndex]);
                self.DrawGrid(X: data.UndoX[3][1][data.UndoIndex], Y: data.UndoX[4][1][data.UndoIndex]);
                data.PieceA1[0].X = data.UndoX[0][0][data.UndoIndex];
                data.PieceA1[0].Y = data.UndoX[1][0][data.UndoIndex];
    
                status.PreCastling();
            }
        };
    }
    
    @objc func ClickButtonAISetBlack(_ sender: UIGestureRecognizer) {
        data.AIColor = 0;
        if (data.AIColor == data.NowStep % 2) {
        self.AI_Run();
        }
    }

    @objc func ClickButtonAISetWhite(_ sender: Any) {
        data.AIColor = 1;
        if (data.AIColor == data.NowStep % 2) {
        self.AI_Run();
        }
    }

    @objc func ClickButtonReset(_ sender: Any) {
        data.AIColor = 2;
        data.UndoIndex = 0;
        self.SetCheckerBoard()
        self.RefreshMap1()
    }
    
    @objc func panSingleDown() {
        let temp = Sw1!.location(in: self.view)
        data.ImgMoveX.X = Int(temp.x)
        data.ImgMoveX.Y = Int(temp.y)
        print(Sw1!.state.rawValue)
        if Sw1!.state.rawValue == 3 {
            self.CheckerBoard_MouseUp(Button: 0, Shift: 0, X: data.ImgMoveX.X, Y: data.ImgMoveX.Y)
        }
    }
    
    func Piece1_Click(Index:Int)->Void {
        var Color1 = 0
        
        Color1 = Index / 6;
        Color1 = Color1 * 6;
        
        data.Map1[data.QueeningX][data.QueeningY] = Index;
        self.DrawGrid(X: data.QueeningX, Y: data.QueeningY); //LastSelect
        
        if (data.NowStep % 2 == data.AIColor ) {
            self.AI_Run();
        };
    };
    
    func CheckerBoard_MouseUp(Button:Int,Shift:Int,X:Int,Y:Int)->Void {
        var I = 0
        var J = 0
        var Color1 = 0
        var LastMap2Val = 0
    
        var I1 = 0
        
        I = (X - Int(data.BGshiftY.origin.x)) / data.PieceWidth;
        J = (Y - Int(data.BGshiftY.origin.y)) / data.PieceWidth;
        print("Click X = \(I), Y = \(J)")
    
        if (condition.InCheckerBoard(X: I, Y: J) == 1 ) {
    
            LastMap2Val = data.Map2[I][J];
            status.PossibleMove(PieceIndex: data.Map1[data.PieceA1[0].X][data.PieceA1[0].Y], FlagPsbMoveOrCls: 2, X: data.PieceA1[0].X, Y: data.PieceA1[0].Y); //Cls
    
            if (LastMap2Val > 0 ) {
    
                self.PushUndo(X1: data.PieceA1[0].X, Y1: data.PieceA1[0].Y, L1: data.PieceA1[0].Level, X2: I, Y2: J, L2: data.Map1[I][J]);
    
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
                        self.DrawGrid(X: I, Y: J + 1);
                    } else {
                        data.Map1[I][J - 1] = Chess.SpaceNum.rawValue
                        self.DrawGrid(X: I, Y: J - 1);
                    };
    
                } else if (LastMap2Val == 5 ) { //Queening
    
                    data.QueeningX = I;
                    data.QueeningY = J;
    
                    Color1 = data.Map1[I][J] / 6;
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
    
                    Color1 = data.Map1[I + 1][J];
                    data.Map1[I - 1][J] = Color1;
                    data.Map1[I + 1][J] = Chess.SpaceNum.rawValue;
    
                    self.DrawGrid(X: I - 1, Y: J);
                    self.DrawGrid(X: I + 1, Y: J);
    
                    I1 = 3;
                    data.UndoX[I1 + 0][0][data.UndoIndex - 1] = I + 1;
                    data.UndoX[I1 + 1][0][data.UndoIndex - 1] = J;
                    data.UndoX[I1 + 2][0][data.UndoIndex - 1] = Color1;
                    data.UndoX[I1 + 0][1][data.UndoIndex - 1] = I - 1;
                    data.UndoX[I1 + 1][1][data.UndoIndex - 1] = J;
                    data.UndoX[I1 + 2][1][data.UndoIndex - 1] = Chess.SpaceNum.rawValue;
                } else if (LastMap2Val == 7 ) { //Left Castling
    
                    Color1 = data.Map1[I - 2][J];
                    data.Map1[I + 1][J] = Color1;
                    data.Map1[I - 2][J] = Chess.SpaceNum.rawValue
    
                    self.DrawGrid(X: I - 2, Y: J);
                    self.DrawGrid(X: I + 1, Y: J);
    
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
                self.DrawGrid(X: data.PieceA1[0].X, Y: data.PieceA1[0].Y); //LastSelect
                //[PlayerClick play];//not implemented yet
    
                data.Map2[I][J] = 0;
    
                status.PreCastling();
    
                if (data.NowStep % 2 == data.AIColor && LastMap2Val != 5 ) {
                    self.AI_Run();//AI_Run;
                };
                if (data.NowStep % 2 == 1 - data.AIColor && LastMap2Val == 5 ) {
                    self.Piece1_Click(Index: Color1 + 1);
                };
    
            } else if (data.Map1[I][J] < Chess.SpaceNum.rawValue ) { //Select
    
                if (data.Map1[I][J] / 6 == data.NowStep % 2) {
                    if (data.Map1[I][J] < Chess.SpaceNum.rawValue ) {
                        self.DrawGrid(X: data.PieceA1[0].X, Y: data.PieceA1[0].Y);
                        status.PossibleMove(PieceIndex: data.Map1[I][J], FlagPsbMoveOrCls: 1, X: I, Y: J); //LastSelect
    
                    };
                }
            };
            data.PieceA1[0].X = I;
            data.PieceA1[0].Y = J;
            data.PieceA1[0].Level = data.Map1[I][J];
            self.DrawGrid(X: I, Y: J);
    
            if (LastMap2Val > 0 ) {
                self.DrawMoveGrid(X: data.PieceA1[1].X, Y: data.PieceA1[1].Y);
                self.DrawMoveGrid(X: data.PieceA1[2].X, Y: data.PieceA1[2].Y);
            } else {
                if (data.Map2[data.PieceA1[1].X][data.PieceA1[1].Y] == 0 ) {
                    self.DrawGrid(X: data.PieceA1[1].X, Y: data.PieceA1[1].Y);
                };
                if (data.Map2[data.PieceA1[2].X][data.PieceA1[2].Y] == 0 ) {
                    self.DrawGrid(X: data.PieceA1[2].X, Y: data.PieceA1[2].Y);
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
//        data.UndoIndex = 0;
//
//        if (S != nil) {
//            self.DecodeGameID(GameIDS: S);
//            self.RefreshMap1()
//            if ([S length] > 72) {
//                data.AIColor = [S characterAtIndex:72] - '0';
//            }
//        } else {
            self.SetCheckerBoard();
            self.RefreshMap1()
//        }
//        self.RefreshMap1()
    }
    
    
    //MARK: - Error Test
    func Etest()->Void {
        var I = 0
        var L = 0
        
        while (I <= 7) {
            while (L <= 7) {
                if (data.Map2[I][L] != 0 ) {
                    break;
                }
                L = L + 1
            }
            if (I < 8 && L < 8) {
                if (data.Map2[I][L] != 0 ) {
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
                if (data.Map2[X][Y] != 0 ) {
                    self.DrawMoveGrid(X: X, Y: Y)
                };
                X = X + 1
            };
            Y = Y + 1
        };
        
    };
    
    
    //MARK: - AI
    func AI_Run()->Void {
        AILevel1.AIMain2();
        //self.Etest();
        self.CheckerBoard_MouseUp(Button:0, Shift:0, X:data.AIChoice[0].X1.X * data.PieceWidth + Int(data.BGshiftY.origin.x), Y:data.AIChoice[0].X1.Y * data.PieceWidth + Int(data.BGshiftY.origin.y));
        self.CheckerBoard_MouseUp(Button:0, Shift:0, X:data.AIChoice[0].X2.X * data.PieceWidth + Int(data.BGshiftY.origin.x), Y:data.AIChoice[0].X2.Y * data.PieceWidth + Int(data.BGshiftY.origin.y));
        
        self.RefreshMap1()
        
    };
}




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
//            if (data.Map1[X][Y] == 0 || data.Map1[X][Y] == 6) {
//                TempS = [TempS stringByAppendingString:@"9"];
//            } else {
//                TempS = [TempS stringByAppendingString:[NSString stringWithFormat:@"%d", data.Map1[X][Y] % 6]];
//            }
//        }
//        NSLog(@"%@", TempS);
//    }
//}
//
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
//    S = self.GameID(Step1: data.NowStep);
//    S = [S stringByAppendingString:[NSString stringWithFormat:@"%d", data.AIColor]];
//    [S writeToFile:FilePath atomically:true encoding:NSUTF8StringEncoding error:&E];
//    //NSLog(@"%@", [E localizedFailureReason]);
//};
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
//    data.MarkPsbMovC[0][MoveorAtk] = 0;
//    data.MarkPsbMovC[1][MoveorAtk] = 0;
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
//                if (data.Map1[X][Y] < Chess.SpaceNum.rawValue ) {
//                    C1 = data.Map1[X][Y] / 6;
//
//                    //condition.MarkPsbAtk(X: X, Y: Y, Color1: C1);
//                    self.MarkPsbMov(X: X, Y: Y);
//                    C = C + 1;
//                };
//            };
//
//        };
//    };
//
//};

