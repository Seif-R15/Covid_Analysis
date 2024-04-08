#Define variables
local_dataset_dir="/home/cloudera/Desktop/data"
hdfs_target_dir="/user/cloudera/ds/COVID_HDFS_LZ"
hdfs_target_dir="/user/cloudera/ds/COVID_HDFS_PARTITIONED"

# Check if the target directory exists in HDFS
hdfs dfs -test -d $hdfs_target_dir
if [ $? -ne 0 ]; then
    # Create the target directory in HDFS
    hdfs dfs -mkdir -p $hdfs_target_dir
fi

# Copy the dataset from local directory to HDFS
hdfs dfs -put $local_dataset_dir/* $hdfs_target_dir

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "Dataset copied successfully to HDFS directory: $hdfs_target_dir"
else
    echo "Error: Failed to copy dataset to HDFS directory."
    exit 1
fi
