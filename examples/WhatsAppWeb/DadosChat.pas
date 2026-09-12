unit DadosChat;

{ Modelo de dados em memória usado pelo exemplo. Os nomes em português deixam
  claro que cada sessão mantém suas próprias conversas, mensagens e rascunhos. }

interface

uses
  System.SysUtils;

const
  QuantidadeContatos = 5;
  LimiteCaracteresMensagem = 2000;

type
  // Uma mensagem contém somente o conteúdo necessário para desenhar o balão.
  TMensagemChat = record
    Texto: string;
    DataHora: TDateTime;
    EnviadaPorMim: Boolean;
  end;
  TArrayMensagensChat = array of TMensagemChat;

  // Os valores usados na demonstração também possuem tipos explícitos.
  TRecNome = record
    Valor: string;
  end;
  TArrayRecNomes = array of TRecNome;

  TRecInicial = record
    Valor: string;
  end;
  TArrayRecIniciais = array of TRecInicial;

  TRecUltimoTexto = record
    Valor: string;
  end;
  TArrayRecUltimosTextos = array of TRecUltimoTexto;

  // Cada conversa guarda seu cabeçalho, rascunho e histórico completo.
  TConversa = record
    Nome: string;
    Iniciais: string;
    Descricao: string;
    Rascunho: string;
    Mensagens: TArrayMensagensChat;
    procedure AdicionarMensagem(const Texto: string; EnviadaPorMim: Boolean; DataHora: TDateTime);
    function UltimaMensagem: string;
  end;
  TArrayConversas = array of TConversa;

// Prepara dados locais novos para cada instância do frame de conversa.
procedure CarregarConversasDemonstracao(out Conversas: TArrayConversas);

implementation

procedure TConversa.AdicionarMensagem(const Texto: string;
  EnviadaPorMim: Boolean; DataHora: TDateTime);
var
  Indice: Integer;
  TextoLimpo: string;
begin
  // Centraliza a validação para mensagens iniciais e mensagens digitadas.
  TextoLimpo := Trim(Texto);

  if TextoLimpo = '' then
    raise EArgumentException.Create('A mensagem não pode ficar vazia.');

  if Length(TextoLimpo) > LimiteCaracteresMensagem then
    raise EArgumentException.CreateFmt('Use até %d caracteres por mensagem.',
      [LimiteCaracteresMensagem]);

  Indice := Length(Mensagens);
  SetLength(Mensagens, Indice + 1);
  Mensagens[Indice].Texto := TextoLimpo;
  Mensagens[Indice].DataHora := DataHora;
  Mensagens[Indice].EnviadaPorMim := EnviadaPorMim;
end;

function TConversa.UltimaMensagem: string;
begin
  Result := '';
  if Length(Mensagens) > 0 then
    Result := Mensagens[High(Mensagens)].Texto;
end;

procedure CarregarConversasDemonstracao(out Conversas: TArrayConversas);
var
  Nomes: TArrayRecNomes;
  Iniciais: TArrayRecIniciais;
  UltimosTextos: TArrayRecUltimosTextos;
  Indice: Integer;
  HorarioInicial: TDateTime;
begin
  SetLength(Nomes, QuantidadeContatos);
  Nomes[0].Valor := 'Mariana Costa';
  Nomes[1].Valor := 'Equipe de produto';
  Nomes[2].Valor := 'Rafael Almeida';
  Nomes[3].Valor := 'Sofia Martins';
  Nomes[4].Valor := 'Família';

  SetLength(Iniciais, QuantidadeContatos);
  Iniciais[0].Valor := 'MC';
  Iniciais[1].Valor := 'EP';
  Iniciais[2].Valor := 'RA';
  Iniciais[3].Valor := 'SM';
  Iniciais[4].Valor := 'FA';

  SetLength(UltimosTextos, QuantidadeContatos);
  UltimosTextos[0].Valor := 'Combinado! Até daqui a pouco.';
  UltimosTextos[1].Valor := 'O protótipo ficou muito bom!';
  UltimosTextos[2].Valor := 'Vamos tomar um café amanhã?';
  UltimosTextos[3].Valor := 'Obrigada pelo retorno!';
  UltimosTextos[4].Valor := 'Encontro no domingo confirmado.';

  SetLength(Conversas, QuantidadeContatos);

  // Horários determinísticos tornam a prévia do exemplo fácil de conferir.
  HorarioInicial := Date + EncodeTime(10, 20, 0, 0);
  for Indice := Low(Conversas) to High(Conversas) do
  begin
    Conversas[Indice].Nome := Nomes[Indice].Valor;
    Conversas[Indice].Iniciais := Iniciais[Indice].Valor;
    Conversas[Indice].Descricao := 'conversa de demonstração';
    Conversas[Indice].Rascunho := '';
    SetLength(Conversas[Indice].Mensagens, 0);

    Conversas[Indice].AdicionarMensagem(
      'Oi! Tudo bem por aí?',
      False,
      HorarioInicial
    );

    Conversas[Indice].AdicionarMensagem(
      'Tudo ótimo! Estou organizando os detalhes para o nosso encontro.',
      True,
      HorarioInicial + 1 / 1440
    );

    Conversas[Indice].AdicionarMensagem(
      'Perfeito. Podemos conversar às 15h? Quero te mostrar algumas ideias que preparei para o projeto.',
      False,
      HorarioInicial + 2 / 1440
    );

    Conversas[Indice].AdicionarMensagem(
      'Podemos sim! Vou separar um tempo na agenda.',
      True,
      HorarioInicial + 3 / 1440
    );

    Conversas[Indice].AdicionarMensagem(
      UltimosTextos[Indice].Valor,
      False,
      HorarioInicial + 4 / 1440
    );
  end;

  // A conversa em grupo usa uma descrição específica no cabeçalho.
  Conversas[1].Descricao := 'Mariana, Rafael, Sofia e você';
end;

end.