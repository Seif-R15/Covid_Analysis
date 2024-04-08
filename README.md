![image](https://github.com/Seif-R15/Covid_Analysis/assets/90916570/e5149293-ca0c-4906-917e-087dbe067b75)# Covid_Analysis
Covid_Analysis from Ingestion using HDFS Hive hql script and Oozie workflow to Visualization using Power BI

# Steps

- Transfer dataset from local machine to the virtual machine using appropriate tool as WIN SCP
- Load dataset from virtual machine document to Cloudera HDFS by creating a shell script load_dataset_to_hdfs.sh 
- EXTRACT: Extract data from the covid-19.csv file to created tables.
- LOAD: Load the data extracted to make the Staging, Partitioning, Final_Output stages.
![image](https://github.com/Seif-R15/Covid_Analysis/assets/90916570/bdb6a44c-0a07-4bfd-9401-1eff8ea2c0df)
- TRANSFORM: Transform the data using HQL and hive commands to create tables for each stage with their characteristics.
![image](https://github.com/Seif-R15/Covid_Analysis/assets/90916570/4cb10226-8264-4923-b863-6ddd9995b79d)
- AUTOMATE: Automate these ETL process to be used for any desired csv file.
![image](https://github.com/Seif-R15/Covid_Analysis/assets/90916570/afb9c770-5710-4b00-ba35-66a925b03c04)



