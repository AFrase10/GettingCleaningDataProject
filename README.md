# Getting and Cleaning Data Course Project

This data science course is available through Coursera. The objectives of this course are to learn how to acquire data, read it into a statistical software program, and manipulate the dataset so it is easy to view and make sense of. 

The requirements of this project are to:

- The submitted data set is tidy.
- The Github repo contains the required scripts.
- GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries   calculated, along with units, and any other relevant information.
- The README that explains the analysis files is clear and understandable.
- The work submitted for this project is the work of the student who submitted it.

The dataset being used is: Human Activity Recognition Using Smartphones

## Content of Repository

### run_analysis.R
This is an R script for generating a tidy data text file. The requirements for tidy data as provided by the course are:
- Each variable you measure should be in one column.
- Each different observation of that variable should be in a different row.
- There should be one table for each “kind” of variable.
- If you have multiple tables, they should include a column in the table that allows them to be linked

### CodeBook.md 
Describes the variables, the data, and any transformations or work that was performed to clean up the data.

## CleanedData.txt
A text file containing the tidied dataset generated in run_analysis.R
- All variables are in one column.
- Each observation is displayed in its own row.
- The table makes sense of variables relations and were assembled together.

