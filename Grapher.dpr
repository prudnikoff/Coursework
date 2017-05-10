program Grapher;

uses
  Forms,
  Unit1 in 'Unit1.pas' {mainForm},
  Unit2 in 'Unit2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TmainForm, mainForm);
  Application.Run;
end.
