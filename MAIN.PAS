unit MAIN;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList,uZlomky,uMatice,uKomplex,uOperace,uNasobeniK,uOperaceJedne,Grids,uPridat,
  zlibex,regexpr,uExport,Registry,uHodnoty,uDebug,uFormat,uZ2,uNahSoustava;

type
  ENeniSoustava=class(Exception);
  TMainForm = class(TForm)
    mnuHlavni: TMainMenu;
    mnuSoubor: TMenuItem;
    mnuNova: TMenuItem;
    mnuOtevrit: TMenuItem;
    mnuZavrit: TMenuItem;
    mnuOkna: TMenuItem;
    mnuNapoveda: TMenuItem;
    N1: TMenuItem;
    mnuKonec: TMenuItem;
    mnuKaskadne: TMenuItem;
    mnuDlazdiceH: TMenuItem;
    mnuOAplikaci: TMenuItem;
    dlgOpen: TOpenDialog;
    mnuUlozit: TMenuItem;
    mnuUlozitJako: TMenuItem;
    mnuUpravy: TMenuItem;
    mnuVyjmout: TMenuItem;
    mnuKopirovat: TMenuItem;
    mnuVlozit: TMenuItem;
    mnuMinimalizovatVse: TMenuItem;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    FileNew1: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    FileOpen1: TAction;
    FileSaveAs1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    mnuDlazdiceV: TMenuItem;
    ImageList1: TImageList;
    mnuMatice: TMenuItem;
    mnuScitat: TMenuItem;
    mnuOdecitat: TMenuItem;
    mnuNasobit: TMenuItem;
    mnuNasobitK: TMenuItem;
    N2: TMenuItem;
    mnuOpacna: TMenuItem;
    mnuTransponovat: TMenuItem;
    mnuHorniTrojuh: TMenuItem;
    mnuNahodne: TMenuItem;
    mnuNahodneCisla: TMenuItem;
    mnuNahodneZlomky: TMenuItem;
    mnuNahodneDesetinna: TMenuItem;
    mnuNahodneSoustavaCisla: TMenuItem;
    mnuNovaSoustava: TMenuItem;
    mnuNastaveni: TMenuItem;
    mnuNastaveniGauss: TMenuItem;
    mnuGaussJednicky: TMenuItem;
    mnuGaussCela: TMenuItem;
    mnuInverzni: TMenuItem;
    mnuJednotkova: TMenuItem;
    mnuDolniTrojuh: TMenuItem;
    mnuNovaMatice: TMenuItem;
    ppmNovy: TPopupMenu;
    mnuPNovaMatice: TMenuItem;
    mnuPNovaSoustava: TMenuItem;
    ppmNahodne: TPopupMenu;
    mnuPNahodneCisla: TMenuItem;
    mnuPNahodneZlomky: TMenuItem;
    mnuPNahodneDesetinna: TMenuItem;
    ControlBar1: TControlBar;
    tlbSoubor: TToolBar;
    tolNova: TToolButton;
    tobOtevrit: TToolButton;
    tobUlozit: TToolButton;
    ToolButton3: TToolButton;
    tobVyjmout: TToolButton;
    tobKopirovat: TToolButton;
    tobVlozit: TToolButton;
    ToolButton7: TToolButton;
    tobKaskadne: TToolButton;
    tobDlazdiceV: TToolButton;
    tobDlazdiceH: TToolButton;
    N3: TMenuItem;
    tlbMatice: TToolBar;
    tobNahodne: TToolButton;
    tobTransponovat: TToolButton;
    tobOpacna: TToolButton;
    tobNasobitK: TToolButton;
    tobHorniTrojuh: TToolButton;
    tobInverzni: TToolButton;
    tobDolniTrojuh: TToolButton;
    tobJednotkova: TToolButton;
    ToolButton17: TToolButton;
    tobScitat: TToolButton;
    tobOdcitat: TToolButton;
    tobNasobit: TToolButton;
    mnuDiagonalni: TMenuItem;
    tobDiagonalni: TToolButton;
    mnuZobrazitParametry: TMenuItem;
    tobZobrazitParametry: TToolButton;
    dlgSave: TSaveDialog;
    imgPozadi: TImage;
    mnuNahodneKomplex: TMenuItem;
    mnuNahodneSoustavaKomplex: TMenuItem;
    mnuNahodneSoustava_: TMenuItem;
    mnuNahodneSoustavaZlomky: TMenuItem;
    mnuNahodneSoustavaDesetinna: TMenuItem;
    mnuImaginarniPromenna: TMenuItem;
    mnuImgI: TMenuItem;
    mnuImgJ: TMenuItem;
    mnuImgVlastni: TMenuItem;
    mnuPNahodneKomplex: TMenuItem;
    ppmNahodneSoustava: TPopupMenu;
    mnuPNahodneSoustavaCisla: TMenuItem;
    mnuPNahodneSoustavaZlomky: TMenuItem;
    mnuPNahodneSoustavaDesetinna: TMenuItem;
    mnuPNahodneSoustavaKomplex: TMenuItem;
    tobNahodneSoustava: TToolButton;
    mnuRadky: TMenuItem;
    mnuRadkyPridat: TMenuItem;
    mnuRadkyOdebrat: TMenuItem;
    mnuVybrat: TMenuItem;
    mnuSloupce: TMenuItem;
    mnuSloupcePridat: TMenuItem;
    mnuSloupceOdebrat: TMenuItem;
    N4: TMenuItem;
    mnuOriznout: TMenuItem;
    tlbRadkySloupce: TToolBar;
    tobRadkyPridat: TToolButton;
    tobRadkyOdebrat: TToolButton;
    tobSloupcePridat: TToolButton;
    tobSloupceOdebrat: TToolButton;
    tobVybrat: TToolButton;
    tobOriznout: TToolButton;
    ToolButton1: TToolButton;
    tobNazev: TToolButton;
    mnuNazev: TMenuItem;
    mnuZpravy: TMenuItem;
    mnuZpravaNepresne: TMenuItem;
    mnuExport: TMenuItem;
    mnuZlomky: TMenuItem;
    mnuOddelitCelouCast: TMenuItem;
    N5: TMenuItem;
    mnuNahodneSoustava: TMenuItem;
    mnuPNahodnaSoustava: TMenuItem;
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure mnuScitatClick(Sender: TObject);
    procedure mnuOdecitatClick(Sender: TObject);
    procedure mnuNasobitClick(Sender: TObject);
    procedure mnuNasobitKClick(Sender: TObject);
    procedure mnuTransponovatClick(Sender: TObject);
    procedure mnuOpacnaClick(Sender: TObject);
    procedure mnuHorniTrojuhClick(Sender: TObject);
    procedure mnuNahodneZlomkyClick(Sender: TObject);
    procedure mnuNahodneCislaClick(Sender: TObject);
    procedure mnuNahodneDesetinnaClick(Sender: TObject);
    procedure mnuNahodneSoustavaCislaClick(Sender: TObject);
    procedure mnuNovaSoustavaClick(Sender: TObject);
    procedure mnuGaussJednickyClick(Sender: TObject);
    procedure mnuGaussCelaClick(Sender: TObject);
    procedure mnuInverzniClick(Sender: TObject);
    procedure mnuDolniTrojuhClick(Sender: TObject);
    procedure mnuJednotkovaClick(Sender: TObject);
    procedure mnuNovaMaticeClick(Sender: TObject);
    procedure tolNovaClick(Sender: TObject);
    procedure tobNahodneClick(Sender: TObject);
    procedure mnuDiagonalniClick(Sender: TObject);
    procedure mnuZobrazitParametryClick(Sender: TObject);
    procedure mnuOtevritClick(Sender: TObject);
    procedure mnuUlozitJakoClick(Sender: TObject);
    procedure mnuUlozitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mnuNahodneKomplexClick(Sender: TObject);
    procedure mnuNahodneSoustavaKomplexClick(Sender: TObject);
    procedure mnuNahodneSoustavaZlomkyClick(Sender: TObject);
    procedure mnuNahodneSoustavaDesetinnaClick(Sender: TObject);
    procedure mnuImgVlastniClick(Sender: TObject);
    procedure tobNahodneSoustavaClick(Sender: TObject);
    procedure mnuRadkyOdebratClick(Sender: TObject);
    procedure mnuVybratClick(Sender: TObject);
    procedure mnuSloupceOdebratClick(Sender: TObject);
    procedure mnuRadkyPridatClick(Sender: TObject);
    procedure mnuSloupcePridatClick(Sender: TObject);
    procedure mnuOriznoutClick(Sender: TObject);
    procedure mnuNazevClick(Sender: TObject);
    procedure mnuExportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuNahodneSoustavaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure VytvoritOknoMatice(matice:TMatice);
  end;

  type TZnacka=array[0..2]of char;

