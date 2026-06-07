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
    END LOOP;
END;
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
    END LOOP;
END;
/

--M6 zad 2
DECLARE
--kolekcja asocjacyjna indeksowana tekstem
    TYPE t_collection_at IS TABLE OF varchar2(100) INDEX BY varchar2(150);
    v_exceptions t_collection_at;
    v_klucz VARCHAR2(20);
BEGIN
    v_exceptions('ORA-6530') := 'ACCESS_INTO_NULL';
    v_exceptions('ORA-6592') := 'CASE_NOT_FOUND';
    v_exceptions('ORA-6531') := 'COLLECTION_IS_NULL';
    v_exceptions('ORA-6511') := 'CURSOR_ALREADY_OPEN';
    v_exceptions('ORA-1') := 'DUP_VAL_ON_INDEX';
    v_exceptions('ORA-1001') := 'INVALID_CURSOR';
    v_exceptions('ORA-1722') := 'INVALID_NUMBER';
    v_exceptions('ORA-1017') := 'LOGIN_DENIED';
    v_exceptions('ORA-100') := 'NO_DATA_FOUND';
    v_exceptions('ORA-6548') := 'NO_DATA_NEEDED';
    v_exceptions('ORA-1012') := 'NOT_LOGGED_ON';
    v_exceptions('ORA-6501') := 'PROGRAM_ERROR';
    v_exceptions('ORA-6504') := 'ROWTYPE_MISMATCH';
    v_exceptions('ORA-30625') := 'SELF_IS_NULL';
    v_exceptions('ORA-6500') := 'STORAGE_ERROR';
    v_exceptions('ORA-6533') := 'SUBSCRIPT_BEYOND_COUNT';
    v_exceptions('ORA-6532') := 'SUBSCRIPT_OUTSIDE_LIMIT';
    v_exceptions('ORA-1410') := 'SYS_INVALID_ROWID';
    v_exceptions('ORA-51') := 'TIMEOUT_ON_RESOURCE';
    v_exceptions('ORA-1422') := 'TOO_MANY_ROWS';
    v_exceptions('ORA-6502') := 'VALUE_ERROR';
    v_exceptions('ORA-1476') := 'ZERO_DIVIDE';

    v_klucz := v_exceptions.FIRST;
    WHILE v_klucz IS NOT NULL LOOP
        dbms_output.put_line(v_klucz || ' ' || v_exceptions(v_klucz));
        v_klucz := v_exceptions.NEXT(v_klucz);
    END LOOP;
END;
/

--M6 zad 3
DECLARE
--kolekcja zagnie¿dzona
    TYPE t_collection_nt IS TABLE OF NUMBER;
    v_element t_collection_nt := t_collection_nt(1,2,3,4,5,6,7,8,9,10);
    v_klucz number;
BEGIN
    v_element.DELETE(2);
    v_element.DELETE(5);
    v_element.DELETE(9);
    
    v_klucz := v_element.FIRST;
    WHILE v_klucz IS NOT NULL LOOP
        dbms_output.put_line(v_element(v_klucz));
        v_klucz := v_element.NEXT(v_klucz);
    END LOOP;
END;
/
--M6 zad 4
--Która kolekcja:
--ma maksymaln¹ liczbê elementów? VT
--mo¿e byæ indeksowana tekstem?  AT
--ma dodatkowe operatory do porównywania kolekcji? NT
--nie wymaga inicjalizacji? AT
--nie mo¿e byæ rzadka? VT
--nie mo¿e byæ u¿yta w SQL? AT
