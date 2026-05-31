alter session set current_schema = kurs_plsql;

set serveroutput on;
--M6 zad 1
desc departments;
--A. kolekcja asocjacyjna
DECLARE
    TYPE t_departments_at IS TABLE OF departments%ROWTYPE INDEX BY PLS_INTEGER;
    v_departments t_departments_at; --deklarowanie zmiennej
BEGIN
--    wczytywanie ca³ej tabeli do kolekcji
    SELECT * BULK COLLECT INTO v_departments FROM departments;

    FOR i IN 1 .. v_departments.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_departments(i).department_name || ' ' || v_departments(i).MANAGER_ID);
    END LOOP;
END;
/
--B. kolekcja zagnie¿d¿onej
DECLARE
    TYPE t_departments_nt IS TABLE OF departments%ROWTYPE;
    v_departments t_departments_nt; --deklarowanie zmiennej
BEGIN
--    wczytywanie ca³ej tabeli do kolekcji
    SELECT * BULK COLLECT INTO v_departments FROM departments;

    FOR i IN 1 .. v_departments.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_departments(i).department_name || ' ' || v_departments(i).MANAGER_ID);
    END LOOP;END;
/
--C. kolekcja varray
DECLARE
    TYPE t_departments_vt IS VARRAY(27) OF departments%ROWTYPE;
    v_departments t_departments_vt; --deklarowanie zmiennej
BEGIN
--    wczytywanie ca³ej tabeli do kolekcji
    SELECT * BULK COLLECT INTO v_departments FROM departments;

    FOR i IN 1 .. v_departments.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_departments(i).department_name || ' ' || v_departments(i).MANAGER_ID);
    END LOOP;END;
/
