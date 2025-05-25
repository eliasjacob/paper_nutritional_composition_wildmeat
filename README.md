# Comprehensive Nutritional Composition of Wild Meat: Data Preparation and Imputation

This project accompanies the research paper "Comprehensive Nutritional Composition of Wild Meat: A Systematic Review Using Data Imputation with Artificial Intelligence." It includes the Python scripts (Jupyter Notebooks) used for preparing the raw nutritional data and performing data imputation to address missing values.

The primary goal is to create a robust and comprehensive dataset of wild meat nutritional composition, leveraging advanced data imputation techniques to fill data gaps ethically and effectively. This dataset is important for informed dietary assessments, food security analysis, and policy decisions, particularly for Indigenous Peoples and Local Communities (IPLC) who rely on these resources.

## Project Overview

The project is divided into two main stages, each represented by a Jupyter Notebook:

1.  **Data Preparation (`01-data_preparation.ipynb`):**
    *   Loads the initial dataset (`data/input_data.csv`).
    *   Cleans and standardizes column names.
    *   Removes irrelevant columns (e.g., dispersion measures, unit specifications if data is standardized, other metadata).
    *   Standardizes categorical variables such as anatomical part (`parte`) and species (`taxon`) using predefined mappings.
    *   Derives new features like `genus` from the taxon information.
    *   Converts data types to appropriate formats (e.g., numeric, category).
    *   Performs initial handling of missing values (e.g., removing rows where all key nutrient values are null).
    *   Corrects data entry issues, such as inconsistent decimal separators.
    *   Outputs a processed dataset (`data/input_data_processed.csv`) ready for imputation.

2.  **Data Imputation (`02_impute_data.ipynb`):**
    *   Loads the processed dataset from the previous stage.
    *   Prepares data for imputation by one-hot encoding categorical features.
    *   Implements a cross-validation framework (Leave-One-Out CV) to evaluate various imputation algorithms (e.g., KNNImputer, MatrixFactorization, SoftImpute, IterativeSVD, IterativeImputer from scikit-learn) for each nutrient column.
    *   Selects the best-performing imputer for each nutrient based on metrics like Symmetric Mean Absolute Percentage Error (SMAPE) and Root Mean Squared Error (RMSE).
    *   Applies the selected best imputer to fill missing values in the entire dataset for each respective nutrient.
    *   Ensures imputed nutrient values are non-negative.
    *   Generates and saves the fully imputed dataset, imputation performance metrics, summary statistics, and visualizations (boxplots).

## Project Structure

```
.
├── 01-data_preparation.ipynb     # Notebook for data cleaning and preparation
├── 02_impute_data.ipynb        # Notebook for data imputation and evaluation
├── data/
│   ├── input_data.csv            # Raw input data (needs to be provided)
│   ├── input_data_processed.csv  # Output of 01-data_preparation.ipynb
│   ├── imputed_data_onehot.csv   # Fully imputed dataset (one-hot encoded)
│   ├── best_imputation_metrics.csv # Metrics for the best imputer per nutrient
│   ├── imputed_data_highlighted.xlsx # User-friendly imputed data with highlights
│   ├── summary_statistics_overall_imputed.xlsx
│   ├── summary_statistics_per_part_imputed.xlsx
│   ├── summary_statistics_per_class_imputed.xlsx
│   ├── summary_statistics_per_class_and_part_imputed.xlsx
│   └── boxplots_imputed/         # Directory for generated boxplot HTML files
│       └── ... (e.g., boxplot_fe.html)
├── helpers.py                    # Helper functions (e.g., symmetric_mape)
├── pyproject.toml                # Poetry project file
├── poetry.lock                   # Poetry lock file
└── README.md                     # This file
```

## Prerequisites

*   Python 3.10+ (developed with 3.12)
*   [Poetry](https://python-poetry.org/docs/#installation) for package management.
*   Jupyter Notebook or JupyterLab (can be installed via Poetry as a development dependency).

The required Python packages are listed in the `pyproject.toml` file.

## Setup

1.  **Clone the repository (if applicable):**
    ```bash
    git clone https://github.com/eliasjacob/paper_nutritional_composition_wildmeat.git
    cd paper_nutritional_composition_wildmeat
    ```

2.  **Install Poetry (if not already installed):**
    Follow the instructions on the [official Poetry website](https://python-poetry.org/docs/#installation).

3.  **Install project dependencies using Poetry:**
    This command will create a virtual environment (if one doesn't exist for the project) and install all dependencies specified in `pyproject.toml` and `poetry.lock`.
    ```bash
    poetry install
    ```

4.  **Activate the Poetry virtual environment:**
    To run scripts or Jupyter notebooks within the environment managed by Poetry:
    ```bash
    poetry shell
    ```
    Alternatively, you can run commands directly using `poetry run <command>`, e.g., `poetry run jupyter lab`.

5.  **Place input data:**
    Ensure the raw data file `input_data.csv` is placed in the `data/` directory.

## Usage

1.  **Activate the Poetry environment (if not already active):**
    ```bash
    poetry shell
    ```

2.  **Launch JupyterLab or Jupyter Notebook:**
    ```bash
    jupyter lab
    # or
    jupyter notebook
    ```

3.  **Run the Data Preparation Notebook:**
    Open and run `01-data_preparation.ipynb`. This will clean the raw data and produce `data/input_data_processed.csv`.

4.  **Run the Data Imputation Notebook:**
    Open and run `02_impute_data.ipynb`. This notebook will:
    *   Load `data/input_data_processed.csv`.
    *   Perform cross-validation to select the best imputation methods.
    *   Impute the missing values in the dataset.
    *   Save the imputed data, metrics, summary statistics, and visualizations to the `data/` directory and its subdirectories.

    *Note: The cross-validation and imputation steps, especially with `ProcessPoolExecutor`, can be computationally intensive and may take a significant amount of time depending on the dataset size and the number of imputers being evaluated.*

## Outputs

The primary outputs generated by the scripts and stored in the `data/` directory include:

*   `input_data_processed.csv`: Cleaned and preprocessed data, ready for imputation.
*   `imputed_data_onehot.csv`: The final dataset with missing values imputed, with categorical features one-hot encoded.
*   `best_imputation_metrics.csv`: A summary of the performance metrics for the best imputer chosen for each nutrient column.
*   `final_imputation_metrics_summary.xlsx`: A cleaned version of the imputation metrics suitable for reporting.
*   `imputed_data_highlighted.xlsx`: A user-friendly Excel version of the imputed dataset where imputed cells are highlighted.
*   `summary_statistics_*.xlsx`: Various Excel files containing descriptive statistics of the imputed nutrient data (overall, per anatomical part, per taxonomic class, etc.).
*   `data/boxplots_imputed/`: A directory containing HTML files of boxplots visualizing the distribution of each imputed nutrient.

## Helper Functions

The `helpers.py` file contains utility functions used in the notebooks, such as the `symmetric_mape` function for calculating the Symmetric Mean Absolute Percentage Error.

## Contributing

Contributions to this project are welcome. Please feel free to fork the repository, make changes, and submit a pull request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.