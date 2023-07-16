--Airline Managment System
--pan card token num-0105336072.
create table airport(id varchar(5),name varchar(20),type varchar(20),location varchar(20),air_id varchar(5));
create table flight(id varchar(5),f_num number(8),price number(5,2),departure varchar(10),departure_time varchar(5),arrival_time varchar(),destination varchar(10),ap_id varchar(5),air_id varchar(5),d_date date,a_date date);
create table passanger(name varchar(10),phone_number number(12),address varchar(40),password varchar(10),username varchar(10),seat_no varchar(10),booking_id varchar(10),type varchar(10),f_num number(8));
--create table ticket_status(status,id);
create table booking(id varchar(10),f_num number(8),b_date date,total_fare number(5,2),journy_date date,seat_type varchar(10),status char(10),seat_no varchar(10));
create table agent(id,booking_id,f_num,name,price)
create airlines(name varchar(20),id varchar(5),type varchar(20));
 
insert into airport(id,name,type,location,air_id) values(&id,&name,&type,&location,&air_id);
insert into flight(id,f_num,price,departure,departure_time,arrival_time,destination,ap_id,air_id,d_date,a_date) values(&id,&f_num,&price,&departure,&departure_time,&arrival_time,&destination,&ap_id,&air_id,&d_date,&a_date);
insert into passanger(name,phone_number,password,username,seat_no,booking_id,type,f_num,City) values(&name,&phone_number,&password,&username,&seat_no,&booking_id,&type,&f_num,&City);
insert into booking(id,f_num,d_date,total_fare,journy_date,seat_type,status,seat_no) values(&id,&f_num,&b_date,&total_fare,&journy_date,&seat_type,&status,&seat_no);
insert into airlines(name,id,type) values(&name,&id,&type);

--FUNCTION
create or replace function get_price(f_num number) return number
as f_price number;
begin
select price into f_price from flight where f_num='491';
return f_price;
dbms_output.put_line(f_price);
end;
 
--PROCEDURE WITH CUESOR.
create table old_record(mobile number(12),u_name varchar(10),pass varchar(10));
create or replace procedure old as
 --declare
 mobile passanger.phone_number%type;
 u_name passanger.username%type;
 pass passanger.password%type;
  cursor dish is
  select phone_number,username,password from passanger;
   begin
   open dish;
   loop
   fetch dish into mobile,u_name,pass;
    exit when dish%NOTFOUND;
   insert into old_record(mobile,u_name,pass) values(mobile,u_name,pass);
  dbms_output.put_line('phone num ->'||mobile||' '||'username ->'||u_name||' '||'password ->'||pass);
   end loop;
   end;
   /

 
 -- PROCEDURE FOR GET DETAILS OF FLIGHT BY FLIGHT NUM
  create or replace procedure details(num in number)
 is 
  f_id flight.id%type;
  f_price flight.price%type;
  f_departure flight.departure%type;
  f_destination flight.destination%type;
  begin
  select id,price,departure,destination into f_id,f_price,f_departure,f_destination from flight where f_num=num;
  dbms_output.put_line('Flight id->'||f_id||' '||'Flight price->'||f_price||' '||'Flight departure->'||f_departure||' '||'Flight destnation->'||f_destination);
end;

--create table del_record as select * from passanger where type='ASDF';
alter table del_record add(u_name varchar(20),del_date date);
  
--TRIGGER FOR RECORED DELETED DATA INTO NEW TABLE
create or replace trigger det BEFORE delete on passanger for each row
declare
u_name varchar(20);
begin
select user into u_name from dual;
insert into del_record values(:OLD.name,:OLD.phone_number,:OLD.password,:OLD.username,:OLD.seat_no,:OLD.booking_id,:OLD.type,:OLD.f_num,:OLD.City,u_name,sysdate);
end;


last ma --TRIGGER FOR INFO OF UPDATE.
CREATE OR REPLACE TRIGGER UPD BEFORE UPDATE on flight for each row
BEGIN
--insert into del_record(num,SYSDATE); 
dbms_output.put_line('FLIGHT SCHEDULE IS UPDATED');
end;
