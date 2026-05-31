/*Zad1.
	Używając kotwiczenia %ROWTYPE wczytaj całą tabelę departments do kolekcji:
		asocjacyjnej
		zagnieżdżonej
		varray
Zad2. 
	Użyj pętli FOR by wyświetlić nazwę departamentu i id_managera na konsoli.
	Stwórz kolekcję asocjacyjną indeksowaną tekstem. Zapisz do niej listę wszystkich predefiniowanych wyjątków Oracle. Indeks kolekcji to kod ORA, wartość przechowywana w kolekcji to nazwa wyjątku, np. kolekcja(‘ora-01422’) powinna zwracać wartość “too_many_rows”, a kolekcja(‘ora-01001’) powinna zwracać wartość “invalid_cursor”. Do wyświetlenia zawartości kolekcji w konsoli użyj pętli WHILE.

	Uwaga. Listę wyjątków znajdziesz w Twojej poprzedniej pracy domowej (moduł 5 zadanie 5)

Zad3.
	Stwórz kolekcję nested table zawierającą liczby od 1 do 10. Następnie wykorzystując metodę DELETE usuń element 2, 5 i 9. Wyświetl następnie zawartość całej kolekcji wykorzystując metodę NEXT.
	Uwaga. Metoda NEXT jest Ci potrzebna do tego, by w  pętli iterować wyłącznie po elementach kolekcji, tzn. by z indeksu 1 przejeść do indeksu 3, 
	a z indeksu 4 do indeksu 6, itd. Inaczej mówiąc Twoja pętla powinna wykonać 7, a nie 10 iteracji, bo tyle elementów zawiera kolekcja.

Zad4. 
	Udziel odpowiedzi na poniższe pytania pisząc: AT(kolekcja asocjacyjna), NT (kolekcja nested table) lub  VT(kolekcja VARRAY). 
	Która kolekcja:
		ma maksymalną liczbę elementów?
		może być indeksowana tekstem?
		ma dodatkowe operatory do porównywania kolekcji?
		nie wymaga inicjalizacji?
		nie może być rzadka?
		nie może być użyta w SQL?
*/