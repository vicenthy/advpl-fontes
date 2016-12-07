#Include "Protheus.ch"
#Include "ApWizard.ch"

User Function Wizard()
Local oWizard, oPanel, oSexo
Local cNome := Space(30)
Local dNasc := Ctod(Space(8))
Local nIdade := 0
Local nSexo := 0
Local aSexo := {"Masculino","Feminino"}

DEFINE WIZARD oWizard TITLE "Exemplo Wizard" ;
       HEADER "Wizard utilizado no curso oficina de programa��o" ;
       MESSAGE "Est� classe tende a ser uma das mais utilizada na programa��o AdvPL" ;
       TEXT "Este exemplo mostra a utiliza��o desta classe e seus poss�veis recursos, sendo assim f�cil e pr�tico." ;
       NEXT {||.T.} ;
		 FINISH {|| .T. } ;
       PANEL ;
       COORD {0,0,400,700}

   // Primeira etapa
   CREATE PANEL oWizard ;
          HEADER "Informe o nome completo" ;
          MESSAGE "Somente ser� poss�vel nomes com at� trinta caracteres" ;
          BACK {|| .T. } ;
          NEXT {|| .T. } ;
          FINISH {|| .F. } ;
          PANEL
   oPanel := oWizard:GetPanel(2)
   @ 15,15 SAY "Nome completo" SIZE 45,8 PIXEL OF oPanel
   @ 25,15 MSGET cNome PICTURE "@!" SIZE 160,10 PIXEL OF oPanel

   // Segunda etapa
   CREATE PANEL oWizard ;
          HEADER "Digite a data de nascimento" ;
          MESSAGE "A data de nascimento dever� ser menor que "+Dtoc(dDataBase)+" a baixo ser� informado a idade" ;
          BACK {|| .T. } ;
          NEXT {|| .T. } ;
          FINISH {|| .F. } ;
          PANEL    
   oPanel := oWizard:GetPanel(3)
   @ 15,15 SAY "Data nascimento" SIZE 45,8 PIXEL OF oPanel
   @ 25,15 MSGET dNasc PICTURE "99/99/99" VALID Eval({||dNasc<dDataBase,nIdade:=Year(dDataBase)-Year(dNasc)}) ;
   SIZE 40,10 PIXEL OF oPanel
   @ 40,15 SAY "Idade" SIZE 45,8 PIXEL OF oPanel
   @ 50,15 MSGET nIdade PICTURE "99" WHEN .F. SIZE 40,10 PIXEL OF oPanel
   
   // Terceira etapa
   CREATE PANEL oWizard ;
          HEADER "Informe a sexoalidade" ;
          MESSAGE "Se estiver em d�vida ligue para sua m�e e tire a d�vida" ;
          BACK {|| .T. } ;
          NEXT {|| .F. } ;
          FINISH {|| .T. } ;
          PANEL
   oPanel := oWizard:GetPanel(4)
   @ 30,10 RADIO oSexo VAR nSexo ITEMS aSexo[1],aSexo[2] SIZE 65,8 PIXEL OF oPanel ON CHANGE MsgInfo("Tem certeza?","Wizard")

ACTIVATE WIZARD oWizard CENTERED

Return