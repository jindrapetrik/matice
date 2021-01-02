program Mdiapp;

uses
  Forms,
  MAIN in 'MAIN.PAS' {MainForm},
  CHILDWIN in 'CHILDWIN.PAS' {MDIChild},
  about in 'about.pas' {AboutBox},
  uMatice in 'uMatice.pas',
  uZlomky in 'uZlomky.pas',
  uOperace in 'uOperace.pas' {frmOperaceDvou},
  uNasobeniK in 'uNasobeniK.pas' {frmNasobeniK},
  uOperaceJedne in 'uOperaceJedne.pas' {frmOperaceJedne},
  uKomplex in 'uKomplex.pas',
  uPridat in 'uPridat.pas' {frmPridat},
  uExport in 'uExport.pas' {frmExport},
  uHodnoty in 'uHodnoty.pas',
  uDebug in 'uDebug.pas' {frmDebug},
  uZ2 in 'uZ2.pas',
  uFormat in 'uFormat.pas' {frmFormat},
  uNahSoustava in 'uNahSoustava.pas' {frmNahodnaSoustava};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Matice 2';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TfrmOperaceDvou, frmOperaceDvou);
  Application.CreateForm(TfrmNasobeniK, frmNasobeniK);
  Application.CreateForm(TfrmOperaceJedne, frmOperaceJedne);
  Application.CreateForm(TfrmPridat, frmPridat);
  Application.CreateForm(TfrmExport, frmExport);
  Application.CreateForm(TfrmDebug, frmDebug);
  Application.CreateForm(TfrmFormat, frmFormat);
  Application.CreateForm(TfrmNahodnaSoustava, frmNahodnaSoustava);
  Application.Run;
end.
