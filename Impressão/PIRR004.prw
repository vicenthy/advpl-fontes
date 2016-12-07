#include "protheus.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#INCLUDE "FWPrintSetup.ch"
#Include "RPTDEF.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "COLORS.CH"
#Include "TOTVS.CH"

//////////////////////////////////////////////////////////////////////////////////////////////////////
// Programa:  PIRR004.PRW                                  								  			//
// Descricao: Relatório simples de produto usando FWMSPRINTER   									//
// Autor:     Jader Berto												           					//
// Data:      03/12/2016																			//
// Autor Alteração: Atila Augusto																	//	
// Data Última Alteração:07/12/2016									                                //
//////////////////////////////////////////////////////////////////////////////////////////////////////


User Function PIRR004()

// declaracao de variaveis
	Local 	aRegs   := {}
	Local 	_xPar01 := ""
	Local 	aArea   := {}
	Local		 _cQry
	Private 	cPerg   := "PIRR004"
	Public 	cFileLogo		:= GetSrvProfString('Startpath','') + 'lgrl01' + '.BMP'
	Public	oBrush		:= TBrush():New(,4)
	Public	oFont07		:= TFont():New('Courier New',07,07,,.F.,,,,.T.,.F.)
	Public	oFont08		:= TFont():New('Courier New',08,08,,.F.,,,,.T.,.F.)
	Public	oFont09		:= TFont():New('Tahoma',09,09,,.F.,,,,.T.,.F.)
	Public	oFont10		:= TFont():New('Tahoma',10,10,,.F.,,,,.T.,.F.)
	Public	oFont10n	:= TFont():New('Courier New',10,10,,.T.,,,,.T.,.F.)
	Public	oFont11		:= TFont():New('Tahoma',11,11,,.F.,,,,.T.,.F.)
	Public	oFont11n	:= TFont():New('Courier New',11,11,,.T.,,,,.T.,.F.)
	Public	oFont12		:= TFont():New('Tahoma',12,12,,.F.,,,,.T.,.F.)
	Public	oFont12n	:= TFont():New('Tahoma',12,12,,.T.,,,,.T.,.F.)
	Public	oFont13		:= TFont():New('Tahoma',13,13,,.T.,,,,.T.,.F.)
	Public	oFont14		:= TFont():New('Tahoma',14,14,,.T.,,,,.T.,.F.)
	Public	oFont15		:= TFont():New('Courier New',15,15,,.T.,,,,.T.,.F.)
	Public	oFont18		:= TFont():New('Arial',18,18,,.T.,,,,.T.,.F.)
	Public	oFont16		:= TFont():New('Arial',16,16,,.T.,,,,.T.,.F.)
	Public	oFont20		:= TFont():New('Arial',20,20,,.F.,,,,.T.,.F.)
	Public	oFont22		:= TFont():New('Arial',22,22,,.T.,,,,.T.,.F.)




	_xPar01 := ""

	aArea := GetArea()

	LjMsgRun("Gerando Relatório de Produtos, aguarde...","Aguarde "  ,{|| Produtos()})

	RestArea(aArea)



Return

Static Function Produtos()
	Local nTotal := 0
	Local nTotDif:= 0
	Local nIBox
	Local cNota := ""
	Local nPrcCus := 0

	Local aAliq   := u_GtIcmPad()
	Local nAliq   := 0

	Private nLin := 640
	Private cPathPDF := "C:\Relatorios\"
	Private lAdjustToLegacy := .T.
	Private lDisableSetup   := .T.
	Private cArquivo 	:= "Relatorio_"+Replace(Time(),":","")
	Private oPrint		:= FWMSPrinter():New(cArquivo, 6, lAdjustToLegacy, cPathPDF, lDisableSetup)

	MONTADIR("C:\Relatorios")

	oPrint:SetPortrait()
	oPrint:SetPaperSize(9)
	oPrint:SetDevice(6)
	oPrint:SetViewPDF(.T.)
	oPrint:cPathPDF		:= cPathPDF
	oPrint:lPDFasPNG		:= .F.


	
