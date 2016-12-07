#Include 'Protheus.ch'

/*/{Protheus.doc} xPIRA00
Rotina de Exemplo para importação de arquivo CSV
@type user function
@author atila
@since 07/12/2016
@version 1.0
@return ${return}, ${return_description}
@example
/*/

User Function xPIRA00()
	Local aArea := GetArea()
	Local cExtens	:= "Arquivo CSV ( *.CSV ) |*.CSV|"
	Local cFile 	:= cGetFile( cExtens, 'Selecione arquivo' , 0 ,  'C:\Importar\' , .T. , GETF_LOCALHARD, , .F. )
	Local lRet := .T.
	Local oProcess
	Local aDados := {}
	Private count := 0
	Private aCab := {}
	If !(empty(cFile))
		If File(cFile)
			oProcess := MsNewProcess():New({|lEnd| LerArq(cFile, lRet, @lEnd, @oProcess, @aDados)}, "Importação de Contas...", "Lendo Arquivo CSV", .T. )
			oProcess:Activate()
		Else
			MsgStop("Arquivo não encontrado")
		EndIf
	EndIf
	RestArea(aArea)
return




Static Function LerArq(cArquivo, lRet, lEnd, oProcess, aDados)
	FT_FUSE(cArquivo)
	oProcess:SetRegua1( 0 )
	oProcess:SetRegua2( 0 )
	FT_FGOTOP()
	oProcess:IncRegua1("Processando arquivo e inserindo linhas..." )
	While !FT_FEOF()
		If lEnd	//houve cancelamento do processo
			Exit
		EndIf
		
		//inicia a inserção no banco depois de processar mais de 1000 linhas 
		If Len(aDados) % 10000 == 0 .And. Len(aDados) > 0
			InserDB(@aDados , @oProcess)
		EndIf
		
		cLinha := FT_FREADLN()
		
		If count == 0
			monCbCH( Separa(cLinha, ";") )
		Else
			AADD( aDados, Separa(cLinha, ";") )
		EndIf
		oProcess:IncRegua2("Processando linhas..." + cValToChar( count )  )
		FT_FSKIP()
		count++
	EndDo
	oProcess:IncRegua1("Finalizando Leitura do arquivo:" + cValToChar( count ) )
	MsgInfo("Importação Finalizada com sucesso!!!", "Informação!")
return lRet


Static function monCbCH(aCab)

return


Static function InserDB(aDados, oProcess)
	Local i := 0
	 //Exclusão deve ter o registro SE1 posicionado
	For i := 1 To Len(aDados)
		aArray := { { "E1_FILIAL"   , xFilial('SE1'), NIL },;
			{ "E1_HIST"     , cValtoChar(aDados[i,2]), NIL },;
			{ "E1_NUM"      , cValtoChar(aDados[i,3]), NIL },;
			{ "E1_TIPO"     , cValtoChar(aDados[i,4]), NIL },;
			{ "E1_NATUREZ"  , cValtoChar(aDados[i,5]), NIL },;
			{ "E1_CLIENTE"  , cValtoChar(aDados[i,6]), NIL },;
			{ "E1_LOJA"  	, "01", NIL },;
			{ "E1_EMISSAO"  , StoD(aDados[i,8]), NIL },;
			{ "E1_VENCTO"   , StoD(aDados[i,9]), NIL },;
			{ "E1_VENCREA"  , StoD(aDados[i,10]), NIL },;
			{ "E1_VALOR"    , Val(StrTran(aDados[i,11],"," , ".")), NIL },;
			{ "E1_VENCORI"  , StoD(aDados[i,12]), NIL },;
			{ "E1_VLCRUZ"  	, VAL(StrTran(aDados[i,13], "," , ".") ), NIL },;
			{ "E1_STATUS"   , cValtoChar(aDados[i,14]), NIL },;
			{ "E1_FLUXO"  	, cValtoChar(aDados[i,15]), NIL },;
			{ "E1_CREDIT"   , cValtoChar(aDados[i,16]), NIL } }
		oProcess:IncRegua2("Inserindo registro no banco:" + cValToChar( count ) )
				GerarMyCR(aArray)
	Next
	aDados := {}
return



Static Function GerarMyCR(aArray)
	Private lMsErroAuto := .F.
	MsExecAuto( { |x,y| FINA040(x,y)} , aArray, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
	If lMsErroAuto
		mostraerro()
	EndIf
return

