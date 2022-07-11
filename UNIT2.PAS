unit Unit2;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, VBXCtrl, Chartfx, Chart2fx, DdeMan;

type
  TForm1 = class(TForm)
    ChartFX1: TChartFX;
    Label1: TLabel;
    Memo1: TMemo;
    DdeClientConv1: TDdeClientConv;
    DdeClientItem1: TDdeClientItem;
    DdeServerConv1: TDdeServerConv;
    DdeServerItem1: TDdeServerItem;
    Procedure NewValue(Sender: TObject);
    Procedure SetMinMaxValue;
    procedure DdeClientItem1Change(Sender: TObject);
    procedure DdeServerConv1ExecuteMacro(Sender: TObject; Msg: TStrings);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

var mas:array[0..31]of real;

{$R *.DFM}

Function FindMinValue:real;
var
   i:byte;
   min:real;
begin
 min:=mas[0];
 for i:=1 to 31 do
   if mas[i]<min then min:=mas[i];
 FindMinValue:=min;
end;

Function FindMaxValue:real;
var
   i:byte;
   max:real;
begin
 max:=mas[0];
 for i:=1 to 31 do
   if mas[i]>max then max:=mas[i];
 FindMaxValue:=max;
end;

Procedure TForm1.SetMinMaxValue;
begin
 ChartFX1.ADM[Csa_MIN]:=round(FindMinVAlue);
 ChartFX1.ADM[CSA_MAX]:=round(FindMaxVAlue);
end;

Procedure TForm1.NewValue(Sender: TObject);
var
  i:byte;
begin
  for i:=0 to 31 do mas[i]:=800;
  DdeClientItem1.DdeItem:='DdeServerItem1'
end;


procedure TForm1.DdeClientItem1Change(Sender: TObject);
var
  y:real;
  c,i:integer;
begin
  Memo1.Lines:=DdeClientItem1.Lines;
  Memo1.Visible:=False;
  for i:=0 to 31 do
    val(Memo1.Lines[i+1],mas[i],c);
  SetMinMaxValue;
  ChartFX1.OpenData[1]:=1;
  for i:=0 to 31 do
    ChartFX1.Value[i]:=mas[i];
  ChartFX1.CloseData[1]:=1;
end;

procedure TForm1.DdeServerConv1ExecuteMacro(Sender: TObject;
  Msg: TStrings);
begin
  if Msg.Strings[0]='CloseProcess' then Close;
end;

end.
