unit uKomplex;

interface

uses uZlomky,RegExpr,uHodnoty;

type
  Rozsah=TZlomek;

  TKomplexniZlomek=class(THodnota)
  private
    function getOrigFormat():integer;
    procedure setOrigFormat(value:integer);
  public
    Re,Im:TZlomek;
    property origFormat:integer read getOrigFormat write setOrigFormat;
    constructor Create(); overload; override;
    constructor Create(re:integer); overload;
    constructor Create(s:string); overload; override;
    constructor Create(kz:TKomplexniZlomek); overload;
    constructor Create(pRe,pIm:TZlomek); overload;
    constructor Create(pRe:TZlomek); overload;
    constructor Create(pRe:TRozsah;pIm:TRozsah=0); overload;
    function retezec():string; override;
    function retezecDesetiny():string; override;
    function jeNula():boolean; override;
    function jeJedna():boolean; override;
    function jeMinusJedna():boolean; override;
    procedure nasob(h:THodnota); overload; override;
    procedure pricti(h:THodnota); overload; override;
    procedure odecti(h:THodnota); overload; override;
    procedure del(h:THodnota); overload; override;
    procedure prirad(h:THodnota); override;
    function opacna():THodnota; override;
    function kopie():THodnota; override;
    destructor Destroy(); override;
  end;

