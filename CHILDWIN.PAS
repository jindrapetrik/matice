unit CHILDWIN;

interface

uses Windows, Classes,dialogs, Graphics,sysutils, Forms, Controls, StdCtrls, ExtCtrls, Grids,uMatice,uZlomky,
  Gauges, Buttons,uKomplex,uHodnoty,uZ2,uDebug, ComCtrls;

type
  TMDIChild = class(TForm)
    stgMatice: TStringGrid;
    shpBilo: TShape;
    shpMatice: TShape;
    pnlParametry: TPanel;
    lblDeterminant: TLabel;
    edtDeterminant: TEdit;
    edtHodnost: TEdit;
    lblHodnost: TLabel;
    btnPrepocitat: TButton;
    chkPrepocitavat: TCheckBox;
    btnSkryt: TButton;
    gauProgress: TProgressBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure stgMaticeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure stgMaticeDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure btnPrepocitatClick(Sender: TObject);
    procedure stgMaticeSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure btnSkrytClick(Sender: TObject);
    procedure stgMaticeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure stgMaticeRowMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure stgMaticeColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure FormDeactivate(Sender: TObject);

  private
    { Private declarations }
    pnazevsouboru:string;
    procedure setNazevSouboru(nnazevsouboru:string);
  public
    matice:TMatice;
    selectedCell:TPoint;
    zavreno:boolean;
    property nazevsouboru:string read pnazevsouboru write setNazevSouboru;
    procedure ObnovitMatici();
    procedure ZobrazParametry();
    { Public declarations }
  end;



  procedure konecEditace();
implementation

uses MAIN;

{$R *.dfm}

procedure TMDIChild.setNazevSouboru(nnazevsouboru:string);
begin
 pnazevsouboru:=nnazevsouboru;
 if(matice<>nil) then
  Caption:=matice.nazev + '('+vratPismeno(matice.typ)+')';
 if(pnazevsouboru<>'') then
  Caption:=Caption+' ['+extractfilename(pnazevsouboru)+']';
end;

procedure TMDIChild.ZobrazParametry();
begin
konecEditace();
if not pnlParametry.Visible then
begin
  pnlParametry.Show;
  width:=width+pnlParametry.Width;
  shpMatice.Align:=alClient;
  shpBilo.Width:=pnlParametry.Left-60;
  stgMatice.Width:=pnlParametry.Left-32;
end;
btnPrepocitat.OnClick(btnPrepocitat);
end;

procedure konecEditace();
var b:boolean;
begin
 b:=true;
 if(MainForm.ActiveMDIChild<>nil) then
 (MainForm.ActiveMDIChild as TMDIChild).stgMatice.OnSelectCell(nil, (MainForm.ActiveMDIChild as TMDIChild).selectedCell.X+1, (MainForm.ActiveMDIChild as TMDIChild).selectedCell.Y+1,b);
end;

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  matice.Destroy;
  zavreno:=true;
  if MainForm.MDIChildCount=1 then
  begin
    MainForm.mnuMatice.Enabled:=false;
    MainForm.mnuRadky.Enabled:=false;
    MainForm.mnuSloupce.Enabled:=false;
    MainForm.mnuNahodne.Enabled:=false;
    MainForm.mnuNahodneSoustava.Enabled:=false;
    MainForm.mnuTransponovat.Enabled:=false;
    MainForm.mnuOpacna.Enabled:=false;
    MainForm.mnuInverzni.Enabled:=false;
    MainForm.mnuNasobitK.Enabled:=false;
    MainForm.mnuHorniTrojuh.Enabled:=false;
    MainForm.mnuDolniTrojuh.Enabled:=false;
    MainForm.mnuJednotkova.Enabled:=false;
    MainForm.mnuScitat.Enabled:=false;
    MainForm.mnuOdecitat.Enabled:=false;
    MainForm.mnuNasobit.Enabled:=false;

    MainForm.tobNahodne.Enabled:=false;
    MainForm.tobTransponovat.Enabled:=false;
    MainForm.tobOpacna.Enabled:=false;
    MainForm.tobInverzni.Enabled:=false;
    MainForm.tobNasobitK.Enabled:=false;
    MainForm.tobHorniTrojuh.Enabled:=false;
    MainForm.tobDolniTrojuh.Enabled:=false;
    MainForm.tobJednotkova.Enabled:=false;
    MainForm.tobScitat.Enabled:=false;
    MainForm.tobOdcitat.Enabled:=false;
    MainForm.tobNasobit.Enabled:=false;
    MainForm.tobUlozit.Enabled:=false;
    MainForm.mnuUlozit.Enabled:=false;
    MainForm.mnuUlozitJako.Enabled:=false;

    MainForm.tobDiagonalni.Enabled:=false;
    MainForm.mnuDiagonalni.Enabled:=false;
    MainForm.tobZobrazitParametry.Enabled:=false;
    MainForm.mnuZobrazitParametry.Enabled:=false;
    MainForm.tobNahodneSoustava.Enabled:=false;

    MainForm.tobVybrat.Enabled:=false;
    MainForm.mnuVybrat.Enabled:=false;

    MainForm.mnuOriznout.Enabled:=false;
    MainForm.tobOriznout.Enabled:=false;

    MainForm.tobRadkyPridat.Enabled:=false;
    MainForm.tobRadkyOdebrat.Enabled:=false;
    MainForm.tobSloupcePridat.Enabled:=false;
    MainForm.tobSloupceOdebrat.Enabled:=false;
    MainForm.tobNazev.Enabled:=false;
    MainForm.mnuNazev.Enabled:=false;

    MainForm.mnuExport.Enabled:=false;
  end;
  
