#include 'totvs.ch'
#INCLUDE 'FWPrintSetup.ch'
#Include 'ParmType.ch'

CLASS MyMSPrinter From FWMSPrinter
	DATA nPage
	METHOD New(cFilePrintert, nDevice, lAdjustToLegacy, cPathInServer, lDisabeSetup, lTReport, oPrintSetup, cPrinter, lServer, lPDFAsPNG, lRaw, lViewPDF, nQtdCopy) CONSTRUCTOR
	METHOD CountPage()
	METHOD QuebraManual()
	METHOD PularLinha()
	METHOD mRodape(bRodape)
	METHOD mCabec(bCabec)
ENDCLASS

//----------------
METHOD New(cFilePrintert, nDevice, lAdjustToLegacy, cPathInServer, lDisabeSetup, lTReport, oPrintSetup, cPrinter, lServer, lPDFAsPNG, lRaw, lViewPDF, nQtdCopy) CLASS MyMSPrinter
	_Super:New(cFilePrintert, nDevice, lAdjustToLegacy, cPathInServer, lDisabeSetup, lTReport, oPrintSetup, cPrinter, lServer, lPDFAsPNG, lRaw, lViewPDF, nQtdCopy)
	::nPage := 0
Return


METHOD PularLinha(nLinAtu, nLin, nPageSize, bRodape, bCabec) CLASS MyMSPrinter
Default nLin := 1
Default nPageSize := ::nPageHeight
Default nPageIni := 640
Default nLinAtu := 1
If nLinAtu >= nPageSize
	::QuebraManual() 
		nLinAtu := nPageIni
	if(bRodape != nil)
		Eval(bRodape)
	endif
	if(bCabec != nil)
		Eval(bCabec)
	endif
EndIf
return nLin 



METHOD CountPage() CLASS MyMSPrinter
::nPage += 1 
Return (::nPage)



METHOD QuebraManual() CLASS MyMSPrinter
::EndPage()
::StartPage()
return 



METHOD mRodape(bRodape) CLASS MyMSPrinter
Eval(bRodape)
Return 


METHOD mCabec(bCabec) CLASS MyMSPrinter
Eval(bCabec)
Return