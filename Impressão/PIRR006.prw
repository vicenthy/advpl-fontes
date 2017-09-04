#Include "Protheus.ch"
#Include "TopConn.Ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "FWPrintSetup.ch"

#DEFINE IMP_PDF 6
*-----------------------------------*
/*/{Protheus.doc} PIRR006


*-----------------------*
 User Function PIRR006() 
*-----------------------*
Local _aAreaAnt   	:= GetArea()
Private _cPerg 		:= "PIRR006"
Private _nLinha		:= 50
Private _nTotal		:= 00
Private oPrint 		:= Nil
Private oFont07 	:= Nil
Private oFont08		:= Nil
Private oFont09		:= Nil
Private oFont10		:= Nil
Private oFont10n	:= Nil
Private oFont11		:= Nil
Private oFont12		:= Nil
Private oFont12n	:= Nil
Private oFont13		:= Nil
Private oFont14		:= Nil
Private oFont15		:= Nil
Private oFont18		:= Nil
Private oFont16		:= Nil
Private oFont20		:= Nil
Private oFont22		:= Nil
Private oFont24		:= Nil
Private _nPage		:= 00
Private _dData    	:= SToD(" / / ")
Private oBrush1 	:= TBrush():New( , CLR_HGRAY )
Private cTipo		:= ""
Private cParDoacao  := SuperGetMv("MV_XOPDOA",, "023")
Private cParOper	:= SuperGetMv("MV_XOPVEN",, "001")
Private cParTran	:= SuperGetMv("MV_XOPTRA",, "011")


MsgRun( "Processando, gerando perguntas...", "Processando, gerando perguntas...", { || CriaPerg() } )

If Pergunte(_cPerg)
	MsgRun( "Processando, aguarde...", "Processando, aguarde...", { || fGerRel() } )
EndIf

RestArea( _aAreaAnt )
Return
//------------------------------------------------------------
//Descrição: Função responsavel pelas configurações de fontes
//------------------------------------------------------------
*---------------------------*
Static Function fGerRel()
*---------------------------*
Local lAdjustToLegacy := .F.
Local lDisableSetup   := .T.
Local oPrinter		  := Nil
Local cLocal          := "C:\"
Local aCmpArqTmp	:= {}
Local cNomeArq		:= ""	

oPrint := FWMSPrinter():New("PIRR006.pdf", IMP_PDF, lAdjustToLegacy, cLocal, lDisableSetup,,,,,, .F.,)
//oPrint:SetLandscape()
oPrint:Setup()
oFont07		:= TFont():New( 'Arial', 07,07,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New( 'Arial', 08,08,,.F.,,,,.T.,.F.)
oFont08n	:= TFont():New( 'Arial', 08,08,,.T.,,,,.T.,.F.)
oFont09		:= TFont():New( 'Arial', 09,09,,.F.,,,,.T.,.F.)
oFont09n	:= TFont():New( 'Arial', 09,09,,.T.,,,,.T.,.F.)
oFont10		:= TFont():New( 'Arial', 10,10,,.F.,,,,.T.,.F.)
oFont10n	:= TFont():New( 'Arial', 10,10,,.T.,,,,.T.,.F.)
oFont11		:= TFont():New( 'Arial', 11,11,,.F.,,,,.T.,.F.)
oFont11n	:= TFont():New( 'Arial', 11,11,,.T.,,,,.T.,.F.)
oFont12		:= TFont():New( 'Arial', 12,12,,.F.,,,,.T.,.F.)
oFont12n	:= TFont():New( 'Arial', 12,12,,.T.,,,,.T.,.F.)
oFont13		:= TFont():New( 'Arial', 13,13,,.F.,,,,.T.,.F.)
oFont13n	:= TFont():New( 'Arial', 13,13,,.T.,,,,.T.,.F.)
oFont14		:= TFont():New( 'Arial', 14,14,,.F.,,,,.T.,.F.)
oFont14n	:= TFont():New( 'Arial', 14,14,,.T.,,,,.T.,.F.)
oFont15n	:= TFont():New( 'Arial', 15,15,,.T.,,,,.T.,.F.)
oFont16n	:= TFont():New( 'Arial', 16,16,,.T.,,,,.T.,.F.)
oFont18		:= TFont():New( 'Arial', 18,18,,.T.,,,,.T.,.T.)
oFont20		:= TFont():New( 'Arial', 20,20,,.F.,,,,.T.,.F.)
oFont20n	:= TFont():New( 'Arial', 20,20,,.T.,,,,.T.,.F.)
oFont22		:= TFont():New( 'Arial', 22,22,,.T.,,,,.T.,.F.)
oFont24		:= TFont():New( 'Arial', 24,24,,.T.,,,,.T.,.F.)

MsgRun( "Imprimindo Dados..."			, "Imprimindo Dados...", {|| fGetDados() })

Return
//------------------------------------------------------------
//Descrição: Função responsavel pela impressão do cabeçalho
//------------------------------------------------------------
*---------------------------------*
 Static Function fGetCabec()
*---------------------------------*
	Local cFileLogo	:= '/PMI/piraque.png'
	Local oBrush1 := TBrush():New( , CLR_HGRAY )
	
	_nPage++      
	_nLinha := fPulaLinha()
	DbSelectArea("SM0")
	DbSeek(cEmpAnt + cFilAnt, .T.)
	
	oPrint:StartPage()
	
	oPrint:SayBitmap( 015, 010, cFileLogo ,121, 29 )
	
	oPrint:Say( 020, 0515, OemToAnsi( "Rotina: " ) + FUNNAME(),oFont10n )
	oPrint:Say( 030, 0515, OemToAnsi( "Pág: " ) + cValToChar(_nPage),oFont10n )
	oPrint:Say( 040, 0515, OemToAnsi( "Data: " ) + DToC(dDatabase),oFont10n )
	oPrint:Say( 050, 0515, OemToAnsi( "Hora: " ) + Time(),oFont10n )
	
	oPrint:Say( _nLinha, 010, OemToAnsi( "RESUMO DO CARREGAMENTO DAS CARGAS" ),oFont24 )
	oPrint:Line( _nLinha + 6, 0010,_nLinha+ 6, 0590 )
	_nLinha := fPulaLinha()
	oPrint:Say( _nLinha, 010, OemToAnsi( "FILIAL: " )+ AllTrim(SM0->M0_CODFIL) + " - " + AllTrim(SM0->M0_FILIAL) ,oFont14 )           
	_nLinha := fPulaLinha()
	//oPrint:FillRect( {_nLinha - 10, 010, _nLinha + 5, 0830}, oBrush1 )
	oPrint:Say( _nLinha, 010, OemToAnsi( "POSIÇÃO EM " ) + DToC(dDataBase) ,oFont14 )           
	
	_nLinha := fPulaLinha()
	
	oPrint:Box( _nLinha, 0010, _nLinha + 20, 0590)//PRINCIPAL
	oPrint:Say( _nLinha + 15, 0012, cTipo, oFont20n )
	
	_nLinha += 20 
	//oPrint:Box( _nLinha, 0010 , _nLinha + 30, 0070)//Emissao
	BoxColor( _nLinha, 0010 , _nLinha + 30, 0070, CLR_HGRAY)
	oPrint:Say( _nLinha + 15, 0012, "DATA", oFont14n )
	oPrint:Say( _nLinha + 25, 0012, "EMISSAO", oFont14n )
	
	//oPrint:Box( _nLinha, 0070 , _nLinha + 30, 0140)//Dias Atraso
	BoxColor( _nLinha, 0070 , _nLinha + 30, 0140, CLR_HGRAY)
	oPrint:Say( _nLinha + 15, 0080, "DIAS DE", oFont14n )
	oPrint:Say( _nLinha + 25, 0080, "ATRASO", oFont14n )
	
	//oPrint:Box( _nLinha, 0140 , _nLinha + 15, 0484)//Carregados 345 
	BoxColor( _nLinha, 0140 , _nLinha + 15, 0590, CLR_HGRAY)
	//oPrint:Say( _nLinha + 10, 0210, "CARREGADOS", oFont14n )
	oPrint:SayAlign( _nLinha, 0140, "CARREGADOS",oFont14n, 0450, 0020,, 2, 2 )
	
	//oPrint:Box( _nLinha, 0484 , _nLinha + 15, 0830)//Não carregados
	//BoxColor( _nLinha, 0484, _nLinha + 15, 0830, CLR_HGRAY)
	//oPrint:Say( _nLinha + 10, 0550, "NÃO CARREGADOS", oFont14n )
	BoxColor( _nLinha  + 15, 0140 , _nLinha + 30, 0180, CLR_HGRAY)
	oPrint:SayAlign( _nLinha + 14, 0142, "Qtde", oFont14n, 0040, 0020,, 2, 2 )
	
	BoxColor( _nLinha + 15, 0180 , _nLinha + 30, 0316, CLR_HGRAY)
	oPrint:SayAlign( _nLinha + 14, 0180, "Vl.Notas", oFont14n, 0137, 0020,, 2, 2 )
	
	BoxColor( _nLinha + 15, 0316 , _nLinha + 30, 0453, CLR_HGRAY)
	oPrint:SayAlign( _nLinha + 14, 0316, "Peso", oFont14n, 0137, 0020,, 2, 2 )
	
	BoxColor( _nLinha + 15, 0453 , _nLinha + 30, 0590, CLR_HGRAY)
	oPrint:SayAlign( _nLinha + 14, 0453, "Volumes", oFont14n, 0137, 0020,, 2, 2 )
	
	/*
	//oPrint:Box( _nLinha + 15, 0484 , _nLinha + 30, 0524)//Quant
	BoxColor( _nLinha + 15, 0484 , _nLinha + 30, 0524, CLR_HGRAY)
	oPrint:Say( _nLinha + 25, 0486, "Qtde.", oFont14n )
	
	//oPrint:Box( _nLinha + 15, 0524 , _nLinha + 30, 0630)//Vl Notas
	BoxColor( _nLinha + 15, 0524 , _nLinha + 30, 0630, CLR_HGRAY)
	oPrint:Say( _nLinha + 25, 0526, "Vl.Notas", oFont14n )
	
	//oPrint:Box( _nLinha + 15, 0630 , _nLinha + 30, 0729)//Peso
	BoxColor( _nLinha + 15, 0630 , _nLinha + 30, 0729, CLR_HGRAY)
	oPrint:Say( _nLinha + 25, 0632, "Peso", oFont14n )
	
	//oPrint:Box( _nLinha + 15, 0729 , _nLinha + 30, 0830)//Volumes
	BoxColor( _nLinha + 15, 0729 , _nLinha + 30, 0830, CLR_HGRAY)
	oPrint:Say( _nLinha + 25, 0731, "Volumes", oFont14n )
	*/
	_nLinha := fPulaLinha() 