var
  MainForm: TMainForm;


  mt2znacka:TZnacka='MAT';
  mt2verze:byte=2;
  mt2kompatibilita:byte=1;

  procedure doLogu(s:string); overload;
  procedure doLogu(s:string;b:boolean); overload;
implementation

{$R *.dfm}

uses CHILDWIN, about;


procedure doLogu(s:string);
begin
  frmDebug.memLog.Lines.Add(s);
end;

procedure doLogu(s:string;b:boolean);
begin
  if b then s:=s+':zapnuto' else s:=s+':vypnuto';
  frmDebug.memLog.Lines.Add(s);
end;

procedure TMainForm.VytvoritOknoMatice(matice:TMatice);
var
  Child: TMDIChild;
begin
  doLogu('Vytváøení nového okna matice');
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
  Child.Caption := matice.nazev+' ('+vratPismeno(matice.typ)+')';
  Child.stgMatice.width:=Child.width-50;
  Child.shpBilo.Width:=Child.Width-60;
  Child.shpBilo.Top:=-10;
  Child.shpBilo.Height:=Child.Height+20;
  Child.matice:=matice;
  Child.stgMatice.RowCount:=matice.radku+1;
  Child.stgMatice.ColCount:=matice.sloupcu+1;
  Child.stgMatice.ColWidths[0]:=length(inttostr(matice.radku))*8+20;
  if(matice.sloupcu<=10) then
   begin
    Child.Width:=Child.stgMatice.ColWidths[0]+matice.sloupcu*Child.stgMatice.ColWidths[1]+64;
    Child.stgMatice.Width:=Child.stgMatice.ColWidths[0]+matice.sloupcu*Child.stgMatice.ColWidths[1]+16;
   end
   else
   begin
     Child.stgMatice.Width:=Child.Width-48;
   end;

  if(matice.radku<=10) then
   begin
    Child.Height:=(matice.radku+1)*Child.stgMatice.RowHeights[0]+12+64;
    Child.stgMatice.Height:=(matice.radku+1)*Child.stgMatice.RowHeights[0]+12;
   end
   else
   begin
     Child.stgMatice.Height:=Child.Height-64;
   end;

  child.ObnovitMatici;
  Child.OnActivate(Child);
