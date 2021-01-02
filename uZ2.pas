unit uZ2;

interface

uses uHodnoty,sysutils,math;

type TZ2Cislo=class(THodnota)
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
   constructor Create(i:TRozsah); overload;
   function getHodnota():TRozsah;
   function kopie():THodnota; override;
   function retezecDesetiny():string; override;

   private
     hodnota:TRozsah;
 end;

 function sectivZ2(i1,i2:TRozsah):TRozsah;
 function odectivZ2(i1,i2:TRozsah):TRozsah;
 function nasobvZ2(i1,i2:TRozsah):TRozsah;

implementation


function sectiBity(i1,i2:integer):integer;
begin
  Result:=1;
  if (i1=1) and(i2=1) then Result:=0;
  if (i1=0) and(i2=0) then Result:=0;
end;

function sectivZ2(i1,i2:TRozsah):TRozsah;
var pos:integer;
begin
  Result:=0;
  pos:=0;
  while (i1<>0)or(i2<>0) do
    begin
      if sectiBity(i1 mod 10,i2 mod 10)=1 then
       Result:=Result+round(power(10,pos));
      pos:=pos+1;
      i1:=i1 div 10;
      i2:=i2 div 10;
    end;
end;

function odectivZ2(i1,i2:TRozsah):TRozsah;
begin
  Result:=sectivZ2(i1,i2);
end;

function nasobvZ2(i1,i2:TRozsah):TRozsah;
var pos:integer;
l2,p:integer;
begin
  Result:=0;
  pos:=0;
  l2:=length(inttostr(i2));
  for p := 0 to l2 - 1 do
    begin
      if i2 mod 10=1 then
       Result:=Result+i1*round(power(10,pos));
      pos:=pos+1;
      i2:=i2 div 10;
    end;
end;


function TZ2Cislo.retezecDesetiny():string;
begin
  Result:=inttostr(hodnota);
end;

function TZ2Cislo.kopie():THodnota;
begin
  Result:=TZ2Cislo.Create(self);
end;

function TZ2Cislo.getHodnota():TRozsah;
begin
  Result:=hodnota;
end;

constructor TZ2Cislo.Create();
begin
  hodnota:=0;
end;

constructor TZ2Cislo.Create(i:TRozsah);
begin
  hodnota:=i;
end;

constructor TZ2Cislo.Create(s:string);
//var prev:integer;
begin
  if (s<>'0') and (s<>'1') then
   raise ESpatnyFormat.Create('Špatný formát Z2 èísla!');
  hodnota:=strtointdef(s,0);
  {prev:=strtointdef(s,-1);
  if prev<0 then
   raise ESpatnyFormat.Create('Špatný formát èísla!');
  hodnota:=prev;
  while prev>0 do
   begin
     if ((prev mod 10)<>0)and((prev mod 10)<>1) then
       raise ESpatnyFormat.Create('Špatný formát èísla!');
     prev:=prev div 10;
   end;}
    
end;

function TZ2Cislo.retezec():string;
begin
  Result:=inttostr(hodnota);
end;
function TZ2Cislo.jeNula():boolean;
begin
  Result:=hodnota=0;
end;
function TZ2Cislo.jeJedna():boolean;
begin
  Result:=hodnota=1;
end;
function TZ2Cislo.jeMinusJedna():boolean;
begin
  Result:=hodnota=1;
end;

procedure TZ2Cislo.nasob(h:THodnota);
begin
  if h is TZ2Cislo then
   hodnota:=nasobvZ2(hodnota,(h as TZ2Cislo).getHodnota);
end;

procedure TZ2Cislo.pricti(h:THodnota);
begin
  if h is TZ2Cislo then
   begin
     hodnota:=sectivZ2(hodnota,(h as TZ2Cislo).getHodnota);
   end;
end;

procedure TZ2Cislo.odecti(h:THodnota);
begin
  pricti(h);
end;

procedure TZ2Cislo.del(h:THodnota);
begin
  //v Z2 se nedeli
  hodnota:=1;
end;

procedure TZ2Cislo.prirad(h:THodnota);
begin
  if h is TZ2Cislo then
   hodnota:=(h as TZ2Cislo).getHodnota;
end;

function TZ2Cislo.opacna():THodnota;
begin
  Result:=TZ2Cislo.Create(hodnota);
end;

end.
