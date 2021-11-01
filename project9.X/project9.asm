;TEMPLATE BA?LANGICI
list		p=16f877A	; hangi pic
#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
;KULLANILACAK DEGISKENLER

SAYI1		EQU 0x20   ;
SAYI2		EQU 0x21   ;
TOPLAM		EQU 0x22   ;

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
	BANKSEL TRISB
	MOVLW B'11111111'
	MOVWF TRISB
	BANKSEL PORTB 
	CLRF PORTB
	BANKSEL TRISC 
	MOVLW B'11111111'
	MOVWF TRISC
	BANKSEL PORTC 
	CLRF PORTC
	BANKSEL TRISD 
	MOVLW B'00000000'
	MOVWF TRISD
	BANKSEL PORTD 
	CLRF PORTD
	
ISLEM
	MOVF PORTB,W
	MOVWF SAYI1 
	MOVF PORTC,W
	MOVWF SAYI2 
	MOVF SAYI1,W
	ADDWF SAYI2,W
	
	MOVWF TOPLAM	
	MOVF TOPLAM,W
	MOVWF PORTD

KESME
	GOTO KESME

	END
	
	