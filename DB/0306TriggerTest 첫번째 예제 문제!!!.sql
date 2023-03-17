 -- 문제 1) [입고] 테﻿이블에 자료가 추가 되는 경우
 -- [상품] 테이블의 재고수량이 되도록 트리거를 작성한다.!
 
delimiter //

CREATE TRIGGER AfterInsertinventory
AFTER INSERT ON 입고 
FOR EACH ROW 
BEGIN
	UPDATE 상품 SET 재고수량 = new.입고수량 + 재고수량
    WHERE 상품코드 = new.상품코드;
END; 

// delimiter ;

-- 결과 확인
INSERT INTO 입고 (입고번호,상품코드,입고일자,입고수량,입고단가)
			VALUES (1, 'AAAAAA', curdate(), 10, 50000); 
SELECT * FROM 상품; 
SELECT * FROM 입고; 

DROP TRIGGER IF EXISTS AfterInsertinventory;
 