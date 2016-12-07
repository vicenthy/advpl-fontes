///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Alertas.prw          | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_Alertas()                                            |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Demonstrar por meio do objeto MsDialog e Button os alertas      |//
//|           | disponiveis no sistema                                          |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
#Include "Protheus.Ch"

User Function Alertas()
Local oDlg := Nil

DEFINE MSDIALOG oDlg TITLE "Alertas" FROM 0,0 TO 150,190 OF oDlg PIXEL

@ 2,3 TO 74,95 LABEL "Exemplo de Alertas" OF oDlg PIXEL

@  9, 7 BUTTON "&MsgInfo"    SIZE 40,10 OF oDlg PIXEL ACTION MsgInfo("Informação","Mensagem")
@ 19, 7 BUTTON "M&sgAlert"   SIZE 40,10 OF oDlg PIXEL ACTION MsgAlert("Alerta 1","Mensagem")
@ 29, 7 BUTTON "Ms&gStop"    SIZE 40,10 OF oDlg PIXEL ACTION MsgStop("Stop","Mensagem")
@ 39, 7 BUTTON "RetryCancel" SIZE 40,10 OF oDlg PIXEL ACTION MsgRetryCancel("Título","Mensagem")
If SubStr(cVersao,1,3)=="MP8"
   @ 49, 7 BUTTON "&Help 1"     SIZE 40,10 OF oDlg PIXEL ACTION Eval({|x|Help("",1,"","HELP","Help Padrão Protheus",1,0)})
   @ 59, 7 BUTTON "H&elp 2"     SIZE 40,10 OF oDlg PIXEL ACTION Eval({|x|Help("",1,"RECNO")})
Else
   @ 49, 7 BUTTON "&Help 1"     SIZE 40,10 OF oDlg PIXEL ACTION Help("",1,"","HELP","Help Padrão Protheus",1,0)
   @ 59, 7 BUTTON "H&elp 2"     SIZE 40,10 OF oDlg PIXEL ACTION Help("",1,"RECNO")
Endif
@  9,51 BUTTON "Msg&YesNo"   SIZE 40,10 OF oDlg PIXEL ACTION MsgYesNo("Aceitar ?","Mensagem")
@ 19,51 BUTTON "Msg&NoYes"   SIZE 40,10 OF oDlg PIXEL ACTION MsgNoYes("Aceitar ?","Mensagem")
@ 29,51 BUTTON "A&viso 1"    SIZE 40,10 OF oDlg PIXEL ACTION Aviso("Titulo 1","Corpo para Mensagem",{"Ok","Cancelar"},1,"Titulo 2")
@ 39,51 BUTTON "Av&iso 2"    SIZE 40,10 OF oDlg PIXEL ACTION Aviso("Titulo 1","Corpo para Mensagem",{"Ok","Cancelar"},2,"Titulo 2")
@ 49,51 BUTTON "Avi&so 3"    SIZE 40,10 OF oDlg PIXEL ACTION Aviso("Titulo 1","Corpo para Mensagem",{"Ok","Cancelar"},3,"Titulo 2")
@ 59,51 BUTTON "Sai&r"       SIZE 40,10 OF oDlg PIXEL ACTION oDlg:End()

//MsgBox(<texto>,<titulo>,<estilo>)
//estilo -> Info,YesNo,Stop,Alert,RetryCancel

ACTIVATE MSDIALOG oDlg CENTER

Return Nil