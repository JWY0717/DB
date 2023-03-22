# BookInsertOrUpdate(2) BookInsertOrUpdate() 프로시저를 수정하여 삽입 작업을 수행하는 프로시저를 작성하시오. 
# 삽입하려는 도서와 동일한 도서가 있으면 삽입하려는 도서의 가격이 높을 때만 새로운 값으로 변경한다. 

use db0220
delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
 myBookID INTEGER,
 myBookName VARCHAR(40),
 myPublisher VARCHAR(40),
 myPrice INT)
BEGIN
 DECLARE mycount INTEGER;
 SELECT count(*) INTO mycount FROM Book
 WHERE bookname LIKE myBookName;
 IF mycount!=0 THEN
 SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정 문 */
 UPDATE Book SET price = myPrice
 WHERE price<myPrice;
 ELSE
 INSERT INTO Book(bookid, bookname, publisher, price)
 VALUES(myBookID, myBookName, myPublisher, myPrice);
 END IF;
END;
//
delimiter ;

-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 25000);
SELECT * FROM Book; -- 15번 투플 삽입 결과 확인

-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book; -- 15번 투플 가격 변경 확인



