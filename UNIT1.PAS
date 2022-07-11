unit Unit1;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, DdeMan;

type
  TForm1 = class(TForm)
    DdeClientConv1: TDdeClientConv;
    DdeClientItem1: TDdeClientItem;
    Memo1: TMemo;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DdeServerConv1: TDdeServerConv;
    DdeServerItem1: TDdeServerItem;
    procedure DdeClientItem1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DdeServerConv1ExecuteMacro(Sender: TObject; Msg: TStrings);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
var
  mas:array[0..31] of real;
  m:real;

procedure TForm1.DdeClientItem1Change(Sender: TObject);
var
  x1,y1,x2,y2,xn,yn,c:integer;
  i,k1,k2:byte;
  sum:real;
  s1:string[7];
  s2:string[2];
begin
 Memo1.Lines:=DdeClientItem1.Lines;
 sum:=0;
 for i:=0 to 31 do
  begin
    val(Memo1.Lines[i+1],mas[i],c);
    sum:=sum+mas[i];
  end;
 m:=sum/32;
 k1:=0; k2:=0;
 for i:=0 to 31 do if mas[i]>m then inc(k1) else inc(k2);
 str(k1,s2);
 Label6.Caption:=s2;
 str(k2,s2);
 Label7.Caption:=s2;
 str(m:7:2,s1);
 Label5.Caption:=s1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DdeClientItem1.DdeItem:='DdeServerItem1';
end;

procedure TForm1.DdeServerConv1ExecuteMacro(Sender: TObject;
  Msg: TStrings);
begin
  if Msg.Strings[0]='CloseProcess' then Close;
end;

end.
