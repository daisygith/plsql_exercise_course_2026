/*
1. Napisz procedurę wygeneruj_liste_produktow, która wyświetli na konsoli wszystkie produkty (tabela products).
2. Stwórz procedurę o nazwie wyswietl_przelozonego_pracownika, która będzie wyświetlać imię i nazwisko pracownika 
	oraz imię i nazwisko jego przełożonego(manager_id). W parametrze procedury przekazywany powinien być id_pracownika. 
	Przykładowo: EXECUTE wyswietl_przelozonego_pracownika(101);  powinno zwrócić informację “Steven King jest przełożonym pracownika: Neena Jochhar”.
3. Stwórz procedurę o dowolnie wybranej (sensownej) nazwie, która będzie zmieniać nazwę_kraju(country_name) 
	na duże litery dla wszystkich krajów z podanego w parametrze id regionu. W parametrze w trybie OUT zwróć informację o
	liczbie zmodyfikowanych rekordów. Wynik uruchomienia procedury powinien wyglądać następująco: “Zmodyfikowano nazwę x 
	krajów należących do regionu id_regionu”.
	Wywołaj program notacją nazwaną dla regionu o id=4.
4. Zmodyfikuj blok anonimowy z MODUŁU 7 lekcja 4, tak by wszystkie wyświetlane atrybuty_kursorowe
	(przed i po poleceniu SELECT) wyświetlały się poprzez wywołanie lokalnej procedury wyświetl_atrybuty_kursorowe.
5. Napisz procedurę, która wyświetli wszystkie nieskompilowane obiekty w schemacie użytkownika kurs_plsql. 
	Jeśli nie znajdziesz żadnego takiego obiektu to wyświetl informację: “Wszystkie obiekty w schemacie kurs_plsql są skompilowane”.
	*/
