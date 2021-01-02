unit uMatice;



interface
uses dialogs,sysutils,RegExpr,uZlomky,uKomplex,Forms,uHodnoty,uZ2;


const nnaNesoudelne=false;
      MT_R=0;
      MT_C=1;
      MT_Z2=2;

        type ERuzneRozmery=class(Exception);
        type ESpatneRozmery=class(Exception);
        type EMimoRozsah=class(Exception);
        type ERadkyVelikost=class(Exception);
        type EGaussNelze=class(Exception);
        type ENelze=class(Exception);
        type ERuzneObory=class(Exception);
        type TRadekMatice=array of THodnota;

        type TMatice=class(TObject)
        private
          pm,pn:integer;
          psoustava:boolean;
          ptyp:integer;
          procedure setSoustava(nsoustava:boolean);
          procedure setTyp(ntyp:integer);
        public
          hodnoty:array of TRadekMatice;
          znamenkoD:boolean;
          nazev:string;
          chyba:boolean;
          nezname:TRadekMatice;
          property soustava:boolean read psoustava write setSoustava;
          property radku:integer read pm;
          property sloupcu:integer read pn;
          property typ:integer read ptyp write setTyp;

          constructor Create(m,n:integer;nnazev:string='';ntyp:integer=MT_C); overload;
          constructor Create(m:TMatice;nnazev:string=''); overload;
          procedure VymenitRadky(r1,r2:integer);
          procedure VynasobitRadek(r:integer;z:THodnota); overload;
          procedure VynasobitRadek(r:integer;k:integer); overload;
          procedure OdebratRadek(r:integer);
          procedure PridatSloupce(pocet:integer);
          procedure OdebratRadky(r1,r2:integer);
          procedure OdebratSloupce(s1,s2:integer);
          procedure OdebratSloupec(s:integer);
          procedure PridatRadky(pocet:integer);
          procedure VlozitRadky(pocet:integer;pozice:integer);
          procedure VlozitSloupce(pocet:integer;pozice:integer);
          destructor Destroy; override;
        end;

        function SectiMatice(m1,m2:TMatice):TMatice;
        function OdectiMatice(m1,m2:TMatice):TMatice;
        function NasobMatice(m1,m2:TMatice):TMatice;
        function NasobKonstantouMatici(m:TMatice;z:THodnota):TMatice; overload;
        function NasobKonstantouMatici(m:TMatice;k:integer):TMatice; overload;
        function OpacnaMatice(m:TMatice):TMatice;
        function TransponovatMatici(m:TMatice):TMatice;
        function NasobekRadku(radek:TRadekMatice;h:THodnota):TRadekMatice; overload;
        function NasobekRadku(radek:TRadekMatice;k:TRozsah):TRadekMatice; overload;
        function GaussovaEliminacniMetoda(m:TMatice;jednicky:boolean=true;celacisla:boolean=true;castecne:boolean=false):TMatice;
        function ObracenaGaussovaEliminacniMetoda(m:TMatice;jednicky:boolean=true;celacisla:boolean=true;castecne:boolean=false):TMatice;
        function JeRadekNulovy(radek:TRadekMatice):boolean;
        function RadekNaCela(radek:TRadekMatice):TRadekMatice;
        function InverzniMatice(m:TMatice):TMatice;
        function PodMatice(m:TMatice;x,y,w,h:integer):TMatice;
        function Determinant(m:TMatice):THodnota;
        procedure ParametryMatice(m:TMatice;var D:THodnota;var h:integer);
        function KopieRadku(radek:TRadekMatice):TRadekMatice;
        function NoveJmenoMatice(m:TMatice;nazev:string):TMatice;
        function radektostr(radek:TRadekMatice):string;
implementation
  uses MAIN,CHILDWIN,uOperaceJedne;

destructor TMatice.Destroy;
var x,y:integer;
begin
 for y := 0 to pm - 1 do
   for x := 0 to pn - 1 do
     hodnoty[y][x].Destroy;
 //finalize(hodnoty);
 //freemem(@hodnoty);
 //hodnoty:=nil;
 inherited;