const
 ZnakStupen='°';
 ZnakMinuta='''';

var
  ZobrazitChybu:Boolean=true;
  ZnakImg:char='i';
function SectiKZlomky(A,B:TKomplexniZlomek):TKomplexniZlomek;
function OdectiKZlomky(A,B:TKomplexniZlomek):TKomplexniZlomek;
function NasobKZlomky(A,B:TKomplexniZlomek):TKomplexniZlomek;
function DelKZlomky(A,B:TKomplexniZlomek):TKomplexniZlomek;
function OpacnyKZlomek(kz:TKomplexniZlomek):TKomplexniZlomek;


implementation
uses SysUtils,Math;

destructor TKomplexniZlomek.Destroy();
begin
Re.Destroy;
Im.Destroy;
inherited;
end;


function TKomplexniZlomek.kopie():THodnota;
begin
  Result:=TKomplexniZlomek.Create(self);
end;

function TKomplexniZlomek.opacna():THodnota;
begin
  Result:=OpacnyKZlomek(self);
end;

constructor TKomplexniZlomek.Create(re:integer);
begin
Create(TZlomek.Create(re),TZlomek.Create(0));
end;

function TKomplexniZlomek.jeJedna():boolean;
begin
  Result:=Re.jeJedna and Im.jeNula;
end;

function TKomplexniZlomek.jeMinusJedna():boolean;
begin
  Result:=Re.jeMinusJedna and Im.jeNula;
end;

procedure TKomplexniZlomek.setOrigFormat(value:integer);
begin
Re.origFormat:=value;
Im.origFormat:=value;
end;

function TKomplexniZlomek.getOrigFormat():integer;
begin
  Result:=Re.origFormat;
end;

constructor TKomplexniZlomek.Create();
begin
  Create(0);
end;

constructor TKomplexniZlomek.Create(s:string);
var reg:TRegExpr;
begin
reg:=TRegExpr.Create;//ZnakImg
reg.Expression:='^([^'+ZnakImg+']*)[ ]?(([\+\-])[ ]?'+ZnakImg+'[\(]?([^\)]*)[\)]?)?$';
if reg.Exec(s) then
 begin
   Re:=TZlomek.Create(reg.Match[1]);
   if (reg.Match[2]<>'')and(reg.Match[4]='') then
    Im:=TZlomek.Create(1)
   else
    Im:=TZlomek.Create(reg.Match[4]);
   if reg.Match[3]='-' then
    Im:=OpacnyZlomek(Im);
 end
 else
 begin
   reg.Expression:='^([-]?)'+ZnakImg+'[\(]?([^\)]*)[\)]?$';
   if reg.Exec(s) then
    begin
      Re:=TZlomek.Create(0);
      if(reg.Match[2]='') then
       Im:=TZlomek.Create(1)
      else
       Im:=TZlomek.Create(reg.Match[2]);
      if reg.Match[1]='-' then
        Im:=OpacnyZlomek(Im);
    end
    else
    begin
      raise ESpatnyFormat.Create('Špatný formát èísla!');
    end;
 end;
end;

constructor TKomplexniZlomek.Create(kz:TKomplexniZlomek);
begin
 Assign(kz);
end;

constructor TKomplexniZlomek.Create(pRe,pIm:TZlomek);
begin
  Re:=pRe;
  Im:=pIm;
end;

constructor TKomplexniZlomek.Create(pRe:TZlomek);
begin
Create(pRe,TZlomek.Create(0));
end;

constructor TKomplexniZlomek.Create(pRe:TRozsah;pIm:TRozsah=0);
begin
  Create(TZlomek.Create(pRe),TZlomek.Create(pIm));
end;


procedure TKomplexniZlomek.prirad(h:THodnota);
var kz:TKomplexniZlomek;
begin
  if h is TKomplexniZlomek then
  begin
    kz:=h as TKomplexniZlomek;
    Re:=TZlomek.Create(kz.Re);
    Im:=TZlomek.Create(kz.Im);
  end;
  if (h is TZlomek)or(h is TRealneCislo) then
  begin
    Re:=TZlomek.Create(h);
    Im:=TZlomek.Create(0);
  end;
end;

function TKomplexniZlomek.jeNula():boolean;
begin
  Result:=Re.jeNula and Im.jeNula;
end;

procedure TKomplexniZlomek.nasob(h:THodnota);
var kz1:TKomplexniZlomek;
begin
    kz1:=NasobKZlomky(self,h as TKomplexniZlomek);
    Re:=kz1.Re;
    Im:=kz1.Im;
end;

procedure TKomplexniZlomek.pricti(h:THodnota);
var kz1:TKomplexniZlomek;
begin
  kz1:=SectiKZlomky(self,h as TKomplexniZlomek);
  Re:=kz1.Re;
  Im:=kz1.Im;
end;

procedure TKomplexniZlomek.odecti(h:THodnota);
var kz1:TKomplexniZlomek;
begin
  kz1:=OdectiKZlomky(self,h as TKomplexniZlomek);
  Re:=kz1.Re;
  Im:=kz1.Im;
end;

procedure TKomplexniZlomek.del(h:THodnota);
var kz1:TKomplexniZlomek;
begin
  kz1:=DelKZlomky(self,h as TKomplexniZlomek);
  Re:=kz1.Re;
  Im:=kz1.Im;
end;


function TKomplexniZlomek.retezec():string;
begin
 if Im.jeNula then
  Result:=Re.retezec
 else
 if Re.jeNula then
  begin
    if Im.jeJedna then
      Result:=ZnakImg
    else
    if Im.jeMinusJedna then
      Result:='-'+ZnakImg
    else
    if ((Im.celaCast<>0)and(Im.citatel<>0))and(Im.origFormat<>ZLT_DESETINNE) then
     Result:=ZnakImg+'('+Im.retezec+')'
    else
     if Im.jeZaporny then
      Result:='-'+ZnakImg+OpacnyZlomek(Im).retezec
     else
      Result:=ZnakImg+Im.retezec;
  end
  else
  begin
    if Im.jeJedna then
      Result:=Re.retezec+'+'+ZnakImg
    else
    if Im.jeMinusJedna then
      Result:=Re.retezec+'-'+ZnakImg
    else
    if ((Im.celaCast<>0)and(Im.citatel<>0))and(Im.origFormat<>ZLT_DESETINNE) then
     Result:=Re.retezec+'+'+ZnakImg+'('+Im.retezec+')'
    else
     if Im.jeZaporny then
      Result:=Re.retezec+'-'+ZnakImg+OpacnyZlomek(Im).retezec
     else
      Result:=Re.retezec+'+'+ZnakImg+Im.retezec;
  end;
end;

function TKomplexniZlomek.retezecDesetiny():string;
begin
 if Im.jeNula then
  Result:=Re.retezecDesetiny
 else
 if Re.jeNula then
  begin
    if Im.jeJedna then
      Result:=ZnakImg
    else
    if Im.jeMinusJedna then
      Result:='-'+ZnakImg
    else
    if ((Im.celaCast<>0)and(Im.citatel<>0))and(Im.origFormat<>ZLT_DESETINNE) then
     Result:=ZnakImg+'('+Im.retezecDesetiny+')'
    else
     if Im.jeZaporny then
      Result:='-'+ZnakImg+OpacnyZlomek(Im).retezecDesetiny
     else
      Result:=ZnakImg+Im.retezecDesetiny;
  end
  else
  begin
    if Im.jeJedna then
      Result:=Re.retezecDesetiny+'+'+ZnakImg
    else
    if Im.jeMinusJedna then
      Result:=Re.retezecDesetiny+'-'+ZnakImg
    else
    if ((Im.celaCast<>0)and(Im.citatel<>0))and(Im.origFormat<>ZLT_DESETINNE) then
     Result:=Re.retezecDesetiny+'+'+ZnakImg+'('+Im.retezecDesetiny+')'
    else
     if Im.jeZaporny then
      Result:=Re.retezecDesetiny+'-'+ZnakImg+OpacnyZlomek(Im).retezecDesetiny
     else
      Result:=Re.retezecDesetiny+'+'+ZnakImg+Im.retezecDesetiny;
  end;
end;

function SectiKZlomky(A,B:TKomplexniZlomek):TKomplexniZlomek;
begin
     Result:=TKomplexniZlomek.Create;
     Result.Re:=SectiZlomky(A.Re,B.Re);
     Result.Im:=SectiZlomky(A.Im,B.Im);
end;

function OdectiKZlomky(A,B:TKomplexniZlomek):TKomplexniZlomek;
begin
     Result:=TKomplexniZlomek.Create;
     Result.Re:=OdectiZlomky(A.Re,B.Re);
     Result.Im:=OdectiZlomky(A.Im,B.Im);
end;

function NasobKZlomky(A,B:TKomplexniZlomek):TKomplexniZlomek;
begin
     Result:=TKomplexniZlomek.Create;
     Result.Re:=OdectiZlomky(NasobZlomky(A.Re,B.Re),NasobZlomky(A.Im,B.Im));
     Result.Im:=SectiZlomky(NasobZlomky(A.Re,B.Im),NasobZlomky(A.Im,B.Re));
end;

function DelKZlomky(A,B:TKomplexniZlomek):TKomplexniZlomek;
begin
     Result:=TKomplexniZlomek.Create;
     Result.Re:=DelZlomky((SectiZlomky(NasobZlomky(A.Re,B.Re),NasobZlomky(A.Im,B.Im))),(SectiZlomky(NasobZlomky(B.Re,B.Re),NasobZlomky(B.Im,B.Im))));
     Result.Im:=DelZlomky((OdectiZlomky(NasobZlomky(A.Im,B.Re),NasobZlomky(A.Re,B.Im))),(SectiZlomky(NasobZlomky(B.Re,B.Re),NasobZlomky(B.Im,B.Im))));
end;



function OdstranMezery(s:string):string;
begin
OdstranMezery:=stringreplace(s,' ','',[rfReplaceAll]);
end;


function OpacnyKZlomek(kz:TKomplexniZlomek):TKomplexniZlomek;
begin
Result:=TKomplexniZlomek.Create(kz);
Result.Re:=OpacnyZlomek(Result.Re);
Result.Im:=OpacnyZlomek(Result.Im);
end;


end.