// posiciona na primeira OS


	GravaPerg(cPerg)
	
	If !Pergunte (cPerg,.T.)
		Return
	Endif


	_cQry := "SELECT "
	_cQry += "   SD2.D2_TOTAL, SC6.C6_FILIAL,  SC6.C6_DATFAT,  SC6.C6_NUM,SC6.C6_NOTA, SC6.C6_ITEM, SC6.C6_PRODUTO, SC6.C6_DESCRI,  "
	_cQry += "   SC6.C6_UM, SC6.C6_PRCVEN, SC6.C6_QTDVEN, SC6.C6_PRUNIT, SC6.C6_LOCAL, SC6.C6_CF, C5_CLIENTE, C5_LOJACLI "
	_cQry += "   FROM " + RetSqlName("SB1") + " SB1 "
	_cQry += "   INNER JOIN " + RetSqlName("SC6") + " SC6 ON(SC6.C6_PRODUTO=SB1.B1_COD) "
	_cQry += "   INNER JOIN " + RetSqlName("SC5") + " SC5 ON (SC6.C6_FILIAL = SC5.C5_FILIAL AND SC6.C6_NUM = SC5.C5_NUM) "
	_cQry += "   INNER JOIN " + RetSqlName("SD2") + " SD2 ON SD2.D2_FILIAL = SC6.C6_FILIAL AND SD2.D2_SERIE = SC6.C6_SERIE AND SD2.D2_DOC = SC6.C6_NOTA  AND SD2.D2_ITEMPV = SC6.C6_ITEM AND SD2.D2_CLIENTE = SC6.C6_CLI AND SD2.D2_LOJA = SC6.C6_LOJA "
	_cQry += "   WHERE SC6.D_E_L_E_T_='' "
	_cQry += "   AND SC5.C5_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "
	_cQry += "   AND SB1.B1_GRUPO   BETWEEN '"+MV_PAR03+"'  	  AND '"+MV_PAR04+"' "
	_cQry += "   AND SC6.C6_PRODUTO BETWEEN '"+MV_PAR05+"'  	 AND '"+MV_PAR06+"' "
	_cQry += "   ORDER BY SC6.C6_NOTA, SC6.C6_ITEM "

	MemoWrite("C:\temp\Query_Custo_Medio.txt",_cQry)
	
	TCQUERY _cQry NEW ALIAS "TCON"

