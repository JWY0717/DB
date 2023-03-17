-- 상품 테이블 작성
CREATE TABLE 상품 (
   상품코드       VARCHAR(6) NOT NULL PRIMARY KEY,
   상품명        VARCHAR(30)  NOT NULL,
   제조사        VARCHAR(30)  NOT NULL,
   소비자가격     INT,
   재고수량     INT DEFAULT 0
);

-- 입고 테이블 작성
CREATE TABLE 입고 (
   입고번호     INT PRIMARY KEY,
   상품코드      VARCHAR(6) NOT NULL,
   입고일자      DATE,
   입고수량      INT,
   입고단가      INT
);

-- 판매 테이블 작성
CREATE TABLE 판매 (
   판매번호      INT  PRIMARY KEY,
   상품코드      VARCHAR(6),
   판매일자      DATE,
   판매수량      INT,
   판매단가      INT
);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
         ('EEEEEE', '프린터', '삼싱', 200000);
COMMIT;
SELECT * FROM 상품;



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

INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (1, 'AAAAAA', '2004-10-10', 5,   50000);
select * from 상품;
select * from 입고;


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

-- 트리거 2번 -- 2.[입고]테이블에 [수량]을 수정하면 [상품]테이블의 [재고수량]도 수정되는 트리거 작성
update 입고 set 입고수량 = 20 where 입고번호 = 1;
SELECT * FROM 상품; 
SELECT * FROM 입고; 


-- 3번  [입고]테이블에서 삭제(취소)를 하면 [상품]테이블에서 상품의 [재고수량]이 수정되는 트리거 작성

delimiter // 
CREATE TRIGGER AfterDelete
AFTER 
update ON 입고 FOR EACH ROW 
BEGIN
	UPDATE 상품 
    set 재고수량 = 재고수량 + NEW.입고수량
	where 상품코드 = NEW.상품코드;
END; 
// delimiter ;


-- 트리거 3번  [입고]테이블에서 삭제(취소)를 하면 [상품]테이블에서 상품의 [재고수량]이 수정되는 트리거 작성
update 입고 set 입고수량 = 1 where 입고번호 = 2;
SELECT * FROM 상품; 
SELECT * FROM 입고; 
