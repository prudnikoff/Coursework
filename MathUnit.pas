unit MathUnit;

interface

uses
  SysUtils, Graphics;

type
  TGraphList = ^elem;
  elem = record
    next, prev, last: TGraphList;
    x, y, sx, sy, radius: integer;
    name: string;
    color: TColor;
    ways: string;
    mark: boolean;
    distance: real;
  end;

var
  graphList: TGraphList;
  numFile, enLetterFile, ruLetterFile: integer;
  fileName, shortestWay: string;

procedure setUpGraphList();
procedure addNode(x, y, radius: integer; color: TColor; name, ways: string);
procedure deleteNode(nodeToDelete: TGraphList);
procedure deleteWayByName(node: TGraphList; name: string);
procedure writeHoleGraphInFile(path: string);
function getLastNode(): TGraphList;
function getWayByNum(node: TGraphList; num: integer): string;
function getDirectionByNum(node: TGraphList; num: integer): integer;
function getWeightByNum(node: TGraphList; num: integer): string;
function getNumOfWays(node: TGraphList): integer;
function getNodeByName(name: string): TGraphList;
function isWayExist(node1, node2: TGraphList): boolean;
procedure deleteHoleGraph();
procedure parseFromFile(path: string);
function countAllNodes(): string;
function isNameExist(name: string): boolean;
procedure replaceAllWays(oldName, newName: string);
procedure prepareToSearch(fromNode: string);
procedure waySearch(node: TGraphList);
function checkWeight(weight: string): boolean;
function getDegreeOfNode(node: TGraphList): string;

implementation

procedure setUpGraphList();
  begin
    new(graphList);
    graphList^.next := nil;
    graphList^.last := graphList;
  end;
//Добавление вершины в список
procedure addNode(x, y, radius: integer; color: TColor; name, ways: string);
  var
    newElem: TGraphList;
  begin
    new(newElem);
    newElem^.x := x;
    newElem^.y := y;
    newElem^.sx := x;
    newElem^.sy := y;
    newElem^.radius := radius;
    newElem^.color := color;
    newElem^.name := name;
    newElem^.ways := ways;
    newElem^.next := nil;
    newElem^.prev := graphList^.last;
    graphList^.last^.next := newElem;
    graphList^.last := newElem;
  end;
//Получение последней вершины
function getLastNode(): TGraphList;
  begin
    result := graphList^.last;
  end;
//Удаление вершины по номеру
procedure deleteWayByNum(node: TGraphList; num: integer);
  var
    first, last: integer;
  begin
    dec(num);
    first := 1;
    while (num >= 0) do begin
      if (node^.ways[first] = '@') then
        dec(num);
      inc(first);
    end;
    dec(first);
    last := first + 1;
    while ((node^.ways[last] <> '@') and (last <= length(node^.ways))) do
      inc(last);
    delete(node^.ways, first, last - first);
  end;
//Удаление пути по имени
procedure deleteWayByName(node: TGraphList; name: string);
  var
    first, last: integer;
  begin
    name := '*' + name + '*';
    first := pos(name, node^.ways);
    dec(first);
    last := first + 1;
    while ((node^.ways[last] <> '@') and (last <= length(node^.ways))) do
      inc(last);
    delete(node^.ways, first, last - first);
  end;
//Ззамена всех путей
procedure replaceAllWays(oldName, newName: string);
  var
    iterator: TGraphList;
  begin
    iterator := graphList^.next;
    while (iterator <> nil) do begin
      if (pos('*' + oldName + '*', iterator^.ways) > 0) then begin
        iterator^.ways := StringReplace(iterator^.ways, '*' + oldName + '*', '*' + newName + '*',
        [rfReplaceAll, rfIgnoreCase]);
      end;
      iterator := iterator^.next;
    end;
  end;
//Удаление вершины
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
//Получение пути по номеру
function getWayByNum(node: TGraphList; num: integer): string;
  var
    first: integer;
    res: string;
  begin
    if (node <> nil) then begin
      dec(num);
      first := 1;
      while (num >= 0) do begin
        if (node^.ways[first] = '@') then
          dec(num);
        inc(first);
      end;
      res := '';
      inc(first);
      while (node^.ways[first] <> '*') do begin
        res := res + node^.ways[first];
        inc(first);
      end;
    end;
    result := res;
  end;
//Получение направления по номеру
function getDirectionByNum(node: TGraphList; num: integer): integer;
  var
    first: integer;
    res: string;
  begin
    if (node <> nil) then begin
      dec(num);
      first := 1;
      while (num >= 0) do begin
        if (node^.ways[first] = '@') then
          dec(num);
        inc(first);
      end;
      inc(first);
      res := '';
      while (node^.ways[first] <> '*') do begin
        inc(first);
      end;
      inc(first);
      res := res + node^.ways[first];
      result := strtoint(res);
    end;
  end;