Return
//------------------------------------------------------------
//Descrição: Função responsavel pela impressão de TOTAIS
//------------------------------------------------------------
*----------------------------*
 Static Function fGetDados()
*----------------------------*
	Local _nLinSay 	:= 410
	Local _cQuery  	:= ""                    
	Local _nTotal	:= 00
	Local nTotValCar := 00
	Local nTotPesCar := 00
	Local nTotVolCar := 00
	Local nTotValnCar:= 00
	Local nTotPesnCar:= 00
	Local nTotVolnCar:= 00
	Local nQtdCar		:= 00
	Local nQtdnCar		:= 00
	Local nX			:= 00
	Local aItens		:= {}
	cTipo := "TOTAL GERAL"
	
	MsgRun("Imprimindo Cabeçalho..."	, "Imprimindo Cabeçalho...", {|| fGetCabec(cTipo)})
	 
	 _cQuery := " SELECT " + CRLF
	 _cQuery += " DAK_FILIAL, " + CRLF
	 _cQuery += " DAK_DATA, " + CRLF
	 _cQuery += " DAK_ACECAR, " + CRLF
 	 _cQuery += " SUM(DAK.DAK_VALOR) DAK_VALOR, " + CRLF
 	 _cQuery += " ( SELECT SUM(ROUND(DAI_PESO, 3)) 
	 _cQuery += " 	FROM " + RetSqlName("DAI") + " DAIPESO " + CRLF
 	 _cQuery += "    INNER JOIN " + RetSqlName("DAK") + " DAKPESO " + CRLF
	 _cQuery += "    ON DAK_FILIAL = DAI_FILIAL" + CRLF
	 _cQuery += "    AND DAK_COD = DAI_COD" + CRLF
	 _cQuery += "    AND DAK_SEQCAR = DAI_SEQCAR" + CRLF
	 _cQuery += "   WHERE DAI_FILIAL = DAK_FILIAL  " + CRLF
	 _cQuery += "   AND DAI_DATA = DAK.DAK_DATA " + CRLF
	 _cQuery += "   AND DAK_ACECAR = DAK.DAK_ACECAR" + CRLF
	 _cQuery += "   AND DAIPESO.D_E_L_E_T_ = ' '" 	+ CRLF
   	 _cQuery += "   AND DAKPESO.D_E_L_E_T_ = ' '" 	+ CRLF
 	 _cQuery += " ) DAI_PESO,   " + CRLF
 	 _cQuery += " ( SELECT SUM(ROUND(DAI_CAPVOL, 3)) " + CRLF
 	 _cQuery += " 	FROM " + RetSqlName("DAI") + " DAICAP   " + CRLF
 	 _cQuery += "    INNER JOIN " + RetSqlName("DAK") + " DAKCAP " + CRLF
	 _cQuery += "    ON DAK_FILIAL = DAI_FILIAL" + CRLF
	 _cQuery += "    AND DAK_COD = DAI_COD" + CRLF
	 _cQuery += "    AND DAK_SEQCAR = DAI_SEQCAR" + CRLF
	 _cQuery += "   WHERE DAI_FILIAL = DAK_FILIAL  " + CRLF
	 _cQuery += "   AND DAI_DATA = DAK.DAK_DATA " + CRLF
	 _cQuery += "   AND DAK_ACECAR = DAK.DAK_ACECAR" + CRLF
	 _cQuery += "   AND DAICAP.D_E_L_E_T_ = ' '" + CRLF
   	 _cQuery += "   AND DAKCAP.D_E_L_E_T_ = ' '" + CRLF
 	 _cQuery += " ) DAI_CAPVOL " + CRLF
	 _cQuery += " FROM " + RetSqlName("DAK") + " DAK " + CRLF
	 _cQuery += " WHERE DAK.D_E_L_E_T_ = ' ' " + CRLF
	 _cQuery += " AND DAK.DAK_FILIAL = '" + xFilial("DAK") + "' " + CRLF
	 _cQuery += " AND DAK.DAK_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' " + CRLF
	 _cQuery += " AND DAK.DAK_ACECAR = '2' " + CRLF
	 _cQuery += " AND DAK.DAK_VALOR > 0 " + CRLF
	 _cQuery += " GROUP BY DAK_FILIAL, DAK_DATA, DAK_ACECAR" + CRLF
	 _cQuery += " ORDER BY DAK_FILIAL, DAK_DATA ASC " + CRLF
		
	If Select("TRBTOT") > 0
		TRBTOT->(DbCloseArea())
	EndIf	            
	
	TcQuery _cQuery new Alias "TRBTOT"
		
	_nLinha := fPulaLinha()
/*	While !TRBTOT->(Eof())
		cData := TRBTOT->DAK_DATA
		nX++ 
		aAdd(aItens, {" ", 0, 0, 0, 0, 0, 0, 0, 0, 0})
		While !TRBTOT->(Eof()) .And. cData == TRBTOT->DAK_DATA
			aItens[nX][01]:= TRBTOT->DAK_DATA
			aItens[nX][02]:= dDataBase - SToD(TRBTOT->DAK_DATA)	
			If AllTrim(TRBTOT->DAK_ACECAR) == "1"
				aItens[nX][03]:= fGetQuant(TRBTOT->DAK_DATA, "1")
				aItens[nX][04]:= TRBTOT->DAK_VALOR
				aItens[nX][05]:= TRBTOT->DAI_PESO
				aItens[nX][06]:= TRBTOT->DAI_CAPVOL
			ElseIf  AllTrim(TRBTOT->DAK_ACECAR) == "2"
				aItens[nX][07]:= fGetQuant(TRBTOT->DAK_DATA, "2")
				aItens[nX][08]:= TRBTOT->DAK_VALOR
				aItens[nX][09]:= TRBTOT->DAI_PESO
				aItens[nX][10]:= TRBTOT->DAI_CAPVOL
			EndIf						
			TRBTOT->(DbSkip())
		EndDo	
	EndDo*/
	
	While !TRBTOT->(Eof())
		nX++
		aAdd(aItens, {" ", 0, 0, 0, 0, 0, 0, 0, 0, 0})
		aItens[nX][01]:= TRBTOT->DAK_DATA
		aItens[nX][02]:= dDataBase - SToD(TRBTOT->DAK_DATA)	
		aItens[nX][03]:= fGetQuant(TRBTOT->DAK_DATA, "2")
		aItens[nX][04]:= TRBTOT->DAK_VALOR
		aItens[nX][05]:= TRBTOT->DAI_PESO
		aItens[nX][06]:= TRBTOT->DAI_CAPVOL
		TRBTOT->(DbSkip())	
	EndDo
	
	fImpItens(aItens)
	
	MsgRun("Imprimindo Vendas...", 			"Imprimindo Vendas... ", {|| fImpVendas()})
	MsgRun("Imprimindo Transferencias...", 	"Imprimindo Transferencias... ", {|| fImpTransf()})
	MsgRun("Imprimindo Organização...", 	"Imprimindo Organização... ", {|| fImpOrg()})
	MsgRun("Imprimindo Praça...", 			"Imprimindo Praça... ", {|| fImpPraca() })
	MsgRun("Imprimindo Interior...", 		"Imprimindo Interior... ", {|| fImpInter() })
	MsgRun("Imprimindo Doação...", 			"Imprimindo Doação... ", {|| fImpDoacao()})
	MsgRun("Imprimindo Outros...", 			"Imprimindo Outros", {|| fImpOutros()})
	
	oPrint:Preview()
