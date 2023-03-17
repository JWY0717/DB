-- 0306 
-- 예제3 <수강신청내역> 테이블에서 과목별로 수강자 수를 반환하는 저장 프로시저를 작성하시오

-- 위치 선언
use db0221;

delimiter // 

-- 선언
create procedure 과목수강자수( 
-- 정보를 뽑아내기 때문에 out을 사용한다!
in  새과목번호 char(6),
out 수강자수 int)
    
-- 실행

Begin 
	
    select count(*) into 수강자수 from 수강신청내역;
    
End; 
// delimiter ;

-- 3번 예제 실행결과
call 과목수강자수(@a);
select count(@a) as 수강자수
from 수강신청내역
where 과목번호='K20002';
