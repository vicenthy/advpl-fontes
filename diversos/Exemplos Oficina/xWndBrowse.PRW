/*
nLin1     = N�o obrigat�rio
nCol1     = N�o obrigat�rio
nLin2     = N�o obrigat�rio
nCol2     = N�o obrigat�rio
cTitle    = T�tulo obrigat�rio
uAlias    = Alias da tabela corrente podendo ser TRB
aCampos   = Se lDic=.T. utilizar� o SX3, do contr�rio o aCampos informado -> aAdd(aCampo,{X3_CAMPO,X3_PICTURE,X3_TITULO,X3_TAMANHO})
aRotina   = Id�ntico ao aRotina para mBrowse
cFun      = Fun��o que dever� retornar um valor l�gico e com isso ser� atribu�do semaf�ro na primeira coluna do browse
cTopFun   = Mostrar os registros com a chave de
cBotFun   = Mostrar os registros com a chave ate
lCentered = Valor verdadeiro centraliza
aResource = aAdd(aResource,{"IMAGEM","Texto significativo"})
nModelo   = Se 1 menu do aRotina, se 2 meno do aRotina
aPesqui   = aAdd(aPesqui{"T�tulo",nOrdem}), se n�o passado ser� utilizado o AxPesqui
cSeek     = Chave principal para a busca, exemplo: xFilial("???")
lDic      = Par�metro em conjunto com aCampos
lSavOrd   = Estabelecer a ordem ap�s pesquisas.
*/

User Function xWndBrowse()
Local cAlias := "SA6"
Local cTitulo := "Cadastro de Bancos"
Local aRotina := {}
Local cTopFun := "xFilial('SA6')"
Local cBotFun := cTopFun
Local nMod := 2
Local cSeek := cTopFun
Local lDic := .T.
Local lSavOrd := .T.
Private cCadastro := " "

aAdd(aRotina,{"Visualizar","AxVisual",0,2})
aAdd(aRotina,{"Incluir"   ,"AxInclui",0,3})
aAdd(aRotina,{"Alterar"   ,"AxAltera",0,4})

MaWndBrowse(,,,,cTitulo,cAlias,,aRotina,,cTopFun,cBotFun,.T.,,nMod,,cSeek,lDic,lSavOrd)

Return