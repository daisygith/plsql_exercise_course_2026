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
-- M5 zad 3
declare 
    v_hight number := 250;
    v_weight number := 80;
    v_bmi number;
    v_przedzial_ponizej varchar2(100):= '<16 "ale z Ciebie niejadek" ';
    v_przedzial_idealny varchar2(100):= '>=16 i <25 "dobra forma, tak trzymaj" ';
    v_przedzial_powyzej varchar2(100):= '>= 25 "zrób kilka pompek" ';
    v_przedzial varchar2(100);
    ex_too_big EXCEPTION;   

begin

    if v_hight > 225 then 
        RAISE ex_too_big;
    end if;
    
    
    v_przedzial := '';
    v_hight := v_hight/100;
    v_bmi := v_weight/power(v_hight,2);
        
    if v_bmi < 16 then
        v_przedzial := v_przedzial_ponizej;
    elsif v_bmi >=16 and v_bmi <25 then
        v_przedzial := v_przedzial_idealny;
    else 
        v_przedzial := v_przedzial_powyzej;
    end if;
    
    dbms_output.put_line(v_przedzial);
EXCEPTION
    WHEN ex_too_big THEN
        DBMS_OUTPUT.PUT_LINE('podany wzrost jest nienaturalnie du¿y i nale¿y wprowadziæ poprawn¹ wartoœæ');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('wyst¹pi³ b³¹d o kodzie: '||sqlcode||', komunikat: '||sqlerrm);
    
end;
/

--M5 zad 4
--https://docs.oracle.com/en/database/oracle/oracle-database/18/lnpls/plsql-error-handling.html?source=%3Aso%3Ach%3Aor%3Adg%3A%3A%3A%3ATurnOnIn+%3Aow%3Aevp%3Acpo%3A%3A%3A%3ARC_CORP260213P00018%3ALPD400439168&source=%3Aso%3Ach%3Aor%3Adg%3A%3A%3A%3ATurnOnIn+%3Aow%3Aevp%3Acpo%3A%3A%3A%3ARC_CORP260213P00018%3ALPD400439168&source=%3Aso%3Ach%3Aor%3Adg%3A%3A%3A%3ATurnOnIn+%3Aow%3Aevp%3Acpo%3A%3A%3A%3ARC_CORP260213P00018%3ALPD400439168&source=%3Aso%3Ach%3Aor%3Adg%3A%3A%3A%3ATurnOnIn+%3Aow%3Aevp%3Acpo%3A%3A%3A%3ARC_CORP260213P00018%3ALPD400439168&source=%3Aso%3Ach%3Aor%3Adg%3A%3A%3A%3ATurnOnIn+%3Aow%3Aevp%3Acpo%3A%3A%3A%3ARC_CORP260213P00018%3ALPD400439168&source=%3Aso%3Ach%3Aor%3Adg%3A%3A%3A%3ATurnOnIn+%3Aow%3Aevp%3Acpo%3A%3A%3A%3ARC_CORP260213P00018%3ALPD400439168&source=%3Aso%3Ach%3Aor%3Adg%3A%3A%3A%3ATurnOnIn+%3Aow%3Aevp%3Acpo%3A%3A%3A%3ARC_CORP260213P00018%3ALPD400439168#GUID-4F0787E6-ABCA-4860-A28E-435C7FE15154


--M5 zad 5
--3  rodzaje wyj¹tków:
--- systemowe predefiniowane - wyj¹tki def. przez oracle, którymi producent nada³ w³asne nazwy
--- systewmowe niedefiniowane - wyj¹tki wywo³ywane przez oracle, którym producent nie nada³ w³asnej nazwy
--- u¿ytkownika - wyj¹tki, które samemu trzeba zdefinowaæ i wywo³aæ

