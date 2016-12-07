///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Oficina.prw          | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_Oficina()                                            |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Esta funcao funciona como funciona o objeto tButton executado   |//
//|           | dentro de um for/next, aqui eh demonstrado tambem a utilizazao  |//
//|           | para coordenadas sem varias compilacoes.                        |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////

#INCLUDE "PROTHEUS.CH"
#DEFINE ENTER Chr(10)+Chr(13)

USER FUNCTION OFICINA()

LOCAL cCaption := "Oficina de Programação"
LOCAL aBotao   := {}
LOCAL oDlg     := NIL
LOCAL cAction  := ""
LOCAL bAction  := NIL
LOCAL nLin     := 0
LOCAL nCol     := 0
LOCAL i        := 0
LOCAL j        := 0
LOCAL y        := 1
LOCAL oMainWnd := NIL
LOCAL oBmp     := NIL
LOCAL cCoord   := ""
LOCAL aX       := {}
LOCAL cMvPar   := "MV_OFICINA"
LOCAL cDesc    := "NAO UTILE ESTE PARAMETRO, ESTE E P/ OS FONTES DO OFICINA DE PROGRAMACAO"
LOCAL cCnt     := "040,003,005,027,047,045,026,380,760"
LOCAL cMsg     := "Opção não disponivel"

If !ExisteSX6(cMvPar)
   CriarSX6(cMvPar,"C",cDesc,cCnt)
Endif

cCoord := GetMv( cMvPar )

While !Empty(cCoord)
   aAdd(aX,Val(SubStr(cCoord,1,3)))
   cCoord := SubStr(cCoord,5)
End

aAdd(aBotao,{"Alertas"                        , "u_Alertas()"     })
aAdd(aBotao,{"MsDialog"+ENTER+ "Objetos"      , "u_DialogObj()"   })
aAdd(aBotao,{"MsDialog"+ENTER+ "Move"         , "u_DialogMov()"   })
aAdd(aBotao,{"ListBox" +ENTER+ "Simples"      , "u_List_Box()"    })
aAdd(aBotao,{"ListBox" +ENTER+ "Semáforo"     , "u_ListBoxSem()"  })
aAdd(aBotao,{"ListBox" +ENTER+ "Mark"         , "u_ListBoxMar()"  })
aAdd(aBotao,{"ListBox" +ENTER+ "Duplo Click"  , "u_ListBoxDup()"  })
aAdd(aBotao,{"ListBox" +ENTER+ "Change"       , "u_ListBoxCha()"  })
aAdd(aBotao,{"ListBox" +ENTER+ "Items"        , "u_ListBoxIte()"  })
aAdd(aBotao,{"ListBox" +ENTER+ "Click Direito", "u_LBoxDir()"     })
aAdd(aBotao,{"RptStatus"                      , "u_GRptStatus()"  })
aAdd(aBotao,{"Processa"                       , "u_GProces1()"    })
aAdd(aBotao,{"Processa 2"                     , "u_GProces2()"    })
aAdd(aBotao,{"MsAguarde"                      , "u_GMsAguarde()"  })
aAdd(aBotao,{"MsgRun"                         , "u_GMsgRun()"     })
aAdd(aBotao,{"ScrollBox"                      , "u_Scroll()"      })
aAdd(aBotao,{"Lê arq. txt"                    , "u_LeArqTxt()"    })
aAdd(aBotao,{"Geração Log"                    , "u_Log()"         })
aAdd(aBotao,{"mBrowse"+ENTER+"Ax´s"           , "u_mBrowsAx()"    })
aAdd(aBotao,{"MarkBrowse"                     , "u_MarkBrw()"     })
aAdd(aBotao,{"GetDados"                       , "u_Get_Dados()"   })
aAdd(aBotao,{"Pai"+ENTER+"Filho"              , "u_Pai_Filho()"   })
aAdd(aBotao,{"Relatório"+ENTER+"DBF"          , "u_Rel_DBF()"     })
aAdd(aBotao,{"Relatório"+ENTER+"SQL"          , "u_Rel_SQL()"     })
aAdd(aBotao,{"TMSPrinter"                     , "u_TMS_Printer()" })
aAdd(aBotao,{"New Print"                      , "u_NewPrint()"    })
aAdd(aBotao,{"Protheus"+ENTER+"Ms-Word"       , "u_Ap_Word()"     })
aAdd(aBotao,{"Rotinas"+ENTER+"Autómaticas"    , "u_Rot_Auto()"    })
aAdd(aBotao,{"e-Mail"                         , "u_e_Mail()"      })
aAdd(aBotao,{"My"+ENTER+"EnchoiceBar"         , "u_MyBar()"       })
aAdd(aBotao,{"Wizard"                         , "u_Wizard()"      })
aAdd(aBotao,{"Parambox"                       , "u_xParambox()"   })
aAdd(aBotao,{"Tree"                           , "u_Trees()"       })
aAdd(aBotao,{"Timer"                          , "u_Timer()"       })
aAdd(aBotao,{"WndBrowse"                      , "u_xWndBrowse()"  })
aAdd(aBotao,{"TwBrowse"                       , "u_xTwBrowse()"   })
aAdd(aBotao,{"MsExplorer"                     , "u_xMsExplorer()" })
aAdd(aBotao,{"Protheus"+ENTER+"HTML"          , "u_xHTMLAdvPL()"  })
aAdd(aBotao,{"Disponivel 1"                   , "Alert('Disp.1')" })
aAdd(aBotao,{"Disponivel 2"                   , "Alert('Disp.2')" })

DEFINE MSDIALOG oDlg FROM 0,0 TO aX[8],aX[9] TITLE cCaption Of oMainWnd PIXEL STYLE DS_MODALFRAME STATUS
oDlg:lEscClose := .F.

@ 0,0 BITMAP oBmp RESNAME "FAIXASUPERIOR" OF oDlg SIZE 1200,50 NOBORDER ADJUST PIXEL
oBmp:Align := CONTROL_ALIGN_TOP

nLin := aX[1] //linha inicial para o botao na vertical
nCol := aX[2] //coluna inicial para o botao na horizontal

For j:=1 To (Len(aBotao)/aX[3]) //para j=1 faca ate a qtde. de botoes dividido por 5 botoes na vertical
   For i:=1 To aX[3]            //para i=1 faca ate 5 botoes na vertical
      cAction := "{|| "+aBotao[y,2]+"}"
      bAction := &cAction
      TButton():New(nLin,nCol,aBotao[y,1],oDlg,bAction,aX[6],aX[7],,,.F.,.T.,.F.,,.F.,,,.F.)
      nLin += aX[4] //na vertical este eh o espaco entre um botao e outro
      y++
   Next i
   nCol += aX[5] //na horizontal este eh o espaco entre um botao e outro
   nLin := aX[1] //linha inicial para o botao na vertical
Next j

TButton():New(175,aX[2],"&Sair",oDlg,{|| oDlg:End()},nCol-5,15,,,.F.,.T.,.F.,,.F.,,,.F.)

ACTIVATE MSDIALOG oDlg CENTERED

RETURN