#UC1
CREATE DATABASE addressbook_service;
SHOW DATABASES;
USE addressbook_service;
SELECT DATABASE();

#UC2
CREATE TABLE addressbook
(	PersonId INT unsigned NOT NULL AUTO_INCREMENT,
	FirstName	VARCHAR(150) NOT NULL,
	LastName	VARCHAR(150) NOT NULL,
	Address	VARCHAR(150) NOT NULL,
    City	VARCHAR(150) NOT NULL,
    State	VARCHAR(150) NOT NULL,
    Zip	VARCHAR(150) NOT NULL,
    PhoneNumber	VARCHAR(15) NOT NULL,
    Email	VARCHAR(150) NOT NULL,
    PRIMARY KEY	(PersonId)
);
DESCRIBE addressbook;

#UC3
INSERT INTO addressbook
(FirstName,LastName,Address,City,State,Zip,PhoneNumber,Email) VALUES
('Terrisa','Sh','CST','Mumbai','Maharashtra','492792','9876543210','ts@gm.com'),
('Bill','Sh','Dadar','Mumbai','Maharashtra','485792','9876543211','bs@gm.com'),
('Mark','W','Karve','Pune','Maharashtra','463792','9876543212','mw@gm.com'),
('Gunjan','T','K','Kerala','Kerala','498792','9876543213','gt@gm.com');
SELECT * FROM addressbook;

#UC4
UPDATE addressbook SET Address = 'Nagar',City='Pune', State='Maharashtra', Zip='426312'
WHERE FirstName = 'Bill';

#UC5
DELETE FROM addressbook
WHERE FirstName = 'Gunjan';

#UC6
SELECT City,FirstName, LastName, Address, State, Zip, PhoneNumber, Email
FROM addressbook WHERE City = 'Pune';
SELECT State,FirstName, LastName, Address, City, Zip, PhoneNumber, Email
FROM addressbook WHERE State = 'Maharashtra';

#UC7
SELECT City,COUNT(City) FROM addressbook GROUP BY City;
SELECT State,COUNT(State) FROM addressbook GROUP BY State;

#UC8
INSERT INTO addressbook 
(FirstName,LastName,Address,City,State,Zip,PhoneNumber,Email) VALUES
('Gunjan','T','K','Mumbai','Maharashtra','498792','9876543213','gt@gm.com');

SELECT PersonId,Firstname, Lastname,Address,City,State,Zip,PhoneNumber,Email
FROM addressbook WHERE City='Mumbai'
ORDER BY Firstname;

#UC9
ALTER TABLE addressbook ADD AddressbookName VARCHAR(20) NOT NULL AFTER PersonId,
ADD AddressbookType VARCHAR(20) NOT NULL AFTER AddressbookName;

UPDATE addressbook SET AddressbookName = 'FamilyContact',AddressbookType='Family'
WHERE FirstName = 'Bill';
UPDATE addressbook SET AddressbookName = 'FamilyContact',AddressbookType='Family'
WHERE FirstName = 'Terrisa';
UPDATE addressbook SET AddressbookName = 'FriendContact',AddressbookType='Friend'
WHERE FirstName = 'Mark';
UPDATE addressbook SET AddressbookName = 'ProfessionContact',AddressbookType='Profession'
WHERE FirstName = 'Gunjan';

#UC10
SELECT AddressbookType,COUNT(FirstName) FROM addressbook GROUP BY AddressbookType;

#UC11
INSERT INTO addressbook 
(AddressbookName,AddressbookType,FirstName,LastName,Address,City,State,Zip,PhoneNumber,Email) VALUES
('FriendContact','Friend','Terrisa','Sh','CST','Mumbai','Maharashtra','492792','9876543210','ts@gm.com');

#UC12
CREATE TABLE addressbook_type (
    TypeId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    AddressbookName VARCHAR(20) NOT NULL,
    AddressbookType VARCHAR(20) NOT NULL,
    PRIMARY KEY	(TypeId)
);
INSERT INTO addressbook_type (AddressbookName,AddressbookType)
SELECT DISTINCT AddressbookName,AddressbookType
FROM addressbook;
SELECT * FROM addressbook;
SELECT * FROM addressbook_type;
ALTER TABLE addressbook DROP COLUMN AddressbookName,
DROP COLUMN AddressbookType;

CREATE TABLE contact_type (
	PersonId INT UNSIGNED NOT NULL,
	TypeId INT UNSIGNED NOT NULL,
    PRIMARY KEY(PersonId,TypeId),
    FOREIGN KEY	(PersonId)
    REFERENCES addressbook(PersonId)
		ON DELETE CASCADE,
	FOREIGN KEY	(TypeId)
    REFERENCES addressbook_type(TypeId)
		ON DELETE CASCADE
);
INSERT INTO contact_type(PersonId,TypeId) VALUES
(1,1),
(1,2),
(2,1),
(3,2),
(5,3);
DELETE FROM addressbook WHERE PersonId = 6;
SELECT * FROM contact_type;
SELECT * FROM addressbook;

CREATE TABLE address_details (
    PersonId INT UNSIGNED NOT NULL,
	Address	VARCHAR(150) NOT NULL,
    City	VARCHAR(150) NOT NULL,
    State	VARCHAR(150) NOT NULL,
    Zip	VARCHAR(150) NOT NULL,
    FOREIGN KEY	(PersonId)
    REFERENCES addressbook(PersonId)
		ON DELETE CASCADE
);
INSERT INTO address_details (PersonId,Address,City,State,Zip)
SELECT DISTINCT PersonId,Address,City,State,Zip
FROM addressbook;
SELECT * FROM address_details;
ALTER TABLE addressbook DROP COLUMN Address,
DROP COLUMN City,
DROP COLUMN State,
DROP COLUMN Zip;
SELECT * FROM addressbook;

#UC13
#UC6--
SELECT City,FirstName, LastName, Address, State, Zip, PhoneNumber, Email
FROM addressbook a,address_details d WHERE a.PersonId=d.PersonId AND City = 'Pune';
SELECT State,FirstName, LastName, Address, City, Zip, PhoneNumber, Email
FROM  addressbook a,address_details d WHERE a.PersonId=d.PersonId AND State = 'Maharashtra';

#UC7--
SELECT City,COUNT(City) FROM addressbook a,address_details d WHERE a.PersonId=d.PersonId GROUP BY City;
SELECT State,COUNT(State) FROM addressbook a,address_details d WHERE a.PersonId=d.PersonId GROUP BY State;

#UC8--
SELECT a.PersonId,Firstname, Lastname,Address,City,State,Zip,PhoneNumber,Email
FROM addressbook a,address_details d WHERE a.PersonId=d.PersonId AND City='Mumbai'
ORDER BY Firstname;

#UC10--
SELECT AddressbookType,COUNT(FirstName) FROM addressbook a,addressbook_type t,contact_type c
WHERE c.TypeId=t.TypeId AND a.PersonId=c.PersonId
GROUP BY AddressbookType;