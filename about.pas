unit about;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,shellapi;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    btnOK: TButton;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Copyright: TLabel;
    lblVerze: TLabel;
    memHistory: TMemo;
    lblHistory: TLabel;
    memInfo: TMemo;
    lblInformations: TLabel;
    lblWeb: TLabel;
    procedure lblWebClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.dfm}

procedure TAboutBox.lblWebClick(Sender: TObject);
begin
ShellExecute(0,pchar('open'),pchar('http://matice.jpexs.com'),pchar(''),pchar(''),SW_MAXIMIZE);
end;

end.
 
