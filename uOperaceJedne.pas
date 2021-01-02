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
    OP_OPACNA:Caption:='Opaèná matice';
    OP_TRANSPONOVANA:Caption:='Transponovaná matice';
    OP_HORNITROJUH:Caption:='Horní trojúhelníková matice';
    OP_DOLNITROJUH:Caption:='Dolní trojúhelníková matice';
    OP_INVERZNI:Caption:='Inverzní matice';
    OP_JEDNOTKOVA:Caption:='Jednotková matice';
    OP_DIAGONALNI:Caption:='Diagonální matice';
    OP_ORIZNOUT:Caption:='Oøíznout matici';
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
       if MessageDlg('Gausovu eliminaci nelze provést. Má se uložit èásteèný výsledek?',mtWarning,[mbYes,mbNo],0)=mrNo then
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
       if MessageDlg('Gausovu eliminaci nelze provést. Má se uložit èásteèný výsledek?',mtWarning,[mbYes,mbNo],0)=mrNo then
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
        raise ENelze.Create('Inverzní matici lze vypoèítat jen pro ètvercovou matici n x n');
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
       MessageDlg('Inverzní matici nelze vypoèítat',mtError,[mbOk],0);
     end;
     (MainForm.MDIChildren[cmbMatice.ItemIndex] as TMDIChild).gauProgress.Visible:=false;
     end;
  end;

 if m2.chyba then
 if MainForm.mnuZpravaNepresne.Checked then
  begin
    MessageDlg('Pøi poèítání došlo k zaokrouhlovacím chybám, výsledek bude nepøesný.',mtWarning,[mbOK],0);
  end;
close;
end;

end.