end;

procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin
  doLogu('Zobrazení nápovìdy');
  AboutBox.ShowModal;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  doLogu('Ukonèení aplikace');
  Close;
end;

procedure TMainForm.mnuScitatClick(Sender: TObject);
begin
doLogu('Zobrazení okna sèítání');
frmOperaceDvou.Zobraz(OP_SCITANI);
end;

procedure TMainForm.mnuOdecitatClick(Sender: TObject);
begin
doLogu('Zobrazení okna odèítání');
frmOperaceDvou.Zobraz(OP_ODCITANI);
end;

procedure TMainForm.mnuNasobitClick(Sender: TObject);
begin
doLogu('Zobrazení okna násobení');
frmOperaceDvou.Zobraz(OP_NASOBENI);
end;

procedure TMainForm.mnuNasobitKClick(Sender: TObject);
begin
doLogu('Zobrazení okna násobení konstantou');
frmNasobeniK.Zobraz;
end;

procedure TMainForm.mnuTransponovatClick(Sender: TObject);
begin
doLogu('Zobrazení okna transponování');
frmOperaceJedne.Zobraz(OP_TRANSPONOVANA);
end;

procedure TMainForm.mnuOpacnaClick(Sender: TObject);
begin
doLogu('Zobrazení okna opaèné matice');
frmOperaceJedne.Zobraz(OP_OPACNA);
end;

procedure TMainForm.mnuHorniTrojuhClick(Sender: TObject);
begin
doLogu('Zobrazení okna horní trojúhelníkové matice');
frmOperaceJedne.Zobraz(OP_HORNITROJUH);

end;

procedure TMainForm.mnuNahodneZlomkyClick(Sender: TObject);
var x,y:integer;
m:TMatice;
s:string;
max:TRozsah;
z1:TZlomek;
begin
if(MainForm.ActiveMDIChild=nil) then exit;
konecEditace();
doLogu('Pøíkaz náhodné zlomky');

s:='10';
inputQuery('Maximum','Zadejte maximální hodnotu èísla',s);
max:=strtoint64def(s,10);

m:=(MainForm.ActiveMDIChild as TMDIChild).matice;
m.typ:=MT_R;
for x:=0 to m.sloupcu-1 do
 for y:=0 to m.radku-1 do
  begin
    z1:=TZlomek.Create(Random(max),Random(max),Random(max)+1,false);
    m.hodnoty[y,x]:=z1;
  end;
(MainForm.ActiveMDIChild as TMDIChild).ObnovitMatici;
end;

procedure TMainForm.mnuNahodneCislaClick(Sender: TObject);
var x,y:integer;
m:TMatice;
s:string;
max:TRozsah;
begin
if(MainForm.ActiveMDIChild=nil) then exit;
konecEditace();
doLogu('Pøíkaz náhodná èísla');

s:='10';
inputQuery('Maximum','Zadejte maximální hodnotu èísla',s);
max:=strtoint64def(s,10);

m:=(MainForm.ActiveMDIChild as TMDIChild).matice;
m.typ:=MT_R;
for x:=0 to m.sloupcu-1 do
 for y:=0 to m.radku-1 do
  begin
    m.hodnoty[y,x]:=TZlomek.Create(Random(max));
  end;
(MainForm.ActiveMDIChild as TMDIChild).ObnovitMatici;
end;

procedure TMainForm.mnuNahodneDesetinnaClick(Sender: TObject);
var x,y:integer;
m:TMatice;
s:string;
max:TRozsah;
z1:TZlomek;
begin
if(MainForm.ActiveMDIChild=nil) then exit;
konecEditace();
doLogu('Pøíkaz náhodná desetinná èísla');
s:='10';
inputQuery('Maximum','Zadejte maximální hodnotu èísla',s);
max:=strtoint64def(s,10);

m:=(MainForm.ActiveMDIChild as TMDIChild).matice;
m.typ:=MT_R;
for x:=0 to m.sloupcu-1 do
 for y:=0 to m.radku-1 do
  begin
    z1:=TZlomek.Create(Random(max),Random(max),Random(max)+1,false);
    m.hodnoty[y,x]:=z1;
    (m.hodnoty[y,x] as TZlomek).origFormat:=ZLT_DESETINNE;
  end;
(MainForm.ActiveMDIChild as TMDIChild).ObnovitMatici;


end;

procedure TMainForm.mnuNahodneSoustavaCislaClick(Sender: TObject);
var //nezname:TRadekMatice;
max,p:integer;
s:string;
m:TMatice;
x,y:integer;
soucet:TZlomek;
kz:TZlomek;
begin
if(MainForm.ActiveMDIChild=nil) then exit;
doLogu('Pøíkaz náhodná soustava èísel');


m:=(MainForm.ActiveMDIChild as TMDIChild).matice;
m.typ:=MT_R;

if(m.sloupcu<>m.radku+1) then
 begin
   raise ENeniSoustava.Create('Matice pro soustavu musí mít r+1 sloupcù.');
   exit;
 end;

 s:='10';
