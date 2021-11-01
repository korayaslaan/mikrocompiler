; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
	
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF

; WDT, ossilatör gibi register ayarlar?

	
;KULLANILACAK DEGISKENLER

ILK_REG		EQU 0x20   ;x20 adresim ilk reg adresim olarak adland?rd?m. Register File içinde çal???r 14 bitli?e dönü?türülür flass belle?e yüklenir 
IKINCI_REG	EQU 0x21   ;
SONUC_REG	EQU 0x22   ;



;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F					






;********************************************************************************************
	ORG     0x000             	; Baslama vektoru

	nop			  			  	; ICD ozelliginin aktif edilmesi icin gereken bekleme 
  	goto    BASLA              	; baslama etiketine gir

	
;**********************************************************************************************
	ORG     0x004             	; kesme vektoru

	movwf   w_temp            	; W n?n yedegini al
	movf	STATUS,w          	; Status un yedegini almak icin onu once W ya al
	movwf	status_temp       	; Status u yedek register '?na al
	movf	PCLATH,w	  		; PCLATH '? yedeklemek icin onu once W 'ya al
	movwf	pclath_temp	  		; PCLATH '? yedek register a al

	; gerekli kodlar

	movf	pclath_temp,w	  	; Geri donmeden once tum yedekleri geri yukle
	movwf	PCLATH		  		
	movf    status_temp,w     	
	movwf	STATUS            	
	swapf   w_temp,f
	swapf   w_temp,w          	
	retfie                    	; Kesme 'den don
;***********************************************************************************************


BASLA
	MOVLW 0x1A  ;1 a say?s?n? omegaya kopyalad?k
	MOVWF ILK_REG ;omegadaki say?y? ilk_reg de?i?kenine att?k 
	
	MOVLW 0x21 ;yeni de?i?ken yazd?k üstüne yazd???m?z için ba?taki de?er silindi 
	MOVWF IKINCI_REG 
	
	MOVF  ILK_REG,0
	ADDWF IKINCI_REG,0
	MOVWF SONUC_REG  
	

	END                       ; Program sonu