end;


function radektostr(radek:TRadekMatice):string;
var
  p: Integer;
begin
Result:='';
for p := 0 to length(radek) - 1 do
  begin
    Result:=Result+radek[p].retezec+' ';
  end;
end;

function KopieRadku(radek:TRadekMatice):TRadekMatice;
var p:integer;
begin
  SetLength(Result,length(radek));
  for p:=0 to length(radek)-1 do
   begin
     Result[p]:=radek[p].kopie();
   end;
end;

procedure TMatice.setSoustava(nsoustava:boolean);
begin
  if nsoustava then
  begin
    if sloupcu=radku+1 then
     psoustava:=true
    else
     psoustava:=false;
  end
  else
  psoustava:=nsoustava;
end;

procedure TMatice.setTyp(ntyp:integer);
begin
  ptyp:=ntyp;
end;

constructor TMatice.Create(m:TMatice;nnazev:string='');
var i,j:integer;
begin
  Create(m.radku,m.sloupcu,nnazev,m.typ);
  chyba:=m.chyba;
  for j:=0 to m.sloupcu-1 do
   for i:=0 to m.radku-1 do
     begin
       hodnoty[i,j].Assign(m.hodnoty[i,j]);
       if hodnoty[i,j] is TKomplexniZlomek then
         (hodnoty[i,j] as TKomplexniZlomek).origFormat:=(m.hodnoty[i,j] as TKomplexniZlomek).origFormat;
     end;
  nezname:=m.nezname;
end;

constructor TMatice.Create(m,n:integer;nnazev:string='';ntyp:integer=MT_C);
var i,j:integer;
begin
  pm:=m;
  pn:=n;
  nazev:=nnazev;
  chyba:=false;
  ptyp:=ntyp;
  setlength(hodnoty,m);
  for i:=0 to m-1 do
   begin
     setlength(hodnoty[i],n);
     for j:=0 to n-1 do
      begin
        hodnoty[i][j]:=novaHodnota(typ,0);
      end;
   end;
  soustava:=false;
end;

procedure TMatice.VymenitRadky(r1,r2:integer);
var temp:TRadekMatice;
begin
 if ((r1<0)or(r1>=radku))or((r2<0)or(r2>=radku)) then
  begin
    raise EMimoRozsah.Create('Èísla øádkù jsou mimo rozsah');
    exit;
  end;
  temp:=hodnoty[r1];
  hodnoty[r1]:=hodnoty[r2];
  hodnoty[r2]:=temp;
end;

procedure TMatice.VynasobitRadek(r:integer;z:THodnota);
var p:integer;
begin
 if ((r<0)or(r>=radku)) then
  begin
    raise EMimoRozsah.Create('Èíslo øádku je mimo rozsah');
    exit;
  end;
for p:=0 to sloupcu-1 do
 begin
   hodnoty[r,p].nasob(z);
 end;
end;
procedure TMatice.VynasobitRadek(r:integer;k:integer);
var p:integer;
begin
 if ((r<0)or(r>=radku)) then
  begin
    raise EMimoRozsah.Create('Èíslo øádku je mimo rozsah');
    exit;
  end;
for p:=0 to sloupcu-1 do
 begin
   hodnoty[r,p].nasob(TRealneCislo.Create(k));
 end;
end;

procedure TMatice.OdebratRadek(r:integer);
var p:integer;
begin
 if ((r<0)or(r>=radku)) then
  begin
    raise EMimoRozsah.Create('Èíslo øádku je mimo rozsah');
    exit;
  end;
for p:=r to radku-2 do
 begin
   hodnoty[p]:=hodnoty[p+1];
 end;
 setlength(hodnoty,length(hodnoty)-1);
 pm:=pm-1;
end;

