-- Active: 1708549946789@@127.0.0.1@3306@SoftwareDB

-- putting the client data into the person table
INSERT INTO Person (FName, LName, PhoneNum, Email)
VALUES
    ('Nathaniel', 'Cardenas', '1 61 201 9859-0190', 'dis.parturient@Sedetlibero.co.uk'),
    ('Joseph', 'Jimenez', '(720) 301-6622', 'egestas@turpisNullaaliquet.edu'),
    ('Indigo', 'Sanchez', '(287) 628-2750', 'vitae.sodales.nisi@erosturpis.edu'),
    ('Reese', 'Coleman', '(583) 256-4773', 'vitae@nequetellusimperdiet.edu'),
    ('Mary', 'Palmer', '(885) 261-1266', 'sem.egestas@urnaconvallis.com'),
    ('Flavia', 'Young', '(586) 963-2730', 'vulputate.mauris.sagittis@estvitaesodales.com'),
    ('Lee', 'Beach', '(512) 648-2867', 'pede.ac@at.org'),
    ('Sydnee', 'Casey', '(545) 729-8045', 'erat.nonummy@Mauris.com'),
    ('Dorothy', 'Riddle', '(975) 262-8139', 'eros.Proin.ultrices@pharetrafeliseget.com'),
    ('Ella', 'Guerrero', '(252) 967-4155', 'erat.nonummy.ultricies@estvitaesodales.org'),
    ('Kylynn', 'Bender', '(823) 736-6054', 'Integer.vulputate.risus@urnasuscipitnonummy.edu'),
    ('Emi', 'Kim', '(992) 407-9758', 'at@hymenaeosMauris.edu'),
    ('Lamar', 'Mcleod', '(892) 597-8866', 'placerat@velnislQuisque.org'),
    ('Sean', 'Pugh', '(184) 160-8822', 'neque@quamdignissimpharetra.edu'),
    ('Ocean', 'Wilcox', '(767) 643-2501', 'velit@convallisligulaDonec.ca'),
    ('Sharon', 'Eaton', '(843) 735-8496', 'sit@eueros.ca'),
    ('Audra', 'Smith', '(552) 602-7097', 'vel.pede.blandit@vulputateullamcorper.org'),
    ('Aurelia', 'Hickman', '(240) 189-7911', 'et@sem.org'),
    ('Sacha', 'Conway', '(284) 994-7823', 'nunc.nulla.vulputate@ultriciesdignissim.ca'),
    ('Regan', 'Greene', '(163) 865-0763', 'massa.Integer.vitae@Suspendisse.com'),
    ('Alvin', 'Greene', '(398) 180-3777', 'egestas@euaugue.ca'),
    ('Cadman', 'Ryan', '(773) 749-0102', 'pellentesque@fringilla.org'),
    ('Edan', 'Curtis', '(702) 180-7972', 'et.magna@Nullatempor.com'),
    ('Chantale', 'Lopez', '(165) 186-3806', 'congue@porttitorinterdumSed.com'),
    ('Alea', 'Page', '(587) 374-5100', 'ac.risus@nunc.com'),
    ('Shana', 'Hess', '(560) 850-4774', 'nec@laoreetipsum.ca'),
    ('Emily', 'Merrill', '(101) 621-6658', 'gravida.Aliquam@odioauctorvitae.com'),
    ('Garrett', 'Wright', '(380) 758-1705', 'eu.sem.Pellentesque@lectuspedeultrices.ca'),
    ('Yvette', 'Hickman', '(526) 291-9406', 'egestas.hendrerit@Nunc.org'),
    ('Sierra', 'Hughes', '(542) 623-2911', 'imperdiet@neque.org'),
    ('Grace', 'Edwards', '(724) 774-3193', 'tincidunt.congue@erat.edu'),
    ('Melanie', 'Foreman', '(896) 187-1072', 'amet.ornare.lectus@tellusimperdiet.ca'),
    ('Timothy', 'Hatfield', '(668) 178-3355', 'dui.in@orci.org'),
    ('Burton', 'Gardner', '(790) 808-1718', 'vitae.odio.sagittis@vitaedolorDonec.ca'),
    ('Griffith', 'Alston', '(818) 254-7929', 'ipsum.Curabitur@a.org'),
    ('Barclay', 'Barry', '(518) 680-4512', 'pharetra.ut.pharetra@Incondimentum.ca'),
    ('Pearl', 'Mclean', '(920) 723-6827', 'augue.eu.tempor@Pellentesquehabitantmorbi.com'),
    ('Yetta', 'Pratt', '(987) 549-7193', 'sit.amet.ultricies@sodales.org'),
    ('Fiona', 'Lott', '(358) 931-6195', 'arcu@sedconsequat.com'),
    ('Halla', 'Le', '(784) 593-7808', 'parturient@mauris.ca'),
    ('Molly', 'Padilla', '(808) 527-0206', 'fringilla.est.Mauris@In.edu'),
    ('Riley', 'Wells', '(673) 553-2804', 'Suspendisse.dui@penatibus.ca'),
    ('Carla', 'Casey', '(339) 450-0540', 'cursus@sitametconsectetuer.com'),
    ('Levi', 'Garcia', '(717) 997-4565', 'hendrerit.neque.In@magnaaneque.ca'),
    ('Barclay', 'Avila', '(360) 325-3211', 'eget@Crasegetnisi.edu'),
    ('Thane', 'Ellison', '(280) 647-1318', 'tortor.Integer@loremipsumsodales.edu'),
    ('Logan', 'Lynn', '(580) 802-9267', 'elit.sed.consequat@Seddictum.ca'),
    ('Kaye', 'Burt', '(498) 630-4803', 'inceptos@ipsumportaelit.ca'),
    ('Maurice', 'Moss', '0118 999 88199 9119 725 3', 'mmoss@Emergency.co.uk'),
    ('Katell', 'Ballard', '1-741-897-9578', 'semper.Nam.tempor@eunequepellentesque.ca');

