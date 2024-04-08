SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions=100000;
SET hive.exec.max.dynamic.partitions.pernode=100000;
set mapreduce.map.memory.mb=4096;
set mapreduce.reduce.memory.mb=4096;
set mapreduce.map.java.opts=-Xmx4g;
set mapreduce.reduce.java.opts=-Xmx4g;

-- Create staging table
CREATE TABLE IF NOT EXISTS covid_db.covid_staging(
    Country                     STRING,
    Total_Cases                 DOUBLE,
    New_Cases                   DOUBLE,
    Total_Deaths                DOUBLE,
    New_Deaths                  DOUBLE,
    Total_Recovered             DOUBLE,
    Active_Cases                DOUBLE,
    Serious                     DOUBLE,
    Tot_Cases                   DOUBLE,
    Deaths                      DOUBLE,
    Total_Tests                 DOUBLE,
    Tests                       DOUBLE,
    CASES_per_Test              DOUBLE,
    Death_in_Closed_Cases      STRING,
    Rank_by_Testing_rate       DOUBLE,
    Rank_by_Death_rate         DOUBLE,
    Rank_by_Cases_rate         DOUBLE,
    Rank_by_Death_of_Closed_Cases DOUBLE
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION '/user/cloudera/ds/COVID_HDFS_LZ';

CREATE EXTERNAL TABLE IF NOT EXISTS covid_db.covid_ds_partitioned(
    Country                     STRING,
    Total_Cases                 DOUBLE,
    New_Cases                   DOUBLE,
    Total_Deaths                DOUBLE,
    New_Deaths                  DOUBLE,
    Total_Recovered             DOUBLE,
    Active_Cases                DOUBLE,
    Serious                     DOUBLE,
    Tot_Cases                   DOUBLE,
    Deaths                      DOUBLE,
    Total_Tests                 DOUBLE,
    Tests                       DOUBLE,
    CASES_per_Test              DOUBLE,
    Death_in_Closed_Cases      STRING,
    Rank_by_Testing_rate       DOUBLE,
    Rank_by_Death_rate         DOUBLE,
    Rank_by_Cases_rate         DOUBLE,
    Rank_by_Death_of_Closed_Cases DOUBLE
)
PARTITIONED BY (COUNTRY_NAME STRING)
LOCATION '/user/cloudera/ds/COVID_HDFS_PARTITIONED';


FROM covid_db.covid_staging 
INSERT INTO TABLE covid_db.covid_ds_partitioned PARTITION(COUNTRY_NAME)
SELECT *, Country AS COUNTRY_NAME; 


drop table if exists covid_db.covid_final_output;

CREATE EXTERNAL TABLE covid_db.covid_final_output 
(
 Country 			                STRING,
 Total_Cases   		                DOUBLE,
 New_Cases    		                DOUBLE,
 Total_Deaths                       DOUBLE,
 New_Deaths                         DOUBLE,
 Total_Recovered                    DOUBLE,
 Active_Cases                       DOUBLE,
 Serious		                  	DOUBLE,
 Tot_Cases                   		DOUBLE,
 Deaths                      		DOUBLE,
 Total_Tests                   		DOUBLE,
 Tests			                 	DOUBLE,
 CASES_per_Test                     DOUBLE,
 Death_in_Closed_Cases     	        STRING,
 Rank_by_Testing_rate 		        DOUBLE,
 Rank_by_Death_rate    		        DOUBLE,
 Rank_by_Cases_rate    		        DOUBLE,
 Rank_by_Death_of_Closed_Cases   	DOUBLE,
 TOP_DEATH 			                DOUBLE,
 TOP_TEST 			                DOUBLE
)

PARTITIONED BY (COUNTRY_NAME STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION '/user/cloudera/ds/COVID_FINAL_OUTPUT';

INSERT OVERWRITE TABLE covid_db.covid_final_output PARTITION(COUNTRY_NAME) SELECT Country, Total_Cases, New_Cases,Total_Deaths,New_Deaths,Total_Recovered,Active_Cases,Serious,Tot_Cases,Deaths,Total_Tests,Tests,CASES_per_Test,Death_in_Closed_Cases,Rank_by_Testing_rate,Rank_by_Death_rate,Rank_by_Cases_rate,Rank_by_Death_of_Closed_Cases,RANK() OVER (ORDER BY Total_Deaths DESC ),RANK() OVER (ORDER BY Total_Tests DESC ),Country FROM covid_db.covid_ds_partitioned;

