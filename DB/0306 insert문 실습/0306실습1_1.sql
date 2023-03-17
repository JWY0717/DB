use db0221;

delimiter // 

-- 선언
create procedure 학과_입력_수정( 
	in 새학과번호 char(2), 
    in 새학과명 char(30), 
    in 새전화번호 char(30)) 
    
-- 실행
begin 
	declare cnt integer;
	select count(*) into cnt
    from 학과
    where 학과번호 = 새학과번호;
    
    if (cnt=0) then
		insert into 학과 
		values(새학과번호, 새학과명,새전화번호);
	else
		 UPDATE 학과 set 학과명=새학과명, 전화번호=새전화번호
         where  학과번호=새학과번호;
	end if;

    
end; 
// delimiter ;

-- 실행결과
call 학과_입력_수정('08', '빅데이터보안학과', '051-512-8623');
select * from 학과 
where 학과명 = '빅데이터보안학과';


