#Include 'Protheus.ch'

/*/{Protheus.doc} ${function_method_class_name}
Leitura de Arquivo utilizando Processa
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

//U_xPIRA01()
User Function xPIRA001()
Local cExtens	:= "Arquivo CSV ( *.CSV ) |*.CSV|"
Local cFile 	:= cGetFile( cExtens, 'Selecione arquivo' , 0 ,  'C:\Importar\' , .T. , GETF_LOCALHARD, , .F. )
Local lRet := .T.

If !(empty(cFile))
	If File(cFile)
		Processa({|| LerArq(cFile, lRet)}, "Lendo Arquivo...")
		Else
			MsgStop("Arquivo não encontrado")
	EndIf
EndIf
return

Static Function LerArq(cArquivo, lRet)

Local aDados  := {}
FT_FUSE(cArquivo)
ProcRegua(FT_FLASTREC())
FT_FGOTOP()

While !FT_FEOF()
 	cLinha := FT_FREADLN()
 	 AADD(aDados, Separa(cLinha, ";") )
 	 IncProc( "Processando : " + cValToChar( Len(aDados) ) )
	FT_FSKIP()
EndDo

MsgInfo("Importação Finalizada com sucesso!!!", "Informação!")
return lRet
