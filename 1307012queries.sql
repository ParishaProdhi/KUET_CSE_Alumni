-- LAB 2 --

		--add
		
		alter table PRESENT_WORKS add INTERESTS varchar(50);
			describe PRESENT_WORKS;
		alter table EXPERIENCES add (EX_WORKS_PLACES varchar(50),STARTING_AGE number(10));
			describe EXPERIENCES;

		--modify
		
		alter table EXPERIENCES modify (EX_WORKS_PLACES varchar(40),STARTING_AGE number(5));
			describe EXPERIENCES;

		--drop 
		
		alter table PRESENT_WORKS drop column INTERESTS;
			describe PRESENT_WORKS;

		--rename
		
		alter table EXPERIENCES rename column STARTING_AGE to START_AGE;
			describe EXPERIENCES;

		--insert--
		
		insert into ALUMNI values(1307011,7,'PRIANKAA','2K13','SATKHIRA',01112311111,'B-',3.56);

		---UPDATE
		
		select ROLL_NO,NAME from ALUMNI where ALUMNI_ID=7;
		update ALUMNI set PRESENT_ADDRESS='SAVAR' where ROLL_NO=1307011;
		select ROLL_NO,NAME from ALUMNI where ROLL_NO=1307011;

		--DELETE
		
		delete from ALUMNI where NAME='PRIANKAA';
		select * from ALUMNI;

		--DROP
		
		alter table EXPERIENCES drop column EX_WORKS_PLACES;
		alter table EXPERIENCES drop column START_AGE;

-- LAB 2 --

-- LAB 3 --

		--make primary key

		ALTER TABLE ALUMNI ADD CONSTRAINT alumni_pk
			PRIMARY KEY (ROLL_NO);

		--make foreign key

		ALTER TABLE CAMPUS_ASSOCIATIONS ADD CONSTRAINT CAMPUS_ASSOCIATIONS_fk
			FOREIGN KEY (ROLL_NO) REFERENCES ALUMNI 	(ROLL_NO);
		ALTER TABLE EXPERIENCES ADD CONSTRAINT EXPERIENCES_fk
			FOREIGN KEY (ROLL_NO) REFERENCES ALUMNI 	(ROLL_NO);
		ALTER TABLE PRESENT_WORKS ADD CONSTRAINT PRESENT_WORKS_fk
			FOREIGN KEY (ROLL_NO) REFERENCES ALUMNI 	(ROLL_NO);

		ALTER TABLE EXPERIENCES ADD CONSTRAINT ex_pk
			PRIMARY KEY (ROLL_NO);

		--drop primary key

		alter table EXPERIENCES drop constraint ex_pk;

-- LAB 3 --

-- LAB 4 --
		SELECT NAME, PRESENT_ADDRESS FROM ALUMNI;
		SELECT DISTINCT PROJECT_PLATFORMS FROM EXPERIENCES;
		
		--comparision search

		SELECT * FROM ALUMNI;
		SELECT (CGPA-1) from ALUMNI where CGPA>3.00;
		select NAME from ALUMNI where CGPA>3.50 AND CGPA<3.75;
		
		--between
		
		select NAME,ROLL_NO from ALUMNI where CGPA BETWEEN 2.00 AND 3.50;
		select NAME,ROLL_NO from ALUMNI where CGPA NOT BETWEEN 2 AND 4;
		
		--in operation
		select ROLL_NO from EXPERIENCES where PROJECT_PLATFORMS in ('PHP');

		--pattern matching

		select ROLL_NO from CAMPUS_ASSOCIATIONS where DREAM like '%YES%';

		--single column ordering

		select NAME,ROLL_NO,BATCH from ALUMNI order by CGPA;
		
		--descending order
		
		select NAME,ROLL_NO,BATCH from ALUMNI order by CGPA desc;
		
		--multiple column ordering
		
		select NAME,ROLL_NO,BATCH from ALUMNI order by ALUMNI_ID,ROLL_NO;

		-- aggregate functions

		select CGPA from ALUMNI;
		select max(CGPA) from ALUMNI;
		select count(*), sum(CGPA), avg(CGPA) from ALUMNI;

		--group by

		select CGPA, count(CGPA) from ALUMNI group by CGPA;

		--having

		select CGPA, count(CGPA) from ALUMNI group by CGPA having CGPA>3.00;

-- LAB 4 --