function SectiMatice(m1,m2:TMatice):TMatice;
var x,y:integer;
begin
  if(m1.radku<>m2.radku)or(m1.sloupcu<>m2.sloupcu) then
   begin
     raise ERuzneRozmery.Create('Nelze sèítat, matice mají rùzné rozmìry');
     exit;
   end;
if(m1.typ<>m2.typ) then
 begin
   raise ERuzneObory.Create('Matice mají rùzné obory hodnot, výpoèet nelze provést.');
   exit;
 end;
Result:=TMatice.Create(m1.radku,m1.sloupcu,'',m1.typ);
for x:=0 to m1.sloupcu-1 do
 for y:=0 to m1.radku-1 do
  Result.hodnoty[y,x]:=THodnota.SectiHodnoty(m1.hodnoty[y,x],m2.hodnoty[y,x]);
end;

function OdectiMatice(m1,m2:TMatice):TMatice;
var x,y:integer;
begin
  if(m1.radku<>m2.radku)or(m1.sloupcu<>m2.sloupcu) then
   begin
     raise ERuzneRozmery.Create('Nelze odeèítat, matice mají rùzné rozmìry');
     exit;
   end;
if(m1.typ<>m2.typ) then
 begin
   raise ERuzneObory.Create('Matice mají rùzné obory hodnot, výpoèet nelze provést.');
   exit;
 end;
Result:=TMatice.Create(m1.radku,m1.sloupcu,'',m1.typ);
for x:=0 to m1.sloupcu-1 do
 for y:=0 to m1.radku-1 do
  Result.hodnoty[y,x]:=THodnota.OdectiHodnoty(m1.hodnoty[y,x],m2.hodnoty[y,x]);
end;


function NasobMatice(m1,m2:TMatice):TMatice;
var i,j,k:integer;
begin
if m1.sloupcu<>m2.radku then
 begin
   raise ESpatneRozmery.Create('Špatné rozmìry matic pro násobení');
   exit;
 end;
if(m1.typ<>m2.typ) then
 begin
   raise ERuzneObory.Create('Matice mají rùzné obory hodnot, výpoèet nelze provést.');
   exit;
 end;
Result:=TMatice.Create(m1.radku,m2.sloupcu,'',m1.typ);
for i:=0 to Result.radku-1 do
 for k:=0 to Result.sloupcu-1 do
  begin
    for j:=0 to m2.radku-1 do
      Result.hodnoty[i,k].pricti(THodnota.nasobHodnoty(m1.hodnoty[i,j],m2.hodnoty[j,k]));
  end;
end;

function NasobKonstantouMatici(m:TMatice;z:THodnota):TMatice;
var x,y:integer;
begin
Result:=TMatice.Create(m);
for x:=0 to m.sloupcu-1 do
 for y:=0 to m.radku-1 do
  Result.hodnoty[y,x].nasob(z);

end;

function NasobKonstantouMatici(m:TMatice;k:integer):TMatice;
begin
  Result:=NasobKonstantouMatici(m,TRealneCislo.Create(k));
end;

function OpacnaMatice(m:TMatice):TMatice;
var x,y:integer;
begin
Result:=TMatice.Create(m);
for x:=0 to m.sloupcu-1 do
 for y:=0 to m.radku-1 do
    Result.hodnoty[y,x]:=Result.hodnoty[y,x].opacna;
end;

function TransponovatMatici(m:TMatice):TMatice;
var x,y:integer;
begin
Result:=TMatice.Create(m.sloupcu,m.radku,'',m.typ);
for x:=0 to m.sloupcu-1 do
 for y:=0 to m.radku-1 do
  Result.hodnoty[x,y]:=m.hodnoty[y,x];
end;

function NasobekRadku(radek:TRadekMatice;h:THodnota):TRadekMatice;
var p:integer;
z2:THodnota;
begin
  setLength(Result,length(radek));
  for p:=0 to length(radek)-1 do
   begin
     z2:=radek[p].kopie();
     z2.nasob(h);
     Result[p]:=z2;
   end;
end;


