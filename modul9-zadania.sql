alter session set current_schema = kurs_plsql;

set serveroutput on;
-- M5 zad 3/ M9 zad 1
DROP FUNCTION LICZ_BMI;
CREATE OR REPLACE FUNCTION LICZ_BMI(
    v_hight number,
    v_weight number
) 
RETURN VARCHAR2
IS
    v_hight2 NUMBER;
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
    v_hight2 := v_hight/100;
    v_bmi := v_weight/power(v_hight2,2);
        
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


