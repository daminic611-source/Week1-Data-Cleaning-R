# Week 1 Internship Task
# Data Cleaning and Preliminary Analysis with R
# Dataset: Titanic Dataset

# Load the dataset
titanic <- read.csv("data/train.csv")

# Display the first 6 rows
head(titanic)

# Check the structure of the dataset
str(titanic)

# Get summary statistics
summary(titanic)

# ---------------------------------------------
# STEP 2: CHECKING MISSING VALUES
# ---------------------------------------------

# Count missing values in each column
colSums(is.na(titanic))

# Calculate total missing values in the dataset
sum(is.na(titanic))

# Calculate percentage of missing values in each column
missing_percentage <- colSums(is.na(titanic)) / nrow(titanic) * 100

# Display missing value percentages
missing_percentage

# ---------------------------------------------
# STEP 3: HANDLING MISSING VALUES
# ---------------------------------------------

# Check missing values before cleaning
colSums(is.na(titanic))

# Fill missing Age values with the median age
titanic$Age[is.na(titanic$Age)] <- median(titanic$Age, na.rm = TRUE)

# Replace missing Embarked values with the most common value
titanic$Embarked[is.na(titanic$Embarked)] <- "S"

# Remove Cabin column because most values are missing
titanic$Cabin <- NULL

# Check missing values after cleaning
colSums(is.na(titanic))

# ---------------------------------------------
# STEP 4: CHECKING AND REMOVING DUPLICATES
# ---------------------------------------------

# Count duplicate rows
sum(duplicated(titanic))

# Remove duplicate rows
titanic <- titanic[!duplicated(titanic), ]

# Check the dataset dimensions after removing duplicates
dim(titanic)

# ---------------------------------------------
# STEP 5: OUTLIER DETECTION
# ---------------------------------------------

# Create a boxplot for Age
boxplot(titanic$Age,
        main = "Boxplot of Age",
        ylab = "Age")

# Create a boxplot for Fare
boxplot(titanic$Fare,
        main = "Boxplot of Fare",
        ylab = "Fare")

# Detect outliers in Fare using the IQR method

Q1 <- quantile(titanic$Fare, 0.25)
Q3 <- quantile(titanic$Fare, 0.75)

IQR_value <- IQR(titanic$Fare)

lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value

# Find outliers
fare_outliers <- titanic$Fare[
  titanic$Fare < lower_bound |
    titanic$Fare > upper_bound
]

# Count the number of outliers
length(fare_outliers)

# ---------------------------------------------
# STEP 6: OUTLIER TREATMENT
# ---------------------------------------------

# Cap Fare values above the upper bound
titanic$Fare[titanic$Fare > upper_bound] <- upper_bound

# Check the Fare boxplot after treatment
boxplot(titanic$Fare,
        main = "Fare After Outlier Treatment",
        ylab = "Fare")

# Check for remaining outliers
fare_outliers_after <- titanic$Fare[
  titanic$Fare < lower_bound |
    titanic$Fare > upper_bound
]

length(fare_outliers_after)

# ---------------------------------------------
# STEP 7: NORMALIZATION
# ---------------------------------------------

# Normalize Age using Min-Max normalization
titanic$Age_Normalized <- (titanic$Age - min(titanic$Age)) /
  (max(titanic$Age) - min(titanic$Age))

# Normalize Fare using Min-Max normalization
titanic$Fare_Normalized <- (titanic$Fare - min(titanic$Fare)) /
  (max(titanic$Fare) - min(titanic$Fare))

# Display the first few normalized values
head(titanic[, c("Age", "Age_Normalized",
                 "Fare", "Fare_Normalized")])

# ---------------------------------------------
# STEP 8: ENCODING CATEGORICAL VARIABLES
# ---------------------------------------------

# Encode Sex
# male = 0, female = 1
titanic$Sex_Encoded <- ifelse(titanic$Sex == "male", 0, 1)

# Encode Embarked
# C = 1, Q = 2, S = 3
titanic$Embarked_Encoded <- ifelse(titanic$Embarked == "C", 1,
                                   ifelse(titanic$Embarked == "Q", 2, 3))

# Display original and encoded values
head(titanic[, c("Sex", "Sex_Encoded",
                 "Embarked", "Embarked_Encoded")])

# ---------------------------------------------
# STEP 9: EXPLORATORY DATA ANALYSIS
# ---------------------------------------------

# Display summary statistics of the cleaned dataset
summary(titanic)

# Structure of the cleaned dataset
str(titanic)

# Mean age of passengers
mean(titanic$Age)

# Median age of passengers
median(titanic$Age)

# Mean fare
mean(titanic$Fare)

# Standard deviation of age
sd(titanic$Age)

