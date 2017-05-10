unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ColorGrd, Math, Unit2, jpeg;

type
  TmainForm = class(TForm)
    mainImage: TImage;
    nodesSizeLabel: TLabel;
    clearButton: TButton;
    sizeRadioGroup: TRadioGroup;
    editRadioGroup: TRadioGroup;
    editLabel: TLabel;
    mainColorGrid: TColorGrid;
    colorLabel: TLabel;
    openButton: TButton;
    graphTypeLabel: TLabel;
    orientationRadioGroup: TRadioGroup;
    weightRadioGroup: TRadioGroup;
    namingLabel: TLabel;
    namingRadioGroup: TRadioGroup;
    saveButton: TButton;
    openDialog: TOpenDialog;
    saveDialog: TSaveDialog;
    buildComboBox: TComboBox;
    buildLabel: TLabel;
    buildButton: TButton;
    countLabel: TLabel;
    countComboBox: TComboBox;
    countButton: TButton;
    shortestWayButton: TButton;
    nodesSearchButton: TButton;
    backgroundColorBox: TColorBox;
    backgroundLabel: TLabel;
    procedure mainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure clearButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure openButtonClick(Sender: TObject);
    procedure mainImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure mainImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure saveButtonClick(Sender: TObject);
    procedure countButtonClick(Sender: TObject);
    procedure buildButtonClick(Sender: TObject);
    procedure shortestWayButtonClick(Sender: TObject);
    procedure nodesSearchButtonClick(Sender: TObject);
    procedure backgroundColorBoxChange(Sender: TObject);
    //procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainForm: TmainForm;
  tempNode: TGraphList;
  isDown: boolean;

implementation

{$R *.dfm}

function getRadius(): integer;
  begin
    if (mainForm.sizeRadioGroup.ItemIndex = 0) then result := 10;
    if (mainForm.sizeRadioGroup.ItemIndex = 1) then result := 18;
    if (mainForm.sizeRadioGroup.ItemIndex = 2) then result := 26;
  end;

procedure clear();
  begin
    with mainForm.mainImage.Canvas do begin
      brush.Color := mainForm.backGroundColorBox.Selected;
      pen.Color := mainForm.backGroundColorBox.Selected;
      rectangle(0, 0, mainForm.mainImage.Width, mainForm.mainImage.Height);
    end;
  end;

function getName(): string;
  var
    num, enLetter, ruLetter: integer;
  begin
    num := 0;
    enLetter := 0;
    ruLetter := 0;
    if (mainForm.namingRadioGroup.ItemIndex = 0) then begin
      while (isNameExist(inttostr(num))) do inc(num);
      result := inttostr(num);
      inc(num);
    end;
    if (mainForm.namingRadioGroup.ItemIndex = 1) then begin
      result := chr(ord('A') + enLetter);
      while (isNameExist(result)) do begin
        inc(enLetter);
        result := chr(ord('A') + enLetter);
      end;
    end;
    if (mainForm.namingRadioGroup.ItemIndex = 2) then begin
      result := chr(ord('А') + ruLetter);
      while (isNameExist(result)) do begin
        inc(ruLetter);
        result := chr(ord('A') + ruLetter);
      end;
    end;
  end;

procedure drawNode(node: TGraphList);
  var
    equetionX, equetionY, x, y, radius: integer;
    name: string;
    color: TColor;
  begin
    x := node^.x;
    y := node^.y;
    radius := node^.radius;
    name := node^.name;
    color := node^.color;
    case radius of
      10: begin
            equetionX := 6;
            equetionY := 7;
          end;
      18: begin
            equetionX := 11;
            equetiony := 12;
          end;
      26: begin
            equetionX := 16;
            equetionY := 17;
          end;
    end;
    with mainForm.mainImage.canvas do begin
      pen.Color := color;
      brush.Color := color;
      ellipse(x - radius, y - radius, x + radius, y + radius);
      font.Size := radius*6 div 7;
      font.Color := clWhite;
      pen.color := clBlue;
      pen.width := 3;
      brush.Style := bsClear;
      ellipse(x - radius, y - radius, x + radius, y + radius);
      brush.Style := bsSolid;
      brush.Color := color;
      textOut(x - trunc(equetionX*length(name)/2), y - equetionY, uppercase(name));
    end;
  end;

