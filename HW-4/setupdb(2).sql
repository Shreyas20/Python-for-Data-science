DROP DATABASE IF EXISTS hw4;
CREATE DATABASE IF NOT EXISTS hw4;
USE hw4;
CREATE TABLE IF NOT EXISTS CRIME_TYPES(
  Primary_Type VARCHAR(64),
  Primary_Type_ID SMALLINT,
  PRIMARY KEY(Primary_Type_ID)
  );
LOAD DATA LOCAL INFILE '/home/shreyas/Downloads/HW-4/primary_type_id.csv' INTO TABLE  CRIME_TYPES FIELDS TERMINATED BY ',' ESCAPED BY '"' IGNORE 1 LINES;

CREATE TABLE IF NOT EXISTS CRIME_INCIDENTS(
Crime_ID INT,
Case_Number CHAR(8),
Date VARCHAR(20),
Arrest CHAR(7),
Domestic CHAR(7),
Beat MEDIUMINT,
District SMALLINT,
Ward SMALLINT,
Community_Area SMALLINT,
FBI_Code CHAR(10),
PRIMARY KEY(CRIME_ID)
); 
LOAD DATA LOCAL INFILE '/home/shreyas/Downloads/HW-4/chicago_crime_data_1.csv' INTO TABLE  CRIME_INCIDENTS FIELDS TERMINATED BY ',' ESCAPED BY '"' IGNORE 1 LINES;
UPDATE CRIME_INCIDENTS SET Date = STR_TO_DATE(Date, '%c/%e/%Y %H:%i');
ALTER TABLE CRIME_INCIDENTS MODIFY Date datetime;

CREATE TABLE IF NOT EXISTS CRIME_DETAILS(
Crime_ID INT,
Case_Number CHAR(8),
Block VARCHAR(128),
IUCR MEDIUMINT,
Primary_Type_ID SMALLINT,
Description VARCHAR(128),
Location_Description VARCHAR(64),
X_Coordinate FLOAT,
Y_Coordinate FLOAT,
Year SMALLINT,
Updated_On VARCHAR(20),
Location CHAR(64),
FOREIGN KEY (Crime_ID)  REFERENCES CRIME_INCIDENTS (Crime_ID),
FOREIGN KEY (Primary_Type_ID) REFERENCES CRIME_TYPES (Primary_Type_ID)
);
LOAD DATA LOCAL INFILE '/home/shreyas/Downloads/HW-4/chicago_crime_data_2.csv' INTO TABLE  CRIME_DETAILS FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
UPDATE CRIME_DETAILS SET Updated_On = STR_TO_DATE(Updated_On, '%c/%e/%Y %H:%i');
ALTER TABLE CRIME_DETAILS MODIFY Updated_On datetime;
