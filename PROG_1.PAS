unit Prog_1;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Grids, Menus, DdeMan;

type
  TForm1 = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    MainMenu1: TMainMenu;
    N2: TMenuItem;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Bevel2: TBevel;
    Memo1: TMemo;
    Memo2: TMemo;
    DdeClientConv1: TDdeClientConv;
    DdeClientItem1: TDdeClientItem;
    Memo3: TMemo;
    DdeServerConv1: TDdeServerConv;
    DdeServerItem1: TDdeServerItem;
    DdeClientConv2: TDdeClientConv;
    DdeClientItem2: TDdeClientItem;
    DdeClientConv3: TDdeClientConv;
    DdeClientItem3: TDdeClientItem;
    procedure FormCreate(Sender: TObject);
    procedure DdeClientItem1Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox3Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

var MacroStr:TStrings;


procedure TForm1.FormCreate(Sender: TObject);
var i:byte;
    s:string[2];
begin
  Memo1.Top:=300;
  Memo2.Lines.Clear;
  Memo2.Lines.Add('Зона колошника');
  for i:=0 to 31 do
    begin
     str(i+1:2,s);
     Memo2.Lines.Add(s);
    end;
  StringGrid1.Cols[0]:=Memo2.Lines;
  N7.Enabled:=False;
  N9.Enabled:=False;
  N11.Enabled:=False;
end;

