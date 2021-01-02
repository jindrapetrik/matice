unit uOperaceJedne;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uMatice,CHILDWIN,uZlomky;

const
        OP_OPACNA=1;
        OP_TRANSPONOVANA=2;
        OP_HORNITROJUH=3;
        OP_DOLNITROJUH=4;
        OP_JEDNOTKOVA=5;
        OP_DIAGONALNI=6;
        OP_INVERZNI=7;
        OP_ORIZNOUT=8;

type
  TfrmOperaceJedne = class(TForm)
    Label3: TLabel;
    Label2: TLabel;
    cmbMatice: TComboBox;
    edtVysledek: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    poperace:integer;
    procedure Zobraz(operace:integer);

  end;

var
  frmOperaceJedne: TfrmOperaceJedne;

implementation
{$R *.dfm}

uses MAIN;

procedure TfrmOperaceJedne.Zobraz(operace:integer);
var p:integer;
cindex:integer;
begin
  if MainForm.MDIChildCount=0 then exit;
  konecEditace();
  poperace:=operace;
  case poperace of
    OP_OPACNA:Caption:='Opa�n� matice';
    OP_TRANSPONOVANA:Caption:='Transponovan� matice';
    OP_HORNITROJUH:Caption:='Horn� troj�heln�kov� matice';
    OP_DOLNITROJUH:Caption:='Doln� troj�heln�kov� matice';
    OP_INVERZNI:Caption:='Inverzn� matice';
    OP_JEDNOTKOVA:Caption:='Jednotkov� matice';
    OP_DIAGONALNI:Caption:='Diagon�ln� matice';
    OP_ORIZNOUT:Caption:='O��znout matici';
  end;
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
    cmbMatice.ItemIndex:=cindex;
  ShowModal();
end;

procedure TfrmOperaceJedne.btnCancelClick(Sender: TObject);
begin
close;
end;

procedure TfrmOperaceJedne.btnOKClick(Sender: TObject);
var m,m2:TMatice;
f:TMDIChild;
begin
hide;
f:=(MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild);
m:=f.matice;
m2:=m;

case poperace of
    OP_OPACNA:MainForm.VytvoritOknoMatice(NoveJmenoMatice(OpacnaMatice(m),edtVysledek.Text));
    OP_TRANSPONOVANA:MainForm.VytvoritOknoMatice(NoveJmenoMatice(TransponovatMatici(m),edtVysledek.Text));
    OP_ORIZNOUT:
     begin
        m2:=NoveJmenoMatice(Podmatice(m,
        f.stgMatice.Selection.Left-1,f.stgMatice.Selection.Top-1,
        f.stgMatice.Selection.Right-f.stgMatice.Selection.Left+1,
        f.stgMatice.Selection.Bottom-f.stgMatice.Selection.Top+1),edtVysledek.Text);
        MainForm.VytvoritOknoMatice(m2);
     end;
    OP_HORNITROJUH,OP_JEDNOTKOVA,OP_DIAGONALNI:
     begin
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Max:=m.radku;
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Position:=0;
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Visible:=true;
     try
       m2:=GaussovaEliminacniMetoda(m,(MainForm.mnuGaussJednicky.Checked or (poperace=OP_JEDNOTKOVA))and(poperace<>OP_DIAGONALNI),MainForm.mnuGaussCela.Checked);
       if(poperace=OP_JEDNOTKOVA)or(poperace=OP_DIAGONALNI) then
         m2:=ObracenaGaussovaEliminacniMetoda(m2,{(poperace=OP_JEDNOTKOVA)}false,(MainForm.mnuGaussCela.Checked)and (not (poperace=OP_JEDNOTKOVA)));
     except
       if MessageDlg('Gausovu eliminaci nelze prov�st. M� se ulo�it ��ste�n� v�sledek?',mtWarning,[mbYes,mbNo],0)=mrNo then
        exit;
       m2:=GaussovaEliminacniMetoda(m,MainForm.mnuGaussJednicky.Checked,MainForm.mnuGaussCela.Checked,true);
     end;
     m2.nazev:=edtVysledek.Text;
     MainForm.VytvoritOknoMatice(m2);
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Visible:=false;
     end;
    OP_DOLNITROJUH:
     begin
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Max:=m.radku;
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Position:=0;
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Visible:=true;
     try
       m2:=ObracenaGaussovaEliminacniMetoda(m,MainForm.mnuGaussJednicky.Checked,MainForm.mnuGaussCela.Checked);
     except
       if MessageDlg('Gausovu eliminaci nelze prov�st. M� se ulo�it ��ste�n� v�sledek?',mtWarning,[mbYes,mbNo],0)=mrNo then
        exit;
       m2:=ObracenaGaussovaEliminacniMetoda(m,MainForm.mnuGaussJednicky.Checked,MainForm.mnuGaussCela.Checked,true);
     end;
     m2.nazev:=edtVysledek.Text;
     MainForm.VytvoritOknoMatice(m2);
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Visible:=false;
     end;

     OP_INVERZNI:
     begin
     if(m.radku<>m.sloupcu) then
      begin
        raise ENelze.Create('Inverzn� matici lze vypo��tat jen pro �tvercovou matici n x n');
        exit;
      end;
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Max:=m.radku;
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Position:=0;
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Visible:=true;
     m2:=m;
     try
       m2:=InverzniMatice(m);
       m2.nazev:=edtVysledek.Text;
       MainForm.VytvoritOknoMatice(m2);
     except
       MessageDlg('Inverzn� matici nelze vypo��tat',mtError,[mbOk],0);
     end;
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Visible:=false;
     end;
  end;

 if m2.chyba then
 if MainForm.mnuZpravaNepresne.Checked then
  begin
    MessageDlg('P�i po��t�n� do�lo k zaokrouhlovac�m chyb�m, v�sledek bude nep�esn�.',mtWarning,[mbOK],0);
  end;
close;
end;

end.
