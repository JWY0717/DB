--  NULL 값 처리!!!
SELECT name ‘이름’, IFNULL(phone, '연락처없음') ‘전화번호’
FROM Customer;

-- 질의 4-11 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오. 
set @seq=0;
select (@seq:=@seq+1)'순번', custid,name,phone
from customer
where @seq < 2;


-- 1. 스칼라 부속질의 – SELECT 부속질의
SELECT name, SUM(saleprice) total
FROM Customer cs, Orders od
WHERE cs.custid=od.custid
GROUP BY od.custid;


-- 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액을 출력).
SELECT ( SELECT name
FROM Customer cs
WHERE cs.custid=od.custid ) ‘name’, SUM(saleprice) ‘total’
FROM Orders od
GROUP BY od.custid;

-- 인라인 뷰- FROM 부속질의
-- 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력).
select cs.namem, sum(od.saleprice) 'total'
from (select custid,name
	  from customer
      where custid <=2) cs,
      orders od
where cs.custid=od.custid
GROUP BY cs.name;

--  중첩질의 – WHERE 부속질의
--  비교 연산자

-- 질의 4-15 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오
SELECT orderid, saleprice
FROM Orders
WHERE saleprice <= (SELECT AVG(saleprice)
FROM Orders);

-- 질의 4-16 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호,금액을 보이시오.

select orderid, custid, saleprice
from	orders od
where	saleprice > (select AVG(saleprice)
					from orders so
                    WHERE od.custid=so.custid);
                    
-- 질의 4-17 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
SELECT SUM(saleprice) ‘total’
FROM Orders
WHERE custid IN (SELECT custid
				FROM Customer
				wHERE address LIKE '%대한민국%');
                
-- 질의 4-18 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번 호와 금액을 보이시오.

select  orderid, saleprice
from orders
where	saleprice > all (select saleprice
						 from orders
						 where custid='3');
-- 질의 4-19 EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오!!!

SELECT SUM(saleprice) '총 판매액'
FROM Orders od
WHERE EXISTS (SELECT *
			  FROM Customer cs
			 WHERE address LIKE '%대한민국%' AND cs.custid=od.custid);
             
-- 뷰의 생성 !!!! --
-- Book 테이블에서 ‘축구’라는 문구가 포함된 자료만 보여주는 뷰
SELECT *
FROM Book
WHERE bookname LIKE '%축구%';

--  위 SELECT 문을 이용해 작성한 뷰 정의문
CREATE VIEW vw_Book
AS SELECT *
FROM Book
WHERE bookname LIKE '%축구%';

-- 4-20 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오.
create view vw_customer
as select    *
from 		customer
where		address like '%대한민국%'

		
-- 4-21 Orders 테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, ‘김연아’ 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.