Return
//------------------------------------------------------------
//Descrição: Função responsavel pela impressão do rodapé
//------------------------------------------------------------
*-----------------------------------*
 Static Function fGetRodape()
*-----------------------------------*
oPrint:Line( 0800, 0010, 0800, 0590 )
oPrint:Say( 0810, 0010, "TOTVS", oFont10n )
oPrint:EndPage()

Return
//------------------------------------------------------------
//Descrição: Função responsavel pelo controle de pulo de linhas
//------------------------------------------------------------
*-------------------------------*
Static Function fPulaLinha(nLin)
*-------------------------------*
Default nLin := 1

_nLinha += 20 * nLin

If _nLinha >= 0750 
	fGetRodape()
	_nLinha := 50
	fGetCabec()
	_nLinha := fPulaLinha()
EndIf

Return _nLinha
//------------------------------------------------------------
//Descrição: Função responsavel pela criação das perguntas do 
//			 parametro
//------------------------------------------------------------
*--------------------------*
Static Function CriaPerg()
*--------------------------*

	PutSx1( _cPerg, "01", "Data de?"		,"","", "mv_ch1", "D",08, 00, 00, "G","", ""	,"",""	, "mv_par01","","","","","","","","","","","","","","","","", { "Digite a data de..."},{},{},"")
	PutSx1( _cPerg, "02", "Data Ate?"		,"","", "mv_ch2", "D",08, 00, 00, "G","", ""	,"",""	, "mv_par02","","","","","","","","","","","","","","","","", { "Digite a data até..."},{},{},"")

Return
//------------------------------------------------------------
//Descrição: Função responsavel pela impressão de VENDAS
//------------------------------------------------------------
*-------------------------------------*
Static Function fImpVendas()
*-------------------------------------*
	Local _nTotal	 := 00
	Local nTotValCar := 00
	Local nTotPesCar := 00
	Local nTotVolCar := 00
	Local nTotValnCar:= 00
	Local nTotPesnCar:= 00
	Local nTotVolnCar:= 00
	Local nQtdCar		:= 00
	Local nQtdnCar		:= 00
	Local cOper     	:= GetMv("MV_XOPER")
	Local aRet			:= {}
	Local nX			:= 00
	Local aItens		:= {}
	
	cTipo := "MAPA DE VENDAS"
	
	fGetRodape()
	_nLinha := 50
	MsgRun("Imprimindo Cabeçalho..."	, "Imprimindo Cabeçalho...", {|| fGetCabec(cTipo)})
	
	_cQuery := " SELECT DAK_FILIAL, " 				+ CRLF
	_cQuery += " 		DAK_DATA, " 				+ CRLF
	_cQuery += " 		DAK_ACECAR, " 				+ CRLF	
	_cQuery += " 	    SUM(D2_QUANT) D2_QUANT, " 	+ CRLF 	
	_cQuery += " 		SUM(D2_TOTAL) D2_TOTAL, 	 " 			+ CRLF
	_cQuery += " 		ROUND(SUM(D2_QUANT * SB1.B1_PESO), 3) DAI_PESO," 								+ CRLF
 	_cQuery += " 		ROUND(SUM((B5_COMPRLC * B5_LARGLC * B5_ALTURLC) * D2_QUANT), 3) DAI_CAPVOL	" 	+ CRLF
 	_cQuery += "   FROM "+ RetSqlName("DAK") +"  DAK  " 	+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("DAI") +"  DAI   "	+ CRLF
	_cQuery += " 	ON DAK_FILIAL 	= DAI_FILIAL  " 			+ CRLF
	_cQuery += " 	AND DAK_COD 	= DAI_COD  " 				+ CRLF
	_cQuery += " 	AND DAK_SEQCAR = DAI_SEQCAR  " 				+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("SD2") +" SD2  " 	+ CRLF
	_cQuery += " 	ON DAI.DAI_FILIAL 	= SD2.D2_FILIAL " 		+ CRLF 
	_cQuery += " 	 AND DAI.DAI_NFISCA = SD2.D2_DOC  " 		+ CRLF
	_cQuery += " 	 AND DAI.DAI_SERIE 	= SD2.D2_SERIE " 		+ CRLF 
	_cQuery += " 	 INNER JOIN "+ RetSqlName("SF4") +"  SF4" 	+ CRLF
  	_cQuery += " 	 ON SD2.D2_TES = F4_CODIGO" 				+ CRLF
	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB1") +" SB1" 	+ CRLF
 	_cQuery += " 	  ON SD2.D2_COD = SB1.B1_COD" 				+ CRLF
 	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB5") +" SB5" 	+ CRLF
 	_cQuery += " 	  ON SB1.B1_COD = SB5.B5_COD" 				+ CRLF 
	_cQuery += " 	 WHERE DAK.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB5.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB1.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	 AND DAI_FILIAL = '" + xFilial("DAI")+ "' "+ CRLF
	_cQuery += " 	 AND DAK.DAK_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' " + CRLF
	_cQuery += " 	 AND DAK.DAK_ACECAR  = '2' " + CRLF
	_cQuery += " 	 AND DAK.DAK_FEZNF = '1'  " + CRLF
	_cQuery += " 	 AND SF4.F4_OPEMOV IN " + FormatIn(cParOper, ",") + " " + CRLF
	_cQuery += " 	GROUP BY DAK_FILIAL,DAK_DATA,DAK_ACECAR " + CRLF
	_cQuery += " 	ORDER BY DAK_FILIAL,DAK_DATA  " + CRLF
	
	If Select("TRBVEN") > 0
		TRBVEN->(DbCloseArea())
	EndIf	            
	
	TcQuery _cQuery new Alias "TRBVEN"
		
	_nLinha := fPulaLinha()
	While !TRBVEN->(Eof())
		nX++
		aAdd(aItens,{" "," ", 0, 0, 0, 0, 0, 0, 0, 0} )
		aItens[nX][01] := TRBVEN->DAK_DATA
		aItens[nX][02] := dDataBase - SToD(TRBVEN->DAK_DATA)		
		aItens[nX][03] := TRBVEN->D2_QUANT
		aItens[nX][04] := TRBVEN->D2_TOTAL
		aItens[nX][05] := TRBVEN->DAI_PESO
		aItens[nX][06] := TRBVEN->DAI_CAPVOL
		TRBVEN->(DbSkip())	
	EndDo
	fImpItens(aItens)
	MsgRun("Imprimindo Rodapé...", "Imprimindo Rodapé... ", {|| fGetRodape()})
	TRBVEN->(DbCloseArea())