procedure renameNode(node: TGraphList);
  var
    newName: string;
  begin
    if (node <> nil) then begin
      newName := inputBox('Grapher', 'Введите имя вершины', node^.name);
      if (isNameExist(newName) or (pos('@', newName) > 0)) then showMessage('Данное имя уже существует!') else begin
        if (newName <> '') then begin
          replaceAllWays(node^.name, newName);
          node^.name := newName;
        end;
      end;
    end;
  end;

procedure graphicConnection(node1, node2: TGraphList; direction: integer; weight: string);
  const
    WIDTH = 2;
  var
    x1, x2, y1, y2, r1, r2, fromX, fromY, toX, toY, deltaX1, deltaX2: integer;
    deltaY1, deltaY2, tempX, tempY, yForWeight: integer;
    sinA: real;
    temp: TGraphList;
  begin
    if ((node1 <> nil) and (node2 <> nil) and (node1 <> node2)) then begin
      if (node1^.x > node2^.x) then begin
        temp := node1;
        node1 := node2;
        node2 := temp;
        if (direction <> 0) then begin
          if (direction = 1) then direction := 2 else direction := 1;
        end;
      end;
      x1 := node1^.x;
      y1 := node1^.y;
      r1 := node1^.radius;
      x2 := node2^.x;
      y2 := node2^.y;
      r2 := node2^.radius;
      sinA := (y1-y2)/ sqrt(sqr(x2-x1) + sqr(y2-y1) + 1);
      deltaY1 := round(r1*sinA);
      deltaY2 := round(r2*sinA);
      fromY := y1 - deltaY1;
      toY := y2 + deltaY2;
      deltaX1 := round(sqrt(sqr(r1) - sqr(deltaY1)));
      deltaX2 := round(sqrt(sqr(r2) - sqr(deltaY2)));
      fromX := x1 + deltaX1;
      toX := x2 - deltaX2;
      yForWeight := min(node1^.y, node2^.y);
      yForWeight := yForWeight + round(abs(node1^.y - node2^.y)/2);
      with mainForm.mainImage.canvas do begin
        //draw connection
        pen.Color := clSilver;
        pen.Width := WIDTH;
        moveTo(fromX, fromY);
        lineTo(toX, toY);
        //draw weight
        font.Color := clBlack;
        font.Size := 12;
        brush.Color := mainForm.backGroundColorBox.Selected;
        brush.Style := bsSolid;
        if (weight <> '1') then
          textOut(node1^.x + round((node2^.x - node1^.x)/2) - 4*length(weight),
          yForWeight - 9, weight);
        //draw direction
        tempX := toX;
        tempY := toY;
        if (direction = 2) then begin
          toX := fromX + round(11*(cos(PI/4+arcsin(sinA))));
          toY := fromY - round(11*(sin(PI/4+arcsin(sinA))));
          moveTo(fromX, fromY);
          lineTo(toX, toY);
          toX := fromX + round(11*(cos(-PI/4+arcsin(sinA))));
          toY := fromY - round(11*(sin(-PI/4+arcsin(sinA))));
          moveTo(fromX, fromY);
          lineTo(toX, toY);
        end;
        if (direction = 1) then begin
          fromX := tempX;
          fromY := tempY;
          toX := fromX - round(11*(cos(PI/4+arcsin(sinA))));
          toY := fromY + round(11*(sin(PI/4+arcsin(sinA))));
          moveTo(fromX, fromY);
          lineTo(toX, toY);
          toX := fromX - round(11*(cos(-PI/4+arcsin(sinA))));
          toY := fromY + round(11*(sin(-PI/4+arcsin(sinA))));
          moveTo(fromX, fromY);
          lineTo(toX, toY);
        end;
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

procedure brightThisNode(node: TGraphList; color: TColor);
  begin
    if (node <> nil) then begin
      with mainForm.mainImage.canvas do begin
        pen.color := color;
        pen.width := 3;
        brush.Style := bsClear;
        ellipse(node^.x - node^.radius, node^.y - node^.radius, node^.x + node^.radius, node^.y + node^.radius);
      end;
    end;
  end;