-- LAB 5 --

		--subquery
		
		select NAME from ALUMNI
		where ROLL_NO IN (select ROLL_NO from CAMPUS_ASSOCIATIONS where KUET_THEATRE='YES');

		--query
		
		select ROLL_NO,JOB from PRESENT_WORKS
		where EXPERT_AREA='GRAPHICS';

		--advance

		select a.NAME, a.CGPA 
		from ALUMNI a
		where a.ROLL_NO IN (select c.ROLL_NO from CAMPUS_ASSOCIATIONS c, EXPERIENCES e
		where c.ROLL_NO=e.ROLL_NO and a.PRESENT_ADDRESS='UTTARA,DHAKA');

		--union all

		select NAME,CGPA from ALUMNI
		where ROLL_NO=1307005
		union all
		select a.NAME, a.CGPA 
		from ALUMNI a
		where a.ROLL_NO IN (select c.ROLL_NO from CAMPUS_ASSOCIATIONS c, EXPERIENCES e
		where c.ROLL_NO=e.ROLL_NO and a.PRESENT_ADDRESS='UTTARA,DHAKA');

		--union 

		select NAME,CGPA from ALUMNI
		where ROLL_NO=1307005
		union 
		select a.NAME, a.CGPA 
		from ALUMNI a
		where a.ROLL_NO IN (select c.ROLL_NO from CAMPUS_ASSOCIATIONS c, EXPERIENCES e
		where c.ROLL_NO=e.ROLL_NO and a.PRESENT_ADDRESS='UTTARA,DHAKA');

		--intersect

		select NAME,CGPA from ALUMNI
		where ROLL_NO=1307005
		intersect 
		select a.NAME, a.CGPA 
		from ALUMNI a
		where a.ROLL_NO IN (select c.ROLL_NO from CAMPUS_ASSOCIATIONS c, EXPERIENCES e
		where c.ROLL_NO=e.ROLL_NO and a.PRESENT_ADDRESS='UTTARA,DHAKA');
		
		--minus

		select NAME,CGPA from ALUMNI
		where ROLL_NO=1307005
		minus
		select a.NAME, a.CGPA 
		from ALUMNI a
		where a.ROLL_NO IN (select c.ROLL_NO from CAMPUS_ASSOCIATIONS c, EXPERIENCES e
		where c.ROLL_NO=e.ROLL_NO and a.PRESENT_ADDRESS='UTTARA,DHAKA');

		--precedence of set operator

		select NAME,CGPA from ALUMNI
		where ROLL_NO=1307036
		union
		select a.NAME, a.CGPA 
		from ALUMNI a
		where a.ROLL_NO IN (select c.ROLL_NO from CAMPUS_ASSOCIATIONS c, EXPERIENCES e
		where c.ROLL_NO=e.ROLL_NO and a.PRESENT_ADDRESS='UTTARA,DHAKA');
		intersect
		select NAME,CGPA from ALUMNI
		where ROLL_NO=1307018;

		--another approach with paranthesis

		select NAME,CGPA from ALUMNI
		where ROLL_NO=1307036
		union
		(select a.NAME, a.CGPA 
		from ALUMNI a
		where a.ROLL_NO IN (select c.ROLL_NO from CAMPUS_ASSOCIATIONS c, EXPERIENCES e
		where c.ROLL_NO=e.ROLL_NO and a.PRESENT_ADDRESS='UTTARA,DHAKA')
		intersect
		select NAME,CGPA from ALUMNI
		where ROLL_NO=1307036);

-- LAB 5 --

-- LAB 6 --

		--normal join operation
		select a.NAME , a.CONTACT_NO from ALUMNI a join EXPERIENCES e on a.ROLL_NO=e.ROLL_NO;

		-- using clause
		select a.NAME , a.CONTACT_NO from ALUMNI a join EXPERIENCES using(ROLL_NO);

		--multiple condition
		select a.NAME , a.BLOOD_GROUP, e.DATEofGraduation from ALUMNI a join EXPERIENCES e on ((a.ROLL_NO=e.ROLL_NO) and (a.ROLL_NO=1307012));

		--natural join
		select a.NAME , e.DATEofGraduation from ALUMNI a natural join EXPERIENCES e;

		-- cross join
		select a.NAME , e.DATEofGraduation from ALUMNI a cross join EXPERIENCES e;

		--outer joins

		select a.NAME , a.CGPA from ALUMNI a left outer join EXPERIENCES e on a.ROLL_NO=e.ROLL_NO;
		select a.NAME , a.CGPA from ALUMNI a right outer join EXPERIENCES e on a.ROLL_NO=e.ROLL_NO;
		select a.NAME , a.CGPA from ALUMNI a full outer join EXPERIENCES e on a.ROLL_NO=e.ROLL_NO;


