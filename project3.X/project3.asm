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
;SORU:8 LI LED EKRANIN BITLERINI 2 SER 2 SER YAK
;////////////////////////////////////////////////////////////////////////////////////////////////////

BASLA
	BANKSEL TRISD	  ;D BANKINA G?RER
	MOVLW B'11110000' ;SON 4 BITE 1 DEGERI VERILIR OMEGAYA ATANIR
	MOVWF TRISD       ;OMEGA D BANKINA KOPYALANIR
	BANKSEL PORTD	  ;D PORTUNA GIRILIR
	CLRF PORTD	  ;D PORTU TEMIZLENIR
	BANKSEL TRISB	  ;B BANKINA GIRILIR
	MOVLW B'00000000' ;OMEGAYA SABIT SAYI KOPYALANIR
	MOVWF TRISB	  ;OMEGA TRISB YE KOPYALANIR
	BANKSEL PORTB	  ;B PORTUNA GIRILIR
	CLRF PORTB	  ;B PORTU TEMIZLENIR
	    
BUTON1 
	BTFSC PORTD,4     ;4. PINI KONTROL ET
	GOTO YAK1	  ;YAK 1 METODUNU CAGIR
	GOTO BUTON2 

BUTON2 
	BTFSC PORTD,5
	GOTO YAK2
	GOTO BUTON3 
	
BUTON3
	BTFSC PORTD,6
	GOTO YAK3
	GOTO BUTON4 
	
BUTON4
	BTFSC PORTD,7
	GOTO YAK4
	GOTO SONDUR
	
SONDUR
	MOVLW B'00000000'  ;SONDURMEK ICIN TUM PINLERE 0 DEGERI ATANIR 
	MOVWF PORTB
	GOTO BUTON1
	
YAK1 
	MOVLW B'00000011'  ;YAKMAK ISTEDIGIMIZ PINLERE 1 DEGERINI GONDERIYORUZ
	MOVWF PORTB 
	GOTO BUTON1 
	
YAK2 
	MOVLW B'00001100'
	MOVWF PORTB 
	GOTO BUTON1 

YAK3
	MOVLW B'00110000'
	MOVWF PORTB 
	GOTO BUTON1 

YAK4
	MOVLW B'11000000'
	MOVWF PORTB 
	GOTO BUTON1 

KESME
	GOTO KESME

	END
	
	