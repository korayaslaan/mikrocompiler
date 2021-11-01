
	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
	
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
;KULLANILACAK DEGISKENLER

DEGER_1		EQU 0x25   ;
DEGER_2		EQU 0x26   ;

;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
w_temp		EQU	0x7D		
status_temp	EQU	0x7E	;bunlar template ile geldi bilmiyorum ne oldu?unu 	
pclath_temp	EQU	0x7F					

;********************************************************************************************
	ORG     0x00            	; Baslama vektoru
  	goto    BASLA              	; baslama etiketine gir
	ORG     0x004		 	; kesme vektoru
	
;**********************************************************************************************
	   
	goto	KESME	        	; kesme vektoru
	ORG     0x005  

;***********************************************************************************************


BASLA
	BANKSEL TRISB	  ;banksel sadece trisb de bulunur 
	MOVLW B'00000000' ;0 say?s?n? omegaya kopyalad?
	MOVWF TRISB       ;b registerini omegaya kopyalad?
	BANKSEL PORTB	  ;bank olarak portb yi kullanaca??z
	CLRF PORTB	  ;üstteki sat?r dahil olmak üzeri i?lemleri portb de yapmam?z? sa?lar 'clrf portb nin içini s?f?rlar'
	MOVLW D'21'	  ;omegaya 21 de?erini kopyala
	MOVWF DEGER_1	  ;omegay? deger_1 e yaz
	MOVLW D'03'       ;omegaya 03 de?erini kopyala
	MOVWF DEGER_2	  ;omegay? deger_1 e yaz
	CLRW		  ;omegay? s?f?rlaGF
	
ISLEM 
	ADDWF DEGER_1,W	  ;deger_1 ile omegay? topla
	DECFSZ DEGER_2,F  ;'DECFSZ' döngü için kullan?m mant???nda yukar?daki i?lemi tekrarlar
	GOTO ISLEM 
	MOVWF PORTB	  ;omegay? registere kopyalar 
KESME 
	GOTO KESME
	
	END 

	END                       ; Program sonu