{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/CODER/MODELRAILROADERSLIB-TP)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Unit SCALE;

INTERFACE

Procedure ScaleToRepresentation(S:String;Var Mesure,Representation:Real);
Function  ScaleToRepresentationString(S:String):String;
Function  RepresentionToScale(Mesure,Representation:Real):String;

IMPLEMENTATION

Type
 ScaleModelRailroadersRec=Record
  Dimension:String[2];
  ScaleMesure:Integer;
  ScaleRepresentation:Real;
 End;

Const
 ScaleModelRailroaders:Array[0..12]of ScaleModelRailroadersRec=(
  (Dimension:'II';ScaleMesure:1;ScaleRepresentation:22.5),
  (Dimension:'2';ScaleMesure:1;ScaleRepresentation:22.5),
  (Dimension:'I';ScaleMesure:1;ScaleRepresentation:32),
  (Dimension:'1';ScaleMesure:1;ScaleRepresentation:32),
  (Dimension:'0';ScaleMesure:1;ScaleRepresentation:48),
  (Dimension:'S';ScaleMesure:1;ScaleRepresentation:64),
  (Dimension:'00';ScaleMesure:1;ScaleRepresentation:76.2),
  (Dimension:'HO';ScaleMesure:1;ScaleRepresentation:87),
  (Dimension:'TT';ScaleMesure:1;ScaleRepresentation:120),
  (Dimension:'N';ScaleMesure:1;ScaleRepresentation:160),
  (Dimension:'Z';ScaleMesure:1;ScaleRepresentation:220),
  (Dimension:'ZZ';ScaleMesure:1;ScaleRepresentation:285),
  (Dimension:'T';ScaleMesure:1;ScaleRepresentation:450)
 );

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Procedure ScaleToRepresentation(S:String;Var Mesure,Representation:Real);
Var
 I:Integer;
Begin
 Mesure:=0.0;
 Representation:=0.0;
 For I:=Low(ScaleModelRailroaders)to High(ScaleModelRailroaders)do Begin
  If(StrToUpper(S)=ScaleModelRailroaders[I].Dimension)Then Begin
   Mesure:=ScaleModelRailroaders[I].ScaleMesure;
   Representation:=ScaleModelRailroaders[I].ScaleRepresentation;
   Exit;
  End;
 End;
End;

Function ScaleToRepresentationString(S:String):String;
Var
 Mesure,Representation:Real;
 ResultStr1,ResultStr2:String;
Begin
 ScaleToRepresentation(S,Mesure,Representation);
 Str(Mesure:1:0,ResultStr1);
 If Frac(Representation)=0.0 Then Begin
  Str(Representation:2:0,ResultStr1);
 End
  Else
 Str(Representation:2:1,ResultStr2);
 ScaleToRepresentationString:=ResultStr1+':'+ResultStr2;
End;

Function RepresentionToScale(Mesure,Representation:Real):String;
Var
 I:Integer;
Begin
 Mesure:=0.0;
 Representation:=0.0;
 For I:=Low(ScaleModelRailroaders)to High(ScaleModelRailroaders)do Begin
  If(Mesure=ScaleModelRailroaders[I].ScaleMesure)and
    (Representation=ScaleModelRailroaders[I].ScaleRepresentation)Then Begin
   RepresentionToScale:=ScaleModelRailroaders[I].Dimension;
   Exit;
  End;
 End;
End;

END.