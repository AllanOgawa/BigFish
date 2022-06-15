algoritmo "semnome"
var
      TEMPERATURA:VETOR[1..20] de REAL
       TEMPSTATUS:VETOR[1..20] de CARACTER
    
               PH:VETOR[1..20] de REAL
         PHSTATUS:VETOR[1..20] de CARACTER
    
         OXIGENIO:VETOR[1..20] de REAL
   OXIGENIOSTATUS:VETOR[1..20] de CARACTER
       
           AMONIA:VETOR[1..20] de REAL
     AMONIASTATUS:VETOR[1..20] de CARACTER
         
           TANQUE:VETOR[1..20] de REAL
            GERAL:VETOR[1..20] de CARACTER
         
    x,TotalTanque:INTEIRO
  linha,op,parada:CARACTER

//==============================================================================================================
//==== LEITURA DO ARQUIVO ======================================================================================
//==============================================================================================================

Procedimento Leitura
Arquivo "RELATORIO.txt"
Var
a:inteiro
tmp:caracter
Inicio
Para x de 1 ate 20 faca
     leia(linha)
     a<-1
     tmp<-leCampo(a)
     TEMPERATURA[x]<-caracpnum(tmp)
     tmp<-leCampo(a)
     PH[x]<-caracpnum(tmp)
     tmp<-leCampo(a)
     OXIGENIO[x]<-caracpnum(tmp)
     tmp<-leCampo(a)
     AMONIA[x]<-caracpnum(tmp)
     totaltanque<-totaltanque+1
     tanque[x]<-x
fimpara
fimprocedimento

//==============================================================================================================

Funcao LeCampo(Var a:INTEIRO):CARACTER
Var
y,z:caracter
inicio
y<-""
z<-copia(linha,a,1)
Enquanto ASC(z)<>44 faca
  y<-y+z
  a<-a+1
  z<-copia(linha,a,1)
Fimenquanto
a<-a+1
Retorne y
Fimfuncao

//==============================================================================================================
//==== RECEBE STATUS ===========================================================================================
//==============================================================================================================

Procedimento recebe_geral
inicio
Para x de 1 ate totaltanque faca
 Se ((TEMPERATURA[x]<=30) e (TEMPERATURA[x]>25)) E ((PH[x]<=8.5) e (PH[x]>=6)) E ((OXIGENIO[x]<=0.7) e (OXIGENIO[x]>=0.4)) E (AMONIA[x]=0.05) entao
    GERAL[X]<-"IDEAL"
    Senao
    GERAL[x]<-"VERIFICAR"
 fimse
fimpara
FimProcedimento

//==============================================================================================================

Procedimento recebe_temperatura
inicio
Para x de 1 ate totaltanque faca
Se (TEMPERATURA[x]>38) entao
    TEMPSTATUS[x]<-"MUITO QUENTE"
 Senao
    Se (TEMPERATURA[x]<=38) e (TEMPERATURA[x]>30) entao
       TEMPSTATUS[x]<-"QUENTE"
    Senao
       Se (TEMPERATURA[x]<=30) e (TEMPERATURA[x]>25) entao
          TEMPSTATUS[x]<-"IDEAL"
       Senao
          Se (TEMPERATURA[x]<=25) e (TEMPERATURA[x]>14) entao
             TEMPSTATUS[x]<-"BAIXA"
          Senao
             Se (TEMPERATURA[x]<=14) entao
                TEMPSTATUS[x]<-"MUITO BAIXA"
             Fimse
          Fimse
       Fimse
    Fimse
 Fimse
FimPara
fimprocedimento

//==============================================================================================================

Procedimento recebe_ph
inicio
Para x de 1 ate totaltanque faca
   Se (PH[x]<6) e (PH[x]>=0) entao
      PHSTATUS[X]<-"PH BAIXO(ÁCIDA)"
   Senao
      Se (PH[x]<=8.5) e (PH[x]>=6) entao
         PHSTATUS[X]<-"PH IDEAL(NEUTRA)"
      Senao
         Se (PH[x]<=14) e (PH[x]>8.5) entao
            PHSTATUS[X]<-"PH ALTO (ALCALINA)"
         Fimse
      Fimse
   Fimse
