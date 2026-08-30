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

--M8 zad 2

