///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Log.prw              | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_Log()                                                |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Programa exemplo para tela de log´s...                          |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
USER FUNCTION Log()
LOCAL cFileLog := ""
LOCAL cPath := ""

AutoGrLog("INICIANDO O LOG")
AutoGrLog("---------------")
AutoGrLog("DATABASE...........: "+Dtoc(dDataBase))
AutoGrLog("DATA...............: "+Dtoc(MsDate()))
AutoGrLog("HORA...............: "+Time())
AutoGrLog("ENVIRONMENT........: "+GetEnvServer())
AutoGrLog("PATCH..............: "+GetSrvProfString("Startpath",""))
AutoGrLog("ROOT...............: "+GetSrvProfString("SourcePath",""))
AutoGrLog("VERSÃO.............: "+GetVersao())
AutoGrLog("MÓDULO.............: "+"SIGA"+cModulo)
AutoGrLog("EMPRESA / FILIAL...: "+SM0->M0_CODIGO+"/"+SM0->M0_CODFIL)
AutoGrLog("NOME EMPRESA.......: "+Capital(Trim(SM0->M0_NOME)))
AutoGrLog("NOME FILIAL........: "+Capital(Trim(SM0->M0_FILIAL)))
AutoGrLog("USUÁRIO............: "+SubStr(cUsuario,7,15))

cFileLog := NomeAutoLog()

If cFileLog <> ""
   MostraErro(cPath,cFileLog)
Endif

RETURN