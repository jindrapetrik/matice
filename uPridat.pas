unit uPridat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls;

type
  TfrmPridat = class(TForm)
    cmbUmisteni: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    btnOK: TButton;
    btnStorno: TButton;
    updPocet: TUpDown;
    edtPocet: TEdit;
    procedure btnStornoClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    prType:integer;
    { Private declarations }
  public
    { Public declarations }
    procedure Zobraz(nprType:integer);
  end;

const
  PRP_ZACATEK=0;
  PRP_PREDVYBER=1;
  PRP_ZAVYBER=2;
  PRP_KONEC=3;

  PRT_RADKY=0;
  PRT_SLOUPCE=1;
var
  frmPridat: TfrmPridat;

implementation
 uses MAIN,CHILDWIN;
{$R *.dfm}

procedure TfrmPridat.Zobraz(nprType:integer);
begin
  konecEditace();
  prType:=nprType;
  case prType of
    PRT_RADKY:Caption:='Pøidat øádky';
    PRT_SLOUPCE:Caption:='Pøidat sloupce';
  end;
  showmodal();
end;

procedure TfrmPridat.btnStornoClick(Sender: TObject);
begin
close;
end;

procedure TfrmPridat.btnOKClick(Sender: TObject);
var pocet,pozice,maxpozice:integer;
begin
pocet:=strtointdef(edtPocet.Text,1);
maxpozice:=0;
pozice:=0;
case prType of
   PRT_RADKY:
    begin
      pozice:=(MainForm.ActiveMDIChild AS TMDIChild).stgMatice.Selection.Top-1;
      maxpozice:=(MainForm.ActiveMDIChild AS TMDIChild).matice.radku;
    end;
   PRT_SLOUPCE:
     begin
       pozice:=(MainForm.ActiveMDIChild AS TMDIChild).stgMatice.Selection.Left-1;
       maxpozice:=(MainForm.ActiveMDIChild AS TMDIChild).matice.sloupcu;
     end;
end;

case cmbUmisteni.ItemIndex of
    PRP_ZACATEK:pozice:=0;
    PRP_PREDVYBER:pozice:=pozice;
    PRP_ZAVYBER:pozice:=pozice+1;
    PRP_KONEC:pozice:=maxpozice;
end;

case prType of
   PRT_RADKY:(MainForm.ActiveMDIChild AS TMDIChild).matice.VlozitRadky(pocet,pozice);
   PRT_SLOUPCE:(MainForm.ActiveMDIChild AS TMDIChild).matice.VlozitSloupce(pocet,pozice);
end;

(MainForm.ActiveMDIChild AS TMDIChild).ObnovitMatici();
close;
end;

end.