inputQuery('Maximum','Zadejte maximální hodnotu èísla',s);
max:=strtoint64def(s,10);

 setlength(m.nezname,m.sloupcu-1);
 for p:=0 to length(m.nezname)-1 do
  begin
    m.nezname[p]:=TZlomek.Create(Random(max)+1);
    doLogu('Náhodná neznámá '+inttostr(p+1)+':'+m.nezname[p].retezec);
    //memo1.Lines.Add(inttostr(p)+':'+m.nezname[p].retezec);
  end;

 for y:=0 to m.radku-1 do
 begin
 soucet:=TZlomek.Create(0);
  for x:=0 to m.sloupcu-2 do
  begin
    m.hodnoty[y,x]:=TZlomek.Create(Random(max));
    kz:=THodnota.nasobHodnoty(m.hodnoty[y,x],m.nezname[x]) as TZlomek;
    soucet.pricti(kz);
  end;
 m.hodnoty[y,m.sloupcu-1]:=soucet;
 end;
(MainForm.ActiveMDIChild as TMDIChild).ObnovitMatici;

end;

procedure TMainForm.mnuNahodneSoustavaClick(Sender: TObject);
var
m:TMatice;
begin
if(MainForm.ActiveMDIChild=nil) then exit;
konecEditace();
doLogu('Pøíkaz náhodná soustava èísel');


m:=(MainForm.ActiveMDIChild as TMDIChild).matice;
if frmNahodnaSoustava.zobraz(m) then
  (MainForm.ActiveMDIChild as TMDIChild).ObnovitMatici;
end;

procedure TMainForm.mnuNovaSoustavaClick(Sender: TObject);
var n,m:integer;
s:string;
mat:TMatice;
format:integer;
begin
doLogu('Pøíkaz nová soustava');
s:='3';
m:=-1;
while m<=0 do
begin
  if not inputQuery('Poèet neznámých','Zadejte poèet neznámých',s) then exit;
  m:=strtointdef(s,0);
  if m=0 then exit;
end;
s:='3';
n:=m+1;
format:=frmFormat.ShowModal;
if format=mrCancel then exit;
format:=frmFormat.lsbFormat.ItemIndex;

mat:=TMatice.Create(m,n,chr(65+MDIChildCount),format);
mat.soustava:=true;
VytvoritOknoMatice(mat);
tolNova.Tag:=1;
tolNova.ImageIndex:=35;
end;

procedure TMainForm.mnuGaussJednickyClick(Sender: TObject);
begin
doLogu('Nastavení jednièek na diagonále',mnuGaussJednicky.Checked);
if mnuGaussJednicky.Checked then
  mnuGaussCela.Checked:=false;
end;

procedure TMainForm.mnuGaussCelaClick(Sender: TObject);
begin
doLogu('Nastavení celých èísel(gauss)',mnuGaussCela.Checked);

if mnuGaussCela.Checked then
  mnuGaussJednicky.Checked:=false;
end;

procedure TMainForm.mnuInverzniClick(Sender: TObject);
begin
doLogu('Zobrazení okna inverzní matice');
frmOperaceJedne.Zobraz(OP_INVERZNI);
end;

procedure TMainForm.mnuDolniTrojuhClick(Sender: TObject);
begin
doLogu('Zobrazení okna dolní trojúhelníkové matice');
frmOperaceJedne.Zobraz(OP_DOLNITROJUH);
end;

procedure TMainForm.mnuJednotkovaClick(Sender: TObject);
begin
doLogu('Zobrazení okna jednotkové matice');
frmOperaceJedne.Zobraz(OP_JEDNOTKOVA);
end;

procedure TMainForm.mnuNovaMaticeClick(Sender: TObject);
var m,n:integer;
s:string;
mat:TMatice;
format:integer;
begin
doLogu('Pøíkaz Nová matice');
s:='3';
m:=-1;
while m<=0 do
begin
if not inputQuery('Poèet øádkù','Zadejte poèet øádkù',s) then exit;
if s='debug' then
 begin
   doLogu('Ladící mód aktivován');
   frmDebug.Show;
   exit;
 end;
m:=strtointdef(s,0);
if m=0 then exit;
end;

n:=-1;
s:=inttostr(m);
while n<=0 do
begin
if not inputQuery('Poèet sloupcù','Zadejte poèet sloupcù',s) then exit;
n:=strtointdef(s,0);
if n=0 then exit;
end;

format:=frmFormat.ShowModal;
if format=mrCancel then exit;
format:=frmFormat.lsbFormat.ItemIndex;
mat:=TMatice.Create(m,n,chr(65+MDIChildCount),format);
VytvoritOknoMatice(mat);

tolNova.Tag:=0;
tolNova.ImageIndex:=34;
end;

procedure TMainForm.tolNovaClick(Sender: TObject);
begin
if(tolNova.Tag=0) then
 mnuNovaMatice.OnClick(Sender)
 else
 mnuNovaSoustava.OnClick(Sender);
end;

procedure TMainForm.tobNahodneClick(Sender: TObject);
var tp:Tpoint;
begin
tp.X:=tobNahodne.Left;
tp.Y:=tobNahodne.Top;
tp:=tlbMatice.clientToscreen(tp);
tp.Y:=tp.Y+tobNahodne.Height;
ppmNahodne.Popup(tp.X,tp.Y);
end;

procedure TMainForm.mnuDiagonalniClick(Sender: TObject);
begin
doLogu('Zobrazení okna diagonální matice');
frmOperaceJedne.Zobraz(OP_DIAGONALNI);
end;

procedure TMainForm.mnuZobrazitParametryClick(Sender: TObject);
begin
doLogu('Zobrazení parametrù');
if ActiveMDIChild<>nil then
  (ActiveMDIChild as TMDIChild).ZobrazParametry();
end;

