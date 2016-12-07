
#INCLUDE "PROTHEUS.CH"

USER FUNCTION LeArqTxt()
Private nOpc      := 0
Private cCadastro := "Importação de dados."
Private aSay      := {}
Private aButton   := {}

aAdd( aSay, "Esta rotina irá ler um arquivo texto e gravar a quantidade a contratar na ata de registro de preço em questão" )

aAdd( aButton, { 1,.T.,{|| nOpc := 1,FechaBatch()}})
aAdd( aButton, { 2,.T.,{|| FechaBatch() }} )

FormBatch( cCadastro, aSay, aButton )

If nOpc == 1
	Processa( {|| Import() }, "Processando..." )
Endif

Return

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Le_Arq_Txt.prw       | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - Import()                                               |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao de importacao de dados                                   |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
STATIC FUNCTION Import()
Local cBuffer   := ""
Local cNumLic := "" 
Local cNumAta := ""
Local nQtACon := ""
Local cFileOpen := ""
Local cTitulo1  := "Selecione o arquivo"
Local cExtens   := "Arquivo TXT | *.txt"

cFileOpen := cGetFile(cExtens,cTitulo1,,,.T.)

If !File(cFileOpen)
   MsgAlert("Arquivo texto: "+cFileOpen+" não localizado",cCadastro)
   Return
Endif

dbSelectArea("ZY6")
dbSetOrder(1)

FT_FUSE(cFileOpen)  //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua(FT_FLASTREC()) //QTOS REGISTROS LER

While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
   IncProc()

   // Capturar dados
   cBuffer := FT_FREADLN() //LENDO LINHA 
   
   cNumLic := SubStr(cBuffer,1,15)
   cNumAta := SubStr(cBuffer,16,15)
   cProd   := SubStr(cBuffer,31,15)
   nQtACon := Val(SubStr(cBuffer,46,12))
   
   ZY6->(dbSeek(xFilial("ZY6")+cNumLic+cNumAta))
   
   While !Eof() .And. ZY6->ZY6_FILIAL+ZY6->ZY6_NUMLIC+ZY6->ZY6_NUMATA == xFilial("ZY6")+cNumLic+cNumAta
      If ZY6->ZY6_PRODUT <> cProd
         dbSkip()
         Loop
      Endif
      
      If nQtACon > (ZY6->ZY6_QTLICI-ZY6->ZY6_QTCONT)
         AutoGrLog("Produto: "+ZY6->ZY6_PRODUT+" Item: "+ZY6->ZY6_ITEM+" está com a quantidade maior")
      Else
         ZY6->(RecLock("ZY6",.F.))
         ZY6->ZY6_QTACON := Val(nQtACon)
         ZY6->(MsUnLock())
      Endif
      
      Exit
      
   End
   
   FT_FSKIP()   //proximo registro no arquivo txt
EndDo

FT_FUSE() //fecha o arquivo txt

MsgInfo("Processo finalizada")

Return