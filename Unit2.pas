unit Unit2;

interface

uses
  SysUtils, Graphics;

type
  TGraphList = ^elem;
  elem = record
    next, prev, last: TGraphList;
    x, y, radius: integer;
    name: string;
    color: TColor;
    ways: string;
  end;

var
  graphList: TGraphList;
  numFile, enLetterFile, ruLetterFile: integer;

procedure setUpGraphList();
procedure addNode(x, y, radius: integer; color: TColor; name, ways: string);
procedure deleteNode(nodeToDelete: TGraphList);
procedure writeHoleGraphInFile(path: string; num, enLetter, ruLetter: integer);
function getLastNode(): TGraphList;
function getWayByNum(node: TGraphList; num: integer): string;
function getDirectionByNum(node: TGraphList; num: integer): integer;
function getWeightByNum(node: TGraphList; num: integer): integer;
function getNumOfWays(node: TGraphList): integer;
function getNodeByName(name: string): TGraphList;
function isExist(node1, node2: TGraphList): boolean;
procedure deleteHoleGraph();
procedure parseFromFile(path: string);
function getNum(): integer;
function getEnLetter(): integer;
function getRuLetter(): integer;

implementation

procedure setUpGraphList();
  begin
    new(graphList);
    graphList^.next := nil;
    graphList^.last := graphList;
  end;

procedure addNode(x, y, radius: integer; color: TColor; name, ways: string);
  var
    newElem: TGraphList;
  begin
    new(newElem);
    newElem^.x := x;
    newElem^.y := y;
    newElem^.radius := radius;
    newElem^.color := color;
    newElem^.name := name;
    newElem^.ways := ways;
    newElem^.next := nil;
    newElem^.prev := graphList^.last;
    graphList^.last^.next := newElem;
    graphList^.last := newElem;
  end;

function getLastNode(): TGraphList;
  begin
    result := graphList^.last;
  end;

procedure deleteWayByNum(node: TGraphList; num: integer);
  var
    first, last: integer;
  begin
    dec(num);
    first := 1;
    while (num >= 0) do begin
      if (node^.ways[first] = ',') then
        dec(num);
      inc(first);
    end;
    last := first;
    while ((node^.ways[last] <> ',') and (last <= length(node^.ways))) do
      inc(last);
    delete(node^.ways, first - 1, last - 1);
  end;

procedure deleteNode(nodeToDelete: TGraphList);
  var
    iterator: TGraphList;
    nameToDelete: string;
    numOfWays: integer;
  begin
    if (nodeToDelete <> nil) then begin
      nameToDelete := nodeToDelete^.name;
      iterator := graphList^.next;
      while (iterator <> nil) do begin
        numOfWays := getNumOfWays(iterator);
          while (numOfWays > 0) do begin
            if (nameToDelete = getWayByNum(iterator, numOfWays)) then begin
              deleteWayByNum(iterator, numOfWays);
            end;
            dec(numOfWays);
          end;
        iterator := iterator^.next;
      end;
      iterator := graphList^.next;
      while (iterator <> nil) do begin
        if (iterator = nodeToDelete) then begin
          iterator^.prev^.next := iterator^.next;
          if (iterator^.next <> nil) then
            iterator^.next^.prev := iterator^.prev else
              graphList^.last := iterator^.prev;
          dispose(iterator);
          break;
        end;
      iterator := iterator^.next;
      end;
    end;
  end;

function getWayByNum(node: TGraphList; num: integer): string;
  var
    first: integer;
    res: string;
  begin
    if (node <> nil) then begin
      dec(num);
      first := 1;
      while (num >= 0) do begin
        if (node^.ways[first] = ',') then
          dec(num);
        inc(first);
      end;
      res := '';
      while (node^.ways[first] <> ' ') do begin
        res := res + node^.ways[first];
        inc(first);
      end;
    end;
    result := res;
  end;

function getDirectionByNum(node: TGraphList; num: integer): integer;
  var
    first: integer;
    res: string;
  begin
    if (node <> nil) then begin
      dec(num);
      first := 1;
      while (num >= 0) do begin
        if (node^.ways[first] = ',') then
          dec(num);
        inc(first);
      end;
      res := '';
      if (node^.ways[first+1] = ' ') then first := first + 2 else
        first := first + 3;
      res := res + node^.ways[first];
      result := strtoint(res);
    end;
  end;