Return
*-------------------------------------*
Static Function fImpTransf()
*-------------------------------------*
	Local _nTotal	 := 00
	Local nTotValCar := 00
	Local nTotPesCar := 00
	Local nTotVolCar := 00
	Local nTotValnCar:= 00
	Local nTotPesnCar:= 00
	Local nTotVolnCar:= 00
	Local nQtdCar		:= 00
	Local nQtdnCar		:= 00
	Local nX			:= 00
	Local aItens		:= {}
	
	cTipo := "MAPA DE TRANSFERÊNCIA"
	
	fGetRodape()
	_nLinha := 50
	MsgRun("Imprimindo Cabeçalho..."	, "Imprimindo Cabeçalho...", {|| fGetCabec(cTipo)})
	
	_cQuery := " SELECT DAK_FILIAL, " 						+ CRLF
	_cQuery += " 		DAK_DATA, " 						+ CRLF
	_cQuery += " 		DAK_ACECAR, " 						+ CRLF	
	_cQuery += " 	    SUM(D2_QUANT) D2_QUANT, " 			+ CRLF 	
	_cQuery += " 		SUM(D2_TOTAL) D2_TOTAL, 	 " 		+ CRLF
	_cQuery += " 		ROUND(SUM(D2_QUANT * SB1.B1_PESO), 3) DAI_PESO," 								+ CRLF
 	_cQuery += " 		ROUND(SUM((B5_COMPRLC * B5_LARGLC * B5_ALTURLC) * D2_QUANT), 3) DAI_CAPVOL	" 	+ CRLF	
 	_cQuery += " 		FROM "+ RetSqlName("DAK") +"  DAK  " 	+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("DAI") +"  DAI   "	+ CRLF
	_cQuery += " 	ON DAK_FILIAL 	= DAI_FILIAL  " 			+ CRLF
	_cQuery += " 	AND DAK_COD 	= DAI_COD  " 				+ CRLF
	_cQuery += " 	AND DAK_SEQCAR = DAI_SEQCAR  " 				+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("SD2") +" SD2  " 	+ CRLF
	_cQuery += " 	ON DAI.DAI_FILIAL 	= SD2.D2_FILIAL " 		+ CRLF 
	_cQuery += " 	 AND DAI.DAI_NFISCA = SD2.D2_DOC  " 		+ CRLF
	_cQuery += " 	 AND DAI.DAI_SERIE 	= SD2.D2_SERIE " 		+ CRLF
	_cQuery += " 	 INNER JOIN "+ RetSqlName("SF4") +"  SF4" 	+ CRLF
  	_cQuery += " 	 ON SD2.D2_TES = F4_CODIGO" 				+ CRLF
  	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB1") +" SB1" 	+ CRLF
 	_cQuery += " 	  ON SD2.D2_COD = SB1.B1_COD" 				+ CRLF
 	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB5") +" SB5" 	+ CRLF
 	_cQuery += " 	  ON SB1.B1_COD = SB5.B5_COD" 				+ CRLF 
	_cQuery += " 	 WHERE DAK.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB5.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB1.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI_FILIAL = '" + xFilial("DAI")+ "' "+ CRLF
	_cQuery += " 	  AND DAK.DAK_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' " + CRLF
	_cQuery += " 	  AND DAK.DAK_ACECAR  = '2' " + CRLF
	_cQuery += " 	  AND DAK.DAK_FEZNF = '1'  " + CRLF
	_cQuery += " 	 AND SF4.F4_OPEMOV IN " + FormatIn(cParTran, ",") + " " + CRLF
	_cQuery += " 	GROUP BY DAK_FILIAL,DAK_DATA,DAK_ACECAR " + CRLF
	_cQuery += " 	ORDER BY DAK_FILIAL, DAK_DATA  " + CRLF
	
	If Select("TRBTRA") > 0
		TRBTRA->(DbCloseArea())
	EndIf	            
	
	TcQuery _cQuery new Alias "TRBTRA"
	
	_nLinha := fPulaLinha()
	While !TRBTRA->(Eof())
		nX++
		aAdd(aItens,{" "," ", 0, 0, 0, 0, 0, 0, 0, 0} )
		aItens[nX][01] :=  TRBTRA->DAK_DATA
		aItens[nX][02] :=  dDataBase - SToD(TRBTRA->DAK_DATA)		
		aItens[nX][03]:=  TRBTRA->D2_QUANT
		aItens[nX][04]:=  TRBTRA->D2_TOTAL
		aItens[nX][05]:=  TRBTRA->DAI_PESO
		aItens[nX][06]:=  TRBTRA->DAI_CAPVOL
		TRBTRA->(DbSkip())	
	EndDo
	fImpItens(aItens)
	
	MsgRun("Imprimindo Rodapé...", "Imprimindo Rodapé... ", {|| fGetRodape()})
	TRBTRA->(DbCloseArea())
Return 	
//------------------------------------------------------------
//Descrição: Função responsavel pela impressão de ORGANIZAÇÃO
//------------------------------------------------------------
*-------------------------------------*
Static Function fImpOrg()
*-------------------------------------*
	Local _nTotal	 := 00
	Local nTotValCar := 00
	Local nTotPesCar := 00
	Local nTotVolCar := 00
	Local nTotValnCar:= 00
	Local nTotPesnCar:= 00
	Local nTotVolnCar:= 00
	Local nQtdCar	 := 00
	Local nQtdnCar	 := 00
	Local nX			:= 00
	Local aItens		:= {}
	
	cTipo := "ORGANIZAÇÃO"
	
	fGetRodape()
	_nLinha := 50
	
	MsgRun("Imprimindo Cabeçalho..."	, "Imprimindo Cabeçalho...", {|| fGetCabec(cTipo)})
	_nLinha := fPulaLinha()
	
	_cQuery := " SELECT DAK_FILIAL, " 								+ CRLF
	_cQuery += " 		DAK_DATA, " 								+ CRLF
		_cQuery += " 		DAK_ACECAR, " 							+ CRLF	
	_cQuery += " 	    SUM(D2_QUANT) D2_QUANT, " 					+ CRLF 	
	_cQuery += " 		SUM(D2_TOTAL) D2_TOTAL, 	 " 				+ CRLF
	_cQuery += " 		ROUND(SUM(D2_QUANT * SB1.B1_PESO), 3) DAI_PESO," 								+ CRLF
 	_cQuery += " 		ROUND(SUM((B5_COMPRLC * B5_LARGLC * B5_ALTURLC) * D2_QUANT), 3) DAI_CAPVOL	" 	+ CRLF
 	_cQuery += " 	FROM "+ RetSqlName("DAK") +"  DAK  " 	+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("DAI") +"  DAI   "	+ CRLF
	_cQuery += " 	ON DAK_FILIAL 	= DAI_FILIAL  " 			+ CRLF
	_cQuery += " 	AND DAK_COD 	= DAI_COD  " 				+ CRLF
	_cQuery += " 	AND DAK_SEQCAR = DAI_SEQCAR  " 				+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("SD2") +" SD2  " 	+ CRLF
	_cQuery += " 	ON DAI.DAI_FILIAL 	= SD2.D2_FILIAL " 		+ CRLF 
	_cQuery += " 	 AND DAI.DAI_NFISCA = SD2.D2_DOC  " 		+ CRLF
	_cQuery += " 	 AND DAI.DAI_SERIE 	= SD2.D2_SERIE " 		+ CRLF 
	_cQuery += " 	INNER JOIN "+ RetSqlName("SA1") +" SA1" 	+ CRLF
 	_cQuery += " 	ON SD2.D2_CLIENTE = SA1.A1_COD" 			+ CRLF
 	_cQuery += " 	 AND SD2.D2_LOJA = SA1.A1_LOJA" 			+ CRLF
	_cQuery += " 	 INNER JOIN "+ RetSqlName("SF4") +"  SF4" 	+ CRLF
  	_cQuery += " 	 ON SD2.D2_TES = F4_CODIGO" 				+ CRLF
	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB1") +" SB1" 	+ CRLF
 	_cQuery += " 	  ON SD2.D2_COD = SB1.B1_COD" 				+ CRLF
 	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB5") +" SB5" 	+ CRLF
 	_cQuery += " 	  ON SB1.B1_COD = SB5.B5_COD" 				+ CRLF 
	_cQuery += " 	 WHERE DAK.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB5.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB1.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	 AND DAI_FILIAL = '" + xFilial("DAI")+ "' "+ CRLF
	_cQuery += " 	 AND DAK.DAK_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' " + CRLF
	_cQuery += " 	 AND DAK.DAK_ACECAR  = '2' " 		+ CRLF
	_cQuery += " 	 AND DAK.DAK_FEZNF = '1'  " 		+ CRLF
	_cQuery += " 	 AND SA1.A1_XGCORP = '1'  " 		+ CRLF
	_cQuery += " 	 AND SF4.F4_OPEMOV NOT IN " + FormatIn(cParTran + "," + cParDoacao, ",") + " " + CRLF
	_cQuery += " 	GROUP BY DAK_FILIAL,DAK_DATA,DAK_ACECAR " + CRLF
	_cQuery += " 	ORDER BY DAK_FILIAL, DAK_DATA  " + CRLF
	
	If Select("TRBORG") > 0
		TRBORG->(DbCloseArea())
	EndIf	            
	
	TcQuery _cQuery new Alias "TRBORG"
	
	
	While !TRBORG->(Eof())
		nX++
		aAdd(aItens,{" "," ", 0, 0, 0, 0, 0, 0, 0, 0} )
		aItens[nX][01] :=  TRBORG->DAK_DATA
		aItens[nX][02] :=  dDataBase - SToD(TRBORG->DAK_DATA)		
		aItens[nX][03]:=  TRBORG->D2_QUANT
		aItens[nX][04]:=  TRBORG->D2_TOTAL
		aItens[nX][05]:=  TRBORG->DAI_PESO
		aItens[nX][06]:=  TRBORG->DAI_CAPVOL
		TRBORG->(DbSkip())	
	EndDo
	
	fImpItens(aItens)
	
	MsgRun("Imprimindo Rodapé...", "Imprimindo Rodapé... ", {|| fGetRodape()})
	TRBORG->(DbCloseArea())
