unit Unit3;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin, Grids, DdeMan;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Bevel1: TBevel;
    StringGrid1: TStringGrid;
    SpinEdit1: TSpinEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Bevel2: TBevel;
    Timer1: TTimer;
    DdeServerConv1: TDdeServerConv;
    DdeServerItem1: TDdeServerItem;
    Edit1: TEdit;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure DdeServerConv1ExecuteMacro(Sender: TObject; Msg: TStrings);
    procedure StringGrid1SelectCell(Sender: TObject; Col, Row: Longint;
      var CanSelect: Boolean);
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
  mas:array[0..31]of real;
  StrLines:TStrings;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i:byte;
  S:string[7];
begin
 if RadioButton1.Checked=True then
  begin
   randomize;
   Memo1.Lines.Clear;
   Memo1.Lines.Add('Температура,°С');
   for i:=0 to 31 do
    begin
     mas[i]:=800+400*random;
     str(mas[i]:7:2,s);
     Memo1.Lines.add(s);
    end;
   StringGrid1.Cols[1]:=Memo1.Lines;
   DdeServerItem1.Lines:=Memo1.Lines;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  s:string[2];
  i:byte;
begin
  RadioButton1.Checked:=True;
  Memo2.Lines.Clear;
  Memo2.Lines.Add('Зона колошника');
  for i:=0 to 31 do
    begin
     str(i+1:2,s);
     Memo2.Lines.Add(s);
    end;
  StringGrid1.Cols[0]:=Memo2.Lines;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  Timer1.Interval:=1000*SpinEdit1.Value;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  RadioButton1.Checked:=False;
  RadioButton2.Checked:=True;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
var s:string[7];
    v:real;
    c,i:integer;
begin
  S:=Edit1.Text;
  val(S,V,C);
  if c<>0 then
   begin
    MessageDlg('Неверный ввод числового значения',mtError,[mbOk],0);
    Edit1.Text:='0';
   end
   else
    begin
     mas[StringGrid1.Row-1]:=V;
     Memo1.Lines.Clear;
     Memo1.Lines.Add('Температура,°С');
     for i:=0 to 31 do
      begin
       str(mas[i]:7:2,s);
       Memo1.Lines.add(s);
      end;
     StringGrid1.Cols[1]:=Memo1.Lines;
     DdeServerItem1.Lines:=Memo1.Lines;
    end;
  end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then StringGrid1.SetFocus;
end;

procedure TForm1.DdeServerConv1ExecuteMacro(Sender: TObject;
  Msg: TStrings);
begin
  if Msg.Strings[0]='CloseProcess' then Close;
end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; Col, Row: Longint;
  var CanSelect: Boolean);
begin
  Edit1.Text:=StringGrid1.Cells[1,StringGrid1.Row];
end;

end.
