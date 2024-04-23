<h1 align="center"> Řešení semestrálního projektu z předmětu BPC-DE1</h1>
<h2 align="center">Zadání č. 3: Řízení polohy servomotoru pomocí PWM </h2>

<div>
  <h2>Na projektu spolupracovali:</h2>
  <p>Matěj Matoušek(247142)</p>
  <p>Věra Podestátová (247800)</p>
  <p>Lukáš Bahurinský (240227)</p>
  <p>Petr Losert (247140)</p>
</div>
<br>
<div>
  <p><h2>Teoretický rozbor a vysvětlení problému</h2></p>
  <p>Cílem projektu je vývoj a implementace programu pro ovládání úhlu natočení na sobě nezávislých servomotorů na desku Nexys A7. Natočení jednotlivých servmotorů je řízeno pomocí pulzně šířkové modulace.</p>
  <p><h3>Ovládání polohy servomotoru pomocí pulsně šířkové modulace (PWM)</h3></p>
  <p>Servomotor (též zkráceně servo) je typ motoru, u něhož můžeme pomocí řídícího signálu ovládat natočení osy. Lze tak nastavit přesný úhel natočení serva na základě vstupních požadavků uživatele. Poloha serva se nastavuje pomocí měnící se střídy signálu přivedeného na jeho řídídí vstup. Na tento vstup mohou být přivedeny dvě logické úrovně, logická 1 a logická 0, přičemž střída řídícího signálu udává poměr mezi těmito úrovněmi. Pomocí PWM je tato střída nastavována, a tím i poloha natočení serva. Princip PWM je nastíněn na následujícím obrázku. Jedná se vlastně o integrátor s komparátorem, kde je sčítána doba, po kterou vstupní napěťové pulzy nosného signálu (v obrázku zelenou barvou) mají nižší úroveň, než modulační signál (černou barvou), přičemž po tuhle dobu je výstupní napětí (červenou barvou) v logické úrovni 1. Jakmile dojde k překročení úrovně modulačního signálu, výstup se nastaví do logické úrovně 0. Tím je nastavena šířka výstupního obdélníkového pulzu v závislosti na velikosti úrovně modulačního signálu. Tento proces se opakuje každou periodu nosného signálu.</p>
   <div align="center"> 
     
   ![Princip PWM](https://github.com/Mgfgtes/DE1project/assets/114689757/677637af-a6d0-4ff2-9cb6-c7af3420bfb0)
   </div>  
   <p>K principu pulsně šířkové modulace, převzato z internetu</p> 
     
   
  
  <p><h4>Pro použitá serva udává výrobce následující důležité parametry:</h4>
  - základní frekvence řídídích pulzů je 50 Hz, základní perioda je tedy 20 ms <br>
  - možnost otočení osy serva o 180°, krajní pozice 0° odpovídá šířce pulzu 1 ms, krajní pozice 180° odpovídá šířce pulzu 2 ms. Při testování programu jsme ovšem zjistili, že výrobcem dané meze odpovídají natočení serva jen přibližně o 90°, a proto délku impulzu budeme měnit v romezí od 0,5 ms do 2,5 ms, abychom dosáhli natočení o 180°. Níže uvedené obrázky z měření digitálním osciloskopem ukazují skutečnou minimální a maximální šířku pulzu na PWM výstupu pro otočení serva o 180°.<br>
  - provozní napětí 4,8 až 6 V</p>
<br>

  ![Natoceni serva](https://github.com/Mgfgtes/DE1project/assets/114689757/0d093c4b-1b02-4a41-9426-395c6ebf445d)
<p>Obrázek výrobcem udávaných časových průběhů, překresleno z datasheetu Micro Serva SG90</p> 
<br>
<br>
<div align="center">
  
![OSC_05ms](https://github.com/Mgfgtes/DE1project/assets/114689757/449af7f4-e191-4de7-b51b-0d16f925fdef)
</div>
<p>Měření osciloskopem - skutečná minimální šířka pulzu na výstupu PWM (0,5 ms)</p> 
<br>
<br>
<div align="center">
  
![OSC_25ms](https://github.com/Mgfgtes/DE1project/assets/114689757/6e94a501-7177-4582-ae4e-6e2f9585e5c0)
</div>
<p>Měření osciloskopem - skutečná maximální šířka pulzu na výstupu PWM (2,5 ms)</p>
</div>
<br>
<div>

  <p><h2>Hardwarové komponenty a schéma zapojení</h2></p>
  <p><h4>Pro sestavení projektu jsme použili hardwarové komponenty:</h4>
  - servomotory Micro Servo SG90 <br>
  - převodník napěťové úrovně s tranzistory <br> 
  - Arduino UNO desku <br>
  - Nexys A7 desku <br>
  - propojoací kabely, nepájivé pole a digitální osciloskop pro kontrolní měření a odladění programu</p>
  <p><h4>Popis hardwarového zapojení</h4>
Schéma zapojení je na obrázku níže. Program v jazyce VHDL je nahrán na desku Nexys A7, přičemž pro připojení servomotorů k desce jsou využity Pmod výstupy s označením JA. Zapojeny jsou tři serva, jejich řídící vstupy jsou zapojeny každý na jeden z nezávislých výstupů JA1 až JA3. To umožňuje každé servo ovládat odděleně, nezávisle na ostatních, přičemž přepínání ovládání mezi servy je realizováno pomocí přepínačů na desce Nexys. Z desky Nexys je dále vyveden výstup 3,3 V (JA6) a výstup GND (JA5). Provozní napětí serv je ovšem 5 V, a proto jsou řídící výstupy JA1 až JA3 zapojeny k měniči úrovně napětí s tranzistory z 3,3 V na 5 V na vstupy LV1 až LV3. Reference nižšího napětí je tedy k měniči přivedena z desky Nexys na vstup LV měniče, reference napětí vyššího je přivedena z 5V výstupu desky Arduino UNO na vstup HV měniče. Měnič má k dispozici čtyři kanály, přičemž využíváme tři z nich, jelikož máme připojena tři serva. Ze vstupů HV1 až HV3 poté odebíráme řídící signály pro jednotlivá serva o požadované úrovni impulsů 5 V. Napájecí výstupy serv jsou připojeny na 5 V. Z desky Arduino UNO je také vyveden výstup GND, všechny výstupy GND jsou navzájem propojeny a přivedeny také na referenční GND vstupy měniče. Implementace umožňuje snadné přidání ovládání dalších serv pomocí jednoduché úpravy VHDL kódu. Počet serv je omezen počtem výstupních pinů Pmod. </p>
<p>Uživateli jsou pro ovládní natočení serva k dispozici na desce Nexys tři tlačítka (BTNC, BTNU, BTND) a pro výběr serva přepínače SW0, SW1 a SW2. Pro indikaci stavu natočení je pro servo č. 1 použito deset LED.</p>
  
![Schema zapojeni](https://github.com/Mgfgtes/DE1project/assets/114689757/80ef8e48-1399-4865-a4cc-4bf4bb2dfe68)
<p>Schéma hardwarového zapojení</p>

</div>
<br>
<div>
<p><h2>Popis programové části</h2></p>
   
![top_level](https://github.com/Mgfgtes/DE1project/assets/114689757/a4397063-eed4-40cc-8d28-a4293e025803)
<p>Schéma programové implementace</p> 
  
<p><h3>Popis a simulace nově vytvořené VHDL komponenty</h3> 
<p><h4>Princip funkce nové komponenty a základní princip programu</h4></p>  
Pro ovládní serv pomocí PWM jsme naprogramovali a použili novou komponentu s názvem PWM_controller. Pomocí ní ovládáme šířku výstupních impulsů a tím i střídu výstupních PWM signálů. Základní princip komponenty je založen na funkci integrátoru a komparátoru. Nejprve jsme si definovali vnitřní signál sig_width, který je pro nás v PWM modulačním signálem, a jehož hodnotu uživatelsky nastavujeme tlačítky. Právě s tímto signálem totiž porovnáváme 11bitový výstup sig_count_11bit čítače simple_counter, který cyklicky čítá od 0 do 2047. Dokud je hodnota čítače menší, než úroveň modulačního signálu sig_width, je výstup pwm v úrovni logické 1. Jakmile ovšem hodnota čítače přesáhne hodnotu signálu sig_width, výstup pwm se překlopí do logické 0. V tomto stavu zůstane až do konce periody čítače a na počátku periody další se opět překlopí do logické 1, v níž zůstane opět až do chvíle, než hodnota čítače dosáhne hodnoty sig_width. Celý cyklus se poté periodicky opakuje.</p>

<p>V souladu s informacemi v datasheetu je základní perioda serva (tedy pro náš PWM algoritmus jedna čítací perioda čítače) 20 ms. Víme, že vnitřní taktovací signál na desce má kmitočet 100 MHz, tedy periodu 10 ns. Použili jsme komponentu clock_enable s periodou 1000 a tím na jejím výstupu dostali pulz každých 10 µs. Tento signál (sig_en_10µs) přivádíme na povolovací (enable) vstup čítače simple_counter. Tím zajistíme inkrementaci jeho výstupní hodnoty každých 10 µs. Aby jedna perioda čítače činila 20 ms, musí mít 11bitový výstup (čítá od 0 do 2047 a každých 10 µs zvýší hodnotu o jedničku). Z uvedého ovšem vyplývá, že perioda bude 20,047 ms. Původně jsme u komponenty PWM_controller implementovali také výstup ovfl, který měl být spojen na resetující vstup čítače, a nastaven tak, aby jej při hodnotě čítače 2000 zresetoval. Na měření pomocí osciloskopu (kde lze vidět i periodu rovnu přibližně 20,047 ms) jsme si ovšem ověřili, že tento přesah nemá na chod PWM vliv. Periody impulzů jsou v požadovaných hodnotách a navíc jsme je pro tato serva museli i značně pozměnit (0,5 až 2,5 ms). Problém by mohl nastat u jiných, mnohem více citlivých serv. Výstup ovfl tedy není využit a na resetující vstup čítače je trvale připojena logická 0.</p>

<p><h4>Stručný popis programu a simulace PWM_controlleru</h4></p>  
<p>Ukázka zdrojového souboru komponenty obsahuje vytvoření signálu sig_width a program je dále řízen procesem reagujícím na změnu hodinového signálu. Je možno vidět nastavení natočení osy po stisku tačítka reset (BTNC) a zmenšování či zvětšování hodnoty sig_width podle toho, jaké tlačítko (BTNU nebo BTND) je stisknuto. Výstup ovfl nevyužíváme. Při přetečení čítače dáváme výstup pwm do logické 1 a zpět do logické 0 se výstup pwm dostane po splnění nerovnosti, což plní funkci komparátoru.    
<div align ="center">

![PWM_src1](https://github.com/Mgfgtes/DE1project/assets/114689757/6c318074-b685-452e-b35a-5e3e7e4fdf1f)
</div>
<p>efef</p>
<div align ="center">

  ![PWM_src2](https://github.com/Mgfgtes/DE1project/assets/114689757/d389a529-5132-47cc-8024-c69890d78591)

<div>  
</div>
<br>
<div>
  <p><h2>Uživatelské ovládání</h2></p>
  <p>Pomocí tří přepínačů umístěných na spodní části desky vpravo si může uživatel zvolit, jaké servo chce ovládat. Vždy ovládá všechna serva, která jsou sepnuta, tedy může jich ovládat i více současně.<br>
  - ovládání serv je spínáno prvními třemi přepínači zprava, tedy přepínači na portech s označením J15 (první servo), L16 (druhé servo) a M13 (třetí servo) <br></p>
  <p>Pomocí stisku nebo držení žlutých tlačítek lze otáčet s vybranými servy s rozsahem 0° až 180°.<br>
  - zapojeno je horní tlačítko s označením BTNU pro otáčení hřídele jedním směrem (zvětšování úhlu natočení), spodní tlačítko s označením BTND pro otáčení hřídele opačným směrem (zmenšování úhlu natočení) a prostřední tlačítko s označením BTNC pro nastavení hřídele do výchozí pozice, přibližně do čtvrtiny natočení z celkového rozsahu (výchozí pozice se dá ve VHDL kódu jednoduše změnit)<br></p>
  <p>Jako vizuální ukazatel polohy hřídele může u prvního serva, spínaného přepínačem SW0 na portu J15, sloužit uživateli deset LED umístěných na desce nad přepínači vpravo, které se rozsvěcují a zhasínají dle natočení serva.<br> - je-li natočení serva 0°, tedy minimální krajní pozice, jsou všechny LED zhasnuty. Při zvětšování úhlu natočení se postupně LED začnou zleva rozsvěcet, až při maximu 180° svítí všechny. Stupnice je lineární, tedy přibližně každých 18° se rozsvítí další LED<br></p>       
  
![Foto zapojeni](https://github.com/Mgfgtes/DE1project/assets/114689757/7f6332b1-0204-4de6-b76d-2c031a7dfce8)
<p>Výsledné zapojení se třemi servy</p>
<br>

https://github.com/Mgfgtes/DE1project/assets/114689757/cd505af3-8283-4342-bff6-1d6995125e22
<p>Videoukázka funkčnosti zapojení (případně odkaz: https://drive.google.com/file/d/1y2hiA-SfcKpSBrbN6JuDif9OUEbGEMcl/view?usp=sharing)</p>



</div>