Return 	
//------------------------------------------------------------
//Descrição: Função responsavel pela impressão de INTERIOR
//------------------------------------------------------------
*-------------------------------------*
Static Function fImpInter()
*-------------------------------------*            
	Local _nTotal	 := 00
	Local nTotValCar := 00
	Local nTotPesCar := 00
	Local nTotVolCar := 00
	Local nTotValnCar:= 00
	Local nTotPesnCar:= 00
	Local nTotVolnCar:= 00
	Local nQtdCar		:= 00
	Local nQtdnCar		:= 00
	Local nX			:= 00
	Local aItens		:= {}
	
	cTipo := "INTERIOR"
	
	_nLinha := 50
	MsgRun("Imprimindo Cabeçalho..."	, "Imprimindo Cabeçalho...", {|| fGetCabec(cTipo)})
	
	_cQuery := " SELECT DAK_FILIAL, " 							+ CRLF
	_cQuery += " 		DAK_DATA, " 							+ CRLF
	_cQuery += " 		DAK_ACECAR, " 							+ CRLF	
	_cQuery += " 	    SUM(D2_QUANT) D2_QUANT, " 				+ CRLF 	
	_cQuery += " 		SUM(D2_TOTAL) D2_TOTAL, 	 " 			+ CRLF
	_cQuery += " 		ROUND(SUM(D2_QUANT * SB1.B1_PESO), 3) DAI_PESO," 								+ CRLF
 	_cQuery += " 		ROUND(SUM((B5_COMPRLC * B5_LARGLC * B5_ALTURLC) * D2_QUANT), 3) DAI_CAPVOL	" 	+ CRLF	
 	_cQuery += " 	FROM "+ RetSqlName("DAK") +"  DAK  " 	+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("DAI") +"  DAI   "	+ CRLF
	_cQuery += " 	ON DAK_FILIAL 	= DAI_FILIAL  " 			+ CRLF
	_cQuery += " 	AND DAK_COD 	= DAI_COD  " 				+ CRLF
	_cQuery += " 	AND DAK_SEQCAR = DAI_SEQCAR  " 				+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("SD2") +" SD2  " 	+ CRLF
	_cQuery += " 	ON DAI.DAI_FILIAL 	= SD2.D2_FILIAL " 		+ CRLF 
	_cQuery += " 	 AND DAI.DAI_NFISCA = SD2.D2_DOC  " 		+ CRLF
	_cQuery += " 	 AND DAI.DAI_SERIE 	= SD2.D2_SERIE " 		+ CRLF 
	_cQuery += " 	INNER JOIN "+ RetSqlName("DA8") +" DA8" 	+ CRLF
 	_cQuery += " 	ON DAK.DAK_ROTEIR = DA8.DA8_COD" 			+ CRLF
	_cQuery += " 	 INNER JOIN "+ RetSqlName("SF4") +"  SF4" 	+ CRLF
  	_cQuery += " 	 ON SD2.D2_TES = F4_CODIGO" 				+ CRLF
  	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB1") +" SB1" 	+ CRLF
 	_cQuery += " 	  ON SD2.D2_COD = SB1.B1_COD" 				+ CRLF
 	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB5") +" SB5" 	+ CRLF
 	_cQuery += " 	  ON SB1.B1_COD = SB5.B5_COD" 				+ CRLF 
	_cQuery += " 	 WHERE DAK.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB5.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB1.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI_FILIAL = '" + xFilial("DAI")+ "' "+ CRLF
	_cQuery += " 	  AND DAK.DAK_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' " + CRLF
	_cQuery += " 	  AND DAK.DAK_ACECAR  = '2' " + CRLF
	_cQuery += " 	  AND DAK.DAK_FEZNF = '1'  " + CRLF
	_cQuery += " 	  AND DA8.DA8_XINTER = '1'  " + CRLF
	_cQuery += " 	 AND SF4.F4_OPEMOV NOT IN " + FormatIn(cParTran + "," + cParDoacao, ",") + " " + CRLF
	_cQuery += " 	GROUP BY DAK_FILIAL,DAK_DATA,DAK_ACECAR " + CRLF
	_cQuery += " 	ORDER BY DAK_FILIAL, DAK_DATA  " + CRLF
	
	If Select("TRBINT") > 0
		TRBINT->(DbCloseArea())
	EndIf	            
	
	TcQuery _cQuery new Alias "TRBINT"
	
	_nLinha := fPulaLinha()
	While !TRBINT->(Eof())
		nX++
		aAdd(aItens,{" "," ", 0, 0, 0, 0, 0, 0, 0, 0} )
		aItens[nX][01] :=  TRBINT->DAK_DATA
		aItens[nX][02] :=  dDataBase - SToD(TRBINT->DAK_DATA)		
		aItens[nX][03]:=  TRBINT->D2_QUANT
		aItens[nX][04]:=  TRBINT->D2_TOTAL
		aItens[nX][05]:=  TRBINT->DAI_PESO
		aItens[nX][06]:=  TRBINT->DAI_CAPVOL
		TRBINT->(DbSkip())	
	EndDo
	
	fImpItens(aItens)
	MsgRun("Imprimindo Rodapé...", "Imprimindo Rodapé... ", {|| fGetRodape()})
	
	TRBINT->(DbCloseArea())
	
Return 
//------------------------------------------------------------
//Descrição: Função responsavel pela impressão de PRAÇA
//------------------------------------------------------------
*-------------------------------------*
Static Function fImpPraca()
*-------------------------------------*
	Local _nTotal	 := 00
	Local nTotValCar := 00
	Local nTotPesCar := 00
	Local nTotVolCar := 00
	Local nTotValnCar:= 00
	Local nTotPesnCar:= 00
	Local nTotVolnCar:= 00
	Local nQtdCar	 := 00
	Local nQtdnCar	 := 00
	Local nX	     := 00
	Local aItens     := {}
	
	cTipo := "PRAÇA"
	
	_nLinha := 50
	MsgRun("Imprimindo Cabeçalho..."	, "Imprimindo Cabeçalho...", {|| fGetCabec(cTipo)})
	
	_cQuery := " SELECT DAK_FILIAL, " 				+ CRLF
	_cQuery += " 		DAK_DATA, " 				+ CRLF
	_cQuery += " 		DAK_ACECAR, " 								+ CRLF	
	_cQuery += " 	    SUM(D2_QUANT) D2_QUANT, " 						+ CRLF 	
	_cQuery += " 		SUM(D2_TOTAL) D2_TOTAL, 	 " 					+ CRLF
	_cQuery += " 		ROUND(SUM(D2_QUANT * SB1.B1_PESO), 3) DAI_PESO," 								+ CRLF
 	_cQuery += " 		ROUND(SUM((B5_COMPRLC * B5_LARGLC * B5_ALTURLC) * D2_QUANT), 3) DAI_CAPVOL	" 	+ CRLF
 	_cQuery += " 	FROM "+ RetSqlName("DAK") +"  DAK  " 	+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("DAI") +"  DAI   "	+ CRLF
	_cQuery += " 	ON DAK_FILIAL 	= DAI_FILIAL  " 			+ CRLF
	_cQuery += " 	AND DAK_COD 	= DAI_COD  " 				+ CRLF
	_cQuery += " 	AND DAK_SEQCAR = DAI_SEQCAR  " 				+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("SD2") +" SD2  " 	+ CRLF
	_cQuery += " 	ON DAI.DAI_FILIAL 	= SD2.D2_FILIAL " 		+ CRLF 
	_cQuery += " 	 AND DAI.DAI_NFISCA = SD2.D2_DOC  " 		+ CRLF
	_cQuery += " 	 AND DAI.DAI_SERIE 	= SD2.D2_SERIE " 		+ CRLF 
	_cQuery += " 	INNER JOIN "+ RetSqlName("DA8") +" DA8" 	+ CRLF
 	_cQuery += " 	ON DAK.DAK_ROTEIR = DA8.DA8_COD" 			+ CRLF
 	_cQuery += " 	 INNER JOIN "+ RetSqlName("SF4") +"  SF4" 	+ CRLF
  	_cQuery += " 	 ON SD2.D2_TES = F4_CODIGO" 				+ CRLF
	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB1") +" SB1" 	+ CRLF
 	_cQuery += " 	  ON SD2.D2_COD = SB1.B1_COD" 				+ CRLF
 	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB5") +" SB5" 	+ CRLF
 	_cQuery += " 	  ON SB1.B1_COD = SB5.B5_COD" 				+ CRLF 
	_cQuery += " 	 WHERE DAK.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB5.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB1.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI_FILIAL = '" + xFilial("DAI")+ "' "+ CRLF
	_cQuery += " 	  AND DAK.DAK_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' " + CRLF
	_cQuery += " 	  AND DAK.DAK_ACECAR  = '2' " + CRLF
	_cQuery += " 	  AND DAK.DAK_FEZNF = '1'  " + CRLF
	_cQuery += " 	  AND DA8.DA8_XINTER = '2'  " + CRLF
	_cQuery += " 	 AND SF4.F4_OPEMOV NOT IN " + FormatIn(cParTran + "," + cParDoacao, ",") + " " + CRLF
	_cQuery += " 	GROUP BY DAK_FILIAL,DAK_DATA,DAK_ACECAR " + CRLF
	_cQuery += " 	ORDER BY DAK_FILIAL, DAK_DATA  " + CRLF
	
	If Select("TRBPRC") > 0
		TRBPRC->(DbCloseArea())
	EndIf	            
	
	TcQuery _cQuery new Alias "TRBPRC"
	
	_nLinha := fPulaLinha()
	While !TRBPRC->(Eof())
		nX++
		aAdd(aItens,{" "," ", 0, 0, 0, 0, 0, 0, 0, 0} ) 
		aItens[nX][01] :=  TRBPRC->DAK_DATA
		aItens[nX][02] :=  dDataBase - SToD(TRBPRC->DAK_DATA)		
		aItens[nX][03]:=  TRBPRC->D2_QUANT
		aItens[nX][04]:=  TRBPRC->D2_TOTAL
		aItens[nX][05]:=  TRBPRC->DAI_PESO
		aItens[nX][06]:=  TRBPRC->DAI_CAPVOL
		TRBPRC->(DbSkip())	
	EndDo
	fImpItens(aItens)	
	MsgRun("Imprimindo Rodapé...", "Imprimindo Rodapé... ", {|| fGetRodape()})
	
	TRBPRC->(DbCloseArea())
