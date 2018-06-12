DROP DATABASE beowulf;
CREATE DATABASE beowulf;
USE beowulf;

CREATE TABLE sw(
		id					INT UNSIGNED NOT NULL AUTO_INCREMENT,
		name    		VARCHAR(64) NOT NULL UNIQUE,
		PRIMARY KEY(id)

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE course(
		id					INT UNSIGNED NOT NULL AUTO_INCREMENT,
		name    		VARCHAR(80) NOT NULL,
		contactid		INT UNSIGNED NOT NULL,
		PRIMARY KEY(id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE user(
		id					INT UNSIGNED NOT NULL AUTO_INCREMENT,
		sign    		VARCHAR(80) NULL,
    fname   		VARCHAR(80) NULL,
    lname   		VARCHAR(80) NULL,
    email   		VARCHAR(128) NOT NULL,    
		PRIMARY KEY(id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE swvers(
		id					INT UNSIGNED NOT NULL AUTO_INCREMENT,
		swid		    INT UNSIGNED NOT NULL,
		name    		VARCHAR(64) NULL,
		releasedate TIMESTAMP,
		licenseid		INT UNSIGNED,
		PRIMARY KEY(id),
    FOREIGN KEY(swid) REFERENCES sw(id)

) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE license(
		id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
		licensestatus	  VARCHAR(80) NOT NULL UNIQUE,
		PRIMARY KEY(id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


CREATE TABLE installed(
		id					INT UNSIGNED NOT NULL AUTO_INCREMENT,
		swversid		INT UNSIGNED NOT NULL,
		rooms   		VARCHAR(256) NULL,
		periodstart	VARCHAR(16) NULL,
		periodend		VARCHAR(16) NULL,
		PRIMARY KEY(id),
    FOREIGN KEY(swversid) REFERENCES swvers(id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE whish(
		id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
		swversid    		INT UNSIGNED NOT NULL,
		courseid		    INT UNSIGNED NOT NULL,
		userid          INT UNSIGNED NOT NULL,
		rooms					  VARCHAR(256) NULL,
		status		      INT UNSIGNED NULL,
		approveddate    TIMESTAMP,
		approveduserid  INT UNSIGNED NULL,
		approvedcomment	VARCHAR(256) NULL,
		PRIMARY KEY(id),
    FOREIGN KEY(swversid) REFERENCES swvers(id),
    FOREIGN KEY(courseid) REFERENCES course(id),
    FOREIGN KEY(userid) REFERENCES user(id),
    FOREIGN KEY(approveduserid) REFERENCES user(id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE whishtest(
		whishid				INT UNSIGNED NOT NULL AUTO_INCREMENT,
		teststatus		INT UNSIGNED NULL,
		testdate      TIMESTAMP,
		testuserid    INT UNSIGNED NULL,
		testcomment		VARCHAR(256) NULL,
		PRIMARY KEY(whishid),
    FOREIGN KEY(testuserid) REFERENCES user(id)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


select * from user;

INSERT INTO user (sign, fname, lname, email) VALUES("ABCDE","Greger","Svensson","gresv@his.se");
INSERT INTO user (sign, fname, lname, email) VALUES("DEFGH","Greger","Olsson","greol@his.se");

select * from sw;

INSERT INTO sw(name) VALUES ("7-zip");
INSERT INTO sw(name) VALUES ("Microsoft Office");
INSERT INTO sw(name) VALUES ("WinSCP");

INSERT INTO swvers (swid, name, releasedate) VALUES (2, "17.01", "2017-01-01");

select * from swvers;

INSERT INTO installed(swversid, rooms, periodstart) VALUES (1,"['E101','E102','G404']","20184");

select * from installed;





