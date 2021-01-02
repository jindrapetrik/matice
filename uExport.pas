unit uExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uMatice,FreeExcelSylk, ExtCtrls,uKomplex,uZlomky,uZ2;

type
  TfrmExport = class(TForm)
    cmbFormat: TComboBox;
    lblFormat: TLabel;
    grbMoznosti: TGroupBox;
    btnOK: TButton;
    btnStorno: TButton;
    chkNazev: TCheckBox;
    chkRamecek: TCheckBox;
    chkOdReseni: TCheckBox;
    dlgExport: TSaveDialog;
    chkOcislovat: TCheckBox;
    chkOdsadit: TCheckBox;
    chkOcisTucne: TCheckBox;
    pnlZlomky: TPanel;
    rdbZlomkyPrevest: TRadioButton;
    rdbZlomkyText: TRadioButton;
    lblZlomky: TLabel;
    pnlKomplex: TPanel;
    lblKomplex: TLabel;
    rdbKomplexVlozitText: TRadioButton;
    rdbKomplexReaIm: TRadioButton;
    procedure btnStornoClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkOcislovatClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Zobrazit(nm:TMatice);
  end;

var
  frmExport: TfrmExport;
  m:TMatice;
implementation

procedure TfrmExport.Zobrazit(nm:TMatice);
begin
m:=nm;
chkOdReseni.Enabled:=m.soustava;
if (not m.soustava) and chkOdReseni.Checked then
 chkOdReseni.Checked:=false;

pnlKomplex.Visible:=m.typ=MT_C;
pnlZlomky.Visible:=m.typ<>MT_Z2;
showModal();
end;

{$R *.dfm}

procedure TfrmExport.btnStornoClick(Sender: TObject);
begin
close;
end;

procedure TfrmExport.btnOKClick(Sender: TObject);
var xls:TFreeExcelS;
x,y:integer;
border,border2:TColumnsBorders;
odsadY:integer;
odsadX:integer;
kz:TKomplexniZlomek;
z:TZlomek;
z2:TZ2Cislo;
begin
if dlgExport.Execute then
begin
       try
       xls:=TFreeExcelS.Create(dlgExport.FileName);
       odsadX:=0;
       odsadY:=0;
       if chkOdsadit.Checked then
        begin
          odsadY:=1;
          odsadX:=1;
        end;
       if chkNazev.Checked then
       begin
         xls.Retezec(1+odsadY,1+odsadX,m.nazev);
         odsadY:=odsadY+1;
       end;

       if chkOcislovat.Checked then
       begin
         if chkOcisTucne.Checked then
          xls.SetFontType([B]);


         for y:=0 to m.radku-1 do
          xls.NumericType(1+odsadY+y+1,1+odsadX,y+1,0);
         for x:=0 to m.sloupcu-1 do
          begin
            if rdbKomplexReaIm.Checked and (m.typ=MT_C) then
            begin
              xls.Retezec(1+odsadY,1+odsadX+1+x*2,inttostr(x+1)+' Re');
              xls.Retezec(1+odsadY,1+odsadX+1+x*2+1,inttostr(x+1)+' Im');
            end
            else
             xls.NumericType(1+odsadY,1+odsadX+x+1,x+1,0);
          end;
         if m.soustava then
          if rdbKomplexReaIm.Checked and (m.typ=MT_C) then
            begin
              xls.Retezec(1+odsadY,1+odsadX+m.sloupcu*2-1,'= Re');
              xls.Retezec(1+odsadY,1+odsadX+m.sloupcu*2,'= Im');
            end
            else
              xls.Retezec(1+odsadY,1+odsadX+m.sloupcu,'=');
         odsadX:=odsadX+1;
         odsadY:=odsadY+1;
         xls.SetFontType([]);
       end;

       for y:=0 to m.radku-1 do
       begin
        for x:=0 to m.sloupcu-1 do
         begin
           border:=[];
           border2:=[];
           if chkRamecek.Checked then
            begin
              if x=0 then border:=border+[BoLeft];
              if y=0 then
               begin
                 border:=border+[BoTop];
                 border2:=border2+[BoTop];
               end;
              if x=m.sloupcu-1 then
               begin
                 if rdbKomplexReaIm.Checked and (m.typ=MT_C) then
                  border2:=border2+[BoRight]
                 else
                  border:=border+[BoRight];
               end;
              if y=m.radku-1 then
               begin
                 border:=border+[BoBottom];
                 border2:=border2+[BoBottom];
               end;
            end;
           if chkOdReseni.Checked then
            if (m.soustava)and(x=m.sloupcu-1) then
             border:=border+[BoLeft];

           xls.SetBorder(border);
           if rdbKomplexReaIm.Checked and (m.typ=MT_C) then
           begin
              kz:=m.hodnoty[y,x] as TKomplexniZlomek;
              if(rdbZlomkyPrevest.Checked)then
               begin
                 xls.NumericType(y+1+odsadY,1+odsadX+x*2,kz.Re.desetinneCislo,0);
                 xls.SetBorder(border2);
                 xls.NumericType(y+1+odsadY,1+odsadX+x*2+1,kz.Im.desetinneCislo,0);
               end
              else
               begin
                 xls.Retezec(y+1+odsadY,1+odsadX+x*2,kz.Re.retezec);
                 xls.SetBorder(border2);
                 xls.Retezec(y+1+odsadY,1+odsadX+x*2+1,kz.Im.retezec);
               end;
           end
           else
           begin
             case m.typ of
             MT_R:
               begin
                 z:=m.hodnoty[y,x] as TZlomek;
                 if(rdbZlomkyPrevest.Checked)then
                   xls.NumericType(y+1+odsadY,x+1+odsadX,z.desetinneCislo,0)
                  else
                   xls.Retezec(y+1+odsadY,x+1+odsadX,z.retezec);
               end;
             MT_C:
               begin
                 kz:=m.hodnoty[y,x] as TKomplexniZlomek;
                 if kz.Im.jeNula then
                 begin
                  if(rdbZlomkyPrevest.Checked)then
                   xls.NumericType(y+1+odsadY,x+1+odsadX,kz.Re.desetinneCislo,0)
                  else
                   xls.Retezec(y+1+odsadY,x+1+odsadX,kz.Re.retezec);
                 end
                 else
                 begin
                  if(rdbZlomkyPrevest.Checked)then
                   xls.Retezec(y+1+odsadY,x+1+odsadX,kz.retezecDesetiny)
                  else
                   xls.Retezec(y+1+odsadY,x+1+odsadX,kz.retezec)
                 end;
               end;
             MT_Z2:
               begin
                 z2:=m.hodnoty[y,x] as TZ2Cislo;
                 xls.NumericType(y+1+odsadY,x+1+odsadX,z2.getHodnota,0);
               end;
             end;
           end;
         end;
       end;

       xls.Destroy;
       except
         raise Exception.Create('Nelze zapisovat do souboru.');
       end;
       close;
end;
end;

procedure TfrmExport.chkOcislovatClick(Sender: TObject);
begin
chkOcisTucne.Enabled:=chkOcislovat.Checked;
end;

end.
