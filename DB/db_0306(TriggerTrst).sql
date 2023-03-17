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
   상품코드      VARCHAR(6) NOT NULL REFERENCES 상품(상품코드),
   입고일자      DATE,
   입고수량      INT,
   입고단가      INT
);

-- 판매 테이블 작성
CREATE TABLE 판매 (
   판매번호      INT  PRIMARY KEY ,
   상품코드  VARCHAR(6) NOT NULL REFERENCES 상품(상품코드),
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
         
-- 상품 테이블에 자료 추가 테스트
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (1, 'AAAAAA', '2004-10-10', 5,   50000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (2, 'BBBBBB', '2004-10-10', 15, 700000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (3, 'AAAAAA', '2004-10-11', 15, 52000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (4, 'CCCCCC', '2004-10-14', 15,  250000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (5, 'BBBBBB', '2004-10-16', 25, 700000);
COMMIT;
SELECT * FROM 상품;




