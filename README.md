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
  <p>Servomotor (též zkráceně servo) je typ motoru, u něhož můžeme pomocí řídícího signálu řídit natočení osy. Lze tak nastavit přesný úhel natočení serva na základě vstupních požadavků uživatele. Poloha serva se nastavuje pomocí měnící se střídy signálu přivedeného na jeho řídídí vstup. Na tento vstup mohou být přivedeny dvě logické úrovně, logická 1 a logická 0, přičemž střída řídícího signálu udává poměr mezi těmito úrovněmi. Pomocí PWM je tato střída nastavována, a tím i poloha natočení serva.</p> 
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
  <p><h4>Pro použitá serva udává výrobce následující důležité parametry:</h4>
  - základní frekvence řídídích pulzů je 50 Hz, základní perioda je tedy 20 ms <br>
  - možnost otočení osy serva o 180°, krajní pozice 0° odpovídá šířce pulzu 1 ms, krajní pozice 180° odpovídá šířce pulzu 2 ms <br>
  - provozní napětí 4,8 až 6 V</p>
  <p><h4>Popis hardwarového zapojení</h4>
  Program v jazyce VHDL je nahrán na desku Nexys A7, přičemž pro připojení servomotoů k desce jsou vyuity Pmod výstupy s označením JA. Zapojeny jsou tři serva, každé na jeden z nezávislých výstupů JA1 až JA3. To umožňuje každé servo ovládat odděleně, nezávisle na ostatních, přičemž přepínání ovládání mezi servy je realizováno pomocí přepínačů na desce Nexys. </p>
  

  
</div>