-- putting the contact dates into client table with the corresponding PersonID
INSERT INTO Client (ClientID, FirstContactDate)
VALUES
    ((SELECT MIN(PersonID) FROM Person), '2009-01-01'),
    ((SELECT MIN(PersonID) FROM Person) + 1, '2011-01-01'),
    ((SELECT MIN(PersonID) FROM Person) + 2, '2004-05-07'),
    ((SELECT MIN(PersonID) FROM Person) + 3, '2010-09-08'),
    ((SELECT MIN(PersonID) FROM Person) + 4, '2007-05-05'),
    ((SELECT MIN(PersonID) FROM Person) + 5, '2003-02-11'),
    ((SELECT MIN(PersonID) FROM Person) + 6, '2010-02-11'),
    ((SELECT MIN(PersonID) FROM Person) + 7, '2003-12-03'),
    ((SELECT MIN(PersonID) FROM Person) + 8, '2004-05-03'),
    ((SELECT MIN(PersonID) FROM Person) + 9, '2010-09-08'),
    ((SELECT MIN(PersonID) FROM Person) + 10, '2001-03-05'),
    ((SELECT MIN(PersonID) FROM Person) + 11, '2002-05-08'),
    ((SELECT MIN(PersonID) FROM Person) + 12, '2003-08-10'),
    ((SELECT MIN(PersonID) FROM Person) + 13, '2007-09-10'),
    ((SELECT MIN(PersonID) FROM Person) + 14, '2001-08-04'),
    ((SELECT MIN(PersonID) FROM Person) + 15, '2011-02-06'),
    ((SELECT MIN(PersonID) FROM Person) + 16, '2006-12-02'),
    ((SELECT MIN(PersonID) FROM Person) + 17, '2008-01-05'),
    ((SELECT MIN(PersonID) FROM Person) + 18, '2001-08-04'),
    ((SELECT MIN(PersonID) FROM Person) + 19, '2009-02-08'),
    ((SELECT MIN(PersonID) FROM Person) + 20, '2011-07-10'),
    ((SELECT MIN(PersonID) FROM Person) + 21, '2007-08-08'),
    ((SELECT MIN(PersonID) FROM Person) + 22, '2001-03-05'),
    ((SELECT MIN(PersonID) FROM Person) + 23, '2007-08-08'),
    ((SELECT MIN(PersonID) FROM Person) + 24, '2001-03-05'),
    ((SELECT MIN(PersonID) FROM Person) + 25, '2008-08-08'),
    ((SELECT MIN(PersonID) FROM Person) + 26, '2007-07-07'),
    ((SELECT MIN(PersonID) FROM Person) + 27, '2003-02-08'),
    ((SELECT MIN(PersonID) FROM Person) + 28, '2002-02-04'),
    ((SELECT MIN(PersonID) FROM Person) + 29, '0007-11-10'),
    ((SELECT MIN(PersonID) FROM Person) + 30, '2001-01-11'),
    ((SELECT MIN(PersonID) FROM Person) + 31, '2001-01-11'),
    ((SELECT MIN(PersonID) FROM Person) + 32, '2010-09-10'),
    ((SELECT MIN(PersonID) FROM Person) + 33, '2010-11-10'),
    ((SELECT MIN(PersonID) FROM Person) + 34, '2010-10-10'),
    ((SELECT MIN(PersonID) FROM Person) + 35, '1999-10-09'),
    ((SELECT MIN(PersonID) FROM Person) + 36, '2001-08-01'),
    ((SELECT MIN(PersonID) FROM Person) + 37, '2006-06-10'),
    ((SELECT MIN(PersonID) FROM Person) + 38, '2009-10-06'),
    ((SELECT MIN(PersonID) FROM Person) + 39, '2003-04-03'),
    ((SELECT MIN(PersonID) FROM Person) + 40, '2002-12-02'),
    ((SELECT MIN(PersonID) FROM Person) + 41, '2001-01-01'),
    ((SELECT MIN(PersonID) FROM Person) + 42, '2001-10-11'),
    ((SELECT MIN(PersonID) FROM Person) + 43, '2003-11-07'),
    ((SELECT MIN(PersonID) FROM Person) + 44, '2005-10-08'),
    ((SELECT MIN(PersonID) FROM Person) + 45, '2009-10-09'),
    ((SELECT MIN(PersonID) FROM Person) + 46, '2003-10-11'),
    ((SELECT MIN(PersonID) FROM Person) + 47, '2002-10-10'),
    ((SELECT MIN(PersonID) FROM Person) + 48, '2009-10-11'),
    ((SELECT MIN(PersonID) FROM Person) + 49, '2009-10-10');

