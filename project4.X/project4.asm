


;TEMPLATE BA?LANGICI
list		p=16f877A	; hangi pic
#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
;KULLANILACAK DEGISKENLER

SAYAC1		EQU 0x25   ;
SAYAC2		EQU 0x26   ;

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
;SORU:B PORTUNUN 0. PININE BAGLANMI? BUTONDAN 4. PINDEKI LEDI YAK 
;////////////////////////////////////////////////////////////////////////////////////////////////////
BASLA
	BANKSEL TRISB	  ;B BANKINA GIRIS YAP
	MOVLW B'00001111' ;OMEGAYA SABIT DEGERI ATA
	MOVWF TRISB       ;OMEGAYI TRISB YE ATA
	BANKSEL PORTB	  ;B PORTUNA GIRIS YAP
	CLRF PORTB	  ;B PORTUNU TEMIZLE
	
BUTON
	BTFSC PORTB,0	  ;BITI KONTROL ET 0 ISE ATLA
	GOTO YAK


SONDUR
	MOVLW B'00000000'
	MOVWF PORTB
	GOTO BUTON
	
YAK
	BSF PORTB,4        ;4. PINDEKI LEDI YAK 
	GOTO BASLA


KESME
	GOTO KESME

	END
	
	