fimpara
fimprocedimento

//==============================================================================================================

Procedimento recebe_oxigenio
inicio
Para x de 1 ate totaltanque faca
   Se (OXIGENIO[x]<=0.7) e (OXIGENIO[x]>=0.4) entao
      OXIGENIOSTATUS[x]<-"OXIGÊNIO IDEAL"
   Senao
      Se (OXIGENIO[x]>0.7) entao
      OXIGENIOSTATUS[x]<-"OXIGÊNIO ALTO"
      Senao
      OXIGENIOSTATUS[x]<-"OXIGÊNIO BAIXO"
      Fimse
   Fimse
fimpara
Fimprocedimento

//==============================================================================================================

Procedimento recebe_amonia
inicio
Para x de 1 ate totaltanque faca
   Se (AMONIA[x]=0.05) entao
      AMONIASTATUS[x]<-"AMÔNIA IDEAL"
   Senao
      Se (AMONIA[X]>0.05) entao
         AMONIASTATUS[x]<-"AMÔNIA ALTA"
         Senao
         AMONIASTATUS[x]<-"AMÔNIA BAIXA"
      Fimse
   Fimse
fimpara
fimprocedimento

//==============================================================================================================
//==== CLASSIFICAÇÃO ===========================================================================================
//==============================================================================================================

Procedimento class_geral(t:caracter)
var
a,b:inteiro
inicio
Para a de 1 ate totaltanque-1 faca
     Para b de a+1 ate totaltanque faca
          Se(t="2") e (GERAL[a]>GERAL[b]) ou (t="1") e (TANQUE[a]>TANQUE[b]) entao
             base(a,b)
          Fimse
     Fimpara
Fimpara
FimProcedimento

//==============================================================================================================

Procedimento class_temperatura(t:caracter)
var
a,b:inteiro
inicio
Para a de 1 ate totaltanque-1 faca
     Para b de a+1 ate totaltanque faca
          Se (t="1") e (TANQUE[a]>TANQUE[b]) ou (t="2") e (TEMPERATURA[a]>TEMPERATURA[b]) ou (t="3") e (TEMPERATURA[a]<TEMPERATURA[b]) entao
             base(a,b)
          Fimse
     Fimpara
Fimpara
FimProcedimento

//==============================================================================================================

Procedimento class_ph(t:caracter)
var
a,b:inteiro
inicio
Para a de 1 ate totaltanque-1 faca
     Para b de a+1 ate totaltanque faca
          Se (t="1") e (TANQUE[a]>TANQUE[b]) ou (t="2") e (PH[a]>PH[b]) ou (t="3") e (PH[a]<PH[b]) entao
             base(a,b)
          Fimse
     Fimpara
Fimpara
FimProcedimento

//==============================================================================================================

Procedimento class_oxigenio(t:caracter)
var
a,b:inteiro
inicio
Para a de 1 ate totaltanque-1 faca
     Para b de a+1 ate totaltanque faca
          Se (t="1") e (TANQUE[a]>TANQUE[b]) ou (t="2") e (OXIGENIO[a]>OXIGENIO[b]) ou (t="3") e (OXIGENIO[a]<OXIGENIO[b]) entao
             base(a,b)
          Fimse
     Fimpara
Fimpara
FimProcedimento

//==============================================================================================================

Procedimento class_amonia(t:caracter)
var
a,b:inteiro
inicio
Para a de 1 ate totaltanque-1 faca
     Para b de a+1 ate totaltanque faca
          Se (t="1") e (TANQUE[a]>TANQUE[b]) ou (t="2") e (AMONIA[a]>AMONIA[b]) ou (t="3") e (AMONIA[a]<AMONIA[b]) entao
            base(a,b)
          Fimse
     Fimpara