--putting the employee data into person table
INSERT INTO Person (FName, LName, PhoneNum, Email)
VALUES
    ('Emerald', 'Wilkerson', '(830) 380-8286', 'accumsan@In.edu'),
    ('Emmanuel', 'Pace', '(714) 314-1714', 'velit.Sed.malesuada@elitfermentum.org'),
    ('Aline', 'Maddox', '(698) 459-4665', 'elementum.purus.accumsan@parturient.edu'),
    ('Quintessa', 'Frederick', '(280) 320-6684', 'et@Curae;Donectincidunt.ca'),
    ('Carissa', 'Ford', '(869) 528-4436', 'Quisque@elitpellentesquea.ca'),
    ('Odette', 'Espinoza', '(149) 881-6884', 'non.sollicitudin@variusorciin.org'),
    ('Ursula', 'Stewart', '(543) 805-9009', 'condimentum@a.edu'),
    ('Tyrone', 'Wong', '(368) 204-1888', 'lacus.Quisque@DonecnibhQuisque.edu'),
    ('Wyatt', 'Figueroa', '(693) 683-3045', 'ullamcorper@montesnascetur.ca'),
    ('Michael', 'Atkinson', '(788) 663-4346', 'laoreet.lectus@necorciDonec.com'),
    ('Oscar', 'Cox', '(612) 165-4103', 'Vivamus.rhoncus@Suspendissealiquet.org'),
    ('Quail', 'Crawford', '(615) 180-4718', 'convallis.in.cursus@orci.ca'),
    ('Martin', 'Mccarthy', '(806) 840-5820', 'ipsum@nec.edu'),
    ('Palmer', 'Albert', '(927) 107-9138', 'euismod.in@perconubia.edu'),
    ('Blythe', 'Joyner', '(363) 573-4006', 'fringilla.purus.mauris@veliteusem.edu'),
    ('Sonia', 'Burnett', '(272) 566-4195', 'Pellentesque@nibh.org'),
    ('Zane', 'Horn', '(744) 813-6816', 'sed@ProinvelitSed.ca'),
    ('Tatiana', 'Joseph', '(736) 798-7934', 'vitae@dolorsitamet.ca'),
    ('Rooney', 'Wilkins', '(747) 910-9847', 'Nunc.lectus.pede@natoque.org'),
    ('Fay', 'Mckee', '(705) 147-4373', 'ac.facilisis.facilisis@dui.edu'),
    ('Giacomo', 'Cantrell', '(120) 509-7264', 'sem@purus.ca'),
    ('Whitney', 'Jacobson', '(448) 276-7008', 'Phasellus@Vivamusnonlorem.org'),
    ('Lisandra', 'Reyes', '(930) 581-4904', 'amet.consectetuer@CurabiturmassaVestibulum.com'),
    ('Aurora', 'Carrillo', '(481) 462-8535', 'nibh.dolor@blandit.com'),
    ('Angelica', 'Conner', '(651) 696-6850', 'nascetur.ridiculus@et.com');

