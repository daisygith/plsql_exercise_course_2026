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
--v_country_name varchar2(200);
begin
--    for i in (select country_name from countries where region_id = Pregion_id) loop
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
    zmiana_znakow_upper (in_region_id, v_rowscount);
    DBMS_OUTPUT.PUT_LINE('Zmodyfikowano nazwê '||v_rowscount||' krajów nale¿¹cych do regionu ' || in_region_id || '.');
END;
/