


;TEMPLATE BA?LANGICI
list		p=16f877A	; hangi pic
#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
;KULLANILACAK DEGISKENLER

SAYAC		EQU 0x20   ;
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
	goto KESME
	ORG   0x06
;***********************************************************************************************
	
;////////////////////////////////////////////////////////////////////////////////////////////////////
;SORU:1 SANIYE GECIKME ILE LEDLERIN ISIKLARINI DEGISTIREN KOD (KENDI SORUM)
;////////////////////////////////////////////////////////////////////////////////////////////////////

	
BASLA
	BANKSEL ADCON1
	MOVLW H'06'
	MOVWF ADCON1
	BANKSEL TRISA
	MOVLW H'FF'
	MOVWF TRISA
	BANKSEL TRISB
	CLRF TRISB
	
	BANKSEL PORTB
	CLRF PORTB
	BANKSEL PORTA
	CLRF PORTA
	
	MOVLW H'0A'
	MOVWF SAYAC
	
ISLEM 
	BTFSC PORTA,0
	GOTO YAK
	GOTO ISLEM

YAK 
	DECFSZ SAYAC,F
	CALL GOSTER
	GOTO SONDUR 
GOSTER
	MOVF SAYAC,W
	MOVWF PORTB
	GOTO ISLEM
SONDUR 
	MOVLW B'00000000'
	MOVWF PORTB
	MOVLW H'06'
	MOVWF SAYAC
	GOTO ISLEM
KESME
	GOTO KESME
	END
	
	