procedure TMainForm.mnuOtevritClick(Sender: TObject);
var
csv:textfile;
m:Tmatice;
x,y:integer;
w,h:integer;
s,s1:string;
i:integer;
znacka:TZnacka;
verze,kompatibilita:byte;
radku,sloupcu:integer;
r1,r2,r3:TRozsah;
r4:integer;
r5:Extended;
ds:TZDecompressionStream;
fs:TFileStream;
kz:TKomplexniZlomek;
styp:char;
ntyp:integer;
begin
doLogu('Zobrazení okna pro Otevøení matice');
if dlgOpen.Execute then
  begin
    try
    if extractfileext(dlgOpen.filename)='.mt2' then
    begin

    //assignfile(f,dlgOpen.filename);
    fs:=TFileStream.Create(dlgOpen.filename,fmOpenRead);

    //reset(f,1);

    fs.Read(znacka[0],3);
    if znacka<>mt2znacka then
     begin
       fs.Destroy;
       raise Exception.Create('');
       exit;
     end;
    fs.Read(verze,1);
    fs.Read(kompatibilita,1);
    if(kompatibilita<>mt2kompatibilita) then
     begin
       fs.Destroy;
       raise Exception.Create('');
       exit;
     end;
    fs.Read(i,sizeof(i));
    setlength(s,i);
    fs.Read(s[1],i);
    styp:='C';
    if(verze=2) then
    begin
      styp:=s[1];
      s:=copy(s,2,length(s)-1);
    end;
    case styp of
          'C': ntyp:=MT_C;
          'R': ntyp:=MT_R;
          'Z': ntyp:=MT_Z2;
          else ntyp:=MT_C;
        end;
    fs.Read(radku,sizeof(radku));
    fs.Read(sloupcu,sizeof(sloupcu));

    m:=TMatice.Create(radku,sloupcu,s,ntyp);
    ds:=TZDecompressionStream.Create(fs);
    for y:=0 to m.radku-1 do
     for x:=0 to m.sloupcu-1 do
      begin
        ds.read(r1,sizeof(TRozsah));
        ds.read(r2,sizeof(TRozsah));
        ds.read(r3,sizeof(TRozsah));
        ds.read(r4,sizeof(integer));
         ds.read(r5,sizeof(r5));
        kz:=TKomplexniZlomek.Create(0);;

        kz.Re:=TZlomek.Create(r1,r2,r3);
        kz.Re.origFormat:=r4;
        kz.Re.pcislo:=r5;
        ds.read(r1,sizeof(TRozsah));
        ds.read(r2,sizeof(TRozsah));
        ds.read(r3,sizeof(TRozsah));
        ds.read(r4,sizeof(integer));
        ds.read(r5,sizeof(r5));
        kz.Im:=TZlomek.Create(r1,r2,r3);
        kz.Im.origFormat:=r4;
        kz.Im.pcislo:=r5;

        case styp of
          'C': m.hodnoty[y,x]:=kz;
          'R': m.hodnoty[y,x]:=kz.Re.kopie;
          'Z': m.hodnoty[y,x]:=TZ2Cislo.Create(kz.Re.citatel);
        end;

      end;
    //closefile(f);
    ds.Destroy;
    fs.Destroy;
    end
    else if extractfileext(dlgOpen.filename)='.csv' then
    begin
      assignfile(csv,dlgOpen.filename);
      reset(csv);
      m:=TMatice.Create(0,0,chr(65+MDIChildCount),MT_C);

      h:=0;
      while not eof(csv) do
       begin
         m.PridatRadky(1);
         h:=h+1;
         readln(csv,s);
         w:=0;
         while pos(';',s)>1 do
          begin
            w:=w+1;
            if(w>m.sloupcu) then
             m.PridatSloupce(1);
            s1:=copy(s,0,pos(';',s)-1);
            m.hodnoty[h-1,w-1]:=TKomplexniZlomek.Create(s1);
            s:=copy(s,length(s1)+2,length(s));
          end;

         if s<>'' then
         begin
           w:=w+1;
           if(w>m.sloupcu) then
               m.PridatSloupce(1);
           m.hodnoty[h-1,w-1]:=TKomplexniZlomek.Create(s);
         end;
       end;
      closefile(csv);
    end
    else
     exit;
    VytvoritOknoMatice(m);
    while ActiveMDIChild=nil do;
    (ActiveMDIChild as TMDIChild).nazevsouboru:=dlgOpen.filename;
    except
      raise Exception.Create('Chyba pøi ètení souboru. Zøejmì špatný formát Matice.');
    end;
  end;
end;

procedure TMainForm.mnuUlozitJakoClick(Sender: TObject);
begin
doLogu('Zobrazení okna pro uložení matice');
if dlgSave.Execute then
 begin
   (ActiveMDIChild as TMDIChild).nazevsouboru:=dlgSave.FileName;
   mnuUlozit.OnClick(Sender);
 end;
end;

procedure TMainForm.mnuUlozitClick(Sender: TObject);
var 
m:Tmatice;
x,y:integer;
s:string;
i:integer;
cs:TZCompressionStream;
fs:TFileStream;
soubor:string;
csv:Textfile;
kz:TKomplexniZlomek;
z:TZlomek;
z2:TZ2Cislo;
tr:TRozsah;
ex:extended;
int:integer;
begin
doLogu('Pøíkaz Uložit matici');

