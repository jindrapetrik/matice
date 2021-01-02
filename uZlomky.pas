unit uZlomky;


interface
uses dialogs,sysutils,RegExpr,Math,uHodnoty;

        type ENulovyJmenovatel = class(Exception);
        

        
        type TPoleRozsah=array of TRozsah;

        type TZlomek=class(THodnota)
        private
                pcelaCast:TRozsah;
                pcitatel:TRozsah;
                pjmenovatel:TRozsah;

                pnaNesoudelne:boolean;
        public
                origFormat:integer;
                chyba:boolean;
                pcislo:extended;
                property naNesoudelne:boolean read pnaNesoudelne;
                property celaCast:TRozsah read pcelaCast;
                property citatel:TRozsah read pcitatel;
                property jmenovatel:TRozsah read pjmenovatel;
                constructor Create(nnaNesoudelne:boolean=true); overload;
                constructor Create(v:Extended); overload;
                constructor Create(z:TZlomek;nnaNesoudelne:boolean=true); overload;
                constructor Create(ncelaCast,ncitatel,njmenovatel:TRozsah;nnaNesoudelne:boolean=true); overload;
                constructor Create(ncitatel,njmenovatel:TRozsah;nnaNesoudelne:boolean=true); overload;
                constructor Create(ncelaCast:TRozsah;nnaNesoudelne:boolean=true); overload;
                constructor Create(s:string;nnaNesoudelne:boolean=true); overload;
                procedure kratit();
                function retezec():string; override;
                function retezecDesetiny():string; override;
                function desetinneCislo():extended;
                function jeNula():boolean; override;
                function jeJedna():boolean;override;
                function jeMinusJedna():boolean;override;
                function jeKladny():boolean;
                function jeZaporny():boolean;
                procedure nasob(h:THodnota); overload; override;
                procedure nasob(a:TRozsah); overload;
                procedure pricti(h:THodnota); overload; override;
                procedure pricti(a:TRozsah); overload;
                procedure odecti(h:THodnota); overload; override;
                procedure odecti(a:TRozsah); overload;
                procedure del(h:THodnota); overload; override;
                procedure del(a:TRozsah); overload;
                procedure prirad(h:THodnota); override;
                function fullretezec():string;
                procedure prepocitejCelouCast();
                function opacna():THodnota; override;
                function kopie():THodnota; override;
        end;

        function SectiZlomky(z1,z2:TZlomek):TZlomek;
        function OdectiZlomky(z1,z2:TZlomek):TZlomek;
        function NasobZlomky(z1,z2:TZlomek):TZlomek;
        function DelZlomky(z1,z2:TZlomek):TZlomek;
        function ObratZlomek(z:TZlomek):TZlomek;
        function OpacnyZlomek(z:TZlomek):TZlomek;
        function NSD(u,v:TRozsah):TRozsah;
        function nsn(a,b:TRozsah):TRozsah; overload;
        function nsn(p:TPoleRozsah):TRozsah; overload;

const
        ZLT_ZLOMEK=1;
        ZLT_CELE=2;
        ZLT_DESETINNE=3;
        ZLT_NUTNEDESETINNE=4;

        PRESNOST=8;


var
        oddelovac:char=',';
        PRESNOST10:TRozsah=0;
implementation
 uses MAIN;



function TZlomek.kopie():THodnota;
begin
  Result:=TZlomek.Create(self);
end;

constructor TZlomek.Create(v:Extended);
begin
Create(0);
pcislo:=v;
origFormat:=ZLT_NUTNEDESETINNE;
end;


function NSD(u,v:TRozsah):TRozsah;
var r:int64;
begin
 if(u<0) then u:=-u;
 if(v<0) then v:=-v;
 while(v<>0) do
  begin
    r:=u mod v;
    u:=v;
    v:=r;
  end;
  Result:=u;
end;

function nsn(a,b:TRozsah):TRozsah;
  begin
   nsn:=(a*b) div nsd(a,b);
  end;

function nsnr(p:TPoleRozsah;pstart:integer):TRozsah;
begin
if pstart=length(p)-1 then
   Result:=p[pstart]
else
   Result:=nsn(nsnr(p,pstart+1),p[pstart]);
end;

function nsn(p:TPoleRozsah):TRozsah;
begin
  Result:=nsnr(p,0);
end;

