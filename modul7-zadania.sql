alter session set current_schema = kurs_plsql;

set serveroutput on;
--M7 zad 1
desc regions;
select * from kurs_plsql.regions;

DECLARE
    CURSOR curr_region_name IS
                SELECT region_name FROM regions;
    v_region_name regions.region_name%TYPE;
BEGIN
    OPEN curr_region_name;
    FETCH curr_region_name INTO v_region_name;

    WHILE curr_region_name%FOUND 
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_region_name);
        FETCH curr_region_name INTO v_region_name;
    END LOOP;
    
    CLOSE curr_region_name;
END;
/
--M7 zad 2
DECLARE
     
BEGIN

    FOR i IN (SELECT REGION_NAME FROM REGIONS) LOOP
        DBMS_OUTPUT.PUT_LINE(i.REGION_NAME);
    END LOOP;
END;
/
--M7 zad.3
/*
SQL%ROWCOUNT

Dotyczy ostatniej niejawnej instrukcji SQL wykonanej w bloku (czyli zwyk³ego INSERT, UPDATE, DELETE albo SELECT INTO napisanego wprost w kodzie, bez deklarowania kursora).
Mówi: "ile wierszy dotknê³a ta ostatnia instrukcja?".
Przyk³ad: robisz UPDATE regions SET region_name = ... WHERE ...; a zaraz potem DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT) - poka¿e, ile wierszy zosta³o zaktualizowanych przez ten UPDATE.
SQL to tu specjalny, "domyœlny" identyfikator - nie kursor, który zosta³ nazwany, tylko wbudowany wskaŸnik na ostatni¹ niejawn¹ operacjê SQL.

cursor_name%ROWCOUNT

Dotyczy konkretnego, jawnie zadeklarowanego kursora (tego, który zosta³ nazwany, np. curr_region_name - zadania 1).
Mówi: "ile wierszy zosta³o do tej pory pobranych (FETCH-owanych) z tego kursora, licz¹c od OPEN".
To liczba, która roœnie z ka¿dym FETCH - czyli jeœli sprawdzisz j¹ w œrodku pêtli WHILE, po np. 3 FETCH-ach poka¿e 3, nie ca³kowit¹ liczbê wierszy w tabeli.

Kluczowa ró¿nica w jednym zdaniu:
SQL%ROWCOUNT liczy wiersze dotkniête przez ostatni¹ automatyczn¹ instrukcjê DML/SELECT INTO, 
a cursor_name%ROWCOUNT liczy wiersze pobrane FETCH-em z konkretnego kursora jawnego, narastaj¹co w trakcie jego "¿ycia" (OPEN ? CLOSE).
*/
desc kurs_plsql.departments;
desc kurs_plsql.employees;
select * from departments;
select count(*) from departments d, employees e where e.department_id = d.department_id and d.department_name = 'Shipping';
--M7 zad 4
DECLARE
         CURSOR c_dep IS
            SELECT d.department_name as department_name
              from departments d, employees e 
              where e.employee_id = d.manager_id
              AND e.salary < 8000;
              
    v_dept_rec  c_dep%ROWTYPE;
    v_rowcount NUMBER;
BEGIN
    OPEN c_dep;
    LOOP
        FETCH c_dep INTO v_dept_rec;
        EXIT WHEN c_dep%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_dept_rec.DEPARTMENT_NAME);
    END LOOP;
    v_rowcount := c_dep%rowcount;
    CLOSE c_dep;
    
    DBMS_OUTPUT.PUT_LINE('v_rowcount: '||v_rowcount);
END;
/

--M7 zad 5
DECLARE
         CURSOR c_dep(in_dep_name varchar2) IS
            SELECT e.first_name as first_name, e.last_name as last_name
              from departments d, employees e 
              where e.department_id = d.department_id
              AND d.department_name = in_dep_name;
              
    v_dept_rec  c_dep%ROWTYPE;
    v_rowcount NUMBER;
BEGIN
    OPEN c_dep('Marketing');
    LOOP
        FETCH c_dep INTO v_dept_rec;
        EXIT WHEN c_dep%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_dept_rec.first_name || ' ' ||v_dept_rec.last_name );
    END LOOP;
    v_rowcount := c_dep%rowcount;
    CLOSE c_dep;
    
    DBMS_OUTPUT.PUT_LINE('v_rowcount: '||v_rowcount);
END;
/
--M7 zad 6
DECLARE
         CURSOR c_dep(in_dep_name varchar2) IS
            SELECT e.first_name as first_name, e.last_name as last_name, e.salary as salary
              from departments d, employees e 
              where e.department_id = d.department_id
              AND d.department_name = in_dep_name
              FOR UPDATE OF e.salary WAIT 6;
              
    v_dept_rec  c_dep%ROWTYPE;
    v_rowcount NUMBER;

BEGIN
    OPEN c_dep('Administration');
    LOOP
        FETCH c_dep INTO v_dept_rec;
        EXIT WHEN c_dep%NOTFOUND;
        UPDATE employees SET salary = salary * 1.2 WHERE CURRENT OF c_dep;
        DBMS_OUTPUT.PUT_LINE(v_dept_rec.first_name || ' ' ||v_dept_rec.last_name || ' salary ' || v_dept_rec.salary );
    END LOOP;
    v_rowcount := c_dep%rowcount;
    CLOSE c_dep;
    
    DBMS_OUTPUT.PUT_LINE('v_rowcount: '||v_rowcount);
END;
/
DECLARE
    CURSOR c_dep(in_dep_name varchar2) IS
        SELECT e.first_name as first_name, e.last_name as last_name, e.salary as salary
          FROM departments d, employees e 
          WHERE e.department_id = d.department_id
          AND d.department_name = in_dep_name
          FOR UPDATE OF e.salary WAIT 6;

    v_dept_rec   c_dep%ROWTYPE;
    v_rowcount   NUMBER;
    v_new_salary NUMBER;
BEGIN
    OPEN c_dep('Administration');
    LOOP
        FETCH c_dep INTO v_dept_rec;
        EXIT WHEN c_dep%NOTFOUND;

        v_new_salary := v_dept_rec.salary * 1.2;

        UPDATE employees SET salary = salary * 1.2 WHERE CURRENT OF c_dep;

        DBMS_OUTPUT.PUT_LINE(v_dept_rec.first_name || ' ' || v_dept_rec.last_name 
            || ' salary przed: ' || v_dept_rec.salary 
            || ' salary po: ' || v_new_salary);
    END LOOP;

    v_rowcount := c_dep%rowcount;
    CLOSE c_dep;

    DBMS_OUTPUT.PUT_LINE('v_rowcount: ' || v_rowcount);
END;
/
