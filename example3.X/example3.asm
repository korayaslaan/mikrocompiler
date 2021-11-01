; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
	
	;__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
	__CONFIG  H'3F31'
; WDT, ossilatör gibi register ayarlar?

	
;KULLANILACAK DEGISKENLER

D1	EQU 0x20   ;Buradaki ismi degistirebilir ve yenileri eklenebilir
D2	EQU 0x21   ;Buradaki ismi degistirebilir ve yenileri eklenebilir
D3	EQU 0x22   ;Buradaki ismi degistirebilir ve yenileri eklenebilir


;*** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F					






;********************************
	ORG     0x000             	; Baslama vektoru

	nop			  			  	; ICD ozelliginin aktif edilmesi icin gereken bekleme 
  	goto    BASLA              	; baslama etiketine gir

	
;********************************
	ORG     0x04             	; kesme vektoru
	GOTO	KESME
	ORG	0x05
	
;*********************************


BASLA
	BANKSEL	    ADCON1
	MOVLW	    H'06'
	MOVWF	    ADCON1
	BANKSEL	    TRISA
	MOVLW	    H'00000001'
	MOVWF	    TRISA
	
	BANKSEL	    TRISB
	CLRF	    TRISB
	BANKSEL	    PORTB
	CLRF	    PORTB
	
ISLEM
	BTFSS	    PORTA,0
	GOTO	    ISLEM
	BSF	    PORTB,0
	CALL	    GECIKME
	CALL	    SONDUR
	GOTO	    ISLEM
	
SONDUR	
	CLRF	    PORTB
	RETURN

GECIKME
	MOVLW	    0x08
	MOVWF	    D1
	MOVLW	    0x2F
	MOVWF	    D2
	MOVLW	    0x03
	MOVWF	    D3
DONGU
	DECFSZ	    D1,1
	GOTO	    $+2
	DECFSZ	    D2,1
	GOTO	    $+2
	DECFSZ	    D3,1
	GOTO	   DONGU
	
	NOP
	NOP
	NOP
	RETURN
	
	KESME
	GOTO	KESME
	END                       ; Program sonu