-- LAB 6 --

-- LAB 7 --


		--finding the highest cgpa among them


		SET SERVEROUTPUT ON
			DECLARE
   			HIGHEST_CG  ALUMNI.CGPA%type;
		BEGIN
   		SELECT MAX(CGPA)  INTO HIGHEST_CG
  		FROM ALUMNI;
   		DBMS_OUTPUT.PUT_LINE('The highest CGPA is : ' || HIGHEST_CG);
 		END;
		/


		--date


		SET  SERVEROUTPUT ON
			DECLARE
  			individual ALUMNI.NAME%type;
  			time EXPERIENCES.DATEofGraduation%type :='15-JAN-2017';
		BEGIN
  		SELECT NAME INTO individual
  		FROM ALUMNI, EXPERIENCES
  		WHERE ALUMNI.ROLL_NO=EXPERIENCES.ROLL_NO AND
  			DATEofGraduation = time;  
  		DBMS_OUTPUT.PUT_LINE('The ALUMNI ' || individual || ' graduated on the date '|| time);
		END;

		/

-- LAB 7 --

-- LAB 8 --
		--while loop
		SET SERVEROUTPUT ON
			DECLARE
			COUNTER NUMBER(2):=1;
			AL_NAME ALUMNI.NAME%type;
			CONTACT ALUMNI.CONTACT_NO%type;

		BEGIN

			WHILE COUNTER<=5

			LOOP

		select NAME, CONTACT_NO into AL_NAME, CONTACT from ALUMNI where ALUMNI_ID=counter;
		dbms_output.put_line('Record '||counter);
		dbms_output.put_line(AL_NAME ||' ' ||CONTACT);
		dbms_output.put_line('**********************');

			counter :=counter+1;

		end loop;
			exception
			when others then dbms_output.put_line(sqlerrm);
		end;
		/
		--for loop
		SET SERVEROUTPUT ON
			DECLARE
			COUNTER NUMBER(2);
			roll ALUMNI.ROLL_NO%type;
			performance ALUMNI.CGPA%type;

		BEGIN
			for counter in 1..5
			LOOP

		select ROLL_NO, CGPA into roll, performance from ALUMNI where ALUMNI_ID=counter;
		dbms_output.put_line('Record '||counter);
		dbms_output.put_line(roll ||' ' ||performance);
		dbms_output.put_line('**********************');
		end loop;
			exception
		when others then dbms_output.put_line(sqlerrm);
		end;
		/
		--loop--
		set serveroutput on

			declare
			counter number(2):=0;
			nam ALUMNI.NAME%type;
			btch ALUMNI.BATCH%type;
		begin
			loop
			counter:=counter+1;
		select NAME, BATCH into nam, btch from ALUMNI where ALUMNI_ID=counter;
		dbms_output.put_line(nam ||' ' ||btch);
			exit when counter>4;

		end loop;
			exception
		when others then 
		dbms_output.put_line(sqlerrm);
		end;
		/

		--cursor

		SET SERVEROUTPUT ON
			DECLARE
  			CURSOR alumni_cur IS
  
  		SELECT ROLL_NO,PROJECT_PLATFORMS FROM EXPERIENCES;
  			record alumni_cur%ROWTYPE;

		BEGIN
			OPEN alumni_cur;
  			LOOP
    		FETCH alumni_cur INTO record;
      		EXIT WHEN alumni_cur%ROWCOUNT > 3;
      		DBMS_OUTPUT.PUT_LINE ('Alumni Roll : ' || record.ROLL_NO || ' platforms : ' || record.PROJECT_PLATFORMS);
    	END LOOP;
      		CLOSE alumni_cur;   
		END;
		/

		--procedure

		set serveroutput on;

		create or replace procedure pro is 
			id ALUMNI.ALUMNI_ID%type;
			BloodGrp ALUMNI.BLOOD_GROUP%type;

		begin
			id:=4;
		select BLOOD_GROUP into BloodGrp from ALUMNI where ALUMNI_ID=id;
		dbms_output.put_line('types : '||BloodGrp);
		end;
		/
			show errors

		begin
 			pro;
 		end;
 		/

		--procedure

		set serveroutput on;

		create or replace procedure showdate is 
			roll EXPERIENCES.ROLL_NO%type;
			aldate EXPERIENCES.DATEofGraduation%type;

		begin
			roll:='1307012';
		select DATEofGraduation into aldate from EXPERIENCES where roll=ROLL_NO;
		dbms_output.put_line('Roll : '|| roll ||' graduated on date : ' || aldate );
		end;
		/
			show errors
		begin
 			showdate;
 		end;
 		/

		--a procedure for inserting data into person table

		set serveroutput on;

		CREATE OR REPLACE PROCEDURE add_alumni(
  		insertroll ALUMNI.ROLL_NO%TYPE,
  		insertname ALUMNI.NAME%TYPE) IS
		BEGIN
  		INSERT INTO ALUMNI(ROLL_NO,NAME)
  		VALUES (insertroll,insertname);
  		COMMIT;
		END add_alumni;
		/
		SHOW ERRORS

		-- function
		create or replace function cgpaavg return number is
			avg_cgpa ALUMNI.CGPA%type;

		begin
		select avg(CGPA) into avg_cgpa from ALUMNI;
			return avg_cgpa;
		end;
		/

		set serveroutput on
		begin
		dbms_output.put_line('average cgpa: '|| cgpaavg );
		end;
		/
