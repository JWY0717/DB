-- 위치 선언
use db0221;

delimiter // 

-- 선언
create procedure 새수강신청( 
-- 정보 삽입 in 
in  새학번 char(7),
-- 반환받는 값 out
out 새수강신청번호 integer)
    -- 가장 큰 수간신청번호를 아는 것이 중요
-- 실행
Begin 
	select max(수강신청번호) into 새수강신청번호  from 수강신청;
    set 새수강신청번호=새수강신청번호 + 1;
	insert into 수강신청(수강신청번호, 학번, 날짜 ,연도, 학기)
    values(새수강신청번호,새학번,curdate(),'2023','1');
    
End; 
// delimiter ;

call 새수강신청('1804003',@수강신청_번호);
select @수강신청_번호;

