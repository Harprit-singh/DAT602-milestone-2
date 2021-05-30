Drop database if exists abc;
Create database abc;

use abc;
Drop procedure if exists ddl;
delimiter //
Create procedure ddl()

Begin 




create table Player (
	Playerid INT primary key,
	username VARCHAR(50),
	password VARCHAR(50),
	email VARCHAR(50),
	locked int,
	adminuser  boolean,
	loginattempts INT,
    useronline INt,
	hittotal INT,
	misstotal INT,
	highscore INT
);

create table tank (
Tankid INT primary key,
Playerid int,
FOREIGN KEY (Playerid) REFERENCES Player(playerid)
);

create table Game (
Gameid INT  primary key,
gametype boolean,
gamestatus varchar(10)
);

Create table Alien (
Alienid int primary key,
Tankid int,
Missile int,
Foreign key  (Tankid) References tank(Tankid) );

Create table Missile (
missileid int primary key,
tankid int,
Foreign key  (Tankid) References tank(Tankid) );


Create table Session (
Gameid int PRimary key,
Playerid int,
Hit int,
Miss int,
Foreign key (Playerid) References Player(Playerid) );

Create table GameBoard (
Boardid int Primary key,
Gameid int,
Boardnumber int);

create table Userdetails (
userId int Primary key,
username varchar(50),
Foreign key (Playerid) References Player(Playerid) );


END //
Delimiter ; 
--
drop procedure if exists dml;
delimiter //
create procedure dml()
begin

-- insert

INSERT INTO Player(Playerid, username, password, email) values (1, 'Gilbertina', 'Wight', 'gwight0@sfgate.com');
INSERT INTO GameBoard ( Boardid, Gameid, Boardnumber) Values (1 ,1,1 );

Insert into Game ( Gameid, gametype, gamestatus) values (1 , true, 'yes' );
 


END //
Delimiter ; 
call ddl();
call dml();

----------------------------------
Drop procedure if exists Login;
    Delimiter $$

create procedure Login
(in pName varchar(50), in pPassword varchar(500))
begin
    declare proposedUID int default null;
  
	select `Playerid` 
	from 
		`player`
	where 
		 `username` = pName and 
		 `password` = pPassword
	 into proposedUID;
     
     if proposedUID is NULL then
         select 'Invalid Password' as 'Message', -1 as `Value`;
	 else
		select 'Valid Password' as 'Message', proposedUID as `Value`;
	 end if;
     
end $$
delimiter ;

call Login('John',1234);



Drop procedure if exists addingplayer;
    Delimiter $$

create procedure addingplayer 
(in pName varchar(50), in pPassword varchar(50), in pemail varchar(50))
begin
If pUsername IN(
                select ' Username'
                From player)
	Then 
    select 'player already exists' As message;
    else
    INSERT INTO player ('username', 'password', 'email')
    Values (pUsername, npassword, pemail);
    );
       Select player('Usercreated:', pUsername) As MESSAGE;
	
END if;
END //
DELIMITer;
 
 
 
DROP PROCEDURE IF EXISTS `deleteid`;
DELIMITER //
CREATE PROCEDURE `deleteid`(
	IN pUsername VARCHAR(50)
    )
deleteUser: BEGIN
    IF (
		SELECT Username 
        FROM userdetails
        WHERE Username = pUsername) = pUsername
    THEN
		DELETE FROM userdetails
		WHERE Username = pUsername;
			
		SELECT ("iddeleted: ") AS MESSAGE;
	ELSE
		SELECT ("try again") AS MESSAGE;
	END IF;
END //
DELIMITER ;

 DROP PROCEDURE IF EXISTS `getAllUsers`;
DELIMITER //
CREATE PROCEDURE `getAllUsers`()
BEGIN
	SELECT `Username`, `Password`, `Email`
    FROM Userdetails ;
END //
DELIMITER ;
 
 
 














CREATE PROCEDURE `test`.`sp_register`(fullname VARCHAR(50), Mob VARCHAR(10), Email VARCHAR(50), pass VARCHAR(255))
BEGIN
DECLARE s VARCHAR(20);
IF EXISTS(SELECT id FROM users WHERE email = Email)
    THEN SET s = 'User already exists';
ELSE
    INSERT INTO users(`name`,`mobile`,`email`,`password`,`created_at`) 
        VALUES(fullname,Mob, Email, pass,CURRENT_TIMESTAMP())
        THEN SET s =  "User Registered"; 
END IF;


END

    




    