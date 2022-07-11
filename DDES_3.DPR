program Ddes_3;

uses
  Forms,
  Unit1 in 'UNIT1.PAS' {Form1};

{$R *.RES}

begin
  Application.Title := 'Подача шихты';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