procedure TForm1.DdeClientItem1Change(Sender: TObject);
begin
  Memo1.Visible:=False;
  Memo1.Lines:=DDEClientItem1.Lines;
  StringGrid1.Cols[1]:=Memo1.Lines;
  DDEServerItem1.Lines:=Memo1.Lines;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
 case CheckBox2.Checked of
  True:
     begin
      DDEClientItem1.DDEItem:='DdeServerItem1';
      DDEClientItem1.DDEConv:=DDEClientConv1;
      DDEClientConv1.SetLink('DDEs_1','DdeServerConv1');
      if not DDEClientConv1.OpenLink
        then MessageDlg('Не удалось запустить процесс.',mtError,[mbOk],0)
        else
         begin
          CheckBox2.Checked:=True;
          N7.Enabled:=True;
          N6.Enabled:=False;
         end;
     end;
  False:
     begin
      Memo3.Lines.Clear;
      Memo3.Lines.add('CloseProcess');
      DDEClientConv1.ExecuteMacroLines(Memo3.Lines,True);
     end;
 end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not CheckBox2.Checked
   then
    begin
      DDEClientItem1.DDEItem:='DdeServerItem1';
      DDEClientItem1.DDEConv:=DDEClientConv1;
      DDEClientConv1.SetLink('DDEs_1','DdeServerConv1');
      if not DDEClientConv1.OpenLink
        then MessageDlg('Не удалось запустить процесс.',mtError,[mbOk],0)
        else
         begin
          CheckBox2.Checked:=True;
          N7.Enabled:=True;
          N6.Enabled:=False;
         end;
    end;
  if not CheckBox1.Checked
   then
    begin
      DDEClientItem2.DDEItem:='DdeServerItem1';
      DDEClientItem2.DDEConv:=DDEClientConv2;
      DDEClientConv2.SetLink('DDEs_2','DdeServerConv1');
      if not DDEClientConv2.OpenLink
        then MessageDlg('Не удалось запустить процесс.',mtError,[mbOk],0)
        else
         begin
          CheckBox1.Checked:=True;
          N9.Enabled:=True;
          N8.Enabled:=False;
         end;
    end;
  if not CheckBox3.Checked
   then
    begin
      DDEClientItem3.DDEItem:='DdeServerItem1';
      DDEClientItem3.DDEConv:=DDEClientConv3;
      DDEClientConv3.SetLink('DDEs_3','DdeServerConv1');
      if not DDEClientConv3.OpenLink
        then MessageDlg('Не удалось запустить процесс.',mtError,[mbOk],0)
        else
         begin
          CheckBox3.Checked:=True;
          N11.Enabled:=True;
          N10.Enabled:=False;
         end;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 if CheckBox2.Checked
  then
   begin
     Memo3.Lines.Clear;
     Memo3.Lines.add('CloseProcess');
     CheckBox2.Checked:=False;
     DDEClientConv1.ExecuteMacroLines(Memo3.Lines,False);
     N7.Enabled:=False;
     N6.Enabled:=True;
   end;
 if CheckBox1.Checked
  then
   begin
     Memo3.Lines.Clear;
     Memo3.Lines.add('CloseProcess');
     CheckBox1.Checked:=False;
     DDEClientConv2.ExecuteMacroLines(Memo3.Lines,True);
     N9.Enabled:=False;
     N8.Enabled:=True;
   end;
 if CheckBox3.Checked
  then
   begin
     Memo3.Lines.Clear;
     Memo3.Lines.add('CloseProcess');
     CheckBox3.Checked:=False;
     DDEClientConv3.ExecuteMacroLines(Memo3.Lines,True);
     N11.Enabled:=False;
     N10.Enabled:=True;
   end;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  DDEClientItem1.DDEItem:='DdeServerItem1';
  DDEClientItem1.DDEConv:=DDEClientConv1;
  DDEClientConv1.SetLink('DDEs_1','DdeServerConv1');
  if not DDEClientConv1.OpenLink
    then MessageDlg('Не удалось запустить процесс.',mtError,[mbOk],0)
    else
     begin
      CheckBox2.Checked:=True;
      N7.Enabled:=True;
      N6.Enabled:=False;
     end;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  Memo3.Lines.Clear;
  Memo3.Lines.add('CloseProcess');
  CheckBox2.Checked:=False;
  DDEClientConv1.ExecuteMacroLines(Memo3.Lines,True);
  N7.Enabled:=False;
  N6.Enabled:=True;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
 case CheckBox1.Checked of
  True:
     begin
      DDEClientItem2.DDEItem:='DdeServerItem1';
      DDEClientItem2.DDEConv:=DDEClientConv2;
      DDEClientConv2.SetLink('DDEs_2','DdeServerConv1');
      if not DDEClientConv2.OpenLink
        then MessageDlg('Не удалось запустить процесс.',mtError,[mbOk],0)
        else
         begin
          CheckBox1.Checked:=True;
          N9.Enabled:=True;
          N8.Enabled:=False;
         end;
     end;
  False:
     begin
      Memo3.Lines.Clear;
      Memo3.Lines.add('CloseProcess');
      DDEClientConv2.ExecuteMacroLines(Memo3.Lines,True);
     end;
 end;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  DDEClientItem2.DDEItem:='DdeServerItem1';
  DDEClientItem2.DDEConv:=DDEClientConv2;
  DDEClientConv2.SetLink('DDEs_2','DdeServerConv1');
  if not DDEClientConv2.OpenLink
    then MessageDlg('Не удалось запустить процесс.',mtError,[mbOk],0)
    else
     begin
      CheckBox1.Checked:=True;
      N9.Enabled:=True;
      N8.Enabled:=False;
     end;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  Memo3.Lines.Clear;
  Memo3.Lines.add('CloseProcess');
  CheckBox1.Checked:=False;
  DDEClientConv2.ExecuteMacroLines(Memo3.Lines,True);
  N9.Enabled:=False;
  N8.Enabled:=True;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Button2Click(Sender);
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
 case CheckBox3.Checked of
  True:
     begin
      DDEClientItem3.DDEItem:='DdeServerItem1';
      DDEClientItem3.DDEConv:=DDEClientConv3;
      DDEClientConv3.SetLink('DDEs_3','DdeServerConv1');
      if not DDEClientConv3.OpenLink
        then MessageDlg('Не удалось запустить процесс.',mtError,[mbOk],0)
        else
         begin
          CheckBox3.Checked:=True;
          N11.Enabled:=True;
          N10.Enabled:=False;
         end;
     end;
  False:
     begin
      Memo3.Lines.Clear;
      Memo3.Lines.add('CloseProcess');
      DDEClientConv3.ExecuteMacroLines(Memo3.Lines,True);
     end;
 end;
end;

procedure TForm1.N10Click(Sender: TObject);
begin
  DDEClientItem3.DDEItem:='DdeServerItem1';
  DDEClientItem3.DDEConv:=DDEClientConv3;
  DDEClientConv3.SetLink('DDEs_3','DdeServerConv1');
  if not DDEClientConv3.OpenLink
    then MessageDlg('Не удалось запустить процесс.',mtError,[mbOk],0)
    else
     begin
      CheckBox3.Checked:=True;
      N11.Enabled:=True;
      N10.Enabled:=False;
     end;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
  Memo3.Lines.Clear;
  Memo3.Lines.add('CloseProcess');
  CheckBox3.Checked:=False;
  DDEClientConv3.ExecuteMacroLines(Memo3.Lines,True);
  N11.Enabled:=False;
  N10.Enabled:=True;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  Button2Click(sender);
  Close;
end;

end.
