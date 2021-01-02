unit uFormat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmFormat = class(TForm)
    lblVyberteObor: TLabel;
    btnOK: TButton;
    btnStorno: TButton;
    lsbFormat: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure btnStornoClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormat: TfrmFormat;

implementation

{$R *.dfm}

procedure TfrmFormat.btnOKClick(Sender: TObject);
begin
frmFormat.ModalResult:=mrOK;
end;

procedure TfrmFormat.btnStornoClick(Sender: TObject);
begin
frmFormat.ModalResult:=mrCancel;
end;

procedure TfrmFormat.FormCreate(Sender: TObject);
begin
lsbFormat.ItemIndex:=0;
end;

end.
