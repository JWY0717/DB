CREATE TABLE Summer
( sid INTEGER,
class VARCHAR(20),
price INTEGER
);
INSERT INTO Summer VALUES (100, 'FORTRAN', 20000);
INSERT INTO Summer VALUES (150, 'PASCAL', 15000);
INSERT INTO Summer VALUES (200, 'C', 10000);
INSERT INTO Summer VALUES (250, 'FORTRAN', 20000);

-- 계절학기를 듣는 학생의 학번과 수강하는 과목은?
select sid,class
from summer;

-- C 강좌의 수강료는?
select price
from summer
where class='c';

-- 수강료가 가장 비싼 과목은?

select distinct class
from summer
where price = (select max(price)
				from summer);
                
-- 계절학기를 듣는 학생 수와 수강료 총액은?

select distinct count(sid) as 학생수, sum(price) as 수강료총액
from summer;

-- 질의 7-1 200번 학생의 계절학기 수강신청을 취소하시오.

/* C 강좌 수강료 조회 */
select price
from summer
where class='c';

/* 200번 학생의 수강신청 취소 */
delete from summer
where sid=200;

/* C 강좌 수강료 다시 조회 */ 

select price as C수강료
from summer
where class='c';

/* 다음 실습을 위해 200번 학생 자료 다시 입력 */
insert into summer values (200,'C',10000);

-- 질의 7-2 계절학기에 새로운 자바 강좌를 개설하시오.
/* 자바 강좌 삽입 */
INSERT INTO Summer VALUES (NULL, 'JAVA', 25000);

/* Summer 테이블 조회 */
select *
from summer;

/* NULL 값이 있는 경우 주의할 질의 : 투플은 다섯 개지만 수강학생은 총 네 명임 */

select count(*) as 수강인원
from summer;

SELECT COUNT(sid) as 수강인원
FROM Summer;

SELECT count(*) "수강인원"
FROM Summer
WHERE sid IS NOT NULL;

-- 질의 7-3 FORTRAN 강좌의 수강료를 20,000원에서 15,000원으로 수정하시오.

/* FORTRAN 강좌 수강료 수정 */
update summer
set  	price=15000
where   class='FORTRAN';
SELECT *
FROM Summer;

select distinct price as FORTRAN수강료
from 	summer
where   class='FORTRAN';

/* 다음 실습을 위해 FORTRAN 강좌의 수강료를 다시 20,000원으로 복구 */
UPDATE Summer
SET price=20000
WHERE class='FORTRAN';

/* FORTRAN 수강료를 조회하면 두 건이 나옴(데이터 불일치 문제 발생) */
-- 이렇게 실행을 하게 되면 sid가 100인 FORTRA만 가격이 15000으로 바뀜
UPDATE Summer
SET price=15000
WHERE class='FORTRAN' AND sid=100;

-- 13페이지

/* FORTRAN 수강료를 조회하면 두 건이 나옴(데이터 불일치 문제 발생) */
select price as "FORTRAN 수강료"
from 	summer
WHERE class='FORTRAN';

/* 다음 실습을 위해 FORTRAN 강좌의 수강료를 다시 20,000원으로 복구 */
UPDATE Summer
SET price=20000
WHERE class='FORTRAN';

/* 다음 실습을 위해 sid가 NULL인 투플 삭제 */
DELETE FROM Summer
WHERE sid IS NULL;

/* SummerPrice 테이블 생성 */
create table SummerPrice 
(class VARCHAR(20),
 price INTEGER
);
INSERT INTO SummerPrice VALUES ('FORTRAN', 20000);
INSERT INTO SummerPrice VALUES ('PASCAL', 15000);
INSERT INTO SummerPrice VALUES ('C', 10000);


/* SummerEnroll 테이블 생성 */
CREATE TABLE SummerEnroll
( sid INTEGER,
class VARCHAR(20)
);
INSERT INTO SummerEnroll VALUES (100, 'FORTRAN');
INSERT INTO SummerEnroll VALUES (150, 'PASCAL');
INSERT INTO SummerEnroll VALUES (200, 'C');
INSERT INTO SummerEnroll VALUES (250, 'FORTRAN');


-- 7-2 SummerPrice 테이블과 SummerEnroll 테이블을 이용하여 처리하는 질의와 SQL 문

-- 계절학기를 듣는 학생의 학번과 수강하는 과목은?
-- 학번 =sid, 수강과목= class, price=가격
select sid,class
from SummerEnroll;

-- C 강좌의 수강료는?
select price
from  SummerPrice
where class = 'c';

-- 수강료가 가장 비싼 과목은?
select  distinct class
from	summerprice
where price = (select max(price)
				from summerprice);
                
-- 계절학기를 듣는 학생 수와 수강료 총액은?

select  count(sid) as 학생수, sum(price) as 수강료총액
from	SummerPrice, SummerEnroll
where 	SummerPrice.class=SummerEnroll.class;


-- 질의 7-4 200번 학생의 계절학기 수강신청을 취소하시오.
/* C 강좌 수강료 조회 */
select price
from	summerprice
where  class= 'c';

delete
from summerenroll
where sid = 200;

/* C 강좌의 수강료가 존재하는지 확인 */ 
select price
from	summerprice
where  class= 'c';

--  계절학기에 새로운 자바 강좌를 개설하시오.

insert into summerprice values ('JAVA',25000);

-- 질의 7-6 FORTRAN 강좌의 수강료를 20,000원에서 15,000원으로 수정하시오.

update summerprice
set price=15000
where class= 'FORTRAN';

select	*
from summerprice;



