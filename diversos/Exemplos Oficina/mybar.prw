///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  |                      | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_MyBar()                                              |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Neste programa eh demonstrada como montar uma enchoicebar, sem  |//
//|           | a utilizacao do padrao.                                         |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////

#INCLUDE "PROTHEUS.CH"

USER FUNCTION MyBar()
LOCAL oDlg
DEFINE MSDIALOG oDlg TITLE "My EnchoiceBar" FROM 122,0 TO 432,600 OF oDlg PIXEL STYLE DS_MODALFRAME STATUS
ACTIVATE MSDIALOG oDlg CENTER ON INIT MyEnchoBar(oDlg,{||Iif(MsgYesNo("Deseja sair ?","Confirma��o"),oDlg:End(),.F.)})
RETURN

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | MyBar.prw            | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - MyEnchoBar(<objeto>,<bloco de instrucoes>)             |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Esta funcao mostra como montar uma enchoicebar e como acionar   |//
//|           | outras funcoes ao ser clicada.                                  |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
STATIC FUNCTION MyEnchoBar(oObj,bObj)
LOCAL oBar, lOk, lVolta, lLoop, oBtnPsq, oBtnUsr, oBtnImp, oBtnOk, oBtnHlp
DEFINE BUTTONBAR oBar SIZE 25,25 3D TOP OF oObj
If SubStr(cVersao,1,3)<>"MP8"
   DEFINE BUTTON oBtnHlp RESOURCE "S4WB016N"  OF oBar ACTION MsgInfo("Primeiro bot�o",FunName()) TOOLTIP "Help do programa..."
   DEFINE BUTTON oBtnPsq RESOURCE "LOCALIZA"  OF oBar ACTION MsgInfo("Segundo bot�o",FunName())  TOOLTIP "Localizar..."
   DEFINE BUTTON oBtnUsr RESOURCE "USER"      OF oBar ACTION MsgInfo("Terceiro bot�o",FunName()) TOOLTIP "Listar todos..."
   DEFINE BUTTON oBtnImp RESOURCE "IMPRESSAO" OF oBar ACTION MsgInfo("Quarto bot�o",FunName())   TOOLTIP "Imprimir Doc..."
   DEFINE BUTTON oBtnNp  RESOURCE "PRINT02"   OF oBar ACTION MsgInfo("Quinto bot�o",FunName())   TOOLTIP "Imprimir NF..."
   DEFINE BUTTON oBtOk   RESOURCE "OK"        OF oBar ACTION (lLoop:=lVolta,lOk:=Eval(bObj)) TOOLTIP "Sair - <Alt+F4>"
Else
   DEFINE BUTTON oBtnHlp RESOURCE "S4WB016N"  OF oBar ACTION MsgInfo("Primeiro bot�o",FunName()) TOOLTIP "Help"
   DEFINE BUTTON oBtnPsq RESOURCE "LOCALIZA"  OF oBar ACTION MsgInfo("Segundo bot�o",FunName())  TOOLTIP "Localizar"
   DEFINE BUTTON oBtnUsr RESOURCE "USER"      OF oBar ACTION MsgInfo("Terceiro bot�o",FunName()) TOOLTIP "Listar"
   DEFINE BUTTON oBtnImp RESOURCE "IMPRESSAO" OF oBar ACTION MsgInfo("Quarto bot�o",FunName())   TOOLTIP "Impr.Doc"
   DEFINE BUTTON oBtnNp  RESOURCE "PRINT02"   OF oBar ACTION MsgInfo("Quinto bot�o",FunName())   TOOLTIP "Impr.NF"
   DEFINE BUTTON oBtOk   RESOURCE "OK"        OF oBar ACTION (lLoop:=lVolta,lOk:=Eval(bObj)) TOOLTIP "Sair"
Endif
oBar:bRClicked:={||AllwaysTrue()}
RETURN NIL