-- LAB 8 -

--lab 9--

		--trigger
		ALTER TABLE ALUMNI          --LAB2 ADDING A COLUMN BY ALTER
			ADD GRADE VARCHAR(2);


		CREATE OR REPLACE TRIGGER TR_GRADE 
			BEFORE UPDATE OR INSERT ON ALUMNI
			FOR EACH ROW 
		BEGIN
			IF :NEW.CGPA=4.00 THEN
				:NEW.GRADE:='A+';
			ELSIF :NEW.CGPA>=3.75 AND :NEW.CGPA<=4.00 THEN
				:NEW.GRADE:='A';
			ELSIF :NEW.CGPA>3.50 AND :NEW.CGPA<=3.75 THEN
				:NEW.GRADE:='A-';
			ELSIF :NEW.CGPA>=3.25 AND :NEW.CGPA<=3.50 THEN
				:NEW.GRADE:='B+';
			ELSIF :NEW.CGPA>=3.00 AND :NEW.CGPA<=3.25 THEN
				:NEW.GRADE:='B';
			ELSIF :NEW.CGPA>=2.75 AND :NEW.CGPA<=3.00 THEN
				:NEW.GRADE:='B-';
			ELSIF :NEW.CGPA>=2.50 AND :NEW.CGPA<=2.75 THEN
				:NEW.GRADE:='C+';
			ELSIF :NEW.CGPA>=2.25 AND :NEW.CGPA<=2.50 THEN
				:NEW.GRADE:='C';
			ELSIF :NEW.CGPA>=2.00 AND :NEW.CGPA<=2.25 THEN
				:NEW.GRADE:='D';
			ELSIF :NEW.CGPA<=2.00 THEN
				:NEW.GRADE:='F';
		END IF;
		END TR_GRADE;
		/
		insert into ALUMNI(ROLL_NO,ALUMNI_ID,NAME,BATCH,PRESENT_ADDRESS,CONTACT_NO,BLOOD_GROUP,CGPA) values(1307059,6,'NABILA','2K13','KHULNA',12442144546,'AB-',3.79);
		SELECT GRADE FROM ALUMNI;
		--DISABLE triggers
		alter table item disable all triggers;

		--ENABLE triggers
		alter table item enable all triggers;
		ALTER TABLE ALUMNI                           --LAB2 DROPING COLUMN
			DROP COLUMN GRADE;

		select sysdate from dual;
		select current_date from dual;
		select systimestamp from dual;

		--add months
		select add_months(DATEofGraduation,1) as one_month from EXPERIENCES where ROLL_NO=1307018;
		--last day
		select last_day(DATEofGraduation) from EXPERIENCES;
		--extract

		select ROLL_NO,extract(month from DATEofGraduation) as months from EXPERIENCES;

		--extract continues

		select ROLL_NO,extract(year from DATEofGraduation) as year from EXPERIENCES;

--lab 9--