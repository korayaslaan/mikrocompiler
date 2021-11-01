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
;***********************************************************************************************
	
	
;////////////////////////////////////////////////////////////////////////////////////////////////////
;SORU:C PORTUNUN 0. P?N?NE BA?LI BUTONA BASILINCA SA?A 1. P?N?NE BASILINCA SOLA B? B?T KAYDIRAN ÖRNEK
;////////////////////////////////////////////////////////////////////////////////////////////////////

BASLA
	BANKSEL TRISC	   ;C BANKINA ERISILIR 
	MOVLW B'00000011'  ;SABITI OMEGAYA KOPYALA
	MOVWF TRISC        ;TRISC YE OMEGAYI ATA
	BANKSEL TRISB	   ;B BANKINA ERIS
	CLRF TRISB	   ;B BANKINI TEMIZLE
	BANKSEL PORTB	   ;B PORTUNA ERIS
	MOVLW B'00000001'  ;B BANKINDAKI OMEGAYA SABIT DEGERI ATA
	MOVWF PORTB	   ;OMEGAYI PORTB YE KOPYALA
	
ISLEM 
	BTFSS PORTC,0	    ;C PORTUNUN 0. PININI KONTROL ET
	GOTO ISLEM1         
	CALL SAG	    ;SAGA KAYDIR 1 BITI (/2) DEMEK B? NEV? DE?ER OLARAK
	GOTO ISLEM
	
ISLEM1
	BTFSS PORTC,1	    ;C PORTUNUN 1. PININI KONTROL ET
	GOTO ISLEM
	CALL SOL	    ;SOLA KAYDIR 1 BITI (*2) DEMEK B? NEV? DE?ER OLARAK
	GOTO ISLEM

SAG
	RRF PORTB,F
	CALL GECIKME
	RETURN 

SOL 
	RLF PORTB ,F
	CALL GECIKME 
	RETURN 
	
GECIKME 
	MOVLW 0Xff
	MOVWF SAYAC1
	

KESME 
	GOTO KESME
	
	

	END                       ; Program sonu