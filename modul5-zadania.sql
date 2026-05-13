alter session set current_schema = kurs_plsql;

set serveroutput on;
--M5 zad 1
DECLARE
v_value NUMBER := 5;
BEGIN
  CASE v_value
    WHEN 1 THEN
      DBMS_OUTPUT.PUT_LINE('Branch 1');
    WHEN 2 THEN
      DBMS_OUTPUT.PUT_LINE('Branch 2');
    WHEN 3 THEN
      DBMS_OUTPUT.PUT_LINE('Branch 3');
  END CASE;
EXCEPTION
  WHEN CASE_NOT_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Wykryto b³¹d, kod:'||SQLCODE||', komunikat: '||SQLERRM);
    DBMS_OUTPUT.PUT_LINE('¯eby b³¹d siê nie pojawia³ liczba musi byæ w zakresie 1-3');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Wyst¹pi³ b³¹d: ' || SQLERRM);
END;
/
--M5 zad 2
DECLARE
    ex_country_insert EXCEPTION;   
    PRAGMA EXCEPTION_INIT(ex_country_insert, -1);
BEGIN
    INSERT INTO HR.COUNTRIES(COUNTRY_ID, COUNTRY_NAME) values( 'ML', 'Malta');
--    RAISE ex_user;
EXCEPTION
    WHEN ex_country_insert THEN
        DBMS_OUTPUT.PUT_LINE('B³¹d, nie mo¿na wykonaæ inserta na tabeli countries');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('wyst¹pi³ b³¹d o kodzie: '||sqlcode||', komunikat: '||sqlerrm);
END;
/
--
--SELECT * FROM COUNTRIES;
--SELECT owner, table_name FROM all_tables WHERE table_name = 'COUNTRIES';
