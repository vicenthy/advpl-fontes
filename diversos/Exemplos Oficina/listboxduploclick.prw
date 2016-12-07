///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | ListBoxDuploClick.prw| AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_ListBoxDup()                                         |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao que demonstra a utilizacao de listbox com metodo duplo   |//
//|           | click                                                           |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////

#INCLUDE "PROTHEUS.CH"

User Function ListBoxDup()

Local oDlg     := Nil
Local cTitulo  := "Consulta Bancos"

Private oLbx     := Nil 
Private aVetor   := {}

dbSelectArea("SA6")
dbSetOrder(1)
dbSeek(xFilial("SA6"))

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
While !Eof() .And. A6_FILIAL == xFilial("SA6")	
   aAdd( aVetor, { A6_COD, A6_AGENCIA, A6_NUMCON, A6_NOME, A6_NREDUZ, A6_BAIRRO, A6_MUN, A6_FILIAL } )
	dbSkip()
End

If Len( aVetor ) == 0
   Aviso( cTitulo, "Nao existe bancos a consultar", {"Ok"} )
   Return
Endif

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 240,500 PIXEL

@ 010,010 LISTBOX oLbx FIELDS HEADER ;
   "Banco", "Agencia", "C/C", "Raz�o Social", "Fantasia", "Bairro", "Municipio" ;
   SIZE 230,095 OF oDlg PIXEL ON DBLCLICK( u_EdList(oLbx:nAt))
                                      
oLbx:SetArray( aVetor )
oLbx:bLine := {|| {aVetor[oLbx:nAt,1],;
                   aVetor[oLbx:nAt,2],;
                   aVetor[oLbx:nAt,3],;
                   aVetor[oLbx:nAt,4],;
                   aVetor[oLbx:nAt,5],;
                   aVetor[oLbx:nAt,6],;
                   aVetor[oLbx:nAt,7]}}

@ 110,10 SAY "D� duplo click" SIZE 60,007 PIXEL OF oDlg
	                    
DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTER

Return

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | ListBoxItems.prw     | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - EdList()                                               |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
User Function EdList( nPos )
Local cKey := ""
Private cCadastro := "Altera Banco"
Private lRefresh := .T.
Private Inclui := .F.
Private Altera := .T.
Private aRotina := {}

aAdd( aRotina, {"","",0,1} )
aAdd( aRotina, {"","",0,2} )
aAdd( aRotina, {"","",0,3} )
aAdd( aRotina, {"","",0,4} )
aAdd( aRotina, {"","",0,5} )

cKey := aVetor[nPos,8]+aVetor[nPos,1]+aVetor[nPos,2]+aVetor[nPos,3]

dbSelectArea("SA6")
dbSetOrder(1)
dbSeek(cKey)

AxAltera("SA6",RecNo(),4)

aVetor[nPos][1] := SA6->A6_COD
aVetor[nPos][2] := SA6->A6_AGENCIA
aVetor[nPos][3] := SA6->A6_NUMCON
aVetor[nPos][4] := SA6->A6_NOME
aVetor[nPos][5] := SA6->A6_NREDUZ
aVetor[nPos][6] := SA6->A6_BAIRRO
aVetor[nPos][7] := SA6->A6_MUN

oLbx:Refresh()

Return