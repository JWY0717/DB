create table account(
accNum char(10) primary key,
amount int not null default 0);


insert into account values('A',45000);
insert into account values('B',100000);

-- A계좌에서 40000원을 뺴서 B계좌로 송금 하시오

sel