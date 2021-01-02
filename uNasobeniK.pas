unit uNasobeniK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uMatice,CHILDWIN,uHodnoty,uZlomky,uKomplex,uZ2;

type
  TfrmNasobeniK = class(TForm)
    edtKonstanta: TEdit;
    Label1: TLabel;
    cmbMatice: TComboBox;
    Label2: TLabel;
    edtVysledek: TEdit;
    Label3: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Zobraz();
    { Public declarations }
  end;

var
  frmNasobeniK: TfrmNasobeniK;

implementation
   uses MAIN;
{$R *.dfm}

procedure TfrmNasobeniK.Zobraz();
var p:integer;
cindex:integer;
begin
  if MainForm.MDIChildCount=0 then exit;
  konecEditace();
  cindex:=-1;
  cmbMatice.Clear;
  for p:=0 to MainForm.MDIChildCount-1 do
   begin
     cmbMatice.Items.Add(MainForm.MDIChildren[p].Caption);
     if MainForm.ActiveMDIChild=MainForm.MDIChildren[p] then
      cindex:=p;
   end;
  if(cmbMatice.Items.Count>0) then
  begin
    cmbMatice.ItemIndex:=0;
  end;
  if cindex>-1 then
    cmbMatice.ItemIndex:=cmbMatice.Items.Count-1-cindex;
  ShowModal();
end;

procedure TfrmNasobeniK.btnCancelClick(Sender: TObject);
begin
close;
end;

procedure TfrmNasobeniK.btnOKClick(Sender: TObject);
var m:TMatice;
begin

try
m:=(MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).matice;
case m.typ of
  MT_R: m:=NasobKonstantouMatici(m,TZlomek.Create(edtKonstanta.Text));
  MT_C: m:=NasobKonstantouMatici(m,TKomplexniZlomek.Create(edtKonstanta.Text));
  MT_Z2: m:=NasobKonstantouMatici(m,TZ2Cislo.Create(edtKonstanta.Text));
end;
except
  exit;
end;

MainForm.VytvoritOknoMatice(NoveJmenoMatice(m,edtVysledek.Text));
close;
end;

end.
