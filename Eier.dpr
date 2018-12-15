program Eier;

{$APPTYPE CONSOLE}

{$R+,Q+,X-}

uses
  System.SysUtils,
  Math;

const KARTON_GROESSE = 6;         //Gr��e der Kartons

  var
   menge_bioeier : Word;            //Speicherplatz f�r die Menge der Bioeier
   menge_landeier : Word;           //Speicherplatz f�r die Menge der Landeier
   menge_kaefigeier : Word;         //Speicherplatz f�r die Menge der K�figeier
   menge_kartons : Word;            //Speicherplatz f�r die Menge der Kartons
   gesamtmenge : Word;              //Speicherplatz f�r die Gesamtmenge an Eiern
   anzahl_resteier : Word;          //Speicherplatz f�r die Anzahl der restlichen Eier im letzten Karton
   letzter_karton : Boolean;
   gesamt_karton : byte;
   min_anzahl : word;
   max_anzahl : word;
   meiste_bio : boolean;
   meiste_freiland : boolean;
   meiste_kaefig : boolean;
   wenigste_bio : boolean;
   wenigste_freiland : boolean;
   wenigste_kaefig : boolean;
   jede_gekauft : boolean;
   liebling : boolean;

begin
 writeln ('Wie viele Bioeier sollen verpackt werden? ');       //Frage an den Kunden
  readln (menge_bioeier);                             //Eingabe der Menge an Bioeiern
 writeln ('Wie viele Landeier sollen verpackt werden? ');       //Frage an den Kunden
  readln (menge_landeier);                            //Eingabe der Menge an Landeiern
 writeln ('Wie viele K�figeier sollen verpackt werden? ');      //Frage an den Kunden
  readln (menge_kaefigeier);                          //Eingabe der Menge an K�figeiern
    gesamtmenge := menge_bioeier + menge_landeier + menge_kaefigeier;    //Zusammenrechnen der gesamten Eieranzahl

   anzahl_resteier :=  gesamtmenge mod KARTON_GROESSE ;        //Anzahl der Eier im letzten Karton

   anzahl_resteier := anzahl_resteier + byte(anzahl_resteier = 0) * KARTON_GROESSE;

   menge_kartons := gesamtmenge div KARTON_GROESSE;            //Anzahl der vollen Kartons

   letzter_karton := gesamtmenge mod KARTON_GROESSE > 0 = True;             //Pr�ft ob ein Karton nicht ganz voll ist

   gesamt_karton := byte(gesamtmenge mod KARTON_GROESSE > 0) + menge_kartons;      //Pr�ft ob ein weiterer Karton ben�tigt wird

   writeln ('Sie erhalten insgesammt ', gesamtmenge,  ' Eier in insgesammt ' ,gesamt_karton , ' Kartons.');
   writeln ('Im letzten Karton sind ', anzahl_resteier , ' Eier drinnen.');                    // Sagt gekaufte Eiermenge, Kartons und die Anzahl der Eier im letzten Karton




   min_anzahl := min (menge_bioeier , min (menge_landeier, menge_kaefigeier));                 //Pr�ft wie gro� die minimale Anzahl an Eiern einer Sorte ist

    writeln ('Minimale Anzahl der gekauften Eier: ', min_anzahl);

   max_anzahl := max (menge_bioeier , max (menge_landeier, menge_kaefigeier));                 // Pr�ft wie gro� die maximale Anzahl an Eiern einer Sorte ist

    writeln ('Maximale Anzahl der gekauften Eier: ', max_anzahl);


   meiste_bio := (byte(menge_bioeier > menge_landeier) + byte(menge_bioeier > menge_kaefigeier)) = 2;         // Pr�ft ob Bioeier die gr��te Auswahl ist

    writeln ('Es wurden am meisten Bioeier gekauft: ', meiste_bio);

   meiste_freiland := (byte(menge_landeier > menge_kaefigeier) + byte(menge_landeier > menge_bioeier)) = 2;       //Pr�ft ob Freilandeier die gr��te Auswahl ist

    writeln ('Es wurden am meisten Freilandeier gekauft: ', meiste_freiland);

   meiste_kaefig := (byte(menge_kaefigeier > menge_bioeier) + byte(menge_kaefigeier > menge_landeier)) = 2;             //Pr�ft ob K�figeier die gr��te Auswahl ist

    writeln ('Es wurden am meisten K�figeier gekauft: ', meiste_kaefig);


   wenigste_bio := (byte(menge_bioeier < menge_landeier) + byte(menge_bioeier < menge_kaefigeier)) = 2;               //Pr�ft ob Bioeier die kleinste Auswahl ist

    writeln ('Es wurden am wenigsten Bioeier gekauft: ', wenigste_bio);

   wenigste_freiland := (byte(menge_landeier < menge_kaefigeier) + byte(menge_landeier < menge_bioeier)) = 2;         //Pr�ft ob Freilandeier die kleinste Auswahl ist

    writeln ('Es wurden am wenigsten Freilandeier gekauft: ', wenigste_freiland);

   wenigste_kaefig := (byte(menge_kaefigeier < menge_bioeier) + byte(menge_kaefigeier < menge_landeier)) = 2;         //Pr�ft ob K�figeier die kleinste Auswahl ist

    writeln ('Es wurden am wenigsten K�figeier gekauft: ', wenigste_kaefig);

   jede_gekauft := (byte(menge_bioeier > 0) + byte(menge_landeier > 0) + byte(menge_kaefigeier > 0)) = 3;
     writeln ('Es wurde jede Sorte gekauft: ', jede_gekauft);


   liebling := (byte(meiste_bio) + byte(meiste_freiland) + byte(meiste_kaefig)) = 1;
     writeln ('Es gibt eine eindeutige Lieblingssorte: ', liebling);



    readln;
end.





//byte(anzahl_resteier) = 0 * 6
