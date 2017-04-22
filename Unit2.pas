unit Unit2;

interface

uses
  SysUtils, Graphics; {Unit1 in 'Unit1.pas';}

type
  TGraphList = ^elem;
  elem = record
    next, prev, last: TgraphList;
    x, y, radius: integer;
    name: string;
    color: TColor;
    ways: string;
  end;

var
  graphList: TGraphList;

procedure setUpGraphList();
procedure addNode(x, y, radius: integer; color: TColor; name: string);
procedure deleteNode(nodeToDelete: TGraphList);
function getLastNode(): TGraphList;
function getWayByNum(node: TGraphList; num: integer): string;
function getDiractionByNum(node: TGraphList; num: integer): integer;
function getWeightByNum(node: TGraphList; num: integer): integer;
function getNumOfWays(node: TGraphList): integer;
function getNodeByName(name: string): TGraphList;

implementation

procedure setUpGraphList();
  begin
    new(graphList);
    graphList^.next := nil;
    graphList^.last := graphList;
  end;

procedure addNode(x, y, radius: integer; color: TColor; name: string);
  var
    newElem: TGraphList;
  begin
    new(newElem);
    newElem^.x := x;
    newElem^.y := y;
    newElem^.radius := radius;
    newElem^.color := color;
    newElem^.name := name;
    newElem^.next := nil;
    newElem^.prev := graphList^.last;
    graphList^.last^.next := newElem;
    graphList^.last := newElem;
  end;

function getLastNode(): TGraphList;
  begin
    result := graphList^.last;
  end;

procedure deleteNode(nodeToDelete: TGraphList);
  var
    iterator: TGraphList;
  begin
    iterator := graphList^.next;
    while ((iterator <> nil) and (nodeToDelete <> nil)) do begin
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

function getWayByNum(node: TGraphList; num: integer): string;
  var
    first: integer;
    res: string;
  begin
    dec(num);
    first := 1;
    while (num >= 0) do begin
      if (node^.ways[first] = ',') then
        dec(num);
      inc(first);
    end;
    //inc(first);
    res := '';
    while (node^.ways[first] <> ' ') do begin
      res := res + node^.ways[first];
      inc(first);
    end;
    result := res;
  end;

function getDiractionByNum(node: TGraphList; num: integer): integer;
  var
    first: integer;
    res: string;
  begin
    dec(num);
    first := 2;
    while (num > 0) do begin
      if (node^.ways[first] = ',') then
        dec(num);
    end;
    inc(first);
    res := '';
    if (node^.ways[first+1] = ' ') then first := first + 2 else
      first := first + 3;
    res := res + node^.ways[first];
    result := strtoint(res);
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
    dec(num);
    first := 2;
    while (num > 0) do begin
      if (node^.ways[first] = ',') then
        dec(num);
    end;
    inc(first);
    res := '';
    if ((node^.ways[first+3] = ',') and (first <= length(node^.ways))) then first := first + 4 else
      first := first + 5;
    while (node^.ways[first] <> ' ') do begin
      res := res + node^.ways[first];
      inc(first);
    end;
    result := strtoint(res);
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

end.
