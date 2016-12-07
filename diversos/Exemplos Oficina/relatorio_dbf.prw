///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Relatorio_DBF.prw    | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_Rel_DBF()                                            |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao que demonstra a criacao de relatorio com a utilizacao    |//
//|           | das funcoes padroes                                             |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////

/*Lay-Out do Relatorio -> DBF
---------------------------------------------------------------------------------------------------------------------------------
| PREFIXO | TITULO | PARCELA | TIP | EMISSAO | VENCTO | VENCTO REAL |     VLR. ORIGINAL |              PAGO |             SALDO |
---------------------------------------------------------------------------------------------------------------------------------
| Cod/Loj/Nome: 999999-99 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                                                        |
|   UNI   | 999999 |    A    | NFX |99/999/99|99/99/99|   99/99/99  | 99,999,999,999.99 | 99,999,999,999.99 | 99,999,999,999.99 |
|   UNI   | 999999 |    A    | NFX |99/999/99|99/99/99|   99/99/99  | 99,999,999,999.99 | 99,999,999,999.99 | 99,999,999,999.99 |
|   UNI   | 999999 |    A    | NFX |99/999/99|99/99/99|   99/99/99  | 99,999,999,999.99 | 99,999,999,999.99 | 99,999,999,999.99 |
---------------------------------------------------------------------------------------------------------------------------------
| TOTAL.....
---------------------------------------------------------------------------------------------------------------------------------
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
          1         2         3         4         5         6         7         8         9        10        11        12
*/

User Function Rel_DBF()

//+-------------------------------------------------------------------------------
//| Declaracoes de variaveis
//+-------------------------------------------------------------------------------

Local cDesc1  := "Este relatorio ira imprimir informacoes do contas a pagar conforme"         
Local cDesc2  := "parametros informado pelo usuario"                      
Local cDesc3  := "Sera gerado um arquivo em \RELATO\REL_DBF????.XLS, onde ???? e o usuario."

Private cString  := "SE2"
Private Tamanho  := "M"
Private aReturn  := { "Zebrado",2,"Administracao",2,2,1,"",1 }
Private wnrel    := "RELDBF"
Private NomeProg := "RELDBF"
Private nLastKey := 0
Private Limite   := 132
Private Titulo   := "Titulo a Pagar - Ordem de "
Private cPerg    := "RELDBF"
Private nTipo    := 0
Private cbCont   := 0
Private cbTxt    := "registro(s) lido(s)"
Private Li       := 80
Private m_pag    := 1
Private aOrd     := {}
Private Cabec1   := "  PREFIXO   TITULO   PARCELA   TIP   EMISSAO   VENCTO   VENCTO REAL       VLR. ORIGINAL                PAGO               SALDO  "
Private Cabec2   := ""

/*+----------------------
  | Parametros do aReturn 
  +----------------------
aReturn - Preenchido pelo SetPrint()
aReturn[1] - Reservado para formulario
aReturn[2] - Reservado para numero de vias
aReturn[3] - Destinatario
aReturn[4] - Formato 1=Paisagem 2=Retrato
aReturn[5] - Midia 1-Disco 2=Impressora
aReturn[6] - Prota ou arquivo 1-Lpt1... 4-Com1...
aReturn[7] - Expressao do filtro
aReturn[8] - Ordem a ser selecionada
aReturn[9] [10] [n] - Campos a processar se houver
*/

aAdd( aOrd, "Fornecedor"   )
aAdd( aOrd, "Titulo"       )
aAdd( aOrd, "Emissão"      )
aAdd( aOrd, "Vencimento"   )
aAdd( aOrd, "Vencto. Real" )

//Parametros de perguntas para o relatorio
//+-------------------------------------------------------------+
//| mv_par01 - Fornecedor de      ? 999999                      |
//| mv_par02 - Fornecedor ate     ? 999999                      |
//| mv_par03 - Tipo de            ? XXX                         |
//| mv_par04 - Tipo ate           ? XXX                         |
//| mv_par05 - Vencimento de      ? 99/99/99                    |
//| mv_par06 - Vencimento ate     ? 99/99/99                    |
//| mv_par07 - Aglut.Fornecedor   ? Sim/Nao                     |
//+-------------------------------------------------------------+
CriaSx1()

//+-------------------------------------------------------------------------------
//| Disponibiliza para usuario digitar os parametros
//+-------------------------------------------------------------------------------
Pergunte(cPerg,.F.)

//+-------------------------------------------------------------------------------
//| Solicita ao usuario a parametrizacao do relatorio.
//+-------------------------------------------------------------------------------
wnrel := SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,.F.,.F.)
//SetPrint(cAlias,cNome,cPerg,cDesc,cCnt1,cCnt2,cCnt3,lDic,aOrd,lCompres,;
//cSize,aFilter,lFiltro,lCrystal,cNameDrv,lNoAsk,lServer,cPortToPrint)

//+-------------------------------------------------------------------------------
//| Se teclar ESC, sair
//+-------------------------------------------------------------------------------
If nLastKey == 27
   Return
Endif

