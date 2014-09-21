Getting-and-cleaning-data - course project
=========================

read test and train data from local file

1. combined test and training by first binding the test and training sets respectively by columns and then rbinding the 2 sets together

2. extracted only columns measuring mean or std related data using grep on "mean and "std" and then indexing to select the relevant columns

3. assigned descriptive activity levels to the different activities using the "factor" function

4. named variables using the feature names given in the feature file (using same index i used for selecting mean and std related variables so features match the variables.)

5. created tidy dataset by melting the data with "subject" and "Activity" as factors and then using dcast