constructor TZlomek.Create(z:TZlomek;nnaNesoudelne:boolean=true);
begin
  Create(z.celaCast,z.citatel,z.jmenovatel,nnaNesoudelne);
  pcislo:=z.pcislo;
  origFormat:=z.origFormat;
end;


constructor TZlomek.Create(nnaNesoudelne:boolean=true);
begin
 Create(0,0,1,nnaNesoudelne);
 origFormat:=ZLT_CELE;
end;

constructor TZlomek.Create(ncitatel,njmenovatel:TRozsah;nnaNesoudelne:boolean=true);
begin

  Create(0,ncitatel,njmenovatel,nnaNesoudelne);
  origFormat:=ZLT_ZLOMEK;
end;

constructor TZlomek.Create(ncelaCast,ncitatel,njmenovatel:TRozsah;nnaNesoudelne:boolean=true);
begin
  chyba:=false;
  if(PRESNOST10=0) then
   PRESNOST10:=round(power(10,PRESNOST));
  if njmenovatel=0 then
   begin
     raise Exception.Create('Chyba: Jmenovatel nesmí být 0!');
     pcelaCast:=ncelaCast;
     pcitatel:=ncitatel;
     pjmenovatel:=1;
     pcislo:=1;
     exit;
   end;


  pcelaCast:=ncelaCast;
  pcitatel:=ncitatel;
  pjmenovatel:=njmenovatel;
  pnaNesoudelne:=nnaNesoudelne;
  pcislo:=pcelacast+pcitatel/pjmenovatel;

  if(pcitatel<0)and(pjmenovatel<0) then
    begin
      pcitatel:=-pcitatel;
      pjmenovatel:=-pjmenovatel;
    end;
  if(pjmenovatel<0)and(pcitatel>=0) then
    begin
      pcitatel:=-pcitatel;
      pjmenovatel:=-pjmenovatel;
    end;
  if(pcitatel=0) then
   pjmenovatel:=1;
  prepocitejCelouCast();
  if((pcelaCast<0)and(pcitatel>0)) then
    begin
      pcitatel:=-(pjmenovatel-pcitatel);
      pcelaCast:=pcelaCast+1;
    end;
  if((pcelaCast>0)and(pcitatel<0)) then
    begin
      pcitatel:=pjmenovatel+pcitatel;
      pcelaCast:=pcelaCast-1;
    end;
  if(nnaNesoudelne)or(abs(pcitatel)>PRESNOST10)or(abs(pjmenovatel)>PRESNOST10) then
  begin
    kratit();
  end;
  if(abs(pcitatel)>PRESNOST10)or(abs(pjmenovatel)>PRESNOST10) then
   begin
     origFormat:=ZLT_NUTNEDESETINNE;
     //Create(floattostrf(desetinneCislo(),ffFixed,PRESNOST,PRESNOST));
   end;
end;

constructor TZlomek.Create(ncelaCast:TRozsah;nnaNesoudelne:boolean=true);
begin
  Create(ncelaCast,0,1,nnaNesoudelne);
  origFormat:=ZLT_CELE;
end;

