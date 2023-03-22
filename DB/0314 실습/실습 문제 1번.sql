use db0220; 
delimiter // 
CREATE PROCEDURE InsertCustomer(  
	 IN New_custid INTEGER,  
	 IN New_name VARCHAR(40),  
	 IN New_address VARCHAR(40),   
	 IN New_phone VARCHAR(40)) 
 BEGIN  
	INSERT INTO customer(custid, name, address, phone)    
		VALUES(New_custid, New_name, New_address, New_phone); 
END; 
// 
delimiter ;
/* 프로시저 InsertCustomer을 테스트하는 부분 */ 
CALL InsertCustomer(7, '장우영', '대한민국 부산', 010-9565-6787);
CALL InsertCustomer(8, '장우영', '대한민국 부산', 1234);
CALL InsertCustomer(7, '장우영', '대한민국 부산', 010-9565-6787);
SELECT * FROM customer;