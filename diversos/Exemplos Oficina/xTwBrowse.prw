#Include "Protheus.ch"

User Function xTwBrowse()

Local cTitulo := "TwBrowse()"
Local aCpo := {"A6_COD","A6_AGENCIA","A6_NUMCON","A6_NREDUZ","A6_NOME","A6_SALATU"}
Local aTit := {}
Local aDad := {}
Local aPict := {}
Local i := 0
Local nCpo := 0
Local oDlg
Local oLbx
Local aAreaX3 := {}
Local aAreaA6 := {}
Local oFntLbx := TFont():New("Courier New",6,0)

dbSelectArea("SX3")
aAreaX3 := GetArea()
dbSetOrder(2)

/*
For i:=1 To Len(aCpo)
   dbSeek(aCpo[i])
   aAdd(aTit,AllTrim(SX3->X3_TITULO))
Next i
*/

// � poss�vel substituir o For/Next acima por esta linha abaixo
aEval(aCpo,{|x| dbSeek(x), aAdd(aTit,AllTrim(SX3->X3_TITULO)), aAdd(aPict,AllTrim(SX3->X3_PICTURE) ) } )
RestArea(aAreaX3)

dbSelectArea("SA6")
aAreaA6 := GetArea()
dbSetOrder(1)
dbSeek(xFilial("SA6"))

/*
While !Eof() .And. SA6->A6_FILIAL == xFilial("SA6")
   aAdd(aDad,Array(Len(aCpo)))
   nCpo++
   For i:=1 To Len(aCpo)
      aDad[nCpo,i] := TransForm(FieldGet(FieldPos(aCpo[i])),aPict[i])
   Next i
   dbSkip()
End
*/

// � poss�vel substituir o While/End acima por esta linha abaixo
dbEval({|| aAdd(aDad,Array(Len(aCpo))),;
           aEval(aCpo,{|nX,nI| aDad[Len(aDad),nI] := TransForm(FieldGet(FieldPos(aCpo[nI])),aPict[nI])})},,;
           {|z| !Eof().And.SA6->A6_FILIAL==xFilial("SA6")})
RestArea(aAreaA6)

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL

   oLbx := TwBrowse():New(13,1,250,108,,aTit,,oDlg,,,,,,,oFntLbx,,,,,.F.,,.T.,,.F.,,,)
   oLbx:SetArray(aDad)
   oLbx:bLine := {|| aEval( aDad[oLbx:nAt],{|z,w| aDad[oLbx:nAt,w]})}

ACTIVATE MSDIALOG oDlg CENTER ON INIT EnchoiceBar(oDlg,{||oDlg:End()},{||oDlg:End()})

Return