# Standard deviation of fare
sd(titanic$Fare)

# ---------------------------------------------
# STEP 10: SURVIVAL ANALYSIS
# ---------------------------------------------

# Count survived and not survived passengers
table(titanic$Survived)

# Calculate survival percentage
prop.table(table(titanic$Survived)) * 100

# ---------------------------------------------
# STEP 11: SURVIVAL VISUALIZATION
# ---------------------------------------------

# Create a bar chart for survival distribution
barplot(table(titanic$Survived),
        main = "Survival Distribution",
        xlab = "Survival Status",
        ylab = "Number of Passengers",
        names.arg = c("Not Survived", "Survived"))

# ---------------------------------------------
# STEP 12: GENDER-WISE SURVIVAL ANALYSIS
# ---------------------------------------------

# Create a table of survival based on gender
gender_survival <- table(titanic$Sex, titanic$Survived)

# Display the table
gender_survival

# Calculate survival percentage by gender
prop.table(gender_survival, margin = 1) * 100

barplot(gender_survival,
        beside = TRUE,
        main = "Gender-wise Survival",
        xlab = "Gender",
        ylab = "Number of Passengers",
        legend.text = c("Not Survived", "Survived"))

# ---------------------------------------------
# STEP 13: PASSENGER CLASS-WISE SURVIVAL ANALYSIS
# ---------------------------------------------

# Create a table of survival based on passenger class
class_survival <- table(titanic$Pclass, titanic$Survived)

# Display the table
class_survival

# Calculate survival percentage by passenger class
prop.table(class_survival, margin = 1) * 100

barplot(class_survival,
        beside = TRUE,
        main = "Passenger Class-wise Survival",
        xlab = "Passenger Class",
        ylab = "Number of Passengers",
        legend.text = c("Not Survived", "Survived"))

# ---------------------------------------------
# STEP 14: CORRELATION ANALYSIS
# ---------------------------------------------

# Select numerical variables for correlation
numeric_data <- titanic[, c(
  "Survived",
  "Pclass",
  "Age_Normalized",
  "SibSp",
  "Parch",
  "Fare_Normalized",
  "Sex_Encoded",
  "Embarked_Encoded"
)]

# Create correlation matrix
correlation_matrix <- cor(numeric_data)

# Display correlation matrix
correlation_matrix

# ---------------------------------------------
# STEP 15: CORRELATION VISUALIZATION
# ---------------------------------------------

library(corrplot)

corrplot(correlation_matrix,
         method = "color",
         type = "upper",
         tl.col = "black",
         tl.srt = 45,
         title = "Correlation Matrix of Titanic Dataset")

# ---------------------------------------------
# STEP 16: SAVE CLEANED DATASET
# ---------------------------------------------

write.csv(
  titanic,
  "data/titanic_cleaned.csv",
  row.names = FALSE
)

# Check that the cleaned dataset was saved
head(titanic)

# ---------------------------------------------
# STEP 17: SAVE VISUALIZATIONS
# ---------------------------------------------

# 1. Age Boxplot
png("images/age_boxplot.png", width = 800, height = 600)

boxplot(titanic$Age,
        main = "Boxplot of Age",
        ylab = "Age")

dev.off()


# 2. Fare Boxplot After Outlier Treatment
png("images/fare_boxplot_cleaned.png", width = 800, height = 600)

boxplot(titanic$Fare,
        main = "Fare After Outlier Treatment",
        ylab = "Fare")

dev.off()


# 3. Survival Distribution
png("images/survival_distribution.png", width = 800, height = 600)

barplot(table(titanic$Survived),
        main = "Survival Distribution",
        xlab = "Survival Status",
        ylab = "Number of Passengers",
        names.arg = c("Not Survived", "Survived"))

dev.off()


# 4. Gender-wise Survival
png("images/gender_survival.png", width = 800, height = 600)

barplot(gender_survival,
        beside = TRUE,
        main = "Gender-wise Survival",
        xlab = "Gender",
        ylab = "Number of Passengers",
        legend.text = c("Not Survived", "Survived"))

dev.off()


# 5. Passenger Class-wise Survival
png("images/class_survival.png", width = 800, height = 600)

barplot(class_survival,
        beside = TRUE,
        main = "Passenger Class-wise Survival",
        xlab = "Passenger Class",
        ylab = "Number of Passengers",
        legend.text = c("Not Survived", "Survived"))

dev.off()


# 6. Correlation Matrix
png("images/correlation_matrix.png", width = 1000, height = 800)

corrplot(correlation_matrix,
         method = "color",
         type = "upper",
         tl.col = "black",
         tl.srt = 45,
         title = "Correlation Matrix of Titanic Dataset")

dev.off()