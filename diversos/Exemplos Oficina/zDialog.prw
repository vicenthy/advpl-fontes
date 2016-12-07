#include 'protheus.ch'
#include 'topconn.ch'
#include 'tbiconn.ch'

User Function zDialog()
Local oDlg, oButton, oButton2
Private cNOME := Space(40)
Private cTEL  := Space(10)

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

DEFINE MSDIALOG oDlg FROM 0,0 TO 110, 500 PIXEL TITLE "Titulo da Janela"
@ 010, 010 SAY "Nome:" SIZE 55, 08 OF oDlg PIXEL
@ 010, 45 MSGET cNOME SIZE 100, 08 PIXEL PICTURE "@!" VALID !Vazio()

@ 025, 010 SAY "Telefone:" SIZE 55, 08 OF oDlg PIXEL
@ 025, 45 MSGET cTEL SIZE 55, 08 PIXEL PICTURE "@E (99) 9999-9999" VALID !Vazio()

@ 040, 45 BUTTON oButton PROMPT "Sair" SIZE 40, 08 OF oDlg PIXEL ACTION oDlg:End()
@ 040, 90 BUTTON oButton2 PROMPT "Confirmar" SIZE 40, 08 OF oDlg PIXEL ACTION zCOnfir()

ACTIVATE MSDIALOG oDlg CENTERED
return 

Static function zCOnfir()
MsgInfo("Confimado!!!")
return