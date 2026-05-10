alter session set current_schema = kurs_plsql;

set serveroutput on;
--M3 zad 1
declare 
    v_hight number := 180;
    v_weight number := 80;
    v_bmi number;

begin
    v_hight := v_hight/100;
    v_bmi := v_weight/power(v_hight,2);
    dbms_output.put_line('Twój wskaŸnik BMI to: ' || v_bmi);
end;
/
--M3 zad 2
declare 
    v_brutto number := 1600; --zawiera 23%vat
    v_podatek CONSTANT number :=23; -- w %
    v_netto number;

begin
    v_netto := v_brutto/(1+(v_podatek /100));
    dbms_output.put_line('Cena netto: ' || v_netto);
end;
/

--M3 zad 3
--insert into products(PRODUCT_NAME) values ('monitor');
declare 
    v_product_id products.PRODUCT_ID%type;
begin
    insert into products(PRODUCT_NAME) values ('monitor')
    returning PRODUCT_ID into v_product_id;
    
    dbms_output.put_line('zwracana wartoœæ: ' || v_product_id);
end;
/

--M3 zad 4
declare 
    v_name varchar2(40);
    v_age number(2);
begin
    v_name := 'Sylwia';
    v_age :=20;

    dbms_output.put_line( v_name||' ma '|| v_age || ' lat.');
end;
/

--M3 zad 5
declare 
    v_r number := 10;
    v_pi CONSTANT number := 3.14;
    v_obw number;
    v_pole number;
begin
    v_obw := 2* v_pi * v_r;
    dbms_output.put_line( 'Obwód ko³a o promieniu ' ||v_r || ' wynosi ' || v_obw);
    
    v_pole := v_pi * v_r * v_r;
    dbms_output.put_line( 'Pole ko³a o promieniu ' ||v_r || ' wynosi ' || v_pole);
end;
/