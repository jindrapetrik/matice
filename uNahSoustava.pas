unit uNahSoustava;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uMatice,uKomplex,uZlomky,uHodnoty;

type
  TfrmNahodnaSoustava = class(TForm)
    grbKoeficienty: TGroupBox;
    rdbKoefCele: TRadioButton;
    rdbKoefZlomky: TRadioButton;
    grbKoreny: TGroupBox;
    rdbKorenyCele: TRadioButton;
    rdbKorenyZlomky: TRadioButton;
    btnOK: TButton;
    btnStorno: TButton;
    chkKoefKomplex: TCheckBox;
    chkKorenyKomplex: TCheckBox;
    lblRozsah: TLabel;
    edtKoefRozsah: TEdit;
    edtKorenyRozsah: TEdit;
    Label1: TLabel;
    procedure btnStornoClick(Sender: TObject);
    procedure edtKoefRozsahExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function zobraz(var m:TMatice):boolean;
  end;

var
  frmNahodnaSoustava: TfrmNahodnaSoustava;



implementation
{$R *.dfm}

procedure TfrmNahodnaSoustava.btnStornoClick(Sender: TObject);
begin
Close;
end;

function TfrmNahodnaSoustava.zobraz(var m:TMatice):boolean;
var n,x,y:integer;
nezname:array of THodnota;
soucet,h:THodnota;
rozsahKoef,rozsahKoreny:integer;
begin
  Result:=false;
  frmNahodnaSoustava.chkKoefKomplex.Visible:=m.typ=MT_C;
  frmNahodnaSoustava.chkKorenyKomplex.Visible:=m.typ=MT_C;
  if frmNahodnaSoustava.ShowModal()=mrCancel then exit;
  Result:=true;
  rozsahKoef:=strtointdef(frmNahodnaSoustava.edtKoefRozsah.Text,10);
  rozsahKoreny:=strtointdef(frmNahodnaSoustava.edtKorenyRozsah.Text,10);

  setlength(nezname,m.radku);
  for n := 0 to m.radku - 1 do
   begin
     if m.typ=MT_R then
     begin
       if frmNahodnaSoustava.rdbKorenyZlomky.Checked then
        begin
          nezname[n]:=TZlomek.Create(Random(rozsahKoreny),Random(rozsahKoreny-1)+1);
        end
        else
        begin
          nezname[n]:=TZlomek.Create(Random(rozsahKoreny));
        end;
     end;
     if m.typ=MT_C then
     begin
       if frmNahodnaSoustava.chkKorenyKomplex.Checked then
        begin
          if frmNahodnaSoustava.rdbKorenyZlomky.Checked then
           begin
             nezname[n]:=TKomplexniZlomek.Create(TZlomek.Create(Random(rozsahKoreny),Random(rozsahKoreny-1)+1),TZlomek.Create(Random(rozsahKoreny),Random(rozsahKoreny-1)+1));
           end
           else
           begin
             nezname[n]:=TKomplexniZlomek.Create(TZlomek.Create(Random(rozsahKoreny)),TZlomek.Create(Random(rozsahKoreny)));
           end;
        end
        else
        begin
          if frmNahodnaSoustava.rdbKorenyZlomky.Checked then
           begin
             nezname[n]:=TKomplexniZlomek.Create(TZlomek.Create(Random(rozsahKoreny),Random(rozsahKoreny-1)+1));
           end
           else
           begin
             nezname[n]:=TKomplexniZlomek.Create(TZlomek.Create(Random(rozsahKoreny)));
           end;
        end;
     end;
   end;

for x := 0 to m.radku - 1 do
for y := 0 to m.radku - 1 do
  begin
    if m.typ=MT_R then
     begin
       if frmNahodnaSoustava.rdbKoefZlomky.Checked then
        begin
          m.hodnoty[y,x]:=TZlomek.Create(Random(rozsahKoef),Random(rozsahKoef-1)+1);
        end
        else
        begin
          m.hodnoty[y,x]:=TZlomek.Create(Random(rozsahKoef));
        end;
     end;
     if m.typ=MT_C then
     begin
       if frmNahodnaSoustava.chkKoefKomplex.Checked then
        begin
          if frmNahodnaSoustava.rdbKoefZlomky.Checked then
           begin
             m.hodnoty[y,x]:=TKomplexniZlomek.Create(TZlomek.Create(Random(rozsahKoef),Random(rozsahKoef-1)+1),TZlomek.Create(Random(rozsahKoef),Random(rozsahKoef-1)+1));
           end
           else
           begin
             m.hodnoty[y,x]:=TKomplexniZlomek.Create(TZlomek.Create(Random(rozsahKoef)),TZlomek.Create(Random(rozsahKoef)));
           end;
        end
        else
        begin
          if frmNahodnaSoustava.rdbKoefZlomky.Checked then
           begin
             m.hodnoty[y,x]:=TKomplexniZlomek.Create(TZlomek.Create(Random(rozsahKoef),Random(rozsahKoef-1)+1));
           end
           else
           begin
             m.hodnoty[y,x]:=TKomplexniZlomek.Create(TZlomek.Create(Random(rozsahKoef)));
           end;
        end;
     end;
  end;

for y:=0 to m.radku-1 do
 begin
  soucet:=TZlomek.Create(0);
  if m.typ=MT_R then soucet:=TZlomek.Create(0);
  if m.typ=MT_C then soucet:=TKomplexniZlomek.Create(0);

  for x:=0 to m.sloupcu-2 do
  begin
    h:=m.hodnoty[y,x].kopie;
    h.nasob(nezname[x]);
    soucet.pricti(h);
  end;
 m.hodnoty[y,m.sloupcu-1]:=soucet;
 end;

end;

procedure TfrmNahodnaSoustava.edtKoefRozsahExit(Sender: TObject);
var i:integer;
begin
try
  i:=strtoint((Sender as TEdit).Text);
  if i<2 then (Sender as TEdit).Text:='10';
except
  (Sender as TEdit).Text:='10';
end;
end;

end.
