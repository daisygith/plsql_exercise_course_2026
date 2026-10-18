alter session set current_schema = kurs_plsql;

set serveroutput on;
-- M5 zad 3/ M9 zad 1
DROP FUNCTION LICZ_BMI;
CREATE OR REPLACE FUNCTION LICZ_BMI(
    v_height number,
    v_weight number
) 
RETURN VARCHAR2
IS
    v_height2 NUMBER;
    v_bmi number;
    v_przedzial_ponizej varchar2(100):= '<16 "ale z Ciebie niejadek" ';
    v_przedzial_idealny varchar2(100):= '>=16 i <25 "dobra forma, tak trzymaj" ';
    v_przedzial_powyzej varchar2(100):= '>= 25 "zrób kilka pompek" ';
    v_przedzial varchar2(100);
    ex_too_big EXCEPTION;   

begin

    if v_height > 225 then 
        RAISE ex_too_big;
    end if;
    
    
    v_przedzial := '';
    v_height2 := v_height/100;
    v_bmi := v_weight/power(v_height2,2);
        
    if v_bmi < 16 then
        v_przedzial := v_przedzial_ponizej;
    elsif v_bmi >=16 and v_bmi <25 then
        v_przedzial := v_przedzial_idealny;
    else 
        v_przedzial := v_przedzial_powyzej;
    end if;
    
--    dbms_output.put_line(v_przedzial);
    return v_przedzial;
EXCEPTION
    WHEN ex_too_big THEN
        RAISE_APPLICATION_ERROR(-20002,'podany wzrost jest nienaturalnie du¿y i nale¿y wprowadziæ poprawn¹ wartoœæ');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003,'wyst¹pi³ b³¹d o kodzie: '||sqlcode||', komunikat: '||sqlerrm);
    
end;
/
DECLARE
    RESULT VARCHAR(1000);
BEGIN
    RESULT := LICZ_BMI(172,68);
    DBMS_OUTPUT.PUT_LINE(RESULT);
END;
/
-- M9 zad 2
/*RETURN
koñczy program nazwany lub blok anonimowy
ale te¿ zwraca wartoœæ do miejsca wywo³ania.

RETURN WARTOSC
koñczy funkcjê
oddaje sterowanie do wywo³uj¹cego.

EXIT
koñczy pêtle
a program wykonuje siê dalej od instrukcji po pêtli.
*/
-- M9 zad 3
select * from employees;

DROP FUNCTION CZY_PARZYSTE;
CREATE OR REPLACE FUNCTION CZY_PARZYSTE(p_liczba number)
RETURN VARCHAR2
IS
 v_czy_jest varchar2(100);
 v_id number;
BEGIN 

    v_id := mod(p_liczba,2);

    if v_id = 0 then
        v_czy_jest := 'TAK';
    else 
        v_czy_jest := 'NIE';
    end if;
    
    return v_czy_jest;
END CZY_PARZYSTE; 
/
select CZY_PARZYSTE(employee_id) from employees;

declare 
    v_jest varchar2(100);
begin

    for i in 1..10
    loop
        v_jest := CZY_PARZYSTE(i);
        dbms_output.put_line('Nr '|| i || ' jest liczb¹ parzyst¹: ' || v_jest);
    end loop;
end;
/
-- M9 zad 4
select * from employees where department_id = 40;

CREATE OR REPLACE FUNCTION ZWROC_PENSJE(
p_employee_id number)
RETURN NUMBER
IS
v_nowa_pensja number;
v_aktualna_pensja number;
begin
    select salary into v_aktualna_pensja from employees where employee_id = p_employee_id;
    
    if v_aktualna_pensja < 5000 then 
        v_nowa_pensja := (v_aktualna_pensja*0.2)+v_aktualna_pensja;
    elsif v_aktualna_pensja >= 5000 and v_aktualna_pensja <7000 then
        v_nowa_pensja := (v_aktualna_pensja*0.15)+v_aktualna_pensja;
    else 
        v_nowa_pensja := (v_aktualna_pensja*0.1)+v_aktualna_pensja;
    end if;
    
    return v_nowa_pensja;
end ZWROC_PENSJE;
/

CREATE OR REPLACE PROCEDURE AKTUALIZUJ_PENSJE(
p_department_id number)
is
v_zwracana_pensja number;
begin
    for i in (select employee_id, first_name, last_name  from employees where department_id = p_department_id)
    loop
        v_zwracana_pensja := ZWROC_PENSJE(i.employee_id);
        update employees set salary = v_zwracana_pensja where employee_id = i.employee_id;
        dbms_output.put_line('Nowa pensja pracownika ' || i.first_name || ' ' || i.last_name || ' wynosi: ' || v_zwracana_pensja);
    end loop;
    
end AKTUALIZUJ_PENSJE;
/

exec AKTUALIZUJ_PENSJE(50);
