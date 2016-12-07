#Include 'Protheus.ch'
#Include 'FWMBROWSE.ch'
#Include 'FWMVCDEF.ch'

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | FUNC003.prw    | AUTOR | Rafael Brito | DATA | 07/11/2016 		|//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - NFUNC003                                               |//
//|           | Tela para classificação referente a prioridade de atendimento   |//
//|           | OBS:Adicionar o campos customizado C5_XFLAG - tipo CARACTER - 1 |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//|          |                      |                                           |//
//|          |                      |                                           |//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////

User Function FUNC003()

	Local aCores := {}
	//Local cret :="(u_regExtIN({{'SA1','SC5'}},'C5_CLIENTE','A1_COD',{{'C5_NUM', " + '"'+"'"+'"+' + "SC5->C5_NUM" + '+"'+"'"+'"' + "}}," + '"A1_MSBLQL = ' + " '1' " + '"))'
	Local cFiltro := "C5_FILIAL =='"+ xFilial("SC5") +"'"

	Private cCadastro := "Classificação de Pedidos"
	Private aRotina := {}

	aAdd(aRotina, {"Pesquisar"   ,"AxPesqui" , 0 , 1})
	aAdd(aRotina, {"Classificar" ,"U_BClass('SC5',,2)" , 0 , 4})
	aAdd(aRotina, {"Legenda"     ,"U_BLegenda", 0 ,3})
	aAdd(aRotina, {"Filtro"      ,"U_fFilSC5" , 0 ,5})

	AADD(aCores,{"C5_XFLAG == '1' .and. C5_LIBEROK!='E'" ,'BR_PRETO'}) // Cliente Bloqueado - Rafael Brito
	AADD(aCores,{"C5_XFLAG == '2' .and. C5_LIBEROK!='E'", 'BR_PINK'})//Liberação Financeira'
	AADD(aCores,{"C5_XFLAG == '3' .and. C5_LIBEROK!='E'", 'BR_MARROM'})//Falta de Informação
	AADD(aCores,{"C5_XFLAG == '4' .and. C5_LIBEROK!='E'", 'BR_BRANCO'})//Aguardando Importação
	AADD(aCores,{"Empty(C5_LIBEROK) .And. Empty(C5_NOTA) .And. Empty(C5_BLQ)  .And. (u_regExist('SC6',{{'C6_FILIAL', " + '"'+"'"+'"+' + " xFilial('SC5') " + '+"'+"'"+'"' + "},{'C6_NUM', " + '"'+"'"+'"+' + "SC5->C5_NUM" + '+"'+"'"+'"' + "}}, " + '"C6_NOTA <> ' + " ' ' " + '"))', 'BR_CINZA'}) // Faturado Parcial S/Reserva
	AADD(aCores,{"!Empty(C5_LIBEROK) .And. Empty(C5_NOTA) .And. Empty(C5_BLQ)  .And. (u_regExist('SC6',{{'C6_FILIAL', " + '"'+"'"+'"+' + " xFilial('SC5') " + '+"'+"'"+'"' + "},{'C6_NUM', " + '"'+"'"+'"+' + "SC5->C5_NUM" + '+"'+"'"+'"' + "}}, " + '"C6_NOTA <> ' + " ' ' " + '"))', 'BR_LARANJA'}) // Faturado Parcial C/Reserva
	AADD(aCores,{"Empty(C5_LIBEROK) .And. Empty(C5_NOTA) .And. Empty(C5_BLQ)", 'ENABLE'}) // Pedido em Aberto
	AADD(aCores,{"!Empty(C5_NOTA) .Or. C5_LIBEROK=='E' .And. Empty(C5_BLQ)", 'DISABLE'}) // Pedido Encerrado
	AADD(aCores,{"!Empty(C5_LIBEROK) .And. Empty(C5_NOTA) .And. Empty(C5_BLQ)", 'BR_AMARELO'}) // Pedido Liberado
	AADD(aCores,{"C5_BLQ == '1'", 'BR_AZUL'}) // Pedido Bloquedo por regra
	AADD(aCores,{"C5_BLQ == '2'", 'BR_LARANJA'}) // Pedido Bloquedo por verba

	DbSelectArea("SC5")
	DbSetOrder(1)
	//Eval(bFiltraBrw)

	//MBrowse(,,,,"SC5",aCpos,,,,aCores)

	DbSelectArea("SC5")
	DbGoTop()
	MBrowse(6,1,22,75,"SC5",,,,,,aCores)

	//EndFilBrw("SC5",aIndexSC5)

