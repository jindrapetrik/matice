unit uHodnoty;

interface

 uses SysUtils;
 type TRozsah=int64;
 type ESpatnyFormat = class(Exception);
 type THodnota=class abstract(TObject)
   function retezec():string; virtual; abstract;
   function retezecDesetiny():string; virtual; abstract;
   function jeNula():boolean; virtual; abstract;
   function jeJedna():boolean; virtual; abstract;
   function jeMinusJedna():boolean; virtual; abstract;
   procedure nasob(h:THodnota); overload; virtual; abstract;
   procedure pricti(h:THodnota); overload; virtual; abstract;
   procedure odecti(h:THodnota); overload; virtual; abstract;
   procedure del(h:THodnota); overload; virtual; abstract;
   procedure Assign(h:THodnota);
   procedure prirad(h:THodnota); virtual; abstract;
   function kopie():THodnota; virtual; abstract;
   function opacna():THodnota; virtual; abstract;

   constructor Create(); overload; virtual;  abstract;
   constructor Create(s:string); overload; virtual;  abstract;
   constructor Create(h:THodnota); overload;

   class function sectiHodnoty(h1,h2:THodnota):THodnota;
   class function odectiHodnoty(h1,h2:THodnota):THodnota;
   class function nasobHodnoty(h1,h2:THodnota):THodnota;
   class function delHodnoty(h1,h2:THodnota):THodnota;
   class function opacnaHodnota(h:THodnota):THodnota;

   destructor Destroy; override;
 end;

 type TRealneCislo=class(THodnota)
   function retezec():string; override;
   function jeNula():boolean; override;
   function jeJedna():boolean; override;
   function jeMinusJedna():boolean; override;
   procedure nasob(h:THodnota); override;
   procedure pricti(h:THodnota); override;
   procedure odecti(h:THodnota); override;
   procedure del(h:THodnota); override;
   procedure prirad(h:THodnota); override;
   function opacna():THodnota; override;
   constructor Create(); overload; override;
   constructor Create(s:string); overload; override;
   constructor Create(e:Extended); overload;
   function getHodnota():extended;
   function kopie():THodnota; override;
   function retezecDesetiny():string; override;

   private
     hodnota:extended;
 end;

 function novaHodnota(typ:integer;hodnota:integer=0):THodnota;
 function vratPismeno(typ:integer):string;
implementation

uses uZlomky,uZ2,uMatice,uKomplex;

destructor THodnota.Destroy;
begin
  inherited;
end;

function vratPismeno(typ:integer):string;
begin
  case typ of
    MT_R:Result:='R';
    MT_C:Result:='C';
    MT_Z2:Result:='Z2';
    else Result:='?';
  end;
end;

function novaHodnota(typ:integer;hodnota:integer=0):THodnota;
begin
  case typ of
    MT_R: Result:=TZlomek.Create(hodnota);
    MT_C: Result:=TKomplexniZlomek.Create(hodnota);
    MT_Z2: Result:=TZ2Cislo.Create(hodnota);
    else Result:=TRealneCislo.Create(hodnota);
  end;
end;

procedure THodnota.Assign(h:THodnota);
begin
  prirad(h);
end;


function TRealneCislo.kopie():THodnota;
begin
  Result:=TRealneCislo.Create(self);
end;

function TRealneCislo.getHodnota():extended;
begin
  Result:=hodnota;
end;

constructor TRealneCislo.Create();
begin
  hodnota:=0;
end;

constructor TRealneCislo.Create(e:Extended);
begin
  hodnota:=e;
end;

constructor TRealneCislo.Create(s:string);
begin
  hodnota:=strtofloat(s);
end;

function TRealneCislo.retezec():string;
begin
  Result:=floattostr(hodnota);
end;

function TRealneCislo.retezecDesetiny():string;
begin
  Result:=retezec();
end;

function TRealneCislo.jeNula():boolean;
begin
  Result:=hodnota=0;
end;
function TRealneCislo.jeJedna():boolean;
begin
  Result:=hodnota=1;
end;
function TRealneCislo.jeMinusJedna():boolean;
begin
  Result:=hodnota=-1;
end;

procedure TRealneCislo.nasob(h:THodnota);
begin
  if h is TRealneCislo then
   hodnota:=hodnota*(h as TRealneCislo).getHodnota;
end;

procedure TRealneCislo.pricti(h:THodnota);
begin
  if h is TRealneCislo then
   hodnota:=hodnota+(h as TRealneCislo).getHodnota;
end;

procedure TRealneCislo.odecti(h:THodnota);
begin
  if h is TRealneCislo then
   hodnota:=hodnota-(h as TRealneCislo).getHodnota;
end;

procedure TRealneCislo.del(h:THodnota);
begin
  if h is TRealneCislo then
   hodnota:=hodnota/(h as TRealneCislo).getHodnota;
end;

procedure TRealneCislo.prirad(h:THodnota);
begin
  if h is TRealneCislo then
   hodnota:=(h as TRealneCislo).getHodnota;
end;

function TRealneCislo.opacna():THodnota;
begin
  Result:=TRealneCislo.Create(-hodnota);
end;

class function THodnota.sectiHodnoty(h1,h2:THodnota):THodnota;
begin
 Result:=h1.kopie();
 Result.pricti(h2);
end;

class function THodnota.odectiHodnoty(h1,h2:THodnota):THodnota;
begin
 Result:=h1.kopie();
 Result.odecti(h2);
end;

class function THodnota.nasobHodnoty(h1,h2:THodnota):THodnota;
begin
 Result:=h1.kopie();
 Result.nasob(h2);

end;

class function THodnota.delHodnoty(h1,h2:THodnota):THodnota;
begin
 Result:=h1.kopie();
 Result.del(h2);
end;

constructor THodnota.Create(h:THodnota);
begin
  Assign(h);
end;


class function THodnota.opacnaHodnota(h:THodnota):THodnota;
begin
  Result:=h.opacna;
end;
end.