if (ActiveMDIChild as TMDIChild).nazevsouboru='' then
  mnuUlozitJako.OnClick(Sender)
 else
  begin
    try
    m:=(ActiveMDIChild as TMDIChild).matice;
    soubor:=(ActiveMDIChild as TMDIChild).nazevsouboru;
    if extractfileext(soubor)='.csv' then
    begin
      assignfile(csv,soubor);
      rewrite(csv);
      for y:=0 to m.radku-1 do
       begin
        for x:=0 to m.sloupcu-1 do
         begin
           write(csv,m.hodnoty[y,x].retezecDesetiny);
           if(x<m.sloupcu-1) then write(csv,';');
         end;
         writeln(csv);
       end;
      closefile(csv);
      exit;
    end;
    s:=vratPismeno(m.typ)[1]+m.nazev;
    fs:=TFileStream.Create((ActiveMDIChild as TMDIChild).nazevsouboru,fmCreate);
    fs.write(mt2znacka[0],3);
    fs.write(mt2verze,1);
    fs.write(mt2kompatibilita,1);
    i:=length(s);
    fs.write(i,sizeof(i));
    fs.write(s[1],i);
    fs.write(m.radku,sizeof(m.radku));
    fs.write(m.sloupcu,sizeof(m.sloupcu));
    cs:=TZCompressionStream.Create(fs);
    for y:=0 to m.radku-1 do
     for x:=0 to m.sloupcu-1 do
      begin
        case m.typ of
          MT_R:
            begin
            z:=m.hodnoty[y,x] as TZlomek;
            cs.write(z.celaCast,sizeof(TRozsah));
            cs.write(z.citatel,sizeof(TRozsah));
            cs.write(z.jmenovatel,sizeof(TRozsah));
            cs.write(z.origFormat,sizeof(integer));
            cs.write(z.pcislo,sizeof(z.pcislo));
            tr:=0; cs.write(tr,sizeof(TRozsah));
            cs.write(tr,sizeof(TRozsah));
            tr:=1; cs.write(tr,sizeof(TRozsah));
            int:=ZLT_ZLOMEK; cs.write(int,sizeof(integer));
            ex:=0; cs.write(ex,sizeof(ex));
            end;
          MT_C:
            begin
            kz:=m.hodnoty[y,x] as TKomplexniZlomek;
            cs.write(kz.Re.celaCast,sizeof(TRozsah));
            cs.write(kz.Re.citatel,sizeof(TRozsah));
            cs.write(kz.Re.jmenovatel,sizeof(TRozsah));
            cs.write(kz.Re.origFormat,sizeof(integer));
            cs.write(kz.Re.pcislo,sizeof(kz.Re.pcislo));
            cs.write(kz.Im.celaCast,sizeof(TRozsah));
            cs.write(kz.Im.citatel,sizeof(TRozsah));
            cs.write(kz.Im.jmenovatel,sizeof(TRozsah));
            cs.write(kz.Im.origFormat,sizeof(integer));
            cs.write(kz.Im.pcislo,sizeof(kz.Re.pcislo));
            end;
          MT_Z2:
            begin
            z2:=m.hodnoty[y,x] as TZ2Cislo;
            tr:=z2.getHodnota; cs.write(tr,sizeof(TRozsah));
            tr:=0; cs.write(tr,sizeof(TRozsah));
            tr:=1; cs.write(tr,sizeof(TRozsah));
            int:=ZLT_ZLOMEK; cs.write(int,sizeof(integer));
            ex:=0; cs.write(ex,sizeof(ex));
            tr:=0; cs.write(tr,sizeof(TRozsah));
            cs.write(tr,sizeof(TRozsah));
            tr:=1; cs.write(tr,sizeof(TRozsah));
            int:=ZLT_ZLOMEK; cs.write(int,sizeof(integer));
            ex:=0; cs.write(ex,sizeof(ex));
            end;
        end;

      end;
    cs.Destroy;
    fs.Destroy;
    except
      raise Exception.Create('Nelze zapisovat do souboru');
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var reg:TRegistry;
begin
reg:=TRegistry.Create;
reg.RootKey:=HKEY_LOCAL_MACHINE;
if reg.OpenKey('Software\JPEXS\Matice2',false) then
 begin
   mnuImgI.Checked:=false;
   mnuGaussJednicky.Checked:=reg.ReadBool('GaussJednicky');
   mnuGaussCela.Checked:=reg.ReadBool('GaussCela');
   if(reg.ValueExists('OddelitCelouCast')) then
     mnuOddelitCelouCast.Checked:=reg.ReadBool('OddelitCelouCast');
   uKomplex.ZnakImg:=reg.ReadString('ImaginarniPromenna')[1];
   case uKomplex.ZnakImg of
     'i':mnuImgI.Checked:=true;
     'j':mnuImgJ.Checked:=true;
     else
      begin
        mnuImgVlastni.Checked:=true;
        mnuImgVlastni.Tag:=ord(uKomplex.ZnakImg);
        mnuImgVlastni.Caption:='Vlastní ( '+uKomplex.ZnakImg+' )...';
      end;
   end;
   mnuZpravaNepresne.Checked:=reg.ReadBool('ZpravaNepresne');
 end;
reg.Destroy;
Randomize;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
//imgPozadi.Height:=height-175;
//imgPozadi.Width:=width-60;
end;

procedure TMainForm.mnuNahodneKomplexClick(Sender: TObject);
var x,y:integer;
m:TMatice;
s:string;
max:TRozsah;
begin
if(MainForm.ActiveMDIChild=nil) then exit;
konecEditace();
doLogu('Pøíkaz náhodná komplexní èísla');

