;TEMPLATE BA?LANGICI
list		p=16f877A	; hangi pic
#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
;KULLANILACAK DEGISKENLER

SAYAC1		EQU 0x20   ;
SAYAC2		EQU 0x21   ;
SAYAC3		EQU 0x21   ;

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
;SORU:PORT B DEN ALINAN 8 SAYI ?LE PORT C DEN ALINAN 8 SAYIYI TOPLA D PORTUNDA GOSTER
;////////////////////////////////////////////////////////////////////////////////////////////////////


BASLA
	BANKSEL ADCON1
	MOVLW H'06'
	MOVWF ADCON1
	BANKSEL TRISA
	MOVLW B'00000010'
	MOVWF TRISA
	BANKSEL PORTA
	CLRF PORTA
	BANKSEL TRISB
	CLRF TRISB
	BANKSEL PORTB
	CLRF PORTB
	
ISLEM 
	BTFSC PORTA,0
	GOTO YAK
	GOTO ISLEM

YAK 
	MOVLW B'11111111'
	MOVWF PORTB

KESME
	GOTO KESME
	END
	