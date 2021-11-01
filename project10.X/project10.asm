;TEMPLATE BA?LANGICI
list		p=16f877A	; hangi pic
#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
;KULLANILACAK DEGISKENLER

D1		EQU 0x20   ;
D2		EQU 0x21   ;

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
;SORU:1 SANIYE GECIKME ILE LEDLERIN ISIKLARINI DEGISTIREN KOD (KENDI SORUM)
;////////////////////////////////////////////////////////////////////////////////////////////////////
GECIKME 

	MOVLW 0XFF
	MOVWF D1
LOOP 
	MOVLW 0xFF
	MOVWF D2

LOOP2 
	DECFSZ D2,F
	GOTO LOOP2
	

	DECFSZ D1,F
	GOTO LOOP
	RETURN

BASLA
	CLRF PORTB
	BANKSEL TRISB
	CLRF TRISB 
	
	BCF STATUS,5
	
	
	
DONGU
	MOVLW 0x01
	BTFSC PORTB,0
	MOVLW 0x00
	MOVWF PORTB
	CALL GECIKME
	GOTO DONGU
	



KESME
	GOTO KESME

	END
	
	