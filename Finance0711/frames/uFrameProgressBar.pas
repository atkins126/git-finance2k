unit uFrameProgressBar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TframePB = class(TFrame)
    pb1: TProgressBar;
    lblProgressBar: TLabel;
    lbl3: TLabel;
  private


    { Private declarations }
  public
    { Public declarations }
  //  procedure progressBar(posicao, tamMax, pLeft, pTop: Integer);
    procedure progressBar(posicao, tamMax: Integer);
  end;

implementation

{$R *.dfm}


 procedure TframePB.progressBar(posicao, tamMax: Integer);
 begin
    if tamMax=0 then tamMax :=1;

   pb1.MAX := tamMax; pb1.Min :=1;

  if (posicao = 0) then
  begin
      pb1.Position := posicao;
  end;


   pb1.Position := pb1.Position + Trunc((posicao));

  lblProgressBar.Caption := 'Progresso da  Exporta��o. Registro   ' +  IntToStr(pb1.Position) + ' de ' + IntToStr(pb1.Position) ;
end;



end.