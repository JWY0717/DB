-- 1. 테이블에 상품이 입고가 되면 [상품] 테이블에 상품의 재고수량이 수정되는 트리거
delimiter // 
CREATE TRIGGER AfterInsertinventory 
AFTER INSERT ON 입고 FOR EACH ROW 
BEGIN
	UPDATE 상품 
    SET 재고수량 = new.입고수량 + 재고수량
    WHERE 상품코드 = new.상품코드;
END; 
// delimiter ;


-- 2.[입고]테이블에 [수량]을 수정하면 [상품]테이블의 상품의 [재고수량]도 수정되는 트리거 작성
delimiter // 
CREATE TRIGGER AfterUpdate
AFTER 
update ON 입고 FOR EACH ROW 
BEGIN
	UPDATE 상품
    set 재고수량 = 재고수량 -OLD.입고수량 + NEW.입고수량
    WHERE 상품코드=new.상품코드;
END; 
// delimiter ;

-- 3. [입고]테이블에서 삭제(취소)를 하면 [상품]테이블에서 상품의 [재고수량]이 수정되는 트리거 작성

delimiter // 
CREATE TRIGGER AfterDelete
AFTER 
update ON 입고 FOR EACH ROW 
BEGIN
	UPDATE 상품 
	SET 재고수량 = 재고수량 - OLD.입고수량
	WHERE 상품코드 = OLD.상품코드;
END; 
// delimiter ;

-- 입고테이블 삭제 테스트
DELETE FROM 입고 WHERE 입고번호 = 2;
SELECT * FROM 상품; 
SELECT * FROM 입고; 

-- 4. [판매] 테이블에 자료가 추가되면 [상품] 테이블에 상품의 재고수량이 변경이 되는 트리거

delimiter // 
CREATE TRIGGER BeforeUpdate판매
BEFORE UPDATE ON 판매 FOR EACH ROW 			#데이터가 삽입되면 자동적으로 실행됨
BEGIN 
	-- 재고 수량 파악
    DECLARE vqty INTEGER;
    SELECT 재고수량 INTO vqty 
    FROM 상품 
    where 상품코드 = new.상품코드;
    
    IF (vqty + OLD.판매수량) >= NEW.판매수량 THEN 
		UPDATE 상품
		SET 재고수량 = 재고수량 - NEW.판매수량
		WHERE 상품코드 = NEW.상품코드;
	ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '재고가 부족합니다.';
	END IF;
END; 
// 
delimiter ;


-- 5.[판매] 테이블에 자료가 변경이 된다면 [상품] 테이블에 상품의 재고수량이 변경이 되는 트리거
delimiter //
create trigger beforeUpdate판매
before update on 판매 for each row
begin	
    update 상품 set 재고수량 = 재고수량 - new.판매수량 + old.판매수량 where 상품코드 = new.상품코드;
end; 
// delimiter ;


