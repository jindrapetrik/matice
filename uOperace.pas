unit uOperace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uMatice,CHILDWIN;

const
        OP_ZADNA=0;
        OP_SCITANI=1;
        OP_ODCITANI=2;
        OP_NASOBENI=3;

type
  TfrmOperaceDvou = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    cmbMatice1: TComboBox;
    cmbMatice2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtVysledek: TEdit;
    Label3: TLabel;
    procedure Zobraz(operace:integer);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);

  private
    poperace:integer;
    { Private declarations }
  public
    { Public declarations }
  end;



var
  frmOperaceDvou: TfrmOperaceDvou;

implementation
  uses MAIN;
{$R *.dfm}

procedure TfrmOperaceDvou.Zobraz(operace:integer);
var p:integer;
cindex:integer;
begin
  if MainForm.MDIChildCount=0 then exit;

  konecEditace();
  poperace:=operace;

  case poperace of
  OP_SCITANI:Caption:='Sèítání';
  OP_ODCITANI:Caption:='Odèítání';
  OP_NASOBENI:Caption:='Násobení';
  end;
  cindex:=-1;
  cmbMatice1.Clear;
  cmbMatice2.Clear;
  for p:=0 to MainForm.MDIChildCount-1 do
   begin
     cmbMatice1.Items.Add(MainForm.MDIChildren[p].Caption);
     cmbMatice2.Items.Add(MainForm.MDIChildren[p].Caption);
     if MainForm.ActiveMDIChild=MainForm.MDIChildren[p] then
      cindex:=p;
   end;
  if(cmbMatice1.Items.Count>0) then
  begin
    cmbMatice1.ItemIndex:=0;
    cmbMatice2.ItemIndex:=0;
  end;
  if cindex>=0 then
   begin
     cmbMatice1.ItemIndex:=cindex;
     cmbMatice2.ItemIndex:=cindex;
   end;
  ShowModal();
end;

procedure TfrmOperaceDvou.btnCancelClick(Sender: TObject);
begin
close;
end;

procedure TfrmOperaceDvou.btnOKClick(Sender: TObject);
var m1,m2:TMatice;
begin


m1:=(MainForm.MDIChildren[cmbMatice1.ItemIndex] as TMDIChild).matice;
m2:=(MainForm.MDIChildren[cmbMatice2.ItemIndex] as TMDIChild).matice;


case poperace of
  OP_SCITANI:MainForm.VytvoritOknoMatice(NoveJmenoMatice(SectiMatice(m1,m2),edtVysledek.Text));
  OP_ODCITANI:MainForm.VytvoritOknoMatice(NoveJmenoMatice(OdectiMatice(m1,m2),edtVysledek.Text));
  OP_NASOBENI:MainForm.VytvoritOknoMatice(NoveJmenoMatice(NasobMatice(m1,m2),edtVysledek.Text));
end;
close;
end;

end.
