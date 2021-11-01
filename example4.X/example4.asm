


;TEMPLATE BA?LANGICI
list		p=16f877A	; hangi pic
#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
;KULLANILACAK DEGISKENLER

D1		EQU 0x20   ;
D2		EQU 0x21   ;
D3		EQU 0x22   ;

;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
w_temp		EQU	0x7D		
status_temp	EQU	0x7E	;bunlar template ile geldi bilmiyorum ne oldu?unu 	
pclath_temp	EQU	0x7F					

;********************************************************************************************
	ORG     0x00            	; Baslama vektoru
  	goto    BASLA              	; baslama etiketine gir
	ORG     0x04		 	; kesme vektoru
	

;***********************************************************************************************
	
;////////////////////////////////////////////////////////////////////////////////////////////////////
;SORU:PORT B DEN ALINAN 8 SAYI ?LE PORT C DEN ALINAN 8 SAYIYI TOPLA D PORTUNDA GOSTER
;////////////////////////////////////////////////////////////////////////////////////////////////////


BASLA
	BANKSEL TRISB 
	MOVLW B'00000001'
	MOVWF TRISB
	BANKSEL PORTB
	CLRF PORTB
	BANKSEL TRISC
	CLRF TRISC
	BANKSEL PORTC 
	CLRF PORTC
	
KONTROL
	BTFSS TRISB,0
	GOTO KONTROL
	BSF PORTC,3
	CALL GECIKME
	GOTO SONDUR
	GOTO KONTROL
	
SONDUR
	CLRF PORTC
	GOTO KONTROL
	
GECIKME
	MOVLW	    D'9'
	MOVWF	    D1
	MOVLW	    D'6'
	MOVWF	    D2
	MOVLW	    D'3'
	MOVWF	    D3
DONGU
	DECFSZ	    D1,1
	GOTO	    $+2
	DECFSZ	    D2,1
	GOTO	    $+2
	DECFSZ	    D3,1
	GOTO	   DONGU
	
	NOP        ;1 CYCLE BEKLE
	NOP
	NOP
	RETURN


	END
	
	