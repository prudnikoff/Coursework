unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ColorGrd, Unit2;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Label2: TLabel;
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Label1: TLabel;
    ColorGrid1: TColorGrid;
    Label3: TLabel;
    Button2: TButton;
    Label4: TLabel;
    RadioGroup3: TRadioGroup;
    RadioGroup4: TRadioGroup;
    Label5: TLabel;
    RadioGroup5: TRadioGroup;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  num, letter: integer;
  tempNode: TGraphList;
  isDown: boolean;

implementation

{$R *.dfm}

function getRadius(): integer;
  begin
    if (Form1.RadioGroup1.ItemIndex = 0) then result := 10;
    if (Form1.RadioGroup1.ItemIndex = 1) then result := 18;
    if (Form1.RadioGroup1.ItemIndex = 2) then result := 26;
  end;

procedure clear();
  begin
    with Form1.Image1.Canvas do begin
      brush.Color := clWhite;
      pen.Color := clWhite;
      rectangle(0, 0, Form1.Image1.Width, Form1.Image1.Height);
    end;
  end;

function getName(): string;
  begin
    if (Form1.RadioGroup5.ItemIndex = 0) then begin
      result := inttostr(num);
      inc(num);
    end;
    if (Form1.RadioGroup5.ItemIndex = 1) then begin
      result := chr(ord('A') + letter);
      inc(letter);
    end;
  end;

procedure drawNode(node: TGraphList);
  var
    equetionX, equetionY, x, y, radius: integer;
    name: string;
    color: TColor;
  begin
    //inicialisation
    x := node^.x;
    y := node^.y;
    radius := node^.radius;
    name := node^.name;
    color := node^.color;
    case radius of
      10: begin
            if (length(name) > 1) then begin
              equetionX := 6;
              equetionY := 7;
            end else begin
              equetionX := 3;
              equetionY := 7;
            end;
          end;
      18: begin
            if (length(name) > 1) then begin
              equetionX := 11;
              equetiony := 12;
            end else begin
              equetionX := 6;
              equetionY := 12;
            end;
          end;
      26: begin
            if (length(name) > 1) then begin
              equetionX := 16;
              equetionY := 17;
            end else begin
              equetionX := 8;
              equetionY := 17;
            end;
          end;
    end;
    with Form1.Image1.canvas do begin
      pen.Color := color;
      brush.Color := color;
      ellipse(x - radius, y - radius, x + radius, y + radius);
      font.Size := radius*6 div 7;
      font.Color := clWhite;
      textOut(x - equetionX, y - equetionY, name);
      pen.color := clBlue;
      pen.width := 2;
      brush.Style := bsClear;
      ellipse(x - radius, y - radius, x + radius, y + radius);
    end;
  end;

procedure graphicConnection(node1, node2: TGraphList);
  const
    WIDTH = 2;
  var
    temp, x1, x2, y1, y2, r1, r2, fromX, fromY, toX, toY, deltaX1, deltaX2, deltaY1, deltaY2: integer;
    sinA: real;
  begin
    if ((node1 <> nil) and (node2 <> nil) and (node1 <> node2)) then begin
      x1 := node1^.x;
      y1 := node1^.y;
      r1 := node1^.radius;
      x2 := node2^.x;
      y2 := node2^.y;
      r2 := node2^.radius;
      if (x1 > x2) then begin
        temp := x1;
        x1 := x2;
        x2 := temp;
        temp := y1;
        y1 := y2;
        y2 := temp;
        temp := r1;
        r1 := r2;
        r2 := temp;
      end;
      sinA := (y1-y2)/ sqrt(sqr(x2-x1) + sqr(y2-y1));
      deltaY1 := round(r1*sinA);
      deltaY2 := round(r2*sinA);
      fromY := y1 - deltaY1;
      toY := y2 + deltaY2;
      deltaX1 := round(sqrt(sqr(r1) - sqr(deltaY1)));
      deltaX2 := round(sqrt(sqr(r2) - sqr(deltaY2)));
      fromX := x1 + deltaX1;
      toX := x2 - deltaX2;
      with Form1.Image1.canvas do begin
        pen.Color := clSilver;
        pen.Width := WIDTH;
        moveTo(fromX, fromY);
        lineTo(toX, toY);
      end;
    end;
  end;