Return 	
//------------------------------------------------------------
//Descrição: Função responsavel pela impressão de DOAÇÕES
//------------------------------------------------------------
*-------------------------------------*
Static Function fImpDoacao()
*-------------------------------------*
	Local _nTotal	 := 00
	Local nTotValCar := 00
	Local nTotPesCar := 00
	Local nTotVolCar := 00
	Local nTotValnCar:= 00
	Local nTotPesnCar:= 00
	Local nTotVolnCar:= 00
	Local nQtdCar		:= 00
	Local nQtdnCar		:= 00
	Local nX			:= 00
	Local aItens		:= {}
	cTipo := "DOAÇÃO"
	
	fGetRodape()
	_nLinha := 50
	MsgRun("Imprimindo Cabeçalho..."	, "Imprimindo Cabeçalho...", {|| fGetCabec(cTipo)})
	
	_cQuery := " SELECT DAK_FILIAL, " 				+ CRLF
	_cQuery += " 		DAK_DATA, " 				+ CRLF
	_cQuery += " 		DAK_ACECAR, " 				+ CRLF	
	_cQuery += " 	    SUM(D2_QUANT) D2_QUANT, " 	+ CRLF 	
	_cQuery += " 		SUM(D2_TOTAL) D2_TOTAL, 	 " 			+ CRLF
	_cQuery += " 		ROUND(SUM(D2_QUANT * SB1.B1_PESO), 3) DAI_PESO," 								+ CRLF
 	_cQuery += " 		ROUND(SUM((B5_COMPRLC * B5_LARGLC * B5_ALTURLC) * D2_QUANT), 3) DAI_CAPVOL	" 	+ CRLF
 	_cQuery += " 		FROM "+ RetSqlName("DAK") +"  DAK  " 	+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("DAI") +"  DAI   "	+ CRLF
	_cQuery += " 	ON DAK_FILIAL 	= DAI_FILIAL  " 			+ CRLF
	_cQuery += " 	AND DAK_COD 	= DAI_COD  " 				+ CRLF
	_cQuery += " 	AND DAK_SEQCAR = DAI_SEQCAR  " 				+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("SD2") +" SD2  " 	+ CRLF
	_cQuery += " 	ON DAI.DAI_FILIAL 	= SD2.D2_FILIAL " 		+ CRLF 
	_cQuery += " 	 AND DAI.DAI_NFISCA = SD2.D2_DOC  " 		+ CRLF
	_cQuery += " 	 AND DAI.DAI_SERIE 	= SD2.D2_SERIE " 		+ CRLF 
 	_cQuery += " 	 INNER JOIN "+ RetSqlName("SF4") +"  SF4" 	+ CRLF
  	_cQuery += " 	 ON SD2.D2_TES = F4_CODIGO" 				+ CRLF
	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB1") +" SB1" 	+ CRLF
 	_cQuery += " 	  ON SD2.D2_COD = SB1.B1_COD" 				+ CRLF
 	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB5") +" SB5" 	+ CRLF
 	_cQuery += " 	  ON SB1.B1_COD = SB5.B5_COD" 				+ CRLF 
	_cQuery += " 	 WHERE DAK.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB5.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB1.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI_FILIAL = '" + xFilial("DAI")+ "' "+ CRLF
	_cQuery += " 	  AND DAK.DAK_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' " + CRLF
	_cQuery += " 	  AND DAK.DAK_ACECAR  = '2' " + CRLF
	_cQuery += " 	  AND DAK.DAK_FEZNF = '1'  " + CRLF
	_cQuery += " 	  AND SF4.F4_OPEMOV IN " + FormatIn(cParDoacao, ",") + " " + CRLF
	_cQuery += " 	GROUP BY DAK_FILIAL,DAK_DATA,DAK_ACECAR " + CRLF
	_cQuery += " 	ORDER BY DAK_FILIAL,DAK_DATA  " + CRLF
	
	If Select("TRBDOA") > 0
		TRBDOA->(DbCloseArea())
	EndIf	            
	
	TcQuery _cQuery new Alias "TRBDOA"
		
	_nLinha := fPulaLinha()
	While !TRBDOA->(Eof())
		nX++
		aAdd(aItens,{" "," ", 0, 0, 0, 0, 0, 0, 0, 0} ) 
		aItens[nX][01] :=  TRBDOA->DAK_DATA
		aItens[nX][02] :=  dDataBase - SToD(TRBDOA->DAK_DATA)		
		aItens[nX][03] :=  TRBDOA->D2_QUANT
		aItens[nX][04] :=  TRBDOA->D2_TOTAL
		aItens[nX][05] :=  TRBDOA->DAI_PESO
		aItens[nX][06] :=  TRBDOA->DAI_CAPVOL
		TRBDOA->(DbSkip())	
	EndDo
	
	fImpItens(aItens)	
	
	MsgRun("Imprimindo Rodapé...", "Imprimindo Rodapé... ", {|| fGetRodape()})
	TRBDOA->(DbCloseArea())
