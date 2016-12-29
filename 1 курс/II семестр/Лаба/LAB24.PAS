Program LAB24;
Uses CRT;
Type
     pSpisok = ^Slova;
     Slova = Record
             Slv: String;
             Next: pSpisok;
             End;
Var
     Head1, Tail1, Head2, Tail2, Ptr1, Ptr2, Start1, Start2: pSpisok;
     St,Str: String;
     Name: String;
     F: Text;
     I, K: Integer;
BEGIN
     ClrScr;
     Write('Введите имя файла: ');
     ReadLn(Name);
     Assign(F, Name);
     Reset(F);
     Head1 := Nil;
     Tail1 := Nil;
     Head2 := Nil;
     Tail2 := Nil;
     ClrScr;
     While not EOF(F) do
     Begin
          ReadLn(F, St);
          New(Ptr1);
          Ptr1^.Slv := St;
          Ptr1^.Next := Nil;
          If Tail1 <> Nil then
             Tail1^.Next := Ptr1;
          Tail1 := Ptr1;
          If Head1 = Nil then
             Head1 := Ptr1;
     End;
     Ptr1^.Next := Head1;
     Ptr1 := Head1;
     Start1 := Head1;
     Repeat
          Str := Ptr1^.Slv;
          K:=0;
          For I := 2 to length(Str)-1 do
          If ( Str[I] = Str[1] ) and ( K=0 ) then
              Begin
                  Delete (Str, 2, I-2);
                  K:=1;
              End;
          New (Ptr2);
          Ptr2^.Slv := Str;
          Ptr2^.Next := Nil;
          If Tail2 <> Nil then
             Tail2^.Next := Ptr2;
          Tail2 := Ptr2;
          If Head2 = Nil then
             Head2 := Ptr2;
          Start1 := Ptr1^.Next;
          Ptr1 := Start1;
     Until Start1 = Head1;
     Ptr2^.Next := Head2;
     Start1 := Head1;
     Start2 := Head2;
     Ptr1 := Head1;
     Ptr2 := Head2;
     WriteLn('<Исходное слово>..........<Преобразованное слово>');
     WriteLn;
     Repeat
          Write(Ptr1^.Slv,'..........');
          WriteLn(Ptr2^.Slv);
          Start1 := Ptr1^.Next;
          Start2 := Ptr2^.Next;
          Ptr1 := Start1;
          Ptr2 := Start2;
     Until Start2 = Head2;
     Repeat until KeyPressed;
END.