//Получение вершины по имени
function getNodeByName(name: string): TGraphList;
  var
    iterator: TGraphList;
  begin
    iterator := graphList^.next;
    while (iterator <> nil) do begin
      if (uppercase(name) = uppercase(iterator^.name)) then begin
        result := iterator;
      end;
      iterator := iterator^.next;
    end;
  end;
//Получение веса по номеру
function getWeightByNum(node: TGraphList; num: integer): string;
  var
    first: integer;
    res: string;
  begin
    if (node <> nil) then begin
      dec(num);
      first := 1;
      while (num >= 0) do begin
        if (node^.ways[first] = '@') then
          dec(num);
        inc(first);
      end;
      inc(first);
      res := '';
      while (node^.ways[first] <> '*') do begin
        inc(first);
      end;
      inc(first);
      while (node^.ways[first] <> ' ') do begin
        inc(first);
      end;
      inc(first);
      while ((node^.ways[first] <> '@') and (first <= length(node^.ways))) do begin
        res := res + node^.ways[first];
        inc(first);
      end;
      result := res;
    end;
  end;
//Получение количества путей вершины
function getNumOfWays(node: TGraphList): integer;
  var
    iterator, numOfWays: integer;
  begin
    iterator := 1;
    numOfWays := 0;
    while (iterator <= length(node^.ways)) do begin
      if (node^.ways[iterator] = '@') then
        inc(numOfWays);
      inc(iterator);
    end;
    result := numOfWays;
  end;
//Получение степени вершины
function getDegreeOfNode(node: TGraphList): string;
  var
    degree, numOfWays: integer;
  begin
    degree := 0;
    numOfWays := getNumOfWays(node);
    while (numOfWays > 0) do begin
      if ((getDirectionByNum(node, numOfWays) = 1)
      or (getDirectionByNum(node, numOfWays) = 0)) then
        inc(degree);
      dec(numOfWays);
    end;
    result := inttostr(degree);
  end;
//Проверка существования пути
function isWayExist(node1, node2: TGraphList): boolean;
  begin
    if ((node1 <> nil) and (node2 <> nil) and (node1 <> node2)) then begin
      if ((pos('*' + node1^.name + '*', node2^.ways) > 0) and (pos('*' + node2^.name + '*', node1^.ways) > 0)) then result := true else
        result := false; 
    end;
  end;
//Проверка существования имени
function isNameExist(name: string): boolean;
  var
    iterator: TGraphList;
  begin
    iterator := graphList^.next;
    result := false;
    while (iterator <> nil) do begin
      if (uppercase(iterator^.name) = uppercase(name)) then result := true;
      iterator := iterator^.next;
    end;
  end;
//Подсчет всех вершины
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
//Запись полного графа в файл
procedure writeHoleGraphInFile(path: string);
  var
    graphFile: TextFile;
    iterator: TGraphList;
  begin
    assignFile(graphFile, path);
    rewrite(graphFile);
    iterator := graphList^.next;
    writeln(graphFile, countAllNodes());
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
//Удалени графа целиком
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
    graphList^.last := graphList;
  end;
//Парсинг из файла
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
//Подготовка к поиску кратчайшего пути
procedure prepareToSearch(fromNode: string);
  var
    iterator: TGraphList;
  begin
    iterator := graphList^.next;
    while(iterator <> nil) do begin
      iterator^.mark := false;
      if (uppercase(iterator^.name) = uppercase(fromNode)) then iterator^.distance := 0 else
        iterator^.distance := 1.7E37;
      iterator := iterator^.next;
    end;
  end;
//Проверка введенного веса на корректность
function checkWeight(weight: string): boolean;
  const
    rightNumbers = '0123456789,';
  var
    i: integer;
  begin
    result := true;
    for i := 1 to length(weight) do begin
      if (pos(weight[i], rightNumbers) <= 0) then result := false;
    end;
  end;
//Поиск кратчайшего пути
procedure waySearch(node: TGraphList);
  var
    numOfWays: integer;
    temp, minNode, iterator: TGraphList;
  begin
    node^.mark := true;
    numOfWays := getNumOfWays(node);
    shortestWay := shortestWay + node^.name;
    while(numOfWays > 0) do begin
      temp := getNodeByName(getWayByNum(node, numOfWays));
      if ((temp^.distance > (strtofloat(getWeightByNum(node, numOfWays)) + node^.distance))
      and (not temp^.mark) and ((getDirectionByNum(node, numOfWays) = 1) or (getDirectionByNum(node, numOfWays) = 0)))
      then temp^.distance := strtofloat(getWeightByNum(node, numOfWays)) + node^.distance;
      dec(numOfWays);
    end;
    numOfWays := getNumOfWays(node);
    minNode := nil;
    iterator := graphList^.next;
    while(iterator <> nil) do begin
      temp := iterator;
      if ((not temp^.mark) and (minNode = nil)) then minNode := temp;
      if (minNode <> nil) then begin
        if ((temp^.distance < minNode^.distance) and (not temp^.mark)) then minNode := temp;
      end;
      iterator := iterator^.next;
    end;
    if (minNode <> nil) then waySearch(minNode);
  end;

end.
