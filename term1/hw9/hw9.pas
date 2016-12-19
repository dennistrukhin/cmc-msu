program hw9;

type
  Tdata = integer;
  PTree = ^Tree;
  Tree = record
    data: Tdata;
    left, right: PTree;
  end;

var
  my_tree: PTree;


function searchTree(data: integer; var tree, fnode: PTree): boolean;
var
  p, q: PTree;
  result: boolean;
begin
  result := false;
  p := tree;
  if tree <> nil then
    repeat
      q := p;
      if p^.data = data then
        result := true
      else
        begin
        if data < p^.data then
          p := p^.left
        else
          p := p^.right
        end;
    until result or (p = nil);
  searchTree := result;
  fnode := q;
end;


procedure addNode(data: integer; var tree: PTree);
var
  r, treeNode: PTree;
begin
  if not searchTree(data, tree, r) then begin
    new(treeNode);
    treeNode^.data := data;
    treeNode^.left := nil;
    treeNode^.right := nil;
    if tree = nil then
      tree := treeNode
    else
      if data < r^.data then
        r^.left := treeNode
      else
        r^.right := treeNode;
  end;
end;


begin
  new(my_tree);
  addNode(1, my_tree);
  addNode(2, my_tree);
end.
