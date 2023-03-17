-- 실습2번 "수강신청" 데이터베이스의 총 학생 수,과목 수를 계산하는 "통계“
-- stored procedure를 만드시오. 아래 실행 결과는 이 프로시저를 이용하여 출력한 예이다.

-- 위치 선언
use db0221;

delimiter // 

-- 선언
create procedure 통계( 
-- 출력 하기 위해 정보를 뽑아내기 때문에 out을 사용한다!
out 학생수 int, 
out 과목수 int)
    
-- 실행
Begin 
	select count(학번) into 학생수 from 수강신청;
    select count(distinct(과목번호)) into 과목수 from 수강신청내역;
    
End; 
// delimiter ;

-- 실행결과 실습2
CALL 통계(@a, @c);
SELECT @a AS 학생수, @c AS 과목수;