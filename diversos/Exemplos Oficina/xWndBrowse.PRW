/*
nLin1     = Não obrigatório
nCol1     = Não obrigatório
nLin2     = Não obrigatório
nCol2     = Não obrigatório
cTitle    = Título obrigatório
uAlias    = Alias da tabela corrente podendo ser TRB
aCampos   = Se lDic=.T. utilizará o SX3, do contrário o aCampos informado -> aAdd(aCampo,{X3_CAMPO,X3_PICTURE,X3_TITULO,X3_TAMANHO})
aRotina   = Idêntico ao aRotina para mBrowse
cFun      = Função que deverá retornar um valor lógico e com isso será atribuído semafóro na primeira coluna do browse
cTopFun   = Mostrar os registros com a chave de
cBotFun   = Mostrar os registros com a chave ate
lCentered = Valor verdadeiro centraliza
aResource = aAdd(aResource,{"IMAGEM","Texto significativo"})
nModelo   = Se 1 menu do aRotina, se 2 meno do aRotina
aPesqui   = aAdd(aPesqui{"Título",nOrdem}), se não passado será utilizado o AxPesqui
cSeek     = Chave principal para a busca, exemplo: xFilial("???")
lDic      = Parâmetro em conjunto com aCampos
lSavOrd   = Estabelecer a ordem após pesquisas.
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