procedure drawHoleGraphNodes();
  var
    iterator: TGraphList;
  begin
    iterator := graphList^.next;
    while (iterator <> nil) do begin
      drawNode(iterator);
      iterator := iterator^.next;
    end;
  end;

function getNodeByCoordinates(x, y: integer): TGraphList;
  var
    iterator: TGraphList;
    isFound: boolean;
  begin
    isFound := false;
    iterator := graphList^.next;
    while (iterator <> nil) do begin
      if (sqr(iterator^.radius) > (sqr(iterator^.x - x) + sqr(iterator^.y - y))) then begin
        result := iterator;
        isFound := true;
        break;
      end;
      iterator := iterator^.next;
    end;
    if (not isFound) then
      result := nil;
  end;

procedure brightThisNode(node: TGraphList);
  begin
    if (node <> nil) then begin
      with Form1.Image1.canvas do begin
        pen.color := clYellow;
        pen.width := 3;
        brush.Style := bsClear;
        ellipse(node^.x - node^.radius, node^.y - node^.radius, node^.x + node^.radius, node^.y + node^.radius);
      end;
    end;
  end;

procedure mathConnection(node1, node2: TGraphList);
  var
    info1, info2: string;
  begin
    if ((node1 <> nil) and (node2 <> nil) and (node1 <> node2)) then begin
      info1 := ',' + node2^.name + ' ';
      info2 := ',' + node1^.name + ' ';
      if (Form1.RadioGroup3.ItemIndex = 1) then begin
        info1 := info1 + '0 ';
        info2 := info2 + '0 ';
      end else begin
        info1 := info1 + '1 ';
        info2 := info2 + '2 ';
      end;
      info1 := info1 + '0';
      info2 := info2 + '0';
      node1^.ways := node1^.ways + info1;
      node2^.ways := node2^.ways + info2;
    end;
  end;

procedure drawHoleGraphConnection();
  var
    iterator: TGraphList;
    numOfWays: integer;
  begin
    iterator := graphList^.next;
    while (iterator <> nil) do begin
      numOfWays := getNumOfWays(iterator);
      while (numOfWays > 0) do begin
        graphicConnection(iterator, getNodeByName(getWayByNum(iterator, numOfWays)));
        dec(numOfWays);
      end;
      iterator := iterator^.next;
    end;
  end;

procedure drawHoleGraph();
  begin
    drawHoleGraphNodes();
    drawHoleGraphConnection();
  end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
    isDown := false;
    if (Form1.RadioGroup2.ItemIndex = 0) then begin
      addNode(x, y, getRadius(), Form1.ColorGrid1.ForegroundColor, getName());
      drawNode(getLastNode());
    end;
    if (Form1.RadioGroup2.ItemIndex = 1) then begin
      if (tempNode = nil) then begin
        tempNode := getNodeByCoordinates(x, y);
        brightThisNode(getNodeByCoordinates(x, y));
      end else begin
        mathConnection(tempNode, getNodeByCoordinates(x, y));
        clear();
        drawHoleGraph();
        tempNode := nil;
      end;
    end;
    if (Form1.RadioGroup2.ItemIndex = 2) then begin
      isDown := true;
    end;
    if (Form1.RadioGroup2.ItemIndex = 3) then begin
      deleteNode(getNodeByCoordinates(x, y));
      clear();
      drawHoleGraph();
    end;
  end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  num := 0;
  letter := 0;
  clear();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  clear();
  setUpGraphList();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  drawHoleGraph();
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var
    node: TGraphList;
begin
  if (isDown) then begin
    node := getNodeByCoordinates(x, y);
    if (node <> nil) then begin
      //brightThisNode(node);
      node^.x := x;
      node^.y := y;
      clear();
      drawHoleGraph();
      //brightThisNode(node);
    end;
  end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  isDown := false;
end;

end.