// inicia impressao

	nIBox := nLin
	oPrint:StartPage()
	While !TCON->(EOF())

		If Empty(cNota)
			fCabecOS(.F.)
		EndIf
	
		If nLin >= 2700
			oPrint:Line(nLin,0100,nIBox,0100)
			oPrint:Line(nLin,2320,nIBox,2320)
			oPrint:Line(nIBox,0100,nIBox,2320)
			oPrint:Say(3000,0100,"* * *    C O N T I N U A   N  A   P R Ó X I M A   P Á G I N A  * * *",oFont12)
			oPrint:EndPage()
			oPrint:StartPage()
			nLin := 640
			nIBox := nLin
			fCabecOS(.T.)
		Endif
	
		nPrcCus := Round(u_fPrcVen(TCON->C6_PRODUTO, TCON->C6_LOCAL, TCON->C6_CF, TCON->C5_CLIENTE, TCON->C5_LOJACLI, TCON->C6_DATFAT),2) * TCON->C6_QTDVEN
	
		nTOTAL_DIF := TCON->D2_TOTAL - nPrcCus
		
		If nTotal_Dif <= 0
			TCON->(DbSkip())
			Loop
		EndIf
		
		// Verifica se o cliente escolhido está na lista de clientes do parâmetro MV_XSA1SM0
		nPos  := ascan(aAliq,{ |x| x[1] == TCON->C5_CLIENTE .and. x[2] == TCON->C5_LOJACLI})
		if nPos > 0
			nAliq := aAliq[nPos,4]
		Else
			nAliq := 0
		EndIf
				
		If cNota <> TCON->C6_NOTA
			// dados do Relatório
			
			nLin += 45
			//oPrint:Box(nLin,0100,nIBox,2320)
			If !Empty(cNota)
				
				oPrint:Line(nLin,0510,nLin,2300)
				nLin+=25
				oPrint:Say(nLin,0510,OemToAnsi('TOTALIZADOR: '),oFont12n)
				oPrint:Say(nLin,775,STRZERO(nTotal,2),oFont12n)
				oPrint:Say(nLin,2050,Alltrim(Transform(nTotDif,"@e 9,999,999,999,999.99")),oFont12n)
				
				nLin+=15
				oPrint:Line(nLin,0510,nLin,2300)
				nLin+=20
				
				oPrint:Line(nLin,0100,nIBox,0100)
				oPrint:Line(nLin,0100,nLin,2320)
				oPrint:Line(nLin,2320,nIBox,2320)
				
				nTotal := 0
				nTotDif:= 0
			EndIf
			nLin+=10
			oPrint:Line(nLin,0100,nLin,2320)
			nIBox := nLin
			
			nLin += 45
			
			oPrint:Say(nLin,0125,OemToAnsi('Nota: '),oFont12n)
			oPrint:Say(nLin,0250,OemToAnsi(TCON->C6_NOTA),oFont12)
			nLin += 45
			oPrint:Say(nLin,0510,OemToAnsi('Produtos'),oFont12n)
			oPrint:Say(nLin,0895,OemToAnsi('Custo M.T'),oFont12n)
			oPrint:Say(nLin,1280,OemToAnsi('Custo M.P'),oFont12n)
			oPrint:Say(nLin,1665,OemToAnsi('Qtde'),oFont12n)
			oPrint:Say(nLin,2050,OemToAnsi('Total Dif'),oFont12n)
			
			nLin += 45
			
			oPrint:Say(nLin,0510,TCON->C6_PRODUTO,oFont12)
			oPrint:Say(nLin,0895,Alltrim(Transform(TCON->D2_TOTAL,"@e 9,999,999,999,999.99")),oFont12)
			oPrint:Say(nLin,1280,Alltrim(Transform(nPrcCus,"@e 9,999,999,999,999.99")),oFont12)
			oPrint:Say(nLin,1665,Alltrim(Str(TCON->C6_QTDVEN)),oFont12)
			oPrint:Say(nLin,2050,Alltrim(Transform(nTOTAL_DIF,"@e 9,999,999,999,999.99")),oFont12)
		Else
			nLin += 45
			
			oPrint:Say(nLin,0510,TCON->C6_PRODUTO,oFont12)
			oPrint:Say(nLin,0895,Alltrim(Transform(TCON->D2_TOTAL,"@e 9,999,999,999,999.99")),oFont12)
			oPrint:Say(nLin,1280,Alltrim(Transform(nPrcCus,"@e 9,999,999,999,999.99")),oFont12)
			oPrint:Say(nLin,1665,Alltrim(Str(TCON->C6_QTDVEN)),oFont12)
			oPrint:Say(nLin,2050,Alltrim(Transform(nTOTAL_DIF,"@e 9,999,999,999,999.99")),oFont12)
		EndIf
		
		nTotal++
		nTotDif += nTOTAL_DIF
		cNota := 	TCON->C6_NOTA
		
	

	
		TCON->(DbSkip())
	End
	nLin+=45

	oPrint:Line(nLin,0510,nLin,2300)
	nLin+=25
	oPrint:Say(nLin,0510,OemToAnsi('TOTALIZADOR: '),oFont12n)
	oPrint:Say(nLin,775,STRZERO(nTotal,2),oFont12n)
	oPrint:Say(nLin,2050,Alltrim(Transform(nTotDif,"@e 9,999,999,999,999.99")),oFont12n)

	nLin+=15
	oPrint:Line(nLin,0510,nLin,2300)
	nLin+=20

	oPrint:Line(nLin,0100,nIBox,0100)
	oPrint:Line(nLin,0100,nLin,2320)
	oPrint:Line(nLin,2320,nIBox,2320)

// finaliza pagina
	oPrint:EndPage()

	TCON->(DbCloseArea())

// verifica se existe arquivo e exclui


// exibe
	oPrint:Preview()
	FreeObj(oPrint)




Return




Static Function fCabecOS(_lContinuacao)
	Local nTamLogo := 580 // Largura -- Altura proporcional

