#############################################################################
# File name:  Makefile
# Author:     chadd williams
# Date:       Jan 26, 2024
# Class:      CS445
# Assignment: SoftwareDB
# Purpose:    build PDF files
#############################################################################


all:  # do nothing. You must specify a target

ENSCRIPT_FLAGS=-C -T 2 -p - -M Letter -Esql --color -fCourier8
ENSCRIPT_FLAGS_PHP=-C -T 2 -p - -M Letter --color -fCourier8

insertPDFs: 
	enscript ${ENSCRIPT_FLAGS} Create.sql  | ps2pdf - Create.sql.pdf
	enscript ${ENSCRIPT_FLAGS} Stored.sql  | ps2pdf - Stored.sql.pdf

queryPDFs: 
	enscript ${ENSCRIPT_FLAGS} Queries.sql  | ps2pdf - Queries.sql.pdf
	enscript ${ENSCRIPT_FLAGS} Stored.sql  | ps2pdf - Stored.sql.pdf

backupDB:
	mysqldump -u root -p -e --create-options --databases SoftwareDB > Full.sql

PHP:
	head -v -n -0 php/insert*.php | enscript ${ENSCRIPT_FLAGS_PHP} | ps2pdf - Inserts.php.pdf

printWebPHP:
	head -v -n -0 \
	../html/userAuth.php \ ../html/logoutUser.php \
	../html/index.html \
	../html/redirectNonAuthenticatedUser.php \
	../html/show*.php ../html/query*.php \
	 | enscript ${ENSCRIPT_FLAGS_PHP} | ps2pdf - WebPage.php.pdf

printMongo:
	head -v -n -0 \
	../html/getReviews.php ../html/searchReviews.php \
	../html/avgStars.php \
	../html/generateRandomReviewAgreeDisagree.php \
	../html/add*.php \
	 | enscript ${ENSCRIPT_FLAGS_PHP} | ps2pdf - Mongo.php.pdf

#to add insert php file, must separate with a "; \" so its all on "one" line
INSERT:
	mariadb --protocol=tcp -uroot -pmariadb -h localhost < Create.sql
	mariadb --protocol=tcp -uroot -pmariadb -h localhost < Stored.sql
	cd php; \
	php ./insertAuthors.php BookstoreDB_Data/CS445_BookStoreData_Authors.csv; \
	php ./insertBookEditions.php BookstoreDB_Data/CS445_BookStoreData_BookEditions.csv; \
	php ./insertWrote.php BookstoreDB_Data/CS445_BookStoreData_Wrote.csv; \
	php ./insertDiscounts.php BookstoreDB_Data/CS445_BookStoreData_Discounts.csv; \
	php ./insertShipping.php BookstoreDB_Data/CS445_BookStoreData_Shipping.csv; \
	php ./insertUsers.php BookstoreDB_Data/CS445_BookStoreData_Users.csv; \
	php ./insertWishLists.php BookstoreDB_Data/CS445_BookStoreData_WishLists.csv; \
	php ./insertSales.php BookstoreDB_Data/CS445_BookStoreData_Sales.csv; \
	php ./insertInCarts.php BookstoreDB_Data/CS445_BookStoreData_Carts.csv; \
	cd ../../html; \
	php ./addReviewsFromFileCLI.php \
	../BookstoreDB/php/BookstoreDB_Data/CS445_BookStoreData_BookReviews.csv; \
	php ./generateRandomReviewAgreeDisagree.php; \
	php ./addAgreeDisagreeToReview.php \
	./randomReviewAgreeDisagree.csv;

clean:
	rm *.pdf