//+-------------------------------------------------------------------------------
//| Estabelece os padroes para impressao, conforme escolha do usuario
//+-------------------------------------------------------------------------------
SetDefault(aReturn,cString)

//+-------------------------------------------------------------------------------
//| Verificar se sera reduzido ou normal
//+-------------------------------------------------------------------------------
nTipo := Iif(aReturn[4] == 1, 15, 18)

//+-------------------------------------------------------------------------------
//| Se teclar ESC, sair
//+-------------------------------------------------------------------------------
If nLastKey == 27
   Return
Endif

//+-------------------------------------------------------------------------------
//| Chama funcao que processa os dados
//+-------------------------------------------------------------------------------
RptStatus({|lEnd| RelDbfImp(@lEnd, wnrel, cString) }, "Aguarde...", "Processando registros...", .T. )

Return

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Relatorio_DBF.prw    | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - RelDbfImp()                                            |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao de impressao                                             |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
Static Function RelDbfImp(lEnd,wnrel,cString)
Local cFilSE2   := xFilial(cString)
Local nIndice   := 0
Local cArqSE2   := ""
Local cIndice   := ""
Local cFiltro   := ""
Local aCol      := {}
Local cFornec   := ""
Local nValor    := 0
Local nPago     := 0
Local nSaldo    := 0
Local nT_Valor  := 0
Local nT_Pago   := 0
Local nT_Saldo  := 0
Local cArqExcel := ""

//+-----------------------
//| Cria filtro temporario
//+-----------------------
cFiltro := "E2_FILIAL == '"+cFilSE2+"' "
cFiltro += ".And. E2_FORNECE >= '"+mv_par01+"' "
cFiltro += ".And. E2_FORNECE <= '"+mv_par02+"' "
cFiltro += ".And. E2_TIPO >= '"+mv_par03+"' "
cFiltro += ".And. E2_TIPO <= '"+mv_par04+"' "
cFiltro += ".And. Dtos(E2_VENCTO) >= '"+Dtos(mv_par05)+"' "
cFiltro += ".And. Dtos(E2_VENCTO) <= '"+Dtos(mv_par06)+"' "

//+-----------------------
//| Cria indice temporario
//+-----------------------
If aReturn[8] == 1            //Fornecedor
   cIndice := "E2_FORNECE+E2_LOJA+E2_NUM"
Elseif aReturn[8] == 2        //Titulo
   cIndice := "E2_NUM+E2_FORNECE+E2_LOJA"
Elseif aReturn[8] == 3        //Emissao
   cIndice := "Dtos(E2_EMISSAO)+E2_FORNECE+E2_LOJA"
Elseif aReturn[8] == 4        //Vencimento
   cIndice := "Dtos(E2_VENCTO)+E2_FORNECE+E2_LOJA"
Elseif aReturn[8] == 5        //Vencimento Real
   cIndice := "Dtos(E2_VENCREA)+E2_FORNECE+E2_LOJA"
Endif

Titulo += aOrd[aReturn[8]]

//+-----------------------------------
//| Cria um nome de arquivo temporario
//+-----------------------------------
cArqSE2 := CriaTrab(Nil,.F.)

//+--------------------------------
//| Cria indice e filtro temporario
//+--------------------------------
dbSelectArea(cString)
IndRegua(cString,cArqSE2,cIndice,,cFiltro)
nIndice := RetIndex()
nIndice := nIndice + 1

dbSelectArea(cString)
#IFNDEF TOP
   dbSetIndex(cArqSE2+OrdBagExt())
#ENDIF
dbSetOrder(nIndice)
dbGoTop()
SetRegua( RecCount() )

//+--------------------
//| Coluna de impressao
//+--------------------
aAdd( aCol, 004 ) //Prefixo
aAdd( aCol, 012 ) //Titulo
aAdd( aCol, 024 ) //Parcela
aAdd( aCol, 031 ) //Tipo
aAdd( aCol, 036 ) //Emissao
aAdd( aCol, 046 ) //Vencimento
aAdd( aCol, 058 ) //Vencimento Real
aAdd( aCol, 070 ) //Valor Original
aAdd( aCol, 090 ) //Pago
aAdd( aCol, 110 ) //Saldo

cFornec := SE2->E2_FORNECE+SE2->E2_LOJA