Fimpara
FimProcedimento

//==============================================================================================================

Procedimento base(a,b:inteiro)
var
tmp:real
tmpcarac:caracter
inicio

 tmp      <-tanque[a]
 tanque[a]<-tanque[b]
 tanque[b]<-tmp
 
 tmpcarac<-GERAL[a]
 GERAL[a]<-GERAL[b]
 GERAL[b]<-tmpcarac

 tmp           <-TEMPERATURA[a]
 TEMPERATURA[a]<-TEMPERATURA[b]
 TEMPERATURA[b]<-tmp

 tmpcarac     <-TEMPSTATUS[a]
 TEMPSTATUS[a]<-TEMPSTATUS[b]
 TEMPSTATUS[b]<-tmpcarac

 tmp  <-PH[a]
 PH[a]<-PH[b]
 PH[b]<-tmp

 tmpcarac   <-PHSTATUS[a]
 PHSTATUS[a]<-PHSTATUS[b]
 PHSTATUS[b]<-tmpcarac

 tmp        <-OXIGENIO[a]
 OXIGENIO[a]<-OXIGENIO[b]
 OXIGENIO[b]<-tmp

 tmpcarac         <-OXIGENIOSTATUS[a]
 OXIGENIOSTATUS[a]<-OXIGENIOSTATUS[b]
 OXIGENIOSTATUS[b]<-tmpcarac

 tmp      <-AMONIA[a]
 AMONIA[a]<-AMONIA[b]
 AMONIA[b]<-tmp

 tmpcarac       <-AMONIASTATUS[a]
 AMONIASTATUS[a]<-AMONIASTATUS[b]
 AMONIASTATUS[b]<-tmpcarac
fimprocedimento

//==============================================================================================================
//==== CONSULTA ================================================================================================
//==============================================================================================================

Procedimento consulta_geral
var
tp:caracter
lin:inteiro
inicio
lin<-0
 Repita
 Escreva(" CLASSIFICAR POR ORDEM DE TANQUE(1) OU POR STATUS(2): ")
 leia(tp)
 Ate (tp="1") ou (tp="2")
 class_geral(tp)
    limpatela
       Para x de 1 ate totaltanque faca
           Se lin=0 ENTAO
                Escreval("               TEMPERATURA   PH     OXIGENIO     AMONIA       STATUS GERAL ")
                Escreval(" -------------------------------------------------------------------------------")
           fimse
           Se (GERAL[x]="IDEAL") entao
            escreval(" TANQUE ",tanque[x]:3,"  |   >",temperatura[x]:2,"°C<","     >",ph[x]:3:1,"<","     >",oxigenio[x]:3:1,"< ","    >",amonia[x]:4:2,"<      |  >",GERAL[x],"<")
           Senao
            escreval(" TANQUE ",tanque[x]:3,"  |    ",temperatura[x]:2,"°C ",ph[x]:9:1," ",oxigenio[x]:9:1,"  ",amonia[x]:9:2,"       |  ",GERAL[x])
           Fimse
           lin<-lin+1
       fimpara

    Se lin>0 ENTAO
        Escreval(" -------------------------------------------------------------------------------")
        Escreval(" < Pressione >>ENTER<< Para retornar ao Menu > ")
        leia(parada)
        limpatela
    fimse
FimProcedimento

//==============================================================================================================