constructor TZlomek.Create(s:string;nnaNesoudelne:boolean=true);
var re:TRegExpr;
ncelaCast,ncitatel,njmenovatel:TRozsah;
st:string;
exponent:TRozsah;
zaporne:boolean;
begin
re:=TRegExpr.Create;
re.Expression:='^([\-]?[0-9]+)?(([\-\+ ][0-9]+)/([0-9]+))?[ ]*$';
if(re.Exec(s)) then  //Formát a+b/c
 begin
   st:=re.Match[1];
   if(st='')then st:='0';
   ncelaCast:=strtoint64(st);
   st:=re.Match[3];
   if st='' then st:='0';
   ncitatel:=strtoint64(st);
   st:=re.Match[4];
   if st='' then st:='1';
   njmenovatel:=strtoint64(st);
   Create(ncelaCast,ncitatel,njmenovatel,nnaNesoudelne);
   origFormat:=ZLT_ZLOMEK;
 end
 else
 begin
   re.Expression:='^([\-]?[0-9]+)/([0-9]+)[ ]*$';
   if(re.Exec(s)) then                        //Formát a/b
    begin
      ncelaCast:=0;
      st:=re.Match[1];
      if st='' then st:='0';
      ncitatel:=strtoint64(st);
      st:=re.Match[2];
      if st='' then st:='1';
      njmenovatel:=strtoint64(st);
      Create(ncelaCast,ncitatel,njmenovatel,nnaNesoudelne);
      origFormat:=ZLT_ZLOMEK;

    end
    else
    begin
      re.Expression:='^([\-]?[0-9]+)\'+oddelovac+'([0-9]+)[ ]*$';
      if(re.Exec(s)) then       //Formát desetinné èíslo
       begin
         st:=re.Match[1];
         zaporne:=st='-0';
         ncelaCast:=strtoint(st);
         st:=re.Match[2];
         if(length(st)>PRESNOST) then
          st:=Copy(st,0,PRESNOST);
         ncitatel:=strtoint64(st);
         if(ncelaCast<0) then ncitatel:=-ncitatel;
         if(zaporne) then
          begin
            ncitatel:=-ncitatel;
          end;
         njmenovatel:=round(power(10,length(st)));

         Create(ncelaCast,ncitatel,njmenovatel,nnaNesoudelne);
         origFormat:=ZLT_DESETINNE;
       end
       else
       begin
         re.Expression:='^([\-]?[0-9]+)\'+oddelovac+'([0-9]+)E([-]?[0-9]+)[ ]*$';
         if(re.Exec(s)) then       //Formát desetinné èíslo E
           begin
                ncelaCast:=strtoint(re.Match[1]);
                st:=re.Match[2];
                if(length(st)>PRESNOST) then
                 st:=Copy(st,0,PRESNOST);
                ncitatel:=strtoint(st);
                njmenovatel:=round(power(10,length(st)));
                st:=re.Match[3];
                exponent:=strtoint(st);
                ncelaCast:=ncelaCast*round(power(10,exponent));
                ncitatel:=ncitatel*round(power(10,exponent));
                Create(ncelaCast,ncitatel,njmenovatel,nnaNesoudelne);
                origFormat:=ZLT_DESETINNE;
           end
           else
           begin
            raise ESpatnyFormat.Create('Špatný formát èísla!');
            Create(0,0,1);
           end;
       end;
    end;
 end;
re.Destroy;
end;

function SectiZlomky(z1,z2:TZlomek):TZlomek;
var ncelaCast,ncitatel,njmenovatel:TRozsah;
jmabs:TRozsah;
begin
  if (z1.origFormat>=ZLT_DESETINNE)or(z2.origFormat>=ZLT_DESETINNE) then
   begin
     Result:=TZlomek.Create(z1.pcislo+z2.pcislo);
     exit;
   end;
  njmenovatel:=z1.jmenovatel*z2.jmenovatel;

  jmabs:=njmenovatel;
  if jmabs<0 then
   jmabs:=-jmabs;
  if (jmabs>PRESNOST10)or(njmenovatel=0) then
   begin
     z1.kratit;
     z2.kratit;
     njmenovatel:=z1.jmenovatel*z2.jmenovatel;
   end;

  ncelaCast:=z1.celaCast+z2.celaCast;
  ncitatel:=z1.citatel*z2.jmenovatel+z2.citatel*z1.jmenovatel;
  Result:=TZlomek.Create(ncelaCast,ncitatel,njmenovatel,z1.naNesoudelne);
  Result.kratit;
  if(z1.origFormat>=ZLT_DESETINNE) then Result.origFormat:=z1.origFormat;
  if(z2.origFormat>Result.origFormat) then Result.origFormat:=z2.origFormat;
end;

function OdectiZlomky(z1,z2:TZlomek):TZlomek;
var ncelaCast,ncitatel,njmenovatel:TRozsah;
begin
  if (z1.origFormat>=ZLT_DESETINNE)or(z2.origFormat>=ZLT_DESETINNE) then
   begin
     Result:=TZlomek.Create(z1.pcislo-z2.pcislo);
     exit;
   end;
  ncelaCast:=z1.celaCast-z2.celaCast;
  ncitatel:=z1.citatel*z2.jmenovatel-z2.citatel*z1.jmenovatel;
  njmenovatel:=z1.jmenovatel*z2.jmenovatel;
  Result:=TZlomek.Create(ncelaCast,ncitatel,njmenovatel,z1.naNesoudelne);
  if(z1.origFormat>=ZLT_DESETINNE) then Result.origFormat:=z1.origFormat;
  if(z2.origFormat>Result.origFormat) then Result.origFormat:=z2.origFormat;