// cabecalho
	oPrint:SayBitmap(-050,100,cFileLogo,nTamLogo,(nTamLogo)*(72.27/100))
	oPrint:Say(080,0950,AllTrim(SM0->M0_NOMECOM),oFont16)
	oPrint:Say(135,0950,AllTrim(SM0->M0_ENDCOB)+' - '+AllTrim(SM0->M0_CIDCOB)+'/'+AllTrim(SM0->M0_ESTCOB)+ '  -  ' + AllTrim(TransForm(SM0->M0_CEPCOB,'@R 99.999-999')),oFont11)
	oPrint:Say(180,0950,AllTrim(SM0->M0_TEL),oFont11)
	oPrint:Say(180,1700,AllTrim("Inscr.Municipal: " + SM0->M0_INSCM),oFont11)
	oPrint:Say(225,0950,AllTrim("www.piraque.com.br"),oFont11)
	oPrint:Say(225,1700,AllTrim("piraque@piraque.com.br"),oFont11)
	oPrint:Line(255,0950,255,2200)
	oPrint:Say(0300,0950,OemToAnsi("CNPJ: ")+TransForm(SM0->M0_CGC,'@R 99.999.999/9999-99'),oFont12)
//oPrint:Say(0300,1700,OemToAnsi("VIA: ")+_aVias[_nV],oFont12)

	oPrint:Say(0370,0100,OemToAnsi(space(35)+' Relatório de Diferença de Preço em notas de Transferência/Rem. Armazém'),oFont16)

	oPrint:Say(0410,1950,OemToAnsi("Data.: "),oFont11n)
	oPrint:Say(0410,2060,Alltrim(DTOC(Date())),oFont11)
	If _lContinuacao
		oPrint:Say(0460,0100,"* * *    C O N T I N U A Ç Ã O    * * *",oFont12)
		nLin-=90
	Else
	// dados do cliente
		oPrint:Box(0430,0100,0600,2320)
		oPrint:Say(0475,0125,OemToAnsi('Parametros Utilizados'),oFont11n)
	
		oPrint:Say(0525,0125,OemToAnsi('Emissão De:'),oFont11n)
		oPrint:Say(0525,0355,DTOC(MV_PAR01),oFont11)
		oPrint:Say(0570,0125,OemToAnsi('Emissão Até:'),oFont11n)
		oPrint:Say(0570,0355,DTOC(MV_PAR02),oFont11)
	
		oPrint:Say(0525,0825,OemToAnsi('Grupo De:'),oFont11n)
		oPrint:Say(0525,1025,MV_PAR03,oFont11)
		oPrint:Say(0570,0825,OemToAnsi('Grupo Até:'),oFont11n)
		oPrint:Say(0570,1025,MV_PAR04,oFont11)
	
		oPrint:Say(0525,1525,OemToAnsi('Produto De:'),oFont11n)
		oPrint:Say(0525,1755,MV_PAR05,oFont11)
		oPrint:Say(0570,1525,OemToAnsi('Produto Até:'),oFont11n)
		oPrint:Say(0570,1755,MV_PAR06,oFont11)
	EndIF


// atividades
//oPrint:Say(0940,0110,OemToAnsi('Atividades: ' + IIF(_lContinuacao,"   *** CONTINUAÇÃO ***","")),oFont14)

Return

Static Function GravaPerg(cPerg)


	PutSx1( cPerg   ,"01","Emissão De"	           ,"","","mv_ch1","D",8,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1( cPerg   ,"02","Emissão Até"	           ,"","","mv_ch2","D",8,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",{},{},{})

	PutSx1( cPerg   ,"03","Grupo De"	           ,"","","mv_ch3","C",TAMSX3("BM_GRUPO")[1],0,0,"G","","SBM","","","MV_PAR03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1( cPerg   ,"04","Grupo Até"	           ,"","","mv_ch4","C",TAMSX3("BM_GRUPO")[1],0,0,"G","","SBM","","","MV_PAR04","","","","","","","","","","","","","","","","",{},{},{})

	PutSx1( cPerg   ,"05","Produto De"	           ,"","","mv_ch5","C",TAMSX3("B1_COD")[1],0,0,"G","","SB1ATF","","","MV_PAR05","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1( cPerg   ,"06","Produto Até"	           ,"","","mv_ch6","C",TAMSX3("B1_COD")[1],0,0,"G","","SB1ATF","","","MV_PAR06","","","","","","","","","","","","","","","","",{},{},{})


Return