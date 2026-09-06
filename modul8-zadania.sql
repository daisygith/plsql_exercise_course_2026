alter session set current_schema = kurs_plsql;


--M8 zad 1

select * from kurs_plsql.products;
--insert into products(product_name) values ('product8'); 
drop procedure wygeneruj_liste_produktow;
set serveroutput on;
create or replace procedure wygeneruj_liste_produktow 
IS
begin 
    for i in (select * from products order by product_id asc) loop
        dbms_output.put_line('produkt ' || i.product_name);
    end loop;
    
end wygeneruj_liste_produktow;
/
exec wygeneruj_liste_produktow;
select m.first_name ||' '|| m.last_name as manager, e.first_name ||' '|| e.last_name as employee from employees m, employees e where m.employee_id = e.manager_id and e.employee_id = 101;
select * from employees;
--M8 zad 2
drop procedure wyswietl_przelozonego_pracownika;
create or replace procedure wyswietl_przelozonego_pracownika (
    id_pracownika number)
IS 
    v_manager varchar2(200);
    v_employee varchar2(200);
begin 
    select m.first_name ||' '|| m.last_name as manager, e.first_name ||' '|| e.last_name as employee 
    into v_manager, v_employee
    from employees m, employees e where 
    m.employee_id = e.manager_id 
    and e.employee_id = id_pracownika;
    
    dbms_output.put_line(v_manager || ' jest prze³o¿onym pracownika: ' || v_employee);
end;
/
exec wyswietl_przelozonego_pracownika(101);
/

--M8 zad 3
--select * from countries where region_id = 4;
set serveroutput on;
drop procedure zmiana_znakow_upper;
create or replace procedure zmiana_znakow_upper(
in_region_id number, out_count OUT NUMBER
)is
begin
    UPDATE countries
    SET country_name = UPPER(country_name)
    WHERE region_id = in_region_id;
    
    out_count:= sql%rowcount;
end;
/
DECLARE
    v_rowscount NUMBER;
    in_region_id NUMBER := 4;
BEGIN
    zmiana_znakow_upper(in_region_id => in_region_id, out_count => v_rowscount);
    DBMS_OUTPUT.PUT_LINE('Zmodyfikowano nazwê '||v_rowscount||' krajów nale¿¹cych do regionu ' || in_region_id || '.');
END;
/

desc kurs_plsql.departments;
desc kurs_plsql.employees;
select * from departments;
select count(*) from departments d, employees e where e.department_id = d.department_id and d.department_name = 'Shipping';
--M7/M8 zad 4
DECLARE
         CURSOR c_dep IS
            SELECT d.department_name as department_name
              from departments d, employees e 
              where e.employee_id = d.manager_id
              AND e.salary < 8000;
              
    v_dept_rec  c_dep%ROWTYPE;
    v_rowcount NUMBER;
    
    PROCEDURE wyswietl_atrybuty_kursorowe(p_dep_name varchar2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(p_dep_name);
    END;
BEGIN
    OPEN c_dep;
    LOOP
        FETCH c_dep INTO v_dept_rec;
        EXIT WHEN c_dep%NOTFOUND;
        wyswietl_atrybuty_kursorowe(v_dept_rec.DEPARTMENT_NAME);
    END LOOP;
    v_rowcount := c_dep%rowcount;
    CLOSE c_dep;
    wyswietl_atrybuty_kursorowe('v_rowcount: '||v_rowcount);
END;
/
--M8 zad 5
SELECT object_name, object_type, status
FROM user_objects
WHERE status = 'INVALID';
drop procedure STATUS_KOMPILACJI;
CREATE OR REPLACE PROCEDURE STATUS_KOMPILACJI
is
--DECLARE
         CURSOR c_KOMP IS
            SELECT object_name, object_type, status
            FROM user_objects
            WHERE status = 'INVALID';

              
    v_COMP_rec  c_KOMP%ROWTYPE;
    v_rowcount NUMBER;

BEGIN
    OPEN c_KOMP;
    LOOP
        FETCH c_KOMP INTO v_COMP_rec;
        EXIT WHEN c_KOMP%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_comp_rec.object_type || ' ' || v_comp_rec.object_name || ' - INVALID');
    END LOOP;
    v_rowcount := c_KOMP %rowcount;
    CLOSE c_KOMP;
    
    IF v_rowcount = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Wszystkie obiekty w schemacie kurs_plsql s¹ skompilowane');
    END IF;
END;
/
BEGIN
    status_kompilacji;
END;
/