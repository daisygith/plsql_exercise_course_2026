alter session set current_schema = kurs_plsql;

set serveroutput on;
--M4 zad 1
declare 
    v_hight number := 180;
    v_weight number := 80;
    v_bmi number;
    v_przedzial_ponizej varchar2(100):= '<16 "ale z Ciebie niejadek" ';
    v_przedzial_idealny varchar2(100):= '>=16 i <25 "dobra forma, tak trzymaj" ';
    v_przedzial_powyzej varchar2(100):= '>= 25 "zrób kilka pompek" ';
    v_przedzial varchar2(100);
begin
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
    
end;
/
--M4 zad 2
DECLARE
    a NUMBER := 20;
    b NUMBER := 41;
    c NUMBER := 0;
BEGIN
   FOR i IN a..b
   LOOP
        LOOP
        c := a-3;
            EXIT WHEN a>41;
            
                        DBMS_OUTPUT.PUT_LINE('aktualna wartoœæ: '|| a || ', poprzednia wartoœæ: ' || c);
            a:= a+3;
        END LOOP;
   END LOOP; 
END;
/

--M4 zad 3.3 FOR LOOP
DECLARE
BEGIN
    for i in 1..10
    loop
        if mod(i,2) = 0 then
            DBMS_OUTPUT.PUT_LINE('WARTOŒÆ LICZBY PARZYSTEJ Z ZAKRESU 1..10 ' || i);
        end if;
    END LOOP;

END;
/

--M4 zad 3.2 WHILE LOOP
DECLARE
    a number := 1;
    z number := 0;
BEGIN
    while a <= 10 
    loop
        z:= mod(a,2);
        if z = 0 then
            DBMS_OUTPUT.PUT_LINE('WARTOŒÆ LICZBY PARZYSTEJ Z ZAKRESU 1..10 ' || a);
        end if;
        a := a+1;
    END LOOP;

END;
/

--M4 zad 3.1 simple LOOP
DECLARE
    a number := 1;
    z number := 0;
BEGIN
    loop
        z := mod(a,2);
        if z = 0 then
            DBMS_OUTPUT.PUT_LINE('WARTOŒÆ LICZBY PARZYSTEJ Z ZAKRESU 1..10 ' || a);
        end if;
        a := a+1;
        exit when a > 10;
    end loop;
END;
/

--M4 zad 4.1 for; simple
DECLARE
    a number := 1;
BEGIN
    for i in 1..3
    loop
            loop
                    dbms_output.put_line(i || '.'||a);
                    a := a+1;
                exit when a >3;
            end loop;
        a := 1;
    end loop;
END;
/

--M4 zad 4.2 simple; for
DECLARE
    a number := 1;
BEGIN
    loop
            for i in 1..3 
            loop
                dbms_output.put_line(a ||'.'||i);
            end loop;
        a := a+1;
        exit when a >3;
    end loop;
END;
/

--M4 zad 4.3 while; for
DECLARE
    a number := 1;
BEGIN
    while a <=3 
    loop
            for i in 1..3 
            loop
                dbms_output.put_line(a ||'.'||i);
            end loop;
    a := a+1;
    end loop;

END;
/