
-- (3) 출판사가 '이상미디어'인 도서의 이름과 가격을 보여주는 프로시저를 작성하시오.
select bookname, price 
from book
where publisher='이상미디어';


-- (4) 출판사별로 출판사 이름과 도서의 판매 총액을 보이시오(판매 총액은 Orders 테이블에 있다).

select  publisher as 출판사이름,  sum(saleprice) as 판매총액
from book,orders
where book.bookid= orders.bookid
group by publisher;


-- (5) 출판사별로 도서의 평균가보다 비싼 도서의 이름을 보이시오
-- (예를 들어 A 출판사 도서의 평균가가 20,000원이라면 A 출판사 도서 중 20,000원 이상인 도서를 보이면 된다).    

select b1.bookname
from Book b1
where b1.price > (select avg(b2.price)
						from Book b2
						where b2.publisher = b1.publisher);
                        

-- (6) 고객별로 도서를 몇 권 구입했는지와 총 구매액을 보이시오.

select custid, count(*) as 구매권수, sum(saleprice)
from orders
group by custid; 			-- GROUP BY 는 같은 값을 가진 행끼리 하나의 그룹으로 뭉쳐줍니다


-- (7) 주문이 있는 고객의 이름과 주문 총액을 출력하고, 주문이 없는 고객은 이름만 출력하는 프로시저를 작성하시오.




