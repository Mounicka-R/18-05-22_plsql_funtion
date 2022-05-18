
--select * from customer;
--Write a plsql function by passing age and gender, if age <18 then return 0 otherwise return 
--the no. of employees who are in that age and gender.
/
create or replace function f_age_gender(p_age number,p_gender varchar2) return number 
as
    v_cnt number(10);
begin
    if p_age<18 then
        return 0;
    else
        select count(emp_id) into v_cnt
        from employee1
        where trunc(months_between(sysdate,date_of_birth)/12)=p_age
        and gender=p_gender;
        return v_cnt;
    end if;
end;
/
select f_age_gender(30,'M') FROM DUAL;
/    

--------------------------------------------------------------------------------------
--4.Write a function which takes a date in string format and display whether it is a valid date or not.
/
create or replace function f_date(p_date varchar2) return varchar2
as
    v_date date;
begin
    v_date:=to_date(p_date,'ddmmyy');
    if (to_char(v_date,'dd') between 1 and 31) and (to_char(v_date,'mm') between 1 and 12) and (to_char(v_date,'yyyy') between 1000 and 9999) then
        return 'valid';
    else
        return 'not valid';
    end if;
end;
/
select f_date('02222022') from dual;
/

--------------------------------------------------------------------------------------------------
--7. Write a function which takes a value from the user and check whether the given values is a number or
--not. If it is a number, return ‘ valid Number’ otherwise ‘invalid number’.
--Phone Number- should have 10 digits, all should be numbers and phno should start with 9 or 8 or 7.
/
create or replace function f_phone_number(p_ph_number number)return varchar2
as
    v_value varchar2(50);
begin
    if length(p_ph_number)=10 and (regexp_like(p_ph_number,'^[0-9]$')) and (p_ph_number like '9%' or p_ph_number like '8%' or p_ph_number like '7%') then
        return 'vaild number';
    else
        return 'not valid';
    end if;
end;
/
select f_phone_number(9886398309) from dual;
/
create or replace function f_phone_number(p_ph_number number)return varchar2
as
    v_cnt number(10);
begin
    select count(*)into v_cnt
    from dual
    where regexp_like(p_ph_number,'^[0-9]+$')
    and length(p_ph_number)=10
    and p_ph_number like '9%' or  p_ph_number like '8%' or p_ph_number like '7%';
    if v_cnt=1 then
        return 'valid number';
    else 
        return 'not valid number';
    end if;
end;
/
select f_phone_number(2863983092) from dual;
/

            

















------------------------------------------------------------------------------
--5.Write a function which takes Email as input and display whether it is a valid email id or not. The rules
--for finding out validity of email is –
--
--• It should contain at least one ‘@’ symbol.
--• It should not contain more than one @ symbol.
--
--• Email id should not start and end with @
--• After @ there should be at least 2 tokens.  (i.e .co.in but not .com)

/
create or replace function f_email(p_email varchar2)return varchar2
as
begin
    if (p_email like '%@%') and (length(p_email)-length(replace(p_email,'@',''))=1) and (p_email not like'@%') and (regexp_count(substr(p_email,instr(p_email,'@')),'[.]'))=2 then
--        dbms_output.put_line('valid');
        return 'valid';
    else
        return 'invalid';
    end if;
end;
/
select f_email('mounickanaidu@.gmail.com')from dual;
/
