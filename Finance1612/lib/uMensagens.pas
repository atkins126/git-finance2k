unit uMensagens;

interface

function msgErroGravar(): String;
function msgErroAbrir(): String;
function msgEmDesenvolvimento(): String;
function msgConsultaVazia(): String;
function msgExitApplication(): String;
function msgErroLicencaFinance(): String;
function msgErroRegistro(): String;
Function msgErroConversaoValor() :String;
Function msgErroOrganizacaoNula() :String;
Function msgErroNotServer() :String;
Function msgSucesso() :String;
Function msgErroIPServerBD():String;
Function msgErroUsuario():String;


implementation



   function msgErroUsuario(): String;
begin
  Result := 'O Usu�rio ou Senha digitados n�o foram validados.' + #13 + 'Verifique os dados digitados.';
end;

  function msgErroIPServerBD(): String;
begin
  Result := 'O IP do servidor n�o encontrado. Entre em contato com o Suporte.';
end;

  function msgErroNotServer(): String;
begin
  Result := 'Servidor n�o localizado. Entre em contato com o Suporte.';
end;

  function msgSucesso(): String;
begin
  Result := 'Opera��o conclu�da com sucesso.';
end;
 function msgErroOrganizacaoNula(): String;
begin
  Result := 'Ocorreu um erro ao tentar atribuir organiza��o. Entre em contato com o Suporte.';
end;

function msgErroConversaoValor(): String;
begin
  Result := 'Ocorreu um erro ao tentar converter um valor. Entre em contato com o Suporte.';
end;
function msgErroRegistro(): String;
begin
  Result := 'Ocorreu um erro ao registro do sistema. Entre em contato com o Suporte.';
end;

function msgErroGravar(): String;
begin
  Result := 'Ocorreu um erro ao tentar gravar o registro.';
end;

function msgErroAbrir(): String;
begin
  Result := 'Ocorreu um erro ao tentar abrir o registro.';
end;

function msgEmDesenvolvimento(): String;
begin
  Result := 'Rotina em desenvolvimento. Aguarde...';
end;

function msgConsultaVazia(): String;
begin
  Result := ' A consulta solicitada n�o retornou resultados.' + #13 +
    ' Verifique os dados informados.';
end;

function msgExitApplication(): String;
begin
  Result := #13 + ' A Aplica��o ser� encerrada. Obrigado!.';
end;

function msgErroLicencaFinance(): String;
begin
  Result := 'N�o foi poss�vel validar a licen�a. ';
end;

end.
