;TEMPLATE BA?LANGICI
list		p=16f877A	; hangi pic
#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
;KULLANILACAK DEGISKENLER

DEGER1		EQU 0x25   ;
DEGER2		EQU 0x26   ;
DEGER3		EQU 0x27   ;

;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
w_temp		EQU	0x7D		
status_temp	EQU	0x7E	;bunlar template ile geldi bilmiyorum ne oldu?unu 	
pclath_temp	EQU	0x7F					

;********************************************************************************************
	ORG     0x00            	; Baslama vektoru
  	goto    BASLA              	; baslama etiketine gir
	ORG     0x04		 	; kesme vektoru
	
;**********************************************************************************************
	goto	KESME	        	; kesme vektoru
	ORG     0x05
;***********************************************************************************************
	
;////////////////////////////////////////////////////////////////////////////////////////////////////
;SORU:PORT B YE BAGLI OLAN BUTONA BASINCA C NIN 5. PORTUNDAKI LEDI YAK
;////////////////////////////////////////////////////////////////////////////////////////////////////


BASLA
	BANKSEL TRISB	 ;B BANKINA GIRIS YAP
	CLRF TRISB	 ;B BANKINI TEMIZLE
	BANKSEL PORTB	 ;PORTB YE GIRIS YAP
	CLRF PORTB	 ;PORTB YI TEMIZLE
	

KESME
	GOTO KESME

	END
	
	