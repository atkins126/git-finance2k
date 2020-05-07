unit uFrmInfoUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, ShellApi ;

type
  TfrmInfoUpdate = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    btnFechar: TBitBtn;
    btnDown: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInfoUpdate: TfrmInfoUpdate;

implementation

{$R *.dfm}

procedure TfrmInfoUpdate.btnFecharClick(Sender: TObject);
begin
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmInfoUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := caFree; // sempre como ultimo comando
end;

end.
