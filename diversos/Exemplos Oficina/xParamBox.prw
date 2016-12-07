///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | xParambox            | AUTOR | Robson Luiz  | DATA | 19/02/2005 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_xParambox()                                          |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Demonstrar outra maneira de disponibilizar par�metros para o    |//
//|           | usu�rio                                                         |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////

User Function xParamBox()

Local aRet := {}
Local aParamBox := {}
Local aCombo := {"Janeiro","Fevereiro","Mar�o","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"}
Local i	:= 0
Private cCadastro := "xParambox"

// Abaixo est� a montagem do vetor que ser� passado para a fun��o
// --------------------------------------------------------------

aAdd(aParamBox,{1,"Produto",Space(15),"","","SB1","",0,.F.})
// Tipo 1 -> MsGet()
//           [2]-Descricao
//           [3]-String contendo o inicializador do campo
//           [4]-String contendo a Picture do campo
//           [5]-String contendo a validacao
//           [6]-Consulta F3
//           [7]-String contendo a validacao When
//           [8]-Tamanho do MsGet
//           [9]-Flag .T./.F. Parametro Obrigatorio ?

aAdd(aParamBox,{2,"Tipo de cliente",1,aCombo,50,"",.F.})
// Tipo 2 -> Combo
//           [2]-Descricao
//           [3]-Numerico contendo a opcao inicial do combo
//           [4]-Array contendo as opcoes do Combo
//           [5]-Tamanho do Combo
//           [6]-Validacao
//           [7]-Flag .T./.F. Parametro Obrigatorio ?

aAdd(aParamBox,{3,"Mostra deletados",Iif(Set(_SET_DELETED),1,2),{"Sim","N�o"},50,"",.F.})
// Tipo 3 -> Radio
//           [2]-Descricao
//           [3]-Numerico contendo a opcao inicial do Radio
//           [4]-Array contendo as opcoes do Radio
//           [5]-Tamanho do Radio
//           [6]-Validacao
//           [7]-Flag .T./.F. Parametro Obrigatorio ?

aAdd(aParamBox,{4,"Marca todos ?",.F.,"Marque todos se necess�rio for.",50,"",.F.})
// Tipo 4 -> CheckBox ( Com Say )
//           [2]-Descricao
//           [3]-Indicador Logico contendo o inicial do Check
//           [4]-Texto do CheckBox
//           [5]-Tamanho do Radio
//           [6]-Validacao
//           [7]-Flag .T./.F. Parametro Obrigatorio ?

aAdd(aParamBox,{5,"Marca todos ?",.F.,50,"",.F.})
// Tipo 5 -> CheckBox ( linha inteira )
//           [2]-Descricao
//           [3]-Indicador Logico contendo o inicial do Check
//           [4]-Tamanho do Radio
//           [5]-Validacao
//           [6]-Flag .T./.F. Parametro Obrigatorio ?

aAdd(aParamBox,{6,"Qual arquivo",Space(50),"","","",50,.F.,"Arquivo .DBF |*.DBF"})
// Tipo 6 -> File
//           [2]-Descricao
//           [3]-String contendo o inicializador do campo
//           [4]-String contendo a Picture do campo
//           [5]-String contendo a validacao
//           [6]-String contendo a validacao When
//           [7]-Tamanho do MsGet
//           [8]-Flag .T./.F. Parametro Obrigatorio ?
//           [9]-Texto contendo os tipos de arquivo, exemplo: "Arquivos .CSV |*.CSV"
//           [10]-Diretorio inicial do cGetFile

aAdd(aParamBox,{7,"Monte o filtro","SX5","X5_FILIAL==xFilial('SX5')"})
// Tipo 7 -> Montagem de expressao de filtro
//           [2]-Descricao
//           [3]-Alias da tabela
//           [4]-Filtro inicial

aAdd(aParamBox,{8,"Digite a senha",Space(15),"","","","",80,.F.})
// Tipo 8 -> MsGet Password
//           [2]-Descricao
//           [3]-String contendo o inicializador do campo
//           [4]-String contendo a Picture do campo
//           [5]-String contendo a validacao
//           [6]-Consulta F3
//           [7]-String contendo a validacao When
//           [8]-Tamanho do MsGet
//           [9]-Flag .T./.F. Parametro Obrigatorio ?

// Parametros da fun��o Parambox()
// -------------------------------
// 1- Vetor com as configura��es
// 2- T�tulo da janela
// 3- Vetor passador por referencia que cont�m o retorno dos par�metros
// 4- Code block para validar o bot�o Ok
// 5- Vetor com mais bot�es al�m dos bot�es de Ok e Cancel
// 6- Centralizar a janela
// 7- Se n�o centralizar janela coordenada X para in�cio
// 8- Se n�o centralizar janela coordenada Y para in�cio
// 9- Utiliza o objeto da janela ativa
//10- Nome do perfil se caso for carregar
//11- Salvar os dados informados por perfil

If ParamBox(aParamBox,"Teste Par�metros...",@aRet)
   For i:=1 To Len(aRet)
      MsgInfo(aRet[i],"Op��o escolhida")
   Next 
Endif

Return