end;

procedure TMDIChild.FormCreate(Sender: TObject);
begin
nazevsouboru:='';
zavreno:=false;
selectedCell.X:=0;
selectedCell.Y:=0;
end;

procedure TMDIChild.ObnovitMatici();
var x,y:integer;
begin
stgMatice.RowCount:=matice.radku+1;
stgMatice.ColCount:=matice.sloupcu+1;
for x:=0 to matice.sloupcu-1 do
 for y:=0 to matice.radku-1 do
  begin
    stgMatice.Cells[x+1,y+1]:=matice.hodnoty[y,x].retezec;
  end;

end;

procedure TMDIChild.stgMaticeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin

if zavreno then exit;
frmDebug.lblClassName.Caption:=matice.hodnoty[ARow-1,ACol-1].ClassName;
if(matice.hodnoty[ARow-1,ACol-1] is TZlomek) then
 frmDebug.lblOrigType.Caption:=inttostr((matice.hodnoty[ARow-1,ACol-1] as TZlomek).origFormat);

if(selectedCell.X>=matice.sloupcu) then selectedCell.X:=0;
if(selectedCell.Y>=matice.radku)then  selectedCell.Y:=0;

try
  if matice.typ=MT_C then matice.hodnoty[selectedCell.Y][selectedCell.X]:=TKomplexniZlomek.Create(stgMatice.Cells[selectedCell.X+1,selectedCell.Y+1]);
  if matice.typ=MT_R then matice.hodnoty[selectedCell.Y][selectedCell.X]:=TZlomek.Create(stgMatice.Cells[selectedCell.X+1,selectedCell.Y+1]);
  if matice.typ=MT_Z2 then matice.hodnoty[selectedCell.Y][selectedCell.X]:=TZ2Cislo.Create(stgMatice.Cells[selectedCell.X+1,selectedCell.Y+1]);
except

end;

stgMatice.Cells[selectedCell.X+1,selectedCell.Y+1]:=matice.hodnoty[selectedCell.Y][selectedCell.X].retezec;


selectedCell.X:=ACol-1;
selectedCell.Y:=ARow-1;
if chkPrepocitavat.Checked then btnPrepocitat.OnClick(btnPrepocitat);
end;

procedure TMDIChild.stgMaticeDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if(ACol=0)and(ARow>0) then
 begin
   stgMatice.Canvas.TextOut(Rect.Left+(Rect.Right-Rect.Left)div 2-(length(inttostr(ARow))*5 div 2),Rect.Top+5,inttostr(ARow));
 end;
if(ACol>0)and(ARow=0) then
 begin
   if(matice.soustava)and(ACol=matice.sloupcu) then
    stgMatice.Canvas.TextOut(Rect.Left+((Rect.Right-Rect.Left)div 2)-4,Rect.Top+5,'=')
   else
    stgMatice.Canvas.TextOut(Rect.Left+((Rect.Right-Rect.Left)div 2)-(length(inttostr(ACol))*5 div 2),Rect.Top+5,inttostr(ACol));

 end;
if matice.soustava then
 if ACol=matice.sloupcu then
  begin
    stgMatice.Canvas.Pen.Color:=clBlack;
    stgMatice.Canvas.MoveTo(Rect.Left,Rect.Top);
    stgMatice.Canvas.LineTo(Rect.Left,Rect.Bottom);
  end;
end;



procedure TMDIChild.FormActivate(Sender: TObject);
begin

MainForm.mnuNahodne.Enabled:=true;
MainForm.mnuMatice.Enabled:=true;
MainForm.mnuRadky.Enabled:=true;
MainForm.mnuSloupce.Enabled:=true;