procedure mathConnection(node1, node2: TGraphList);
  var
    info1, info2, weight: string;
    exit: boolean;
  begin
    if ((node1 <> nil) and (node2 <> nil)) then begin
      if (isWayExist(node1, node2)) then begin
        deleteWayByName(node1, node2^.name);
        deleteWayByName(node2, node1^.name);
      end;
      weight := '1';
      if (mainForm.weightRadioGroup.ItemIndex = 0) then begin
        weight := inputBox('Grapher', 'Введите вес пути', '');
        if (pos('.', weight) > 0) then weight[pos('.', weight)] := ',';
        if (not checkWeight(weight)) then begin
          showMessage('Некорректный ввод!');
          mathConnection(node1, node2);
          weight := '';
        end;
      end;
      if (weight = '') then weight := '1';
      info1 := '@' + '*' + node2^.name + '*';
      info2 := '@' + '*' + node1^.name + '*';
      if (mainForm.orientationRadioGroup.ItemIndex = 1) then begin
        info1 := info1 + '0 ';
        info2 := info2 + '0 ';
      end else begin
        info1 := info1 + '1 ';
        info2 := info2 + '2 ';
      end;
      info1 := info1 + weight;
      info2 := info2 + weight;
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
        graphicConnection(iterator, getNodeByName(getWayByNum(iterator, numOfWays)),
        getDirectionByNum(iterator, numOfWays), getWeightByNum(iterator, numOfWays));
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

procedure TmainForm.mainImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
    isDown := false;
    if (mainForm.editRadioGroup.ItemIndex = 0) then begin
      addNode(x, y, getRadius(), mainForm.mainColorGrid.ForegroundColor, getName(), '');
      drawNode(getLastNode());
    end;
    if (mainForm.editRadioGroup.ItemIndex = 1) then begin
      if (tempNode = nil) then begin
        tempNode := getNodeByCoordinates(x, y);
        brightThisNode(getNodeByCoordinates(x, y), clYellow);
      end else begin
        mathConnection(tempNode, getNodeByCoordinates(x, y));
        clear();
        drawHoleGraph();
        tempNode := nil;
      end;
    end;
    if (mainForm.editRadioGroup.ItemIndex = 2) then begin
      isDown := true;
    end;
    if (mainForm.editRadioGroup.ItemIndex = 3) then begin
      renameNode(getNodeByCoordinates(x, y));
      clear();
      drawHoleGraph();
    end;
    if (mainForm.editRadioGroup.ItemIndex = 4) then begin
      deleteNode(getNodeByCoordinates(x, y));
      clear();
      drawHoleGraph();
    end;
  end;

procedure countNodesDegree();
  var
    iterator: TGraphList;
    degree: integer;
  begin
    iterator := graphList^.next;
    with mainForm.mainImage.canvas do begin
      while (iterator <> nil) do begin
        degree := getNumOfWays(iterator);
        brush.Style := bsClear;
        font.Size := 10;
        font.Color := clBlack;
        textOut(iterator^.x - 3, iterator^.y - iterator^.radius - 15, inttostr(degree));
        iterator := iterator^.next;
      end;
    end;
  end;

procedure buildGraph(source: string);
  begin
    clear();
    parseFromFile(source);
    fileName := source;
    drawHoleGraph();
  end;

procedure TmainForm.clearButtonClick(Sender: TObject);
  begin
    deleteHoleGraph();
    clear();
  end;

procedure TmainForm.FormCreate(Sender: TObject);
  begin
    clear();
    setUpGraphList();
    fileName := 'MyGraph.gr';
  end;

procedure TmainForm.openButtonClick(Sender: TObject);
  begin
    if openDialog.Execute then begin
      clear();
      parseFromFile(openDialog.FileName);
      fileName := openDialog.FileName;
      drawHoleGraph();
    end;
  end;

procedure TmainForm.mainImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var
    node: TGraphList;
  begin
    if (isDown) then begin
      node := getNodeByCoordinates(x, y);
      if (node <> nil) then begin
        node^.x := x;
        node^.y := y;
        clear();
        drawHoleGraph();
      end;
    end;
  end;

procedure TmainForm.mainImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
    isDown := false;
  end;

procedure TmainForm.saveButtonClick(Sender: TObject);
  begin
    saveDialog.FileName := fileName;
    if saveDialog.Execute then begin
      writeHoleGraphInFile(saveDialog.FileName);
    end;
  end;

