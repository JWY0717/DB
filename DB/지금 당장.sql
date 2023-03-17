-- 트렌젝션

commit;
rollback;		-- 반영을 취소한다는 명령

select @@autocommit;  -- 0 1qjs @@autocommit @@autocommi이 0인상태

set autocommit=1;

-- book 테이블과 같은 형식의 book1,boo2 테이블 만들기
create table book1 (select * from book);
create table book2 (select * from book);


-- delete 사용하여 book1,book2 테이블 삭제 하기!

delete from book1;
rollback;   -- rollback을 실행을 해도 앞에서 delete from book1을 실행하여 데이터가 삭제되었기 때문에 데이터 복구가 되지 않는다!
			-- 하나의 단위 작업이 끝난다.



-- 트렌젝션 만들기alter
start transaction;
delete from book1;
delete from book2;
rollback;           -- 하나의 트렌젝션이 문제가 생겼을 경우 rollback   
-- commit;   -- 하나의 트렌젝션이 끝났을 경우에는 commit을 사용한다 