Return(Nil)




//==============================================================================
//Criação de Filtro
//==============================================================================
User Function fFilSC5()
	Static cFiltroRet := ""

	Private aIndexSC5 := {}
	Private bFiltraBrw := { || FilBrowse("SC5",@aIndexSC5,@cFiltro)}

	cFiltroRet := BuildExpr("SC5",,cFiltroRet)

	EndFilBrw("SC5",aIndexSC5)
	aIndexSC7 := {}
	bFiltraBrw := {|| FilBrowse("SC5",@aIndexSC5,@cFiltroRet) }
	Eval(bFiltraBrw)
	dbGoTop()

Return Nil

//==============================================================================
//Criação de Legendas
//==============================================================================
User Function BLegenda()

	Local aLegenda := {}

	aAdd(aLegenda,{'ENABLE'     , 'Pedido em Aberto'})
	aAdd(aLegenda,{'DISABLE'    , 'Pedido Encerrado'})
	aAdd(aLegenda,{'BR_AMARELO' , 'Pedido Liberado'})
	aAdd(aLegenda,{'BR_PRETO'   , 'Cliente Bloqueado'})// Alterado - Rafael Brito
	aAdd(aLegenda,{'BR_PINK'    , 'Laboratório'})// Alterado - Rafael Brito
	aAdd(aLegenda,{'BR_MARROM'  , 'Falta de Informação'})// Alterado - Rafael Brito
	aAdd(aLegenda,{'BR_BRANCO'  , 'Aguardando Importação'})// Alterado - Rafael Brito
	aAdd(aLegenda,{'BR_AZUL'    , 'Pedido Bloquedo por Regra'})
	aAdd(aLegenda,{'BR_CINZA'   , 'Faturado Parcial S/Reserva'})
	aAdd(aLegenda,{'BR_LARANJA' , 'Faturado Parcial C/Reserva'})

	BrwLegenda(cCadastro,"Legenda", aLegenda)