-- putting in the EmpIDs and salaries
INSERT INTO Employee (EmpID, Salary)
VALUES 
    ((SELECT MIN(PersonID) FROM Person) + 50, 40109),
    ((SELECT MIN(PersonID) FROM Person) + 51, 106354),
    ((SELECT MIN(PersonID) FROM Person) + 52, 153308),
    ((SELECT MIN(PersonID) FROM Person) + 53, 167687),
    ((SELECT MIN(PersonID) FROM Person) + 54, 23308),
    ((SELECT MIN(PersonID) FROM Person) + 55, 153903),
    ((SELECT MIN(PersonID) FROM Person) + 56, 49855),
    ((SELECT MIN(PersonID) FROM Person) + 57, 31763),
    ((SELECT MIN(PersonID) FROM Person) + 58, 73617),
    ((SELECT MIN(PersonID) FROM Person) + 59, 63376),
    ((SELECT MIN(PersonID) FROM Person) + 60, 61079),
    ((SELECT MIN(PersonID) FROM Person) + 61, 77551),
    ((SELECT MIN(PersonID) FROM Person) + 62, 178511),
    ((SELECT MIN(PersonID) FROM Person) + 63, 46726),
    ((SELECT MIN(PersonID) FROM Person) + 64, 96594),
    ((SELECT MIN(PersonID) FROM Person) + 65, 81188),
    ((SELECT MIN(PersonID) FROM Person) + 66, 25777),
    ((SELECT MIN(PersonID) FROM Person) + 67, 83660),
    ((SELECT MIN(PersonID) FROM Person) + 68, 172150),
    ((SELECT MIN(PersonID) FROM Person) + 69, 30249),
    ((SELECT MIN(PersonID) FROM Person) + 70, 127242),
    ((SELECT MIN(PersonID) FROM Person) + 71, 196268),
    ((SELECT MIN(PersonID) FROM Person) + 72, 156704),
    ((SELECT MIN(PersonID) FROM Person) + 73, 87891),
    ((SELECT MIN(PersonID) FROM Person) + 74, 82579);


    -- insert service plan DATABASE
INSERT INTO ServicePlan (Cost, ServiceLevel)
VALUES
    (10000, 'Gold'),
    (7000, 'Silver'),
    (3000, 'Bronze'),
    (100, 'Tin');