Return 	
//------------------------------------------------------------
//Descrição: Função responsavel pela impressão de OUTROS
//------------------------------------------------------------
*-------------------------------------*
Static Function fImpOutros()
*-------------------------------------*
	Local _nTotal	 := 00
	Local nTotValCar := 00
	Local nTotPesCar := 00
	Local nTotVolCar := 00
	Local nTotValnCar:= 00
	Local nTotPesnCar:= 00
	Local nTotVolnCar:= 00
	Local nQtdCar	 := 00
	Local nQtdnCar	 := 00
	Local nX		 := 00
	Local aItens	 := {}
	
	cTipo := "OUTROS"
	cTodosCF := GetMv("MV_XDOACAO") + "," + GetMv("MV_XOPER") + "," + GetMv("MV_XCFTRAN") 
	fGetRodape()
	_nLinha := 50
	MsgRun("Imprimindo Cabeçalho..."	, "Imprimindo Cabeçalho...", {|| fGetCabec(cTipo)})
	
	_cQuery := " SELECT DAK_FILIAL, " 							+ CRLF
	_cQuery += " 		DAK_DATA, " 							+ CRLF
	_cQuery += " 		DAK_ACECAR, " 						+ CRLF	
	_cQuery += " 	    SUM(D2_QUANT) D2_QUANT, " 				+ CRLF 	
	_cQuery += " 		SUM(D2_TOTAL) D2_TOTAL, 	 " 			+ CRLF
	_cQuery += " 		ROUND(SUM(D2_QUANT * SB1.B1_PESO), 3) DAI_PESO," 								+ CRLF
 	_cQuery += " 		ROUND(SUM((B5_COMPRLC * B5_LARGLC * B5_ALTURLC) * D2_QUANT), 3) DAI_CAPVOL	" 	+ CRLF
 	_cQuery += " 		FROM "+ RetSqlName("DAK") +"  DAK  " 	+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("DAI") +"  DAI   "	+ CRLF
	_cQuery += " 	ON DAK_FILIAL 	= DAI_FILIAL  " 			+ CRLF
	_cQuery += " 	AND DAK_COD 	= DAI_COD  " 				+ CRLF
	_cQuery += " 	AND DAK_SEQCAR = DAI_SEQCAR  " 				+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("SD2") +" SD2  " 	+ CRLF
	_cQuery += " 	ON DAI.DAI_FILIAL 	= SD2.D2_FILIAL " 		+ CRLF 
	_cQuery += " 	 AND DAI.DAI_NFISCA = SD2.D2_DOC  " 		+ CRLF
	_cQuery += " 	 AND DAI.DAI_SERIE 	= SD2.D2_SERIE " 		+ CRLF
	_cQuery += " 	INNER JOIN "+ RetSqlName("SA1") +" SA1" 	+ CRLF
 	_cQuery += " 	ON SD2.D2_CLIENTE = SA1.A1_COD" 			+ CRLF
 	_cQuery += " 	 AND SD2.D2_LOJA = SA1.A1_LOJA" 			+ CRLF
 	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB1") +" SB1" 	+ CRLF
 	_cQuery += " 	  ON SD2.D2_COD = SB1.B1_COD" 				+ CRLF
 	_cQuery += " 	 INNER JOIN "+ RetSqlName("SB5") +" SB5" 	+ CRLF
 	_cQuery += " 	  ON SB1.B1_COD = SB5.B5_COD" 				+ CRLF 
	_cQuery += " 	 WHERE DAK.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB5.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND SB1.D_E_L_E_T_ = ' '  " 				+ CRLF
	_cQuery += " 	  AND DAI_FILIAL = '" + xFilial("DAI")+ "' "+ CRLF
	_cQuery += " 	  AND DAK.DAK_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' " + CRLF
	_cQuery += " 	  AND DAK.DAK_ACECAR  = '2' " + CRLF
	_cQuery += " 	  AND DAK.DAK_FEZNF = '1'  " + CRLF
	_cQuery += " 	  AND SA1.A1_XGCORP = '2'  " + CRLF
	_cQuery += " 	 AND SD2.D2_CF NOT IN " + FormatIn(cParDoacao + "," + cParOper + "," + cParTran , ",") + " " + CRLF
	_cQuery += " 	GROUP BY DAK_FILIAL,DAK_DATA,DAK_ACECAR " + CRLF
	_cQuery += " 	ORDER BY DAK_FILIAL, DAK_DATA  " + CRLF
	
	If Select("TRBOUT") > 0
		TRBOUT->(DbCloseArea())
	EndIf	            
	
	TcQuery _cQuery new Alias "TRBOUT"
		
	
	_nLinha := fPulaLinha()
	While !TRBOUT->(Eof())
		nX++
		aAdd(aItens,{" "," ", 0, 0, 0, 0, 0, 0, 0, 0} ) 
		aItens[nX][01] :=  TRBOUT->DAK_DATA
		aItens[nX][02] :=  dDataBase - SToD(TRBOUT->DAK_DATA)		
		aItens[nX][03]:=  TRBOUT->D2_QUANT
		aItens[nX][04]:=  TRBOUT->D2_TOTAL
		aItens[nX][05]:=  TRBOUT->DAI_PESO
		aItens[nX][06]:=  TRBOUT->DAI_CAPVOL
		TRBOUT->(DbSkip())	
	EndDo

	fImpItens(aItens)	
	
	MsgRun("Imprimindo Rodapé...", "Imprimindo Rodapé... ", {|| fGetRodape()})
	TRBOUT->(DbCloseArea())
Return 	
//------------------------------------------------------------
//Descrição: Função responsavel por retornar as quantidades 
//			 referente ao pedido de venda
//------------------------------------------------------------
*-------------------------------------------------*
Static Function fGetQuant(cEmissao, cCarreg, cInterior, lFezNf)
*-------------------------------------------------*
	Local aArea := GetArea()
	Local _nQuant := 0
	Default cInterior := ""
	Default lFezNf	:= .T.
	
	_cQuery := " SELECT SUM(SC6.C6_QTDVEN) QUANT, SUM(SC6.C6_VALOR) VALOR 
	_cQuery += " FROM " + RetSqlName("DAI") + " DAI" + CRLF
	_cQuery += " INNER JOIN " + RetSqlName("DAK") + " DAK" + CRLF
	_cQuery += " ON DAI.DAI_FILIAL = DAK.DAK_FILIAL" + CRLF
	_cQuery += " AND DAI.DAI_COD   = DAK.DAK_COD" + CRLF
	_cQuery += " AND DAI.DAI_SEQCAR= DAK.DAK_SEQCAR" + CRLF
	_cQuery += " AND DAI.DAI_DATA  = DAK.DAK_DATA" + CRLF
	_cQuery += " AND DAI.D_E_L_E_T_= DAK.D_E_L_E_T_" + CRLF
	_cQuery += " INNER JOIN " + RetSqlName("SC6") + " SC6" + CRLF
	_cQuery += " ON DAI.DAI_FILIAL  = SC6.C6_FILIAL" + CRLF
	_cQuery += " AND DAI.DAI_CLIENT = SC6.C6_CLI" + CRLF
	_cQuery += " AND DAI.DAI_LOJA   = SC6.C6_LOJA" + CRLF
	_cQuery += " AND DAI.DAI_PEDIDO   = SC6.C6_NUM" + CRLF
	If !Empty(cInterior)
		_cQuery += " INNER JOIN " + RetSqlName("DA8") + " DA8" + CRLF
		_cQuery += " ON DAK.DAK_ROTEIR = DA8.DA8_COD " + CRLF
	EndIf
	_cQuery += " WHERE DAI.D_E_L_E_T_ = ' '" + CRLF
	_cQuery += " AND DAI.DAI_DATA = '" + cEmissao + "'" + CRLF
	_cQuery += " AND DAK.DAK_ACECAR = '" + cCarreg + "'" + CRLF
	If !lFezNf
		_cQuery += " AND DAK.DAK_FEZNF = '2'" + CRLF
	EndIf
	If !Empty(cInterior)
		_cQuery += " AND DA8.DA8_XINTER = '"+ cInterior +"'" + CRLF
	EndIf
	
	If Select("TRBQUANT") > 0
		TRBQUANT->(DbCloseArea())
	EndIf	            
	
	TcQuery _cQuery new Alias "TRBQUANT"
	
	If !Eof()
		_nQuant := TRBQUANT->QUANT 
	EndIf
	
	TRBQUANT->(DbCloseArea())
	RestArea(aArea)