function NasobekRadku(radek:TRadekMatice;k:TRozsah):TRadekMatice;
begin
  Result:=NasobekRadku(radek,TRealneCislo.Create(k));
end;

function DelRadek(radek:TRadekMatice;h:THodnota):TRadekMatice;
var p:integer;
begin
setlength(Result,length(radek));
for p:=0 to length(radek)-1 do
 begin
   Result[p]:=THodnota.delHodnoty(radek[p],h);
 end;
end;

function SecistRadky(radek1,radek2:TRadekMatice):TRadekMatice;
var p:integer;
begin
if(length(radek1)<>length(radek2)) then
 begin
   raise ERadkyVelikost.Create('Nelze sèítat rùznì dlouhé øádky');
   exit;
 end;
setlength(Result,length(radek1));
for p:=0 to length(radek1)-1 do
 begin
   Result[p]:=THodnota.sectiHodnoty(radek1[p],radek2[p]);
 end;
end;

function Determinant(m:TMatice):THodnota;
var m2:TMatice;
p:integer;
begin
Result:=novaHodnota(m.typ,0);
try
  m2:=GaussovaEliminacniMetoda(m,false,false);
  if m2.radku<m.radku then exit;
  Result:=novaHodnota(m.typ,1);
  for p:=0 to m2.radku-1 do
   begin
     Result.nasob(m2.hodnoty[p,p]);
   end;
  if m2.znamenkoD then Result.nasob(novaHodnota(m2.typ,-1));
except

end;
end;

procedure ParametryMatice(m:TMatice;var D:THodnota;var h:integer);
var m2:TMatice;
p:integer;
begin
D:=TKomplexniZlomek.Create(0);
h:=0;
try
  m2:=GaussovaEliminacniMetoda(m,false,false);
  h:=m2.radku;
  if m2.radku<m.radku then exit;
  D:=novaHodnota(m2.typ,1);
  for p:=0 to m2.radku-1 do
   begin
     D.nasob(m2.hodnoty[p,p]);
   end;
  if m2.znamenkoD then D.nasob(novaHodnota(m2.typ,-1));
except

end;
end;

function GaussovaEliminacniMetoda(m:TMatice;jednicky:boolean=true;celacisla:boolean=true;castecne:boolean=false):TMatice;
var y2,r,s:integer;
existujeNenulovy:boolean;
nas:THodnota;
begin
  Result:=TMatice.Create(m);
  Result.znamenkoD:=false;
  try
    s:=-1;
    for r:=0 to Result.radku-1 do
     begin
       (MainForm.MDIChildren[frmOperaceJedne.cmbMatice.ItemIndex] as TMDIChild).gauProgress.Position:=r;
       Application.ProcessMessages;
       s:=s+1;
       if(r>=Result.radku) then break;
       if(s>=Result.radku) then break;
       while(Result.hodnoty[r,s].jeNula) do
       begin
         existujeNenulovy:=false;
         for y2:=r+1 to Result.radku-1 do
          begin
            if y2>=Result.radku then break;
            if not Result.hodnoty[y2,s].jeNula then
              begin
                existujeNenulovy:=true;
                Result.VymenitRadky(r,y2);
                Result.znamenkoD:=not Result.znamenkoD;
              end;
          end;
          if(not existujeNenulovy)then
          s:=s+1;
       end;
       for y2:=r+1 to Result.radku-1 do
        begin
          if Result.hodnoty[y2,s].jeNula then continue;          
          if y2>=Result.radku then break;
          nas:=THodnota.delHodnoty(Result.hodnoty[y2,s],Result.hodnoty[r,s]);
          //MainForm.memo1.Lines.Add('øádek '+inttostr(r)+' podradek:'+inttostr(y2));
          //MainForm.memo1.Lines.Add('èinitel:'+nas.re.retezec);
          nas:=nas.opacna;
          doLogu('Násobitel:'+nas.retezec);
          //showmessage(nas.retezec);
          //MainForm.memo1.Lines.Add('opaèný:'+nas.retezec);
          //Chyba:!!!
          Result.hodnoty[y2]:=SecistRadky(Result.hodnoty[y2],NasobekRadku(Result.hodnoty[r],nas));//-b/a
          if(not Result.hodnoty[y2,s].jeNula) then
           begin
            Result.chyba:=true;
            //showmessage('Chyba:'+inttostr(y2)+'_'+inttostr(s));
            //showmessage(Result.hodnoty[y2,s].retezec);
            //exit;
            Result.hodnoty[y2,s]:=novaHodnota(Result.typ,0);
           end;
        end;
       if(celacisla) then
        Result.hodnoty[r]:=RadekNaCela(Result.hodnoty[r]);
       if(jednicky) then
       if Result.typ<>MT_Z2 then
        begin
          Result.hodnoty[r]:=DelRadek(Result.hodnoty[r],Result.hodnoty[r,s]);
          if not Result.hodnoty[r,s].jeJedna then
           begin
             Result.chyba:=true;
             Result.hodnoty[r,s]:=novaHodnota(Result.typ,1);
           end;
        end;
       
       for y2:=Result.radku-1 downto r+1 do
        begin
          if y2>=Result.radku then break;
          if(JeRadekNulovy(Result.hodnoty[y2])) then
            begin //oprav
              //exit;
              Result.OdebratRadek(y2);
            end;
        end;

     end;
   except
     if(not castecne) then
       raise EGaussNelze.Create('Nelze dokonèit Gaussovu eliminaci, nastala chyba');
   end;