if matice<>nil then
MainForm.mnuNahodneSoustava.Enabled:=matice.sloupcu=matice.radku+1;
MainForm.tobNahodneSoustava.Enabled:=MainForm.mnuNahodneSoustava.Enabled;
MainForm.mnuTransponovat.Enabled:=true;
MainForm.mnuOpacna.Enabled:=true;
MainForm.mnuInverzni.Enabled:=true;
MainForm.mnuNasobitK.Enabled:=true;
MainForm.mnuHorniTrojuh.Enabled:=true;
MainForm.mnuDolniTrojuh.Enabled:=true;
MainForm.mnuJednotkova.Enabled:=true;
MainForm.mnuScitat.Enabled:=true;
MainForm.mnuOdecitat.Enabled:=true;
MainForm.mnuNasobit.Enabled:=true;
if matice<>nil then
 begin
   MainForm.mnuNahodne.Enabled:=matice.typ<>MT_Z2;
   MainForm.tobNahodne.Enabled:=matice.typ<>MT_Z2;
   MainForm.mnuPNahodneKomplex.Enabled:=matice.typ=MT_C;
   MainForm.mnuPNahodnaSoustava.Enabled:=matice.soustava;
   MainForm.mnuNahodneKomplex.Enabled:=matice.typ=MT_C;
 end;

MainForm.tobTransponovat.Enabled:=true;
MainForm.tobOpacna.Enabled:=true;
MainForm.tobInverzni.Enabled:=true;
MainForm.tobNasobitK.Enabled:=true;
MainForm.tobHorniTrojuh.Enabled:=true;
MainForm.tobDolniTrojuh.Enabled:=true;
MainForm.tobJednotkova.Enabled:=true;
MainForm.tobScitat.Enabled:=true;
MainForm.tobOdcitat.Enabled:=true;
MainForm.tobNasobit.Enabled:=true;

MainForm.tobUlozit.Enabled:=true;
MainForm.mnuUlozit.Enabled:=true;
MainForm.mnuUlozitJako.Enabled:=true;

MainForm.tobDiagonalni.Enabled:=true;
MainForm.mnuDiagonalni.Enabled:=true;

MainForm.tobZobrazitParametry.Enabled:=true;
MainForm.mnuZobrazitParametry.Enabled:=true;
MainForm.tobVybrat.Enabled:=true;
MainForm.mnuVybrat.Enabled:=true;
MainForm.mnuOriznout.Enabled:=true;
MainForm.tobOriznout.Enabled:=true;
MainForm.tobRadkyPridat.Enabled:=true;
MainForm.tobRadkyOdebrat.Enabled:=true;
MainForm.tobSloupcePridat.Enabled:=true;
MainForm.tobSloupceOdebrat.Enabled:=true;
MainForm.tobNazev.Enabled:=true;
MainForm.mnuExport.Enabled:=true;
MainForm.mnuNazev.Enabled:=true;
MainForm.tobNazev.Enabled:=true;
end;

procedure TMDIChild.btnPrepocitatClick(Sender: TObject);
var hD:THodnota;h:integer;
begin
ParametryMatice(matice,hD,h);
edtDeterminant.Text:=hD.retezec;
edtHodnost.Text:=inttostr(h);
//btnPrepocitat.Enabled:=false;
end;

procedure TMDIChild.stgMaticeSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
btnPrepocitat.Enabled:=true;
end;

procedure TMDIChild.btnSkrytClick(Sender: TObject);
begin
pnlParametry.Hide;
width:=width-pnlParametry.Width;
shpBilo.Width:=Width-60;
stgMatice.Width:=Width-50;
end;

procedure TMDIChild.stgMaticeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
stgMatice.Options:=stgMatice.Options+[goEditing];
MainForm.tobVybrat.Down:=false;
end;

procedure TMDIChild.stgMaticeRowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var radek:TRadekMatice;
begin
  FromIndex:=FromIndex-1;
  ToIndex:=ToIndex-1;
  radek:=matice.hodnoty[FromIndex];
  matice.OdebratRadek(FromIndex);
  matice.VlozitRadky(1,ToIndex);
  matice.hodnoty[ToIndex]:=radek;
end;

procedure TMDIChild.stgMaticeColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var sloupec:TRadekMatice;
r:integer;
begin
FromIndex:=FromIndex-1;
ToIndex:=ToIndex-1;
setlength(sloupec,matice.radku);
for r:=0 to matice.radku-1 do
 begin
   sloupec[r]:=matice.hodnoty[r][FromIndex];
 end;

matice.OdebratSloupec(FromIndex);
matice.VlozitSloupce(1,ToIndex);
for r:=0 to matice.radku-1 do
 begin
   matice.hodnoty[r][ToIndex]:=sloupec[r];
 end;
end;

procedure TMDIChild.FormDeactivate(Sender: TObject);
var b:boolean;
begin
b:=true;
stgMatice.OnSelectCell(nil, (MainForm.ActiveMDIChild as TMDIChild).selectedCell.X+1, selectedCell.Y+1,b);
end;

end.