-- insert SoftwareProduct data
INSERT INTO SoftwareProduct(Name, CurrVersionNum, EmpID, Dependencies)
VALUES
    ('Stellar Teller', 3.00, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Aline'
                             AND
                             Person.LName = 'Maddox'), 'SpellerLite,Vi,mauris id'),
    ('Word Precise', 4.10, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Quintessa'
                             AND
                             Person.LName = 'Frederick'), 'Anodize,Where Am I? GPS App,Speller,mauris id,Vivamus nibh'),
    ('Anodize', 3.00, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Carissa'
                             AND
                             Person.LName = 'Ford'), 'ATM Buddy'),
    ('ATM Buddy', 5.32, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Odette'
                             AND
                             Person.LName = 'Espinoza'), 'Where Am I? GPS App,Speller,StoryTeller,mauris id'),
    ('Where Am I? GPS App', 1.00, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Ursula'
                             AND
                             Person.LName = 'Stewart'), 'SpellerLite,Vi,mauris id'),
    ('Speller', 5.33, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Tyrone'
                             AND
                             Person.LName = 'Wong'), 'SpellerLite,Stone Tablet'),
    ('SpellerLite', 1.10, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Wyatt'
                             AND
                             Person.LName = 'Figueroa'), 'StoryTeller,Stone Tablet,mauris id'),
    ('StoryTeller', 4.02, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Michael'
                             AND
                             Person.LName = 'Atkinson'), NULL),
    ('Stone Tablet', 5.32, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Oscar'
                             AND
                             Person.LName = 'Cox'), 'Vi,mauris id'),
    ('Vi', 1.33, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Quail'
                             AND
                             Person.LName = 'Crawford'), NULL),
    ('mauris id', 1.00, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Martin'
                             AND
                             Person.LName = 'Mccarthy'), 'Vivamus nibh'),
    ('Vivamus nibh', 1.01, (SELECT PersonID
                             FROM Person
                             WHERE
                             Person.FName = 'Palmer'
                             AND
                             Person.LName = 'Albert'), NULL);

       
                      
