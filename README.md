# Week 1 – Data Cleaning and Preliminary Analysis with R

## 📌 Project Overview

This project was completed as part of a Week 1 internship task focused on **data cleaning, preprocessing, and preliminary exploratory data analysis using R**.

The **Titanic dataset** was selected because it contains both numerical and categorical variables along with missing values and potential outliers.

The analysis demonstrates the complete data preprocessing workflow, from initial dataset inspection to cleaning, transformation, visualization, and preliminary analysis.

---

## 🎯 Objectives

The main objectives of this project are:

* Inspect and understand the dataset structure.
* Identify and handle missing values.
* Check and remove duplicate records.
* Detect and treat outliers.
* Normalize numerical variables.
* Encode categorical variables.
* Generate descriptive statistics.
* Perform exploratory data analysis.
* Analyze correlations between numerical variables.
* Create meaningful visualizations.

---

## 📊 Dataset

The project uses the **Titanic training dataset** containing information about 891 passengers.

Important variables include:

| Variable   | Description                       |
| ---------- | --------------------------------- |
| `Survived` | Survival status of the passenger  |
| `Pclass`   | Passenger class                   |
| `Sex`      | Gender                            |
| `Age`      | Age of passenger                  |
| `SibSp`    | Number of siblings/spouses aboard |
| `Parch`    | Number of parents/children aboard |
| `Fare`     | Passenger fare                    |
| `Embarked` | Port of embarkation               |

---

## 🧹 Data Cleaning

The following preprocessing techniques were performed:

### Missing Values

* Missing `Age` values were replaced using the median.
* Missing `Embarked` values were replaced with the most common category.
* The `Cabin` variable was removed because of a high number of missing values.

### Duplicate Records

Duplicate rows were checked and no duplicate records were found.

### Outlier Detection

The **Interquartile Range (IQR)** method was used to identify potential outliers in the `Fare` variable.

A total of **116 potential Fare outliers** were identified.

Instead of deleting these observations, extreme Fare values were capped at the calculated upper IQR boundary.

### Normalization

Min-Max normalization was applied to:

* `Age`
* `Fare`

### Categorical Encoding

The following variables were encoded:

* `Sex`: Male = 0, Female = 1
* `Embarked`: C = 1, Q = 2, S = 3

---

## 📈 Exploratory Data Analysis

The project includes:

* Dataset summary statistics
* Survival distribution
* Gender-wise survival analysis
* Passenger class-wise survival analysis
* Age and Fare boxplots
* Correlation matrix

The analysis showed clear differences in survival patterns based on **gender and passenger class**.

---

## 📁 Project Structure

```text
Week1-Data-Cleaning-R/
│
├── data/
│   ├── train.csv
│   └── titanic_cleaned.csv
│
├── code/
│   └── week1_analysis.R
│
├── images/
│   ├── age_boxplot.png
│   ├── fare_boxplot_cleaned.png
│   ├── survival_distribution.png
│   ├── gender_survival.png
│   ├── class_survival.png
│   └── correlation_matrix.png
│
├── Week1_Report.docx
└── README.md
```

---

## 🛠️ Tools Used

* R
* RStudio
* R `corrplot` package
* Microsoft Word
* GitHub

---

## 📌 Conclusion

This project demonstrates the practical application of data cleaning and preliminary data analysis techniques using R. The Titanic dataset was successfully cleaned, transformed, and analyzed through statistical summaries and visualizations.

The processed dataset can be used as a foundation for further statistical analysis or machine learning tasks.

---

## 👩‍💻 Author

**[Your Name]**

**Week 1 Internship Task – Data Cleaning and Preliminary Analysis with R**

