program Grapher;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {mainForm},
  MathUnit in 'MathUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TmainForm, mainForm);
  Application.Run;
end.
