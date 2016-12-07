#include "Protheus.ch"

User Function Trees()                                 
Local cBmp1 := "PMSEDT3" //"PMSDOC"  //"FOLDER5" //"PMSMAIS"  //"SHORTCUTPLUS"
Local cBmp2 := "PMSDOC" //"PMSEDT3" //"FOLDER6" //"PMSMENOS" //"SHORTCUTMINUS"
Private cCadastro := "Modelo Tree"
Private oDlg
Private oTree1

DEFINE MSDIALOG oDlg TITLE cCadastro FROM 0,0 TO 240,500 PIXEL

   //DbTree():New(<nTop>, <nLeft>, <nBottom>, <nRight>, <oWnd>,<{uChange}>, <{uRClick}>, <.lCargo.>, <.lDisable.> )
   oTree1 := dbTree():New(10,10,95,240,oDlg,{|| U_ProcTrees(oTree1:GetCargo())},,.T.)
   
		//<oTree>:AddTree( <cLabel>, <.lOpen.>, <cResOpen>, <cResClose>, <cBmpOpen>, <cBmpClose>, <cCargo> )
		oTree1:AddTree("Caneta"+Space(24),.T.,cBmp1,cBmp1,,,"1.0")
	
			//<oTree>:AddTreeItem( <cLabel>, <cResOpen>, <cBmpOpen>, <cCargo>)
			oTree1:AddTreeItem("Tampa Dianteira",cBmp2,,"1.1")
			oTree1:AddTreeItem("Tampa Traseira"	,cBmp2,,"1.2")
			oTree1:AddTreeItem("Corpo"				,cBmp2,,"1.3")
			oTree1:AddTreeItem("Embalagem"		,cBmp2,,"1.4")
			oTree1:AddTreeItem("MOD1"				,cBmp2,,"1.5")
		oTree1:AddTree("Carga",.T.,cBmp1,cBmp1,,,"2.0")
			oTree1:AddTreeItem("Bico"				,cBmp2,,"2.1")
			oTree1:AddTreeItem("Tubo"				,cBmp2,,"2.2")
			oTree1:AddTreeItem("Tinta"				,cBmp2,,"2.3")
			oTree1:AddTreeItem("MOD2"				,cBmp2,,"2.4")
		oTree1:EndTree()
	oTree1:EndTree() 	

DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTER

Return           


User Function ProcTrees(cCargo)
Local cRet := ""

If     cCargo == "1.1" ; MsgInfo("Tampa dianteira",cCadastro)
Elseif cCargo == "1.2" ; MsgInfo("Tampa traseira",cCadastro)
Elseif cCargo == "1.3" ; MsgInfo("Corpo",cCadastro)
Elseif cCargo == "1.4" ; MsgInfo("Embalagem",cCadastro)
Elseif cCargo == "1.5" ; MsgInfo("MOD1",cCadastro)
Elseif cCargo == "2.1" ; MsgInfo("Bico",cCadastro)
Elseif cCargo == "2.2" ; MsgInfo("Tubo",cCadastro)
Elseif cCargo == "2.3" ; MsgInfo("Tinta",cCadastro)
Elseif cCargo == "2.4" ; MsgInfo("MOD2",cCadastro)
Endif
		
Return