While !Eof() .And. !lEnd
   
   If Li > 55
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif
   
   @ Li, aCol[1] PSay "Cod/Loj/Nome: "+SE2->E2_FORNECE+"-"+SE2->E2_LOJA+" "+SE2->E2_NOMFOR
   Li ++
   
   While !Eof() .And. !lEnd .And. SE2->E2_FORNECE+SE2->E2_LOJA == cFornec
   
      IncRegua()
      
      If Li > 55
         Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      Endif
   
      If mv_par07 == 2
         @ Li, aCol[1]  PSay SE2->E2_PREFIXO
         @ Li, aCol[2]  PSay SE2->E2_NUM
         @ Li, aCol[3]  PSay SE2->E2_PARCELA
         @ Li, aCol[4]  PSay SE2->E2_TIPO
         @ Li, aCol[5]  PSay SE2->E2_EMISSAO
         @ Li, aCol[6]  PSay SE2->E2_VENCTO
         @ Li, aCol[7]  PSay SE2->E2_VENCREA
         @ Li, aCol[8]  PSay SE2->E2_VALOR               PICTURE "@E 99,999,999,999.99"
         @ Li, aCol[9]  PSay SE2->E2_VALOR-SE2->E2_SALDO PICTURE "@E 99,999,999,999.99"
         @ Li, aCol[10] PSay SE2->E2_SALDO               PICTURE "@E 99,999,999,999.99"
         Li ++
      Endif
      
      nValor += SE2->E2_VALOR
      nPago  += (SE2->E2_VALOR-SE2->E2_SALDO)
      nSaldo += SE2->E2_SALDO
   
      nT_Valor += SE2->E2_VALOR
      nT_Pago  += (SE2->E2_VALOR-SE2->E2_SALDO)
      nT_Saldo += SE2->E2_SALDO

      dbSkip()
   End
   
   @ Li, 000 PSay Replicate("-",Limite)
   Li ++
   @ Li, aCol[1]  PSay "TOTAL....."
   @ Li, aCol[8]  PSay nValor PICTURE "@E 99,999,999,999.99"
   @ Li, aCol[9]  PSay nPago  PICTURE "@E 99,999,999,999.99"
   @ Li, aCol[10] PSay nSaldo PICTURE "@E 99,999,999,999.99"
   Li +=2
   
   cFornec := SE2->E2_FORNECE+SE2->E2_LOJA
   nValor  := 0
   nPago   := 0
   nSaldo  := 0
      
End

If lEnd
   @ Li, aCol[1] PSay cCancel
   Return
Endif

@ Li, 000 PSay Replicate("=",Limite)
Li ++
@ Li, aCol[1]  PSay "TOTAL GERAL....."
@ Li, aCol[8]  PSay nT_Valor PICTURE "@E 99,999,999,999.99"
@ Li, aCol[9]  PSay nT_Pago  PICTURE "@E 99,999,999,999.99"
@ Li, aCol[10] PSay nT_Saldo PICTURE "@E 99,999,999,999.99"
   
If Li <> 80
   Roda(cbCont,cbTxt,Tamanho)
Endif

//+-------------------------------------------------------------------------------
//| Gera arquivo do tipo .DBF com extensao .XLS p/ usuario abrir no Excel.
//+-------------------------------------------------------------------------------
cArqExcel := "\RELATO\"+NomeProg+Substr(cUsuario,7,4)+".XLS"
Copy To &cArqExcel

dbSelectArea("SE2")
RetIndex("SE2")
Set Filter To
dbSetOrder(1)
dbGoTop()

If aReturn[5] == 1
   Set Printer TO
   dbCommitAll()
   Ourspool(wnrel)
EndIf

Ms_Flush()

Return

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Relatorio_DBF.prw    | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - CriaSX1()                                              |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao que cria o grupo de perguntas se necessario              |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
Static Function CriaSx1()
Local j  := 0
Local nY := 0
Local aReg := {}

aAdd(aReg,{cPerg,"01","Fornecedor de ?     ","mv_ch1","C",6,0,0,"G","","mv_par01","","","","","","","","","","","","","","","SA2"})
aAdd(aReg,{cPerg,"02","Fornecedor ate ?    ","mv_ch2","C",6,0,0,"G","(mv_par02>=mv_par01)","mv_par02","","","","","","","","","","","","","","","SA2"})
aAdd(aReg,{cPerg,"03","Tipo de ?           ","mv_ch3","C",3,0,0,"G","","mv_par03","","","","","","","","","","","","","","","05"})
aAdd(aReg,{cPerg,"04","Tipo ate ?          ","mv_ch4","C",3,0,0,"G","(mv_par04>=mv_par03)","mv_par04","","","","","","","","","","","","","","","05"})
aAdd(aReg,{cPerg,"05","Vencimento de ?     ","mv_ch5","D",8,0,0,"G","","mv_par05","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"06","Vencimento ate ?    ","mv_ch6","D",8,0,0,"G","(mv_par06>=mv_par05)","mv_par06","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"07","Aglutina Fornecedor?","mv_ch7","N",1,0,0,"C","","mv_par07","Sim","","","Nao","","","","","","","","","","",""})
aAdd(aReg,{"X1_GRUPO","X1_ORDEM","X1_PERGUNT","X1_VARIAVL","X1_TIPO","X1_TAMANHO","X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID","X1_VAR01","X1_DEF01","X1_CNT01","X1_VAR02","X1_DEF02","X1_CNT02","X1_VAR03","X1_DEF03","X1_CNT03","X1_VAR04","X1_DEF04","X1_CNT04","X1_VAR05","X1_DEF05","X1_CNT05","X1_F3"})

dbSelectArea("SX1")
dbSetOrder(1)

For ny:=1 to Len(aReg)-1
	If !dbSeek(aReg[ny,1]+aReg[ny,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aReg[ny])
			FieldPut(FieldPos(aReg[Len(aReg)][j]),aReg[ny,j])
		Next j
		MsUnlock()
	EndIf
Next ny

Return