Return Nil
//================================================================================
// Criação do Grid - Gerando apenas a visualização do pedido.
//================================================================================
User Function BClass(cAlias,nReg,nOpc)

	Local nX := 0
	Local nUsado := 0
	Local aButtons := {}
	Local aCpoEnch := {}
	Local cAliasE := cAlias
	Local aAlterEnch := {}
	Local aPos := {000,000,080,400}
	Local nModelo := 3
	Local lF3 := .F.
	Local lMemoria := .T.
	Local lColumn := .F.
	Local caTela := ""
	Local lNoFolder := .F.
	Local lProperty := .F.
	Local aCpoGDa := {}
	Local cAliasGD := "SC6"
	Local nSuperior := 081
	Local nEsquerda := 000
	Local nInferior := 250
	Local nDireita := 400
	Local cLinOk := "AllwaysTrue"
	Local cTudoOk := "AllwaysTrue"
	Local cIniCpos := "C6_ITEM"
	Local nFreeze := 000
	Local nMax := 999
	Local cFieldOk := "AllwaysTrue"
	Local cSuperDel := ""
	Local cDelOk := "AllwaysFalse"
	Local aHeader := {}
	Local aCols := {}
	Local aAlterGDa := {}
	Private oDlg
	Private oGetD
	Private oEnch
	Private aTELA[0][0]
	Private aGETS[0]

	DbSelectArea("SX3")
	DbSetOrder(1)
	DbSeek(cAliasE)

	While !Eof() .And. SX3->X3_ARQUIVO == cAliasE
		If !(SX3->X3_CAMPO $ "C5_FILIAL") .And. cNivel >= SX3->X3_NIVEL .And.;
		X3Uso(SX3->X3_USADO)
			AADD(aCpoEnch,SX3->X3_CAMPO)
		EndIf
		DbSkip()
	End
	aAlterEnch := aClone(aCpoEnch)

	DbSelectArea("SX3")
	DbSetOrder(1)
	MsSeek(cAliasGD)

	While !Eof() .And. SX3->X3_ARQUIVO == cAliasGD
		If !(AllTrim(SX3->X3_CAMPO) $ "C6_FILIAL") .And.;
		cNivel >= SX3->X3_NIVEL .And. X3Uso(SX3->X3_USADO)
			AADD(aCpoGDa,SX3->X3_CAMPO)
		EndIf
		DbSkip()
	End

	aAlterGDa := aClone(aCpoGDa)
	nUsado:=0

	dbSelectArea("SX3")
	dbSeek("SC6")
	aHeader:={}

	While !Eof().And.(x3_arquivo=="SC6")
		If X3USO(x3_usado).And.cNivel>=x3_nivel
			nUsado:=nUsado+1
			AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,x3_tamanho,;
			x3_decimal,"AllwaysTrue()",x3_usado, x3_tipo, x3_arquivo, x3_context } )
		Endif
		dbSkip()
	End

	If nOpc==3 // Incluir
		aCols:={Array(nUsado+1)}
		aCols[1,nUsado+1]:=.F.
		For nX:=1 to nUsado
			IF aHeader[nX,2] == "C6_ITEM"
				aCols[1,nX]:= "0001"
			ELSE
				aCols[1,nX]:=CriaVar(aHeader[nX,2])
			ENDIF
		Next
	Else
		aCols:={}
		dbSelectArea("SC6")
		dbSetOrder(1)

		dbSeek(xFilial()+SC5->C5_NUM)
		While !eof().and.C6_NUM==SC5->C5_NUM
			AADD(aCols,Array(nUsado+1))
			For nX:=1 to nUsado
				aCols[Len(aCols),nX]:=FieldGet(FieldPos(aHeader[nX,2]))
			Next
			aCols[Len(aCols),nUsado+1]:=.F.
			dbSkip()
		End
	Endif

	oDlg := MSDIALOG():New(000,000,500,800, cCadastro,,,,,,,,,.T.)
	RegToMemory("SC5", If(nOpc==3,.T.,.F.))

	oEnch := MsMGet():New(cAliasE,nReg,nOpc,/*aCRA*/,/*cLetra*/,/*cTexto*/,;
	aCpoEnch,aPos,aAlterEnch, nModelo, /*nColMens*/, /*cMensagem*/,;
	/*cTudoOk*/, oDlg,lF3, lMemoria,lColumn,caTela,lNoFolder,;
	lProperty)

	oGetD:= MsNewGetDados():New(nSuperior, nEsquerda, nInferior, nDireita,;
	nOpc,cLinOk,cTudoOk, cIniCpos, aAlterGDa, nFreeze, nMax,cFieldOk,;
	cSuperDel,cDelOk, oDLG, aHeader, aCols)

	oDlg:bInit := {|| EnchoiceBar(oDlg, {|| U_OpSist(),oDlg:End()},{||oDlg:End()},,)}
	oDlg:lCentered := .T.
	oDlg:Activate()

Return







User Function regExist(cParam1, aParam2)

return 



//================================================================================================
//Atribuição do Status  - legenda
//================================================================================================
User Function OpSist()

	Local oRadMenu1
	Local nRadMenu1 := 1
	Local oButton1
	Local oDlg
	Local cFlag :=""
	Local aCab :={}

	DEFINE MSDIALOG oDlg TITLE "Escolha" FROM 000,000 TO 200,200 PIXEL
	@ 015, 020 RADIO oRadMenu1 VAR nRadMenu1 ITEMS "Laboratório","Falta de Informação","Aguardando Importação" SIZE 072,072 OF oDlg PIXEL
	@ 053, 030 BUTTON oButton1 PROMPT "Confirma" SIZE 037, 012 OF oDlg ACTION(oDlg:end()) PIXEL
	@ 072, 030 BUTTON oButton2 PROMPT "Cancelar" SIZE 037, 012 OF oDlg ACTION(nRadMenu1:=0,oDlg:end()) PIXEL
	ACTIVATE MSDIALOG oDlg CENTERED

	If nRadMenu1 == 1
		cFlag := "2"
	ElseIf nRadMenu1 == 2
		cFlag := "3"
	ElseIf nRadMenu1 == 3
		cFlag := "4"
	EndIf

	DbSelectArea("SC5")
	DbSetOrder(1)
	DbSeek(xFilial("SC5")+SC5->C5_NUM)

	If Found()
		RecLock("SC5", .F.)
		SC5->C5_XFLAG := cFlag
		MsUnLock() //Confirma e finaliza a operação
	EndIf
	MsgInfo('Pedido Classificado.')

Return