end;

function NasobZlomky(z1,z2:TZlomek):TZlomek;
var ncelaCast,ncitatel,njmenovatel:TRozsah;
jmabs:TRozsah;
begin
  if (z1.origFormat>=ZLT_DESETINNE)or(z2.origFormat>=ZLT_DESETINNE) then
   begin
     Result:=TZlomek.Create(z1.pcislo*z2.pcislo);
     exit;
   end;
  njmenovatel:=z1.jmenovatel*z2.jmenovatel;
  try
  jmabs:=njmenovatel;
  if jmabs<0 then jmabs:=-jmabs;
  if (jmabs>PRESNOST10)or(njmenovatel=0) then
   begin
     z1.kratit;
     z2.kratit;
     njmenovatel:=z1.jmenovatel*z2.jmenovatel;
   end;
  except
    njmenovatel:=1;
  end;
  ncelaCast:=0;
  ncitatel:=(z1.citatel+z1.celaCast*z1.jmenovatel)*(z2.citatel+z2.celaCast*z2.jmenovatel);

  Result:=TZlomek.Create(ncelaCast,ncitatel,njmenovatel,z1.naNesoudelne);
  Result.kratit;
  Result.chyba:=true;
  if(z1.origFormat>=ZLT_DESETINNE) then Result.origFormat:=z1.origFormat;
  if(z2.origFormat>Result.origFormat) then Result.origFormat:=z2.origFormat;
end;

procedure TZlomek.prepocitejCelouCast();
begin
  if(pjmenovatel=0) then exit;
  pcelaCast:=pcelaCast+pcitatel div pjmenovatel;
  pcitatel:=pcitatel mod pjmenovatel;
  if(pcitatel=0) then pjmenovatel:=1;
end;

procedure TZlomek.kratit();
var D:int64;
begin
 if origFormat>=ZLT_DESETINNE then exit;
 D:=NSD(pcitatel,pjmenovatel);
 if d<>0 then
 begin
   pcitatel:=pcitatel div D;
   pjmenovatel:=pjmenovatel div D;
 end;
 if pcitatel=pjmenovatel then
  begin
    pcitatel:=1;
    pjmenovatel:=1;
  end;
 { for i:=2 to 10 do
   begin
     if i>pcitatel div 2 then exit;
     if (pjmenovatel mod i=0)and(pcitatel mod i=0) then
      begin
        pjmenovatel:=pjmenovatel div i;
        pcitatel:=pcitatel div i;
      end;
   end;}
end;

function ObratZlomek(z:TZlomek):TZlomek;
var ncelaCast,ncitatel,njmenovatel:TRozsah;
begin
  if z.origFormat>=ZLT_DESETINNE then
   begin
     Result:=TZlomek.Create(1/z.pcislo);
     exit;
   end;
  ncelaCast:=0;
  ncitatel:=z.jmenovatel;
  njmenovatel:=z.citatel+z.celaCast*z.jmenovatel;
  if njmenovatel=0 then
   begin
     raise ENulovyJmenovatel.Create('Jmenovatel nesmí být 0!');
     exit;
   end;
  Result:=TZlomek.Create(ncelaCast,ncitatel,njmenovatel,z.naNesoudelne);
  if(z.origFormat>=ZLT_DESETINNE) then Result.origFormat:=z.origFormat;
end;

function TZlomek.jeNula():boolean;
begin
  Result:=(pcislo=0);
end;

function TZlomek.jeJedna():boolean;
begin
  Result:=(pcislo=1);
end;

function TZlomek.jeMinusJedna():boolean;
begin
  Result:=(pcislo=-1);
end;

function DelZlomky(z1,z2:TZlomek):TZlomek;
begin


  if (z1.origFormat>=ZLT_DESETINNE)or(z2.origFormat>=ZLT_DESETINNE) then
   begin
     try
       Result:=TZlomek.Create(z1.pcislo / z2.pcislo);
     except
       Result:=TZlomek.Create(0);
     end;
     exit;
   end;
  z2:=ObratZlomek(z2);
  Result:=NasobZlomky(z1,z2);
  if(z1.origFormat>=ZLT_DESETINNE) then Result.origFormat:=z1.origFormat;
  if(z2.origFormat>Result.origFormat) then Result.origFormat:=z2.origFormat;