s:='10';
inputQuery('Maximum','Zadejte maximální hodnotu èísla',s);
max:=strtoint64def(s,10);

m:=(MainForm.ActiveMDIChild as TMDIChild).matice;
m.typ:=MT_C;
for x:=0 to m.sloupcu-1 do
 for y:=0 to m.radku-1 do
  begin
    m.hodnoty[y,x]:=TKomplexniZlomek.Create(Random(max),Random(max));
  end;
(MainForm.ActiveMDIChild as TMDIChild).ObnovitMatici;

end;

procedure TMainForm.mnuNahodneSoustavaKomplexClick(Sender: TObject);
var nezname:TRadekMatice;
max,p:integer;
s:string;
m:TMatice;
x,y:integer;
soucet:TKomplexniZlomek;
begin
if(MainForm.ActiveMDIChild=nil) then exit;
doLogu('Pøíkaz náhodná soustava komplexních èísel');


m:=(MainForm.ActiveMDIChild as TMDIChild).matice;
m.typ:=MT_C;

if(m.sloupcu<>m.radku+1) then
 begin
   raise ENeniSoustava.Create('Matice pro soustavu musí mít r+1 sloupcù.');
   exit;
 end;

 s:='10';
inputQuery('Maximum','Zadejte maximální hodnotu èísla',s);
max:=strtoint64def(s,10);

 setlength(nezname,m.sloupcu-1);
 for p:=0 to length(nezname)-1 do
  begin
    nezname[p]:=TKomplexniZlomek.Create(Random(max)+1,Random(max)+1);
  end;

 for y:=0 to m.radku-1 do
 begin
 soucet:=TKomplexniZlomek.Create(0);
  for x:=0 to m.sloupcu-2 do
  begin
    m.hodnoty[y,x]:=TKomplexniZlomek.Create(Random(max),Random(max));
    soucet.pricti(THodnota.nasobHodnoty(m.hodnoty[y,x],nezname[x] ));
  end;
 m.hodnoty[y,m.sloupcu-1].Assign(soucet);
 end;
(MainForm.ActiveMDIChild as TMDIChild).ObnovitMatici;

 tobNahodne.Tag:=3;
tobNahodne.ImageIndex:=21;

end;

procedure TMainForm.mnuNahodneSoustavaZlomkyClick(Sender: TObject);
var nezname:TRadekMatice;
max,p:integer;
s:string;
m:TMatice;
x,y:integer;
soucet:TZlomek;
z1:TZlomek;
begin
if(MainForm.ActiveMDIChild=nil) then exit;
doLogu('Pøíkaz náhodná soustava zlomkù');


m:=(MainForm.ActiveMDIChild as TMDIChild).matice;
m.typ:=MT_R;

if(m.sloupcu<>m.radku+1) then
 begin
   raise ENeniSoustava.Create('Matice pro soustavu musí mít r+1 sloupcù.');
   exit;
 end;

 s:='10';
inputQuery('Maximum','Zadejte maximální hodnotu èísla',s);
max:=strtoint64def(s,10);

 setlength(nezname,m.sloupcu-1);
 for p:=0 to length(nezname)-1 do
  begin
    nezname[p]:=TZlomek.Create(Random(max)+1);
    doLogu('Náhodná neznámá '+inttostr(p+1)+':'+nezname[p].retezec);
  end;

 for y:=0 to m.radku-1 do
 begin
 soucet:=TZlomek.Create(0);
  for x:=0 to m.sloupcu-2 do
  begin
    z1:=TZlomek.Create(Random(max),Random(max),Random(max)+1);
    m.hodnoty[y,x]:=z1;
    soucet.pricti(THodnota.NasobHodnoty(m.hodnoty[y,x] as TZlomek,nezname[x] as TZlomek));
  end;
 m.hodnoty[y,m.sloupcu-1]:=soucet;
 end;
(MainForm.ActiveMDIChild as TMDIChild).ObnovitMatici;


end;

procedure TMainForm.mnuNahodneSoustavaDesetinnaClick(Sender: TObject);
var nezname:TRadekMatice;
max,p:integer;
s:string;
m:TMatice;
x,y:integer;
soucet:TZlomek;
z1:TZlomek;
begin
if(MainForm.ActiveMDIChild=nil) then exit;
doLogu('Pøíkaz náhodná soustava desetinných èísel');


m:=(MainForm.ActiveMDIChild as TMDIChild).matice;
m.typ:=MT_R;

if(m.sloupcu<>m.radku+1) then
 begin
   raise ENeniSoustava.Create('Matice pro soustavu musí mít r+1 sloupcù.');
   exit;
 end;

 s:='10';
inputQuery('Maximum','Zadejte maximální hodnotu èísla',s);
max:=strtoint64def(s,10);

 setlength(nezname,m.sloupcu-1);
 for p:=0 to length(nezname)-1 do
  begin
    nezname[p]:=TZlomek.Create(Random(max)+1);
    doLogu('Náhodná neznámá '+inttostr(p+1)+':'+m.nezname[p].retezec);
  end;

 for y:=0 to m.radku-1 do
 begin
 soucet:=TZlomek.Create(0);
  for x:=0 to m.sloupcu-2 do
  begin
    z1:=TZlomek.Create(Random(max),Random(max),Random(max)+1);
    m.hodnoty[y,x]:=z1;
    (m.hodnoty[y,x] as TZlomek).origFormat:=ZLT_DESETINNE;
    soucet.pricti(THodnota.nasobHodnoty(m.hodnoty[y,x],nezname[x]));
  end;
 m.hodnoty[y,m.sloupcu-1]:=soucet;
 end;