end;

function ObracenaGaussovaEliminacniMetoda(m:TMatice;jednicky:boolean=true;celacisla:boolean=true;castecne:boolean=false):TMatice;
var y2,r,s:integer;
existujeNenulovy:boolean;
nas:THodnota;
a,b:TRadekMatice;
begin
  Result:=TMatice.Create(m);
  try
    s:=Result.radku;
    for r:=Result.radku-1 downto 0 do
     begin
       (MainForm.MDIChildren[frmOperaceJedne.cmbMatice.ItemIndex] as TMDIChild).gauProgress.Position:=Result.radku-1-r;
       Application.ProcessMessages;
       s:=s-1;
       if(r<0) then break;
       if(s<0) then break;

       while(Result.hodnoty[r,s].jeNula) do
       begin
         existujeNenulovy:=false;
         for y2:=r-1 downto 0 do
          begin
            if y2<0 then break;
            if not Result.hodnoty[y2,s].jeNula then
              begin
                existujeNenulovy:=true;
                Result.VymenitRadky(r,y2);
              end;
          end;
          if(not existujeNenulovy)then
          s:=s+1;
       end;
       for y2:=r-1 downto 0 do
        begin
          if y2<0 then break;
          nas:=THodnota.delHodnoty(Result.hodnoty[y2,s],Result.hodnoty[r,s]);
          nas:=nas.opacna;
          doLogu('Násobitel:'+nas.retezec);
          //function radektostr(radek:TRadekMatice):string;
          a:=Result.hodnoty[y2];
          //doLogu('A:'+radektostr(a));
          b:=NasobekRadku(Result.hodnoty[r],nas);
          //doLogu('B:'+radektostr(b));
          Result.hodnoty[y2]:=SecistRadky(a,b);//-b/a
          //doLogu('C:'+radektostr(Result.hodnoty[y2]));
          //if(MessageDlg('K øádku '+inttostr(y2)+' byl pøièten násobek øádku '+inttostr(r),mtInformation,mbYesNo,0)=7) then
          // exit;

          if(not Result.hodnoty[y2,s].jeNula) then
           begin
            Result.hodnoty[y2,s]:=novaHodnota(Result.typ,0);
           end;
        end;
       if(celacisla) then
        Result.hodnoty[r]:=RadekNaCela(Result.hodnoty[r]);
       if(jednicky) then
       if not Result.typ=MT_Z2 then
        begin
          Result.hodnoty[r]:=DelRadek(Result.hodnoty[r],Result.hodnoty[r,s]);
          if not Result.hodnoty[r,s].jeJedna then
           begin
             Result.chyba:=true;
             Result.hodnoty[r,s]:=novaHodnota(Result.typ,1);
           end;
        end;
       for y2:=r-1 downto 0 do
        begin
          if y2<0 then break;
          if(JeRadekNulovy(Result.hodnoty[y2])) then
           begin
            //showmessage(inttostr(y2));
            //exit;
            Result.OdebratRadek(y2);
           end;

        end;

     end;
   except
     if(not castecne) then
       raise EGaussNelze.Create('Nelze dokonèit Gaussovu eliminaci, nastala chyba');
   end;