Return _nQuant
//------------------------------------------------------------
//Descrição: Função para imprimir os Totais 
//  		 Essa função recebe um array e imprime
//------------------------------------------------------------
*----------------------------------------------*
Static Function fImpTotais(aDados)
*----------------------------------------------*
	If Len(aDados) > 0
		BoxColor( _nLinha - 13, 0010 , _nLinha + 20, 0140, CLR_HGRAY)
		oPrint:Say( _nLinha + 10, 0050, "TOTAL", oFont16 )
		
		BoxColor( _nLinha - 13, 0140 , _nLinha + 20, 0180, CLR_HGRAY)
		oPrint:SayAlign( _nLinha ,0140, cValToChar(aDados[1]),oFont14n, 0040, 0020,, 2, 2 )
		
		BoxColor( _nLinha - 13, 0180 , _nLinha + 20, 0316, CLR_HGRAY)
		//oPrint:Say( _nLinha + 10, 0182, TransForm(aDados[2], "@E 999,999,999,999.99"), oFont14n )
		oPrint:SayAlign( _nLinha ,0180, Transform(aDados[2], "@E 999,999,999,999.99"),oFont14n, 0135, 0020,, 1, 2 )
		
		BoxColor( _nLinha - 13, 0316 , _nLinha + 20, 0453, CLR_HGRAY)
		oPrint:SayAlign( _nLinha ,0316, Transform(aDados[3], "@E 999,999,999,999.999"),oFont14n, 0135, 0020,, 1, 2 )
		
		BoxColor( _nLinha - 13, 0453 , _nLinha + 20, 0590, CLR_HGRAY)
		//oPrint:Say( _nLinha + 10, 0387, TransForm(aDados[4], "@E 999,999,999,999.99"), oFont14n )	
		oPrint:SayAlign( _nLinha ,0453, Transform(aDados[4], "@E 999,999,999,999.999"),oFont15n, 0135, 0020,, 1, 2 )
		
	/*	
		BoxColor( _nLinha - 13, 0484 , _nLinha + 20, 0524, CLR_HGRAY)
		oPrint:SayAlign( _nLinha ,0484, cValToChar(aDados[5]),oFont14n, 0040, 0020,, 2, 2 )
	
		BoxColor( _nLinha - 13, 0524 , _nLinha + 20, 0630, CLR_HGRAY)
		oPrint:SayAlign( _nLinha ,0524, Transform(aDados[6], "@E 999,999,999,999.99"),oFont14n, 0098, 0020,, 1, 2 )
		
		BoxColor( _nLinha - 13, 0630 , _nLinha + 20, 0729, CLR_HGRAY)
		//oPrint:Say( _nLinha + 10, 0632, TransForm(aDados[7], "@E 999,999,999,999.99"), oFont14n )
		oPrint:SayAlign( _nLinha ,0630, Transform(aDados[7], "@E 999,999,999,999.99"),oFont14n, 0098, 0020,, 1, 2 )
		
		//oPrint:Box( _nLinha - 13, 0729 , _nLinha + 20, 0830)//Volumes
		BoxColor( _nLinha - 13, 0729 , _nLinha + 20, 0830, CLR_HGRAY)
		oPrint:SayAlign( _nLinha ,0729, Transform(aDados[8], "@E 999,999,999,999.99"),oFont14n, 0100, 0020,, 1, 2 )
		*/
	EndIf	
Return
//------------------------------------------------------------
//Descrição: Função Impressão dos itens 
//  		 Essa função recebe como parametro os itens e imprime
//------------------------------------------------------------
*--------------------------------------*
Static Function fImpItens(aItens)
*--------------------------------------*
	Local nQtdCar	 	:= 00
	Local nTotValCar 	:= 00
	Local nTotPesCar 	:= 00
	Local nTotVolCar	:= 00			
	Local nQtdnCar		:= 00
	Local nTotValnCar	:= 00
	Local nTotPesnCar	:= 00
	Local nTotVolnCar	:= 00
	Local nX			:= 00
	
	Default aItens := {" "," ", 0, 0, 0, 0, 0, 0, 0, 0}
	
	For nX := 01 To Len(aItens)
		
		If aItens[nX][3] > 0 .Or. aItens[nX][7] > 0// Quant entregue .Or. Quant não entregue 
		
		oPrint:Box( _nLinha - 13 , 0010 , _nLinha + 17, 0070) 
		//oPrint:Say( _nLinha, 0012, DToC(SToD(aItens[nX][1])), oFont13n )
		oPrint:SayAlign( _nLinha - 13 , 0010,DToC(SToD(aItens[nX][1])),oFont14n, 0059, 0017,, 2, 2 )
		
		oPrint:Box( _nLinha - 13, 0070 , _nLinha + 17, 0140) 
		//oPrint:Say( _nLinha, 0095, cValToChar(aItens[nX][2]), oFont13n )
		oPrint:SayAlign( _nLinha - 13 ,0070,cValToChar(aItens[nX][2]),oFont15n, 0069, 0017,, 2, 2 )
		
		oPrint:Box( _nLinha - 13, 0140 , _nLinha + 17, 0180)//Quant 
		//oPrint:Say( _nLinha, 0142, cValToChar(aItens[nX][3]), oFont13n )
		oPrint:SayAlign( _nLinha - 13 ,0140,cValToChar(aItens[nX][3]),oFont15n, 0039, 0017,, 2, 2 )
		
		oPrint:Box( _nLinha - 13, 0180 , _nLinha + 17, 0316)//Vl Notas
		//oPrint:Say( _nLinha , 0182, TransForm(Round(aItens[nX][4], 02), "@E 999,999,999,999.99"), oFont13n )
		oPrint:SayAlign( _nLinha - 13 ,0180,TransForm(Round(aItens[nX][4], 02), "@E 999,999,999,999.99"),oFont15n, 0135, 0017,, 1, 2 )
		
		oPrint:Box( _nLinha - 13, 0316 , _nLinha + 17, 0453)//Peso
		//oPrint:Say( _nLinha , 0288, TransForm(Round(aItens[nX][5], 02), "@E 999,999,999,999.99"), oFont13n )
		oPrint:SayAlign( _nLinha - 13 ,0316,TransForm(Round(aItens[nX][5], 02), "@E 999,999,999,999.999"),oFont15n, 0135, 0017,, 1, 2 )
		
		oPrint:Box( _nLinha - 13, 0453 , _nLinha + 17, 0590)//Volumes
		//oPrint:Say( _nLinha, 0387, TransForm(aItens[nX][6], "@E 999,999,999,999.99"), oFont13n )
		oPrint:SayAlign( _nLinha - 13,0453,TransForm(Round(aItens[nX][6], 02), "@E 999,999,999.999"),oFont15n, 0135, 0017,, 1, 2 )
	
	
		
		/*
		oPrint:Box( _nLinha - 13, 0484 , _nLinha + 17, 0524)//Quant
		//oPrint:Say( _nLinha , 0486, cValToChar(Round(aItens[nX][7], 02)), oFont13n )
		oPrint:SayAlign( _nLinha - 13,0484, cValToChar(aItens[nX][7]),oFont13n, 0039, 0017,, 2, 1 )	
		
		oPrint:Box( _nLinha - 13, 0524 , _nLinha + 17, 0630)//Vl Notas 98
		//oPrint:Say( _nLinha , 0526, TransForm(Round(aItens[nX][8], 02), "@E 999,999,999,999.99"), oFont13n )
		oPrint:SayAlign( _nLinha - 13,0524,TransForm(Round(aItens[nX][8], 02), "@E 999,999,999,999.99"),oFont13n, 0105, 0017,, 1, 2 )
		
		oPrint:Box( _nLinha - 13, 0630 , _nLinha + 17, 0729)//Peso
		//oPrint:Say( _nLinha , 0632, TransForm(Round(aItens[nX][9], 02), "@E 999,999,999,999.99"), oFont13n )
		oPrint:SayAlign( _nLinha - 13, 0630,TransForm(Round(aItens[nX][9], 02), "@E 999,999,999,999.99"),oFont13n, 0098, 0017,, 1, 2 )
		
		oPrint:Box( _nLinha - 13, 0729 , _nLinha + 17, 0830)//Volumes
		//oPrint:Say( _nLinha, 0731, TransForm(aItens[nX][10], "@E 999,999,999,999.99"), oFont13n )
		oPrint:SayAlign( _nLinha - 13,0729,TransForm(Round(aItens[nX][10], 02), "@E 999,999,999,999.99"),oFont13n, 0100, 0017,, 1, 2 )
		
		*/
		nQtdCar	 	+= aItens[nX][03]
		nTotValCar 	+= aItens[nX][04]
		nTotPesCar 	+= aItens[nX][05]
		nTotVolCar	+= aItens[nX][06]	
		/*		
		nQtdnCar	+= aItens[nX][07]
		nTotValnCar	+= aItens[nX][08]
		nTotPesnCar	+= aItens[nX][09]
		nTotVolnCar	+= aItens[nX][10]
		*/
		_nLinha := fPulaLinha()	
		EndIf
	Next nX		
	aTotais := {nQtdCar,nTotValCar,nTotPesCar,nTotVolCar,nQtdnCar,nTotValnCar,nTotPesnCar,nTotVolnCar}
	fImpTotais(aTotais)
Return
*-------------------------------------------------------------------*
Static Function BoxColor(nPos1, nPos2, nPos3, nPos4, cColor )
*-------------------------------------------------------------------*
oBrush1 := TBrush():New2( , CLR_BLACK)   
oBrush2 := TBrush():New2( , cColor )           

oPrint:fillRect( { nPos1, nPos2, nPos3, nPos4 }, oBrush1 )   
oPrint:fillRect( { nPos1 + 1, nPos2 + 1, nPos3 - 1, nPos4 - 1 }, oBrush2, "-1")   

oBrush1:End()
oBrush2:End()

Return