Procedimento consulta
var
lin:inteiro
tp:caracter
inicio
lin<-0
 Repita
 Escreva(" CLASSIFICAR POR TANQUE(1), CRESCENTE(2) OU DECRESCENTE(3): ")
 leia(tp)
 Ate (tp="1") ou (tp="2") ou (tp="3")
 Se (op="2") entao
 class_temperatura(tp)
 limpaTela
 Para x de 1 ate totaltanque faca
           Se lin=0 ENTAO
                Escreval("               TEMPERATURA     PH    OXIGENIO    AMONIA     STATUS DA TEMPERATURA")
                Escreval(" -------------------------------------------------------------------------------")
           fimse
            escreval(" TANQUE ",tanque[x]:3,"  |   ","> ",temperatura[x]:2,"°C <",ph[x]:9:1," ",oxigenio[x]:9:1," ",amonia[x]:9:2,"    |  ",TEMPSTATUS[x])
           lin<-lin+1
 fimpara
 Senao
    Se (op="3") entao
       class_ph(tp)
       limpatela
       Para x de 1 ate totaltanque faca
           Se lin=0 ENTAO
                Escreval("               TEMPERATURA     PH    OXIGENIO    AMONIA     STATUS DO PH")
                Escreval(" -------------------------------------------------------------------------------")
           fimse
            escreval(" TANQUE ",tanque[x]:3,"  |    ",temperatura[x]:2,"°C       ","> ",ph[x]:3:1," <",oxigenio[x]:7:1," ",amonia[x]:9:2,"    |  ",PHSTATUS[x])
           lin<-lin+1
       fimpara
    Senao
       Se (op="4") entao
          class_oxigenio(tp)
                 limpatela
       Para x de 1 ate totaltanque faca
           Se lin=0 ENTAO
                Escreval("               TEMPERATURA    PH     OXIGENIO    AMONIA     STATUS DO OXIGENIO")
                Escreval(" -------------------------------------------------------------------------------")
           fimse
            escreval(" TANQUE ",tanque[x]:3,"  |    ",temperatura[x]:2,"°C       ",ph[x]:3:1,"     > ",oxigenio[x]:3:1," <",amonia[x]:9:2,"    |  ",OXIGENIOSTATUS[x])
           lin<-lin+1
       fimpara
          Senao
             Se (op="5") entao
                class_amonia(tp)
                       limpatela
       Para x de 1 ate totaltanque faca
           Se lin=0 ENTAO
                Escreval("               TEMPERATURA   PH     OXIGENIO     AMONIA       STATUS DA AMONIA")
                Escreval(" -------------------------------------------------------------------------------")
           fimse
            escreval(" TANQUE ",tanque[x]:3,"  |    ",temperatura[x]:2,"°C ",ph[x]:9:1," ",oxigenio[x]:9:1,"      > ",amonia[x]:4:2," <    |  ",AMONIASTATUS[x])
           lin<-lin+1
       fimpara
             fimse
       fimse
    fimse
 fimse

    Se lin>0 ENTAO
        Escreval(" -------------------------------------------------------------------------------")
        Escreval(" < Pressione >>ENTER<< Para retornar ao Menu > ")
        leia(parada)
        limpatela
    fimse
Fimprocedimento

//==============================================================================================================
//==== PROGRAMA ================================================================================================
//==============================================================================================================

Procedimento Menu
inicio
Repita
  Limpatela
  Escreval("   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
  Escreval("                               B  I  G  F  I  S  H")
  Escreval("   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
  Escreval
  Escreval
  EscrevaL(" M E N U  P R I N C I P A L")
  Escreval
  Escreval(" 1 - CONSULTAR GERAL")
  Escreval(" 2 - CONSULTAR APENAS TEMPERATURA")
  Escreval(" 3 - CONSULTAR APENAS PH ")
  Escreval(" 4 - CONSULTAR APENAS OXIGÊNIO")
  Escreval(" 5 - CONSULTAR APENAS AMÔNIA")
  Escreval(" 6 - FIM")
  Escreval
  Escreval
  Escreval
  Escreva(" OPÇÃO: ")
  leia(op)
  Escolha op
     Caso "1"
          consulta_geral
     Caso "2"
          consulta
     Caso "3"
          consulta
     Caso "4"
          consulta
     Caso "5"
          consulta
  FimEscolha
Ate (op="6")
FimProcedimento

//==============================================================================================================
//==============================================================================================================

inicio
Leitura
recebe_geral
recebe_temperatura
recebe_ph
recebe_oxigenio
recebe_amonia
Menu
fimalgoritmo