end;

function JeRadekNulovy(radek:TRadekMatice):boolean;
var p:integer;
begin
  Result:=true;
  for p:=0 to length(radek)-1 do
   begin
     if not radek[p].jeNula then
      begin
        Result:=false;
        exit;
      end;
   end;
end;

function RadekNaCela(radek:TRadekMatice):TRadekMatice;
var n:TRozsah;
p:integer;
begin
  n:=1;
  if radek[0] is TKomplexniZlomek then
  begin
    n:=(radek[0] as TKomplexniZlomek).Re.jmenovatel;
    n:=nsn((radek[0] as TKomplexniZlomek).Im.jmenovatel,n);
    for p:=1 to length(radek)-1 do
     begin
       n:=nsn((radek[p] as TKomplexniZlomek).Re.jmenovatel,n);
       n:=nsn((radek[p] as TKomplexniZlomek).Im.jmenovatel,n);
     end;
  end;
  if radek[0] is TZlomek then
  begin
    n:=(radek[0] as TZlomek).jmenovatel;
    for p:=1 to length(radek)-1 do
     begin
       n:=nsn((radek[p] as TZlomek).jmenovatel,n);
     end;
  end;
  Result:=NasobekRadku(radek,n);
end;


procedure TMatice.PridatSloupce(pocet:integer);
var r,s:integer;
begin
if pocet<0 then
 begin
   raise EMimoRozsah.Create('Nelze pøidat záporný poèet sloupcù');
   exit;
 end;
for r:=0 to radku-1 do
 begin
   setlength(hodnoty[r],sloupcu+pocet);
   for s:=sloupcu to sloupcu+pocet-1 do
    begin
      hodnoty[r,s]:=novaHodnota(typ,0);
    end;
 end;
pn:=pn+pocet;
end;

function PodMatice(m:TMatice;x,y,w,h:integer):TMatice;
var nx,ny:integer;
begin
if (x<0)or(y<0)or(w<=0)or(h<=0)or(x>=m.sloupcu)or(y>=m.radku)or(x+w-1>=m.sloupcu)or(y+h-1>=m.radku) then
 begin
   raise EMimoRozsah.Create('Špatnì zadané rozmìry');
   exit;
 end;

  Result:=TMatice.Create(h,w,'',m.typ);
  for nx:=0 to w-1 do
   for ny:=0 to h-1 do
    begin
      Result.hodnoty[ny,nx]:=m.hodnoty[y+ny,x+nx].kopie();
    end;
end;

function InverzniMatice(m:TMatice):TMatice;
var p:integer;
radkuPred:integer;
nerozsirena:TMatice;
begin
Result:=TMatice.Create(m);
radkuPred:=Result.radku;
Result.PridatSloupce(Result.radku);
     for p:=0 to Result.radku-1 do
      begin
        Result.hodnoty[p,Result.radku+p]:=TZlomek.Create(1);
      end;
try
Result:=GaussovaEliminacniMetoda(Result,true,false);
nerozsirena:=PodMatice(Result,0,0,radkuPred,radkuPred);
for p := 0 to radkuPred - 1 do
 begin
   if JeRadekNulovy(nerozsirena.hodnoty[p]) then
     raise ENelze.Create('Inverzní matice neexistuje');
 end;