end;

function TZlomek.retezecDesetiny():string;
begin
   Result:=floattostr(desetinneCislo);
end;

function TZlomek.retezec():string;
var s:string;
begin
  if(origFormat=ZLT_NUTNEDESETINNE) then
   begin
     Result:=floattostr(pcislo);
     exit;
   end;
  if(origFormat=ZLT_DESETINNE) then
   begin
     Result:=floattostr(desetinneCislo);
     exit;
   end;
  s:='';
  if MainForm.mnuOddelitCelouCast.Checked then
  begin
  if(pcelaCast<>0) then
   begin
     s:=inttostr(pcelaCast);
     if(pcitatel>0) then
      s:=s+'+';
   end;
   if(pcitatel<>0) then
    s:=s+inttostr(pcitatel)+'/'+inttostr(pjmenovatel);
   if(s='') then s:='0';
   Result:=s;
 end
 else
 begin
   if(pcitatel<>0) then
    s:=s+inttostr(pcelaCast*pjmenovatel+pcitatel)+'/'+inttostr(pjmenovatel)
   else
    s:=inttostr(pcelaCast);
   if(s='') then s:='0';
   Result:=s;
 end;
end;

function TZlomek.fullretezec():string;
begin
  if MainForm.mnuOddelitCelouCast.Checked then
   Result:=inttostr(pcelaCast)+' '+inttostr(pcitatel)+'/'+inttostr(pjmenovatel)
  else
   Result:=inttostr(pcelaCast*pjmenovatel+pcitatel)+'/'+inttostr(pjmenovatel)

end;

procedure TZlomek.nasob(a:TRozsah);
begin
pcelaCast:=pcelaCast*a;
pcitatel:=pcitatel*a;
end;

procedure TZlomek.nasob(h:THodnota);
begin
Assign(NasobZlomky(self,TZlomek.Create(h)));
end;

procedure TZlomek.pricti(a:TRozsah);
begin
  pcelaCast:=pcelaCast+a;
end;

procedure TZlomek.pricti(h:THodnota);
begin
Assign(SectiZlomky(self,TZlomek.Create(h)));
end;

procedure TZlomek.odecti(a:TRozsah);
begin
Assign(OdectiZlomky(self,TZlomek.Create(a)));
end;

procedure TZlomek.odecti(h:THodnota);
begin
Assign(OdectiZlomky(self,TZlomek.Create(h)));
end;

procedure TZlomek.del(a:TRozsah);
begin
prirad(DelZlomky(self,TZlomek.Create(a)));
end;

procedure TZlomek.del(h:THodnota);
begin
prirad(DelZlomky(self,TZlomek.Create(h)));
end;

procedure TZlomek.prirad(h:THodnota);
var z:TZlomek;
begin
 if h is TRealneCislo then
 begin
   Create((h as TRealneCislo).getHodnota);
 end;
 if h is TZlomek then
 begin
  z:=h as TZlomek;
  pcelaCast:=z.celaCast;
  pcitatel:=z.citatel;
  pjmenovatel:=z.jmenovatel;
  origFormat:=z.origFormat;
  if(z.origFormat<ZLT_DESETINNE) then
    pcislo:=pcelaCast+pcitatel/pjmenovatel
  else
    pcislo:=z.pcislo;
 end;
end;

function TZlomek.desetinneCislo():extended;
begin
  if origFormat=ZLT_NUTNEDESETINNE then
    Result:=pcislo
  else
    Result:=pcelaCast+pcitatel/pjmenovatel;
end;

function OpacnyZlomek(z:TZlomek):TZlomek;
begin
  Result:=TZlomek.Create(-z.celaCast,-z.citatel,z.jmenovatel,z.naNesoudelne);
  if(z.origFormat>=ZLT_DESETINNE) then Result.origFormat:=z.origFormat;
  Result.pcislo:=-z.pcislo;
end;

function TZlomek.opacna():THodnota;
begin
  Result:=OpacnyZlomek(self);
end;

function TZlomek.jeKladny():boolean;
begin
  Result:=(celaCast>0)or(citatel>0);
end;

function TZlomek.jeZaporny():boolean;
begin
  Result:=(celaCast<0)or(citatel<0);
end;

end.

 