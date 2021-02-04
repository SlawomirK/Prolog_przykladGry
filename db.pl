:- dynamic(aktualna_pozycja/1).

%fakty opisujace położenie obiektów
%polozenie scian względem siebie
przy(sciana_polnocna,sciana_wschodnia).
przy(sciana_polnocna,sciana_zachodnia).
przy(scianaWschodnia,scianaPolnocna).
przy(scianaWschodnia,scianaPoludniowa).
przy(scianaPoludniowa,scianaWschodnia).
przy(scianaPoludniowa,scianaZachodnia).
przy(scianaZachodnia,scianaPolnocna).
przy(scianaZachodnia,scianaPoludniowa).
%meble
przy(lozko,scianaZachodnia).
przy(lozko,scianaPoludniowa).
przy(scianaPolnocna,lustro).
przy(szafka_nocna,lozko).
przy(szafka_nocna,scianaPoludniowa).
przy(biurko,scianaPoludniowa).
przy(biurko,scianaWschodnia).
przy(biurko,okno).
przy(szafa,scianaPolnocna).
przy(szafa,scianaWschodnia).
przy(szafa,okno).
przy(lustro,scianaPolnocna).
przy(lustro,szafa).


%relacje symetryczna
przy(X,Y):-przy(X,Y),!.
przy(X,Y):-przy(Y,X),!.


naprzeciwko_w_odleglosci(scianaPolnocna,scianaPoludniowa,3).
naprzeciwko_w_odleglosci(scianaWschodnia,scianaZachodnia,5).
naprzeciwko_w_odleglosci(lozko,lustro,1).
naprzeciwko_w_odleglosci(lozko,biurko,2).
naprzeciwko_w_odleglosci(X,Y,_):-naprzeciwko_w_odleglosci(X,Y,_),!.
naprzeciwko_w_odleglosci(X,Y,_):-naprzeciwko_w_odleglosci(Y,X,_).


%okno, drzwi
jest_w(okno,scianaWschodnia).
jest_w(drzwi,scianaZachodnia).


%reguly opisujące obiekty
opisz(lozko) :-
        write('Jestes przy lozku'), nl,
        write('Polozone jest w rogu pokoju przy scianach poludniowej i zachodniej'),
		%write('obok jest'),nl,przy(lozko,X),write(X),
		nl.
		
opisz(szafka_nocna):-
		write('Patrzysz na mala brazowa szafke nocna'), nl,
        write('Polozona jest po prawej stronie lozka'), nl.

opisz(szafa):-
		write('Jestes przy szafie niedaleko jest biurko, '),nl,
		write('tuz obok okna'),nl.

opisz(biurko):-
		write('Jestes przy biurku niedaleko szafy, '),nl,
		write('tuz obok okna'),nl.
		
opisz(lustro):-
		write('Jestes przed lustrem'),nl,
		write('ma okolo 1.5 metra wysokosci, ale jest zbyt ciemno aby cos w nim zobaczyc'),nl.
		
opisz(drzwi):-
		write('Jestes tuz obok drzwi'),nl.
		
opisz(komar_zabity):-
		write('PLASK!!!, komar zabity. Mozesz isc spac'),nl,graj(0),nl.
		
opisz(komar_zyje):-
		write('komar wciaz bzyczy i nie daje ci zasnac'),nl.
		
opisz(srodek):-
		write('Jestes posrodku pokoju'),nl.
		



ruch_do_przodu([X,Y]):-	
	(Y >= 3 -> N = Y;N is Y+1),
	retract(aktualna_pozycja([X,Y])),
	asserta(aktualna_pozycja([X,N])),
	do_przodu([X,Y],[X,N]).
	
ruch_w_lewo([X,Y]):-
	(X =< 1 -> N = X;N is X-1),
	retract(aktualna_pozycja([X,Y])),
	asserta(aktualna_pozycja([N,Y])),
	w_lewo([X,Y],[N,Y]).
	
ruch_w_prawo([X,Y]):-
	(X >= 3 -> N = X;N is X+1),
	retract(aktualna_pozycja([X,Y])),
	asserta(aktualna_pozycja([N,Y])),
	w_prawo([X,Y],[N,Y]).
	
ruch_do_tylu([X,Y]):-
	(Y =< 1 -> N = Y;N is Y-1),
	retract(aktualna_pozycja([X,Y])),
	asserta(aktualna_pozycja([X,N])),	
	do_tylu([X,Y],[X,N]).
	

do_przodu([1,1],[1,2]):-opisz(lustro).
do_przodu([1,2],[1,3]):-opisz(szafa).
do_przodu([1,3],[1,3]):-
	write('Walisz czolem w sciane!,'),nl,
	write('jestes w rogu pokoju, nie mozesz isc w lewo i do przodu'),nl,
	opisz(szafa).

do_przodu([2,1],[2,2]):-opisz(srodek).
do_przodu([2,2],[2,3]):-opisz(okno).
do_przodu([2,3],[2,3]):-
					write('Czy chcesz wypasc przez okno?'),nl,
					opisz(okno).

do_przodu([3,1],[3,2]):-opisz(szafka_nocna).
do_przodu([3,2],[3,3]):-opisz(biurko).
do_przodu([3,3],[3,3]):-w_prawo([3,3],[3,3]).

do_tylu([1,3],[1,2]):-opisz(lustro).
do_tylu([1,2],[1,1]):-opisz(drzwi).
do_tylu([1,1],[1,1]):-write('Opierasz sie o zamkniete drzwi'),nl.

do_tylu([2,3],[2,2]):-opisz(srodek).
do_tylu([2,2],[2,1]):-opisz(lozko).
do_tylu([2,1],[2,1]):-write('Jestes na luzku, dalej sie nie cofniesz'),nl.

do_tylu([3,3],[3,2]):-opisz(szafka_nocna).
do_tylu([3,2],[3,1]):-opisz(lozko).
do_tylu([3,1],[3,1]):-write('jestes w rogu pokoju, na luzku.'),
						nl,write('nie mozesz sie cofnac ani pojsc w prawo'),nl.


w_lewo([1,1],[1,1]):-write('Nie mozesz wejsc w sciane'),nl.
w_lewo([1,2],[1,2]):-write('Nie mozesz wejsc w lustro'),nl.
w_lewo([1,3],[1,3]):-write('Nie mozesz wejsc do szafy'),nl.
				
w_lewo([2,1],[1,1]):-opisz(drzwi).
w_lewo([2,2],[1,2]):-opisz(lustro).
w_lewo([2,3],[1,3]):-opisz(szafa).

w_lewo([3,1],[2,1]):-opisz(lozko).
w_lewo([3,2],[2,2]):-opisz(srodek).
w_lewo([3,3],[2,3]):-opisz(lozko).

w_prawo([1,1],[2,1]):-opisz(lozko).
w_prawo([2,1],[3,1]):-opisz(lozko).
w_prawo([3,1],[3,1]):-write('po prawej jest sciana, dalej w prawo nie pojdziesz'),nl.

w_prawo([1,2],[2,2]):-opisz(srodek).
w_prawo([2,2],[3,2]):-write('wpadasz nad szafke nocna'),nl,opisz(szafka_nocna).
w_prawo([3,2],[3,2]):-write('za szafka nocna jest juz tylko sciana'),nl.

w_prawo([1,3],[2,3]):-opisz(okno).
w_prawo([2,3],[3,3]):-opisz(biurko).
w_prawo([3,3],[3,3]):-	
					write('jestes w rogu pokoju, nie mozesz isc w prawo ani do przodu'),nl,
					opisz(biurko).



jestes_w([2,1]):-opisz(lozko).
jestes_w([3,1]):-opisz(lozko).
jestes_w([3,2]):-opisz(szafka_nocna).
jestes_w([3,3]):-opisz(biurko).
jestes_w([1,3]):-opisz(szafa).
jestes_w([1,2]):-opisz(lustro).
jestes_w([1,1]):-opisz(drzwi).
jestes_w([2,2]):-opisz(srodek).
jestes_w([2,3]):-opisz(srodek).



	
	
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~POZYCJE GRACZA I KOMARA~~~~~~~~~~~~~~~~~~

aktualna_pozycja([1,1]).
pozycja_komara(Zs):-length(Zs,2),maplist(random(1,4),Zs).
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


%~~~~STEROWANIE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
krok(n):-aktualna_pozycja(X),ruch_do_przodu(X),graj(1).
krok(l):-aktualna_pozycja(X),ruch_w_lewo(X),graj(1).
krok(p):-aktualna_pozycja(X),ruch_w_prawo(X),graj(1).
krok(t):-aktualna_pozycja(X),ruch_do_tylu(X),graj(1).
krok(e):-graj(0).
krok(_):-write('Nogi ci sie placza ze zmeczenia i nie wiesz gdzie isc'),graj(1),nl.

graj(0):-
	write('Polowanie na komara zakonczone, spokojnej nocy'),nl.
	
graj(1):-
	pozycja_komara(POZYCJA_KOMARA),
	aktualna_pozycja(POZYCJA_GRACZA),nl,
	write('gracz'),write(POZYCJA_GRACZA),write('komar'),write(POZYCJA_KOMARA),nl,
	(POZYCJA_GRACZA \== POZYCJA_KOMARA -> nastepny_krok;opisz(komar_zabity)).

nastepny_krok:-
	write('n.-naprzod,l.-lewo,p.-prawo,t.-do tylu'),nl,
	write('e.-jezeli chcesz przerwac'),nl,
	write('Jaki jest twoj kolejny krok?(n/l/p/t) '),nl,
	read(X),
	krok(X),nl.

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

start:-graj(1).