(MainForm.ActiveMDIChild as TMDIChild).ObnovitMatici;


end;

procedure TMainForm.mnuImgVlastniClick(Sender: TObject);
var p:integer;
s:string;
begin
doLogu('Zobrazení okna pro vlastní imaginární znak');

if(Sender =mnuImgVlastni)then
 begin
   s:='';

   while length(s)<>1 do
    begin
      if s='' then
       if((Sender as TMenuItem).Tag<>0) then
        s:=chr((Sender as TMenuItem).Tag);
      if not InputQuery('Vlastní imaginární znak','Zadejte imaginární znak:',s) then exit;
      if length(s)=1 then
       if (s[1]<'a')or(s[1]>'z') then s:='';
    end;
    (Sender as TMenuItem).Tag:=ord(s[1]);
    (Sender as TMenuItem).Caption:='Vlastní ( '+s+' )...';
 end;

mnuImgI.Checked:=false;
mnuImgJ.Checked:=false;
mnuImgVlastni.Checked:=false;
(Sender as TMenuItem).Checked:=true;
uKomplex.ZnakImg:=chr((Sender as TMenuItem).Tag);
for p:=0 to MDIChildCount-1 do
 begin
   (MDIChildren[p] as TMDIChild).ObnovitMatici;
 end;
end;

procedure TMainForm.tobNahodneSoustavaClick(Sender: TObject);
var tp:Tpoint;
begin
tp.X:=tobNahodneSoustava.Left;
tp.Y:=tobNahodneSoustava.Top;
tp:=tlbMatice.clientToscreen(tp);
tp.Y:=tp.Y+tobNahodneSoustava.Height;
ppmNahodneSoustava.Popup(tp.X,tp.Y);

end;

procedure TMainForm.mnuRadkyOdebratClick(Sender: TObject);
var f:TMDIChild;
pocet:integer;
begin
konecEditace();
doLogu('Pøíkaz odebrat øádky');

f:=(MainForm.ActiveMDIChild as TMDIChild);
pocet:=f.stgMatice.Selection.Bottom-f.stgMatice.Selection.Top+1;
if pocet=f.matice.radku then exit;
f.matice.OdebratRadky(f.stgMatice.Selection.Top-1,f.stgMatice.Selection.Bottom-1);
f.stgMatice.RowCount:=f.stgMatice.RowCount-pocet;
f.ObnovitMatici;
end;

procedure TMainForm.mnuVybratClick(Sender: TObject);
begin
konecEditace();
doLogu('Pøíkaz výbìr oblasti');
(ActiveMDIChild as TMDIChild).stgMatice.Options:=(ActiveMDIChild as TMDIChild).stgMatice.Options-[goEditing];
tobVybrat.Down:=true;
end;

procedure TMainForm.mnuSloupceOdebratClick(Sender: TObject);
var f:TMDIChild;
pocet:integer;
begin
konecEditace();
doLogu('Pøíkaz odebrat sloupce');
f:=(MainForm.ActiveMDIChild as TMDIChild);
pocet:=f.stgMatice.Selection.Right-f.stgMatice.Selection.Left+1;
if pocet=f.matice.sloupcu then exit;
f.matice.OdebratSloupce(f.stgMatice.Selection.Left-1,f.stgMatice.Selection.Right-1);
f.stgMatice.ColCount:=f.stgMatice.ColCount-pocet;
f.ObnovitMatici;

end;

procedure TMainForm.mnuRadkyPridatClick(Sender: TObject);
begin
doLogu('Zobrazení okna pøidání øádkù');
frmPridat.Zobraz(PRT_RADKY);
end;

procedure TMainForm.mnuSloupcePridatClick(Sender: TObject);
begin
doLogu('Zobrazení okna pøidání sloupcù');
frmPridat.Zobraz(PRT_SLOUPCE);
end;

procedure TMainForm.mnuOriznoutClick(Sender: TObject);
begin
doLogu('Zobrazení okna oøíznutí matice');
frmOperaceJedne.Zobraz(OP_ORIZNOUT);
end;

procedure TMainForm.mnuNazevClick(Sender: TObject);
begin
konecEditace();
doLogu('Zobrazení okna nového názvu matice');
InputQuery('Zmìnit název','Nový název matice '+(ActiveMDIChild as TMDIChild).matice.nazev,(ActiveMDIChild as TMDIChild).matice.nazev);
(ActiveMDIChild as TMDIChild).nazevsouboru:=(ActiveMDIChild as TMDIChild).nazevsouboru;
end;

procedure TMainForm.mnuExportClick(Sender: TObject);
begin
doLogu('Zobrazení okna exportu');
frmExport.Zobrazit((ActiveMDIChild as TMDIChild).matice);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var reg:TRegistry;
begin
doLogu('Zavøení okna');
reg:=TRegistry.Create;
reg.RootKey:=HKEY_LOCAL_MACHINE;
if reg.OpenKey('Software\JPEXS\Matice2',true) then
 begin
   reg.WriteBool('GaussJednicky',mnuGaussJednicky.Checked);
   reg.WriteBool('GaussCela',mnuGaussCela.Checked);
   reg.WriteString('ImaginarniPromenna',uKomplex.ZnakImg);
   reg.WriteBool('ZpravaNepresne',mnuZpravaNepresne.Checked);
   reg.WriteBool('OddelitCelouCast',mnuOddelitCelouCast.Checked);
 end;
reg.Destroy;
end;

end.