function countGraphSize(): string;
  var
    ways: string;
    graphSize, numOfWays: integer;
    iterator: TGraphList;
  begin
    iterator := graphList^.next;
    ways := '';
    graphSize := 0;
    while (iterator <> nil) do begin
      numOfWays := getNumOfWays(iterator);
      while (numOfWays > 0) do begin
        if (pos(getWayByNum(iterator, numOfWays), ways) <= 0) then inc(graphSize);
        dec(numOfWays);
      end;
      ways := ways + iterator^.name;
      iterator := iterator^.next;
    end;
    result := inttostr(graphSize);
  end;

function countRoundTime(): string;
  var
    ways: string;
    numOfWays: integer;
    holeTime: real;
    iterator: TGraphList;
  begin
    iterator := graphList^.next;
    ways := '';
    holeTime := 0;
    while (iterator <> nil) do begin
      numOfWays := getNumOfWays(iterator);
      while (numOfWays > 0) do begin
        if (pos(getWayByNum(iterator, numOfWays), ways) <= 0) then
          holeTime := holeTime + strtofloat(getWeightByNum(iterator, numOfWays));
        dec(numOfWays);
      end;
      ways := ways + iterator^.name;
      iterator := iterator^.next;
    end;
    result := floattostr(holeTime);
  end;

procedure TmainForm.countButtonClick(Sender: TObject);
  begin
    case countComboBox.ItemIndex of
      0: countNodesDegree();
      1: showMessage('Порядок графа равен ' + countAllNodes());
      2: showMessage('Размер графа равен ' + countGraphSize());
      3: showMessage('Время полного обхода равно ' + countRoundTime());
    end;
  end;

procedure TmainForm.buildButtonClick(Sender: TObject);
  var
    buildName: string;
  begin
    buildName := ExtractFileDir(Application.ExeName) + '\Data\';
    case buildComboBox.ItemIndex of
      0: buildName := buildName + 'BinaryTree.gr';
      1: buildName := buildName + 'Heap.gr';
      2: buildName := buildName + 'Perceptron.gr';
      3: buildName := buildName + 'MetroMap.gr';
      4: buildName := buildName + 'ChemicalModel.gr';
      5: buildName := buildName + 'Sociogram.gr';
      6: buildName := buildName + 'Сonstellation.gr';
    end;
    if (buildName <> (ExtractFileDir(Application.ExeName) + '\Data\')) then
      buildGraph(buildName);
  end;

procedure TmainForm.shortestWayButtonClick(Sender: TObject);
  var
    fromNode, toNode: string;
    i: integer;
  begin
    clear();
    drawHoleGraph();
    fromNode := inputBox('Grapher', 'Введите имя начальной вершины', '');
    toNode := inputBox('Grapher', 'Введите имя конечной вершины', '');
    if (not (isNameExist(fromNode) and isNameExist(toNode))) then begin
      showMessage('Вершины не найдены!');
    end else begin
      prepareToSearch(fromNode);
      shortestWaySearch(getNodeByName(fromNode));
      brightThisNode(getNodeByName(fromNode), clRed);
      brightThisNode(getNodeByName(toNode), clRed);
      if (getNodeByName(toNode)^.distance >= 1.7E37) then showMessage('Пути от ' + fromNode + ' до ' + toNode + ' не существует') else
        showMessage('Кратчайший путь от ' + fromNode + ' до ' + toNode + ' равен ' + floattostr(getNodeByName(toNode)^.distance));
    end;
  end;

procedure TmainForm.nodesSearchButtonClick(Sender: TObject);
  var
    nodeName: string;
    foundNode: TGraphList;
    i: integer;
  begin
    nodeName := inputBox('Grapher', 'Введите имя вершины', '');
    foundNode := getNodeByName(nodeName);
    if (foundNode = nil) then showMessage('Вершина не найдена') else begin
      for i := 0 to 3 do begin
        brightThisNode(foundNode, clRed);
        mainForm.mainImage.Repaint;
        sleep(400);
        brightThisNode(foundNode, clBlue);
        mainForm.mainImage.Repaint;
        sleep(400);
      end;
      brightThisNode(foundNode, clRed);
    end;
  end;

procedure TmainForm.backgroundColorBoxChange(Sender: TObject);
  begin
    clear();
    drawHoleGraph();
  end;

end.
