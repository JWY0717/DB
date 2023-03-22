-- 7) 주문이 있는 고객의 이름과 주문 총액을 출력하고, 주문이 없는 고객은 이름만 출력하는 프로시저를 작성하시오.

drop procedure if exists mission7 ;
delimiter //
CREATE PROCEDURE mission7()
BEGIN
	declare done BOOLEAN default false;			/*행의 끝 여부 */
    declare v_sum INT;							
    declare v_id INT;
    declare v_name varchar(20);
    
    -- select한 결과를 cursor1로 정의
    DECLARE cursor1 CURSOR FOR SELECT custid, name 	FROM Customer; 	  /* 커서 선언 */
    DECLARE CONTINUE handler FOR NOT FOUND SET done=TRUE;           /* 행의 끝일 때 Handler 정의 */

    open cursor1;													/*커서 열기*/
	my_loop: LOOP													/* 선언 */
	FETCH cursor1 INTO v_id,v_name;
		select sum(saleprice) into v_sum from Orders where custid=v_id;
        if done THEN
			LEAVE my_loop;
		End IF;
        select v_name, v_sum;
        END LOOP my_loop;
	close cursor1;
END;
//
delimiter ;
