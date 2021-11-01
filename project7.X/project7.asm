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
;SORU:PORT A NIN PINLERINE BAGLI BUTONLARDAN HANGISINE BASILIRSA PORT B DEKI O PINI YAKAN UYGULAMA
;////////////////////////////////////////////////////////////////////////////////////////////////////


BASLA
	BANKSEL ADCON1	 ;PORTA YI DIGITAL YAPMAK ICIN
	MOVLW H'06'	 ;OMEGAYA REGISTERI KOPYALA
	MOVWF ADCON1	 ;OMEGADAKI DEGERI PORTA YA ATA
	BANKSEL TRISA	 ;A BANKINA GIRIS YAP
	MOVLW B'11111111';BASLANGIC DEGERI OLARAK 1 ATA PULL UP
	MOVWF TRISA	 ;BU DEGERI OMEGADAN TRISA YA KOPYALA
	BANKSEL TRISB	 ;B BANKINA GIRIS YAP 
	MOVLW B'00000000';BASLANGIC DEGERI OLARAK 0 DEGERINI ATA PULL DOWN
	MOVWF TRISB	 ;BU DEGERI OMEGADAN TRISB YE ATA
	BANKSEL PORTB	 ;B PORTUNA GIRIS YAP
	CLRF PORTB	 ;B PORTUNUN GIRIS DEGERLERINI TEMIZLE
	
	
	
BUTON1
	BTFSC PORTA,0	 ;PORTA NIN BITI 0 ISE BI SATIR ATLA 
	BSF PORTB,0	 ;PORTB DEKI 0. PINI1 YAP
	GOTO BUTON2	 ;SONRAKI BUTONA GIT


BUTON2 
	BTFSC PORTA,1	 
	BSF PORTB,1	 
	GOTO BUTON3	
	
BUTON3 
	BTFSC PORTA,2	 
	BSF PORTB,2	 
	GOTO BUTON4	 
	
BUTON4 
	BTFSC PORTA,3	 
	BSF PORTB,3	
	GOTO BUTON5	
	
BUTON5 
	BTFSC PORTA,4	 
	BSF PORTB,4	
	GOTO BUTON6	 
	
BUTON6 
	BTFSC PORTA,5	 
	BSF PORTB,5	
	GOTO SONDUR	
	
SONDUR
	MOVLW B'00000000' ;TUM LEDLERI YAKMAK ICIN TUM LEDLERE 1 DEGERINI GONDER OMEGAYA ATA
	MOVWF PORTB	  ;OMEGADAKI DEGERI REGISTERE AT
	GOTO BUTON1	  ;ISLEM METODUNA GERI DON

KESME
	GOTO KESME

	END
	
	