INSERT INTO UsesProduct(ClientID, SoftwareID, PtOfContact_EmpID, PlanID)
VALUES
    ((SELECT PersonID FROM Person WHERE Person.FName = 'Katell' AND Person.LName = 'Ballard'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'mauris id'),
    (SELECT PersonID FROM Person WHERE Person.FName = 'Michael' AND Person.LName = 'Atkinson'),
    (SELECT PlanID FROM ServicePlan WHERE ServicePlan.ServiceLevel = 'Gold')),
    ((SELECT PersonID FROM Person WHERE FName = 'Garrett' AND LName = 'Wright'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Stellar Teller'),
    (SELECT PersonID FROM Person WHERE FName = 'Whitney' AND LName = 'Jacobson'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Tin')),
    ((SELECT PersonID FROM Person WHERE FName = 'Alvin' AND LName = 'Greene'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Where Am I? GPS App'),
    (SELECT PersonID FROM Person WHERE FName = 'Ursula' AND LName = 'Stewart'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Tin')),
    ((SELECT PersonID FROM Person WHERE FName = 'Ocean' AND LName = 'Wilcox'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'mauris id'),
    (SELECT PersonID FROM Person WHERE FName = 'Tatiana' AND LName = 'Joseph'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Gold')),
    ((SELECT PersonID FROM Person WHERE FName = 'Chantale' AND LName = 'Lopez'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Anodize'),
    (SELECT PersonID FROM Person WHERE FName = 'Blythe' AND LName = 'Joyner'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Tin')),
    ((SELECT PersonID FROM Person WHERE FName = 'Riley' AND LName = 'Wells'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Stone Tablet'),
    (SELECT PersonID FROM Person WHERE FName = 'Palmer' AND LName = 'Albert'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Gold')),
    ((SELECT PersonID FROM Person WHERE FName = 'Flavia' AND LName = 'Young'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Speller'),
    (SELECT PersonID FROM Person WHERE FName = 'Fay' AND LName = 'Mckee'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Gold')),
    ((SELECT PersonID FROM Person WHERE FName = 'Carla' AND LName = 'Casey'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Anodize'),
    (SELECT PersonID FROM Person WHERE FName = 'Whitney' AND LName = 'Jacobson'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Tin')),
    ((SELECT PersonID FROM Person WHERE FName = 'Griffith' AND LName = 'Alston'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'ATM Buddy'),
    (SELECT PersonID FROM Person WHERE FName = 'Aurora' AND LName = 'Carrillo'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Tin')),
    ((SELECT PersonID FROM Person WHERE FName = 'Indigo' AND LName = 'Sanchez'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Word Precise'),
    (SELECT PersonID FROM Person WHERE FName = 'Aline' AND LName = 'Maddox'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Tin')),
    ((SELECT PersonID FROM Person WHERE FName = 'Emily' AND LName = 'Merrill'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Word Precise'),
    (SELECT PersonID FROM Person WHERE FName = 'Aurora' AND LName = 'Carrillo'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Tin')),
    ((SELECT PersonID FROM Person WHERE FName = 'Barclay' AND LName = 'Avila'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'StoryTeller'),
    (SELECT PersonID FROM Person WHERE FName = 'Angelica' AND LName = 'Conner'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Gold')),
    ((SELECT PersonID FROM Person WHERE FName = 'Fiona' AND LName = 'Lott'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Stellar Teller'),
    (SELECT PersonID FROM Person WHERE FName = 'Wyatt' AND LName = 'Figueroa'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Tin')),
    ((SELECT PersonID FROM Person WHERE FName = 'Nathaniel' AND LName = 'Cardenas'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Where Am I? GPS App'),
    (SELECT PersonID FROM Person WHERE FName = 'Carissa' AND LName = 'Ford'),
    NULL),
    ((SELECT PersonID FROM Person WHERE FName = 'Barclay' AND LName = 'Barry'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Vi'),
    (SELECT PersonID FROM Person WHERE FName = 'Michael' AND LName = 'Atkinson'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Bronze')),
    ((SELECT PersonID FROM Person WHERE FName = 'Sean' AND LName = 'Pugh'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'StoryTeller'),
    (SELECT PersonID FROM Person WHERE FName = 'Aline' AND LName = 'Maddox'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Gold')),
    ((SELECT PersonID FROM Person WHERE FName = 'Molly' AND LName = 'Padilla'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Vi'),
    (SELECT PersonID FROM Person WHERE FName = 'Palmer' AND LName = 'Albert'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Bronze')),
    ((SELECT PersonID FROM Person WHERE FName = 'Grace' AND LName = 'Edwards'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'StoryTeller'),
    (SELECT PersonID FROM Person WHERE FName = 'Tatiana' AND LName = 'Joseph'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Bronze')),
    ((SELECT PersonID FROM Person WHERE FName = 'Chantale' AND LName = 'Lopez'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'ATM Buddy'),
    (SELECT PersonID FROM Person WHERE FName = 'Emerald' AND LName = 'Wilkerson'),
    NULL),
    ((SELECT PersonID FROM Person WHERE FName = 'Alvin' AND LName = 'Greene'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Where Am I? GPS App'),
    (SELECT PersonID FROM Person WHERE FName = 'Aline' AND LName = 'Maddox'),
    NULL),
    ((SELECT PersonID FROM Person WHERE FName = 'Alea' AND LName = 'Page'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'mauris id'),
    (SELECT PersonID FROM Person WHERE FName = 'Carissa' AND LName = 'Ford'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Bronze')),
    ((SELECT PersonID FROM Person WHERE FName = 'Alvin' AND LName = 'Greene'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Vi'),
    (SELECT PersonID FROM Person WHERE FName = 'Giacomo' AND LName = 'Cantrell'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Gold')),
    ((SELECT PersonID FROM Person WHERE FName = 'Regan' AND LName = 'Greene'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'SpellerLite'),
    (SELECT PersonID FROM Person WHERE FName = 'Lisandra' AND LName = 'Reyes'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Silver')),
    ((SELECT PersonID FROM Person WHERE FName = 'Yetta' AND LName = 'Pratt'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'SpellerLite'),
    (SELECT PersonID FROM Person WHERE FName = 'Odette' AND LName = 'Espinoza'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Gold')),
    ((SELECT PersonID FROM Person WHERE FName = 'Logan' AND LName = 'Lynn'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Anodize'),
    (SELECT PersonID FROM Person WHERE FName = 'Emmanuel' AND LName = 'Pace'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Tin')),
    ((SELECT PersonID FROM Person WHERE FName = 'Sharon' AND LName = 'Eaton'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'SpellerLite'),
    (SELECT PersonID FROM Person WHERE FName = 'Tatiana' AND LName = 'Joseph'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Tin')),
    ((SELECT PersonID FROM Person WHERE FName = 'Alvin' AND LName = 'Greene'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'ATM Buddy'),
    (SELECT PersonID FROM Person WHERE FName = 'Quail' AND LName = 'Crawford'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Gold')),
    ((SELECT PersonID FROM Person WHERE FName = 'Kaye' AND LName = 'Burt'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Vivamus nibh'),
    (SELECT PersonID FROM Person WHERE FName = 'Emmanuel' AND LName = 'Pace'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Bronze')),
    ((SELECT PersonID FROM Person WHERE FName = 'Timothy' AND LName = 'Hatfield'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Where Am I? GPS App'),
    (SELECT PersonID FROM Person WHERE FName = 'Wyatt' AND LName = 'Figueroa'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Gold')),
    ((SELECT PersonID FROM Person WHERE FName = 'Burton' AND LName = 'Gardner'),
    (SELECT SoftwareID FROM SoftwareProduct WHERE Name = 'Vi'),
    (SELECT PersonID FROM Person WHERE FName = 'Tatiana' AND LName = 'Joseph'),
    (SELECT PlanID FROM ServicePlan WHERE ServiceLevel = 'Silver'));

INSERT INTO WorkingOn(SoftwareID, EmpID)
VALUES
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Anodize'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Zane' AND Person.LName = 'Horn')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Anodize'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Blythe' AND Person.LName = 'Joyner')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'ATM Buddy'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Sonia' AND Person.LName = 'Burnett')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'ATM Buddy'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Tatiana' AND Person.LName = 'Joseph')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'mauris id'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Martin' AND Person.LName = 'Mccarthy')),
    ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'mauris id'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Whitney' AND Person.LName = 'Jacobson')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'mauris id'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Odette' AND Person.LName = 'Espinoza')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'mauris id'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Giacomo' AND Person.LName = 'Cantrell')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Speller'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Blythe' AND Person.LName = 'Joyner')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Speller'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Ursula' AND Person.LName = 'Stewart')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'SpellerLite'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Tatiana' AND Person.LName = 'Joseph')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'SpellerLite'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Aurora' AND Person.LName = 'Carrillo')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'SpellerLite'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Zane' AND Person.LName = 'Horn')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'SpellerLite'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Giacomo' AND Person.LName = 'Cantrell')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Stellar Teller'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Giacomo' AND Person.LName = 'Cantrell')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Stellar Teller'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Tyrone' AND Person.LName = 'Wong')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Stellar Teller'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Oscar' AND Person.LName = 'Cox')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Stone Tablet'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Sonia' AND Person.LName = 'Burnett')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Stone Tablet'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Emmanuel' AND Person.LName = 'Pace')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Stone Tablet'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Giacomo' AND Person.LName = 'Cantrell')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'StoryTeller'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Blythe' AND Person.LName = 'Joyner')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'StoryTeller'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Ursula' AND Person.LName = 'Stewart')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'StoryTeller'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Wyatt' AND Person.LName = 'Figueroa')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Vi'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Tatiana' AND Person.LName = 'Joseph')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Vi'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Wyatt' AND Person.LName = 'Figueroa')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Vivamus nibh'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Angelica' AND Person.LName = 'Conner')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Vivamus nibh'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Fay' AND Person.LName = 'Mckee')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Vivamus nibh'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Whitney' AND Person.LName = 'Jacobson')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Vivamus nibh'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Zane' AND Person.LName = 'Horn')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Where Am I? GPS App'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Tatiana' AND Person.LName = 'Joseph')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Where Am I? GPS App'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Ursula' AND Person.LName = 'Stewart')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Where Am I? GPS App'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Giacomo' AND Person.LName = 'Cantrell')),
   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Word Precise'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Fay' AND Person.LName = 'Mckee')),
    ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Word Precise'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Tyrone' AND Person.LName = 'Wong'));

   ((SELECT SoftwareID FROM SoftwareProduct WHERE SoftwareProduct.Name = 'Word Precise'),
   (SELECT PersonID FROM Person WHERE Person.FName = 'Michael' AND Person.LName = 'Atkinson')),





   
