# (3) 출판사가 '이상미디어'인 도서의 이름과 가격을 보여주는 프로시저를 작성하시오.
use db0220
delimiter //
CREATE PROCEDURE cusor_pro3()

BEGIN
	DECLARE myname varchar(40);
    DECLARE myprice int;
    DECLARE endOfRow BOOLEAN  default false;
    DECLARE bookCursor cursor for select bookname, price from Book where publisher ='이상미디어';
    DECLARE CONTINUE handler FOR NOT FOUND SET endOfRow=TRUE;
	OPEN bookCursor;
    cursor_loop: LOOP
		FETCH bookCursor INTO myname,myprice;
		IF endOfRow THEN LEAVE cursor_loop;
		END IF;
        SELECT myname,myprice;
	END LOOP cursor_loop;
	CLOSE bookCursor;
END;
//
delimiter ;

call cusor_pro3