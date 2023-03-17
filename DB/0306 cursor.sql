--  저장 프로그램
--  커서를 사용하는 프로시저 , 작동 순서
/*	① 커서 선언(DECLARE)
	② 반복 조건 선언(DECLARE, HANDLER)
	③ 커서 열기(OPEN)
	④ 커서에서 데이터 가져오기(FETCH)
	⑤ 데이터 처리
	⑥ 커서 닫기(CLOSE)*/
    delimiter //
CREATE PROCEDURE Interest()
BEGIN
	DECLARE myInterest INTEGER DEFAULT 0.0;
	DECLARE Price INTEGER;
	DECLARE endOfRow BOOLEAN DEFAULT FALSE; 			/* 행의 끝 여부 */
	DECLARE InterestCursor CURSOR FOR 					/* 커서 선언*/
				SELECT saleprice FROM Orders;
	DECLARE CONTINUE handler 							/* 행의 끝일 때 Handler 정의 */
				FOR NOT FOUND SET endOfRow=TRUE;
	OPEN InterestCursor; 								/* 커서의 사용을 시작!*/
	cursor_loop: LOOP
		FETCH InterestCursor INTO Price;				/*FETCH= 행 테이터를 가져옴*/
		IF endOfRow THEN LEAVE cursor_loop;
		END IF;
		IF Price >= 30000 THEN
			SET myInterest = myInterest + Price * 0.1;
		ELSE
			SET myInterest = myInterest + Price * 0.05;
		END IF;
		END LOOP cursor_loop;
		CLOSE InterestCursor;				/*close = 커서의 사용을 끝냄!*/
		SELECT CONCAT(' 전체 이익 금액 = ', myInterest);
END;
//
delimiter ;

-- 실행 Interest 프로시저를 실행하여 판매된 도서에 대한 이익금을 계산 
CALL Interest();
