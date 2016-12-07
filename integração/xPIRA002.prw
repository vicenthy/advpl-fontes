#Include 'Protheus.ch'


/*/{Protheus.doc} ${function_method_class_name}
Leitura de arquivo utilizando MSnewProcess
@type
@author atila
@since 07/12/2016
@version 1.0
@param ${param}, ${param_type}, ${param_descr}
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
/*/
//U_xPIRA02()
User Function xPIRA002()
	Local cExtens	:= "Arquivo CSV ( *.CSV ) |*.CSV|"
	Local cFile 	:= cGetFile( cExtens, 'Selecione arquivo' , 0 ,  'C:\Importar\' , .T. , GETF_LOCALHARD, , .F. )
	Local lRet := .T.
	Local oProcess

	If !(empty(cFile))
		If File(cFile)
			oProcess := MsNewProcess():New({|lEnd| LerArq(cFile, lRet, @lEnd, @oProcess)}, "Importação de Contas...", "Lendo Arquivo CSV", .T. )
			oProcess:Activate()
			//Processa({|| LerArq(cFile, lRet)}, "Lendo Arquivo...")
		Else
			MsgStop("Arquivo não encontrado")
		EndIf
	EndIf
return

Static Function LerArq(cArquivo, lRet, lEnd, oProcess)
	Local aDados  := {}
	FT_FUSE(cArquivo)
	oProcess:SetRegua1( FT_FLASTREC() )
	oProcess:SetRegua2( FT_FLASTREC() )
	FT_FGOTOP()
	oProcess:IncRegua1("Processando arquivo e inserindo linhas..." )
	While !FT_FEOF()
		If lEnd	//houve cancelamento do processo
			Exit
		EndIf
		cLinha := FT_FREADLN()
		AADD(aDados, Separa(cLinha, ";") )
		oProcess:IncRegua2("Processando arquivo: " + cValToChar( Len(aDados) ) )
		FT_FSKIP()
	EndDo

	MsgInfo("Importação Finalizada com sucesso!!!", "Informação!")
return lRet