function getNodeByName(name: string): TGraphList;
  var
    iterator: TGraphList;
  begin
    iterator := graphList^.next;
    while (iterator <> nil) do begin
      if (name = iterator^.name) then begin
        result := iterator;
      end;
      iterator := iterator^.next;
    end;
  end;

function getWeightByNum(node: TGraphList; num: integer): integer;
  var
    first: integer;
    res: string;
  begin
    if (node <> nil) then begin
      dec(num);
      first := 1;
      while (num >= 0) do begin
        if (node^.ways[first] = ',') then
          dec(num);
        inc(first);
      end;
      res := '';
      if (node^.ways[first+1] = ' ') then first := first + 4 else
        first := first + 5;
      while ((node^.ways[first] <> ',') and (first <= length(node^.ways))) do begin
        res := res + node^.ways[first];
        inc(first);
      end;
      result := strtoint(res);
    end;
  end;

function getNumOfWays(node: TGraphList): integer;
  var
    iterator, numOfWays: integer;
  begin
    iterator := 1;
    numOfWays := 0;
    while (iterator <= length(node^.ways)) do begin
      if (node^.ways[iterator] = ',') then
        inc(numOfWays);
      inc(iterator);
    end;
    result := numOfWays;
  end;

function isExist(node1, node2: TGraphList): boolean;
  begin
    if ((node1 <> nil) and (node2 <> nil) and (node1 <> node2)) then begin
      if ((pos(node1^.name, node2^.ways) > 0) and (pos(node2^.name, node1^.ways) > 0)) then result := true else
        result := false;
    end;
  end;

function countAllNodes(): string;
  var
    iterator: TGraphList;
    counter: integer;
  begin
    iterator := graphList^.next;
    counter := 0;
    while (iterator <> nil) do begin
      inc(counter);
      iterator := iterator^.next;
    end;
    result := inttostr(counter);
  end;

procedure writeHoleGraphInFile(path: string; num, enLetter, ruLetter: integer);
  var
    graphFile: TextFile;
    iterator: TGraphList;
  begin
    assignFile(graphFile, path);
    rewrite(graphFile);
  iterator := graphList^.next;
  writeln(graphFile, countAllNodes());
  writeln(graphFile, num);
  writeln(graphFile, enLetter);
  writeln(graphFile, ruLetter);
  while (iterator <> nil) do begin
    writeln(graphFile, iterator^.name);
    writeln(graphFile, iterator^.ways);
    writeln(graphFile, inttostr(iterator^.x));
    writeln(graphFile, inttostr(iterator^.y));
    writeln(graphFile, inttostr(iterator^.radius));
    writeln(graphFile, iterator^.color);
    iterator := iterator^.next;
  end;
  closeFile(graphFile);
  end;

procedure deleteHoleGraph();
  var
    tempNode, iterator: TGraphList;
  begin
    iterator := graphList^.next;
    while (iterator <> nil) do begin
      tempNode := iterator^.next;
      dispose(iterator);
      iterator := tempNode;
    end;
    graphList^.next := nil;
  end;

procedure parseFromFile(path: string);
  var
    graphFile: TextFile;
    numOfNodes, x, y, radius: integer;
    numOfNodesStr, name, ways: string;
    color: TColor;
  begin
    setUpGraphList();
    assignFile(graphFile, path);
    reset(graphFile);
    readln(graphFile, numOfNodesStr);
    readln(graphFile, numFile);
    readln(graphFile, enLetterFile);
    readln(graphFile, ruLetterFile);
    numOfNodes := strtoint(numOfNodesStr);
    while (numOfNodes > 0) do begin
      readln(graphFile, name);
      readln(graphFile, ways);
      readln(graphFile, x);
      readln(graphFile, y);
      readln(graphFile, radius);
      readln(graphFile, color);
      addNode(x, y, radius, color, name, ways);
      dec(numOfNodes);
    end;
    closeFile(graphFile);
  end;

function getNum(): integer;
  begin
    result := numFile;
  end;

function getEnLetter(): integer;
  begin
    result := EnLetterFile;
  end;

function getRuLetter(): integer;
  begin
    result := ruLetterFile;
  end;

end.