if(Result.radku<>radkuPred) then
 raise ENelze.Create('Inverzní matice neexistuje');
Result:=ObracenaGaussovaEliminacniMetoda(Result,true,false);
Result:=PodMatice(Result,m.radku,0,m.radku,m.radku);
except
  raise ENelze.Create('Inverzní matice neexistuje');
end;
end;


procedure TMatice.OdebratRadky(r1,r2:integer);
var p,t,pocet:integer;
begin
 if r2<r1 then
  begin
    t:=r1;
    r1:=r2;
    r2:=t;
  end;
 if ((r1<0)or(r1>=radku))or((r2<0)or(r2>=radku)) then
  begin
    raise EMimoRozsah.Create('Èíslo øádku je mimo rozsah');
    exit;
  end;
pocet:=(r2-r1)+1;
for p:=r1 to radku-1-pocet do
 begin
   hodnoty[p]:=hodnoty[p+pocet];
 end;
 setlength(hodnoty,length(hodnoty)-pocet);
 pm:=pm-pocet;
end;

procedure TMatice.OdebratSloupce(s1,s2:integer);
var p,r,t,pocet:integer;
begin
 if s2<s1 then
  begin
    t:=s1;
    s1:=s2;
    s2:=t;
  end;
 if ((s1<0)or(s1>=sloupcu))or((s2<0)or(s2>=sloupcu)) then
  begin
    raise EMimoRozsah.Create('Èíslo sloupce je mimo rozsah');
    exit;
  end;
pocet:=(s2-s1)+1;
for r:=0 to radku-1 do
begin
for p:=s1 to sloupcu-1-pocet do
 begin
   hodnoty[r,p]:=hodnoty[r,p+pocet];
 end;
 setlength(hodnoty[r],length(hodnoty[r])-pocet);
end;

 pn:=pn-pocet;
 soustava:=soustava;
end;

procedure TMatice.OdebratSloupec(s:integer);
begin
OdebratSloupce(s,s);
end;

procedure TMatice.PridatRadky(pocet:integer);
begin
VlozitRadky(pocet,radku);
end;

procedure TMatice.VlozitRadky(pocet:integer;pozice:integer);
var y,x:integer;
begin
 if (pocet<=0)or(pozice<-1) then
  begin
    raise EMimoRozsah.Create('Špatné parametry pro vložení øádku');
    exit;
  end;

setlength(hodnoty,length(hodnoty)+pocet);

for y:=radku+pocet-1 downto pozice+pocet-1 do
 begin
   setlength(hodnoty[y],sloupcu);
   if y-pocet>=0 then
    hodnoty[y]:=KopieRadku(hodnoty[y-pocet]);
 end;
 for y:=pozice to pozice+pocet-1 do
  begin
    setlength(hodnoty[y],sloupcu);
    for x:=0 to sloupcu-1 do
      hodnoty[y,x]:=novaHodnota(typ,0);
  end;

 pm:=pm+pocet;
end;

procedure TMatice.VlozitSloupce(pocet:integer;pozice:integer);
var y,x:integer;
begin
 if (pocet<=0)or(pozice<-1) then
  begin
    raise EMimoRozsah.Create('Špatné parametry pro vložení sloupce');
    exit;
  end;


for y:=0 to radku-1 do
begin
 setlength(hodnoty[y],length(hodnoty[y])+pocet);
  for x:=sloupcu+pocet-1 downto pozice+pocet-1 do
   begin
     if x-pocet>=0 then
      hodnoty[y,x]:=hodnoty[y,x-pocet].kopie;
   end;
 for x:=pozice to pozice+pocet-1 do
  begin
      hodnoty[y,x]:=novaHodnota(typ,0); 
  end;
end;

 pn:=pn+pocet;
end;


function NoveJmenoMatice(m:TMatice;nazev:string):TMatice;
begin
  Result:=m;
  Result.nazev:=nazev;
end;

end.
