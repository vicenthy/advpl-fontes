#include 'totvs.ch'
#INCLUDE 'FWPrintSetup.ch'
#Include 'ParmType.ch'

CLASS MyMSPrinter From FWMSPrinter
	DATA nPage
	DATA nPageSize
	DATA nPageStart	
	METHOD New(cFilePrintert, nDevice, lAdjustToLegacy, cPathInServer, lDisabeSetup, lTReport, oPrintSetup, cPrinter, lServer, lPDFAsPNG, lRaw, lViewPDF, nQtdCopy) CONSTRUCTOR
	METHOD CountPage()
	METHOD QuebraManual()
	METHOD PularLinha()
	METHOD Iniciar()
	METHOD mRodape()
	METHOD mCabec()
ENDCLASS



METHOD New(cFilePrintert, nDevice, lAdjustToLegacy, cPathInServer, lDisabeSetup, lTReport, oPrintSetup, cPrinter, lServer, lPDFAsPNG, lRaw, lViewPDF, nQtdCopy) CLASS MyMSPrinter
	_Super:New(cFilePrintert, nDevice, lAdjustToLegacy, cPathInServer, lDisabeSetup, lTReport, oPrintSetup, cPrinter, lServer, lPDFAsPNG, lRaw, lViewPDF, nQtdCopy)
	::nPage := 0
	::nPageSize := ::nPageHeight
	::nPageStart := 640	
Return


METHOD PularLinha(nLinAtu, nLin, bRodape, bCabec) CLASS MyMSPrinter

Default nLin := 1
Default nLinAtu := 1
If nLinAtu >= ::nPageSize
	if(bRodape != nil)
		Eval(bRodape)
	endif
		::QuebraManual() 
	nLinAtu := ::nPageStart
	if(bCabec != nil)
		Eval(bCabec)
	endif
		::CountPage()
EndIf
return nLin 



METHOD CountPage() CLASS MyMSPrinter
	::nPage += 1 
Return (::nPage)


METHOD Iniciar(nPageSize, nPageStart ) CLASS MyMSPrinter	
	if(nPageSize != nil .And. nPageSize > 0)
		::nPageSize := nPageSize
	elseif(nPageStart != nil .And. nPageStart > 0 )
			::nPageStart := nPageStart
	endif
Return 



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