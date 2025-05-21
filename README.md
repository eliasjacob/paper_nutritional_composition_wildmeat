# Proximate Composition of Wild Meats Present in Traditional Food Systems of the Brazilian Amazon

Link to the paper: [TBD]

## Overview
This project analyzes and imputes missing values in a dataset of wild meat nutritional composition using Python and Jupyter notebooks. It comprises two main workflows:

1. **Data Preparation** (`01_data_preparation.ipynb`): Cleans and organizes the raw dataset, selects relevant nutritional features, handles missing values for preliminary analysis, and extracts taxonomic information (genus and species).
2. **Data Imputation** (`02_data_imputation.ipynb`): Implements and benchmarks multiple imputation methods (e.g., KNN, Iterative Imputer, SoftImpute) in both single-target and multi-variable settings, computes evaluation metrics, and exports imputed datasets and metrics for further analysis.

## Repository Structure
```
├── 01_data_preparation.ipynb      # Notebook to clean and prepare raw data
├── 02_data_imputation.ipynb       # Notebook to perform and benchmark imputations
├── helpers.py                     # Utility functions (e.g., SMAPE metric)
├── data/                          # Raw and processed data files
│   ├── Thales_Planilha_...csv     # Original raw CSV
│   ├── 01_cleaned.parquet         # Cleaned dataset
│   ├── 01_order_to_impute.json    # Missing-value order mapping
│   ├── imputed_values.csv         # Final imputed dataset
│   └── metrics_results.csv        # Imputation performance metrics
├── pyproject.toml                 # Project metadata and dependencies
├── poetry.lock                    # Locked dependencies
└── README.md                      # Project documentation
```

## Setup and Installation
1. **Clone the repository**
   ```bash
   git clone <repo-url>
   cd paper_nutritional_composition_wildmeat
   ```
2. **Install dependencies** (using Poetry)
   ```bash
   poetry install
   ```
3. **Activate the virtual environment**
   ```bash
   poetry shell
   ```

## Usage
1. **Data Preparation**
   - Open `01_data_preparation.ipynb` in Jupyter or VSCode Notebook.
   - Run all cells to load raw data, clean columns, extract taxonomic features, and export:
     - `data/01_cleaned.parquet`
     - `data/01_order_to_impute.json`
2. **Data Imputation**
   - Open `02_data_imputation.ipynb`.
   - Run all cells to:
     - Load cleaned data and imputation order
     - Benchmark multiple imputation algorithms in parallel
     - Compute performance metrics (RMSE, MAE, SMAPE, R²)
     - Export:
       - `data/metrics_results.csv`
       - `data/imputed_values.csv`

## Notebooks Detail
### 01_data_preparation.ipynb
- **Libraries:** pandas
- **Steps:**
  1. Load raw CSV data
  2. Preview and drop rows with critical missing values (e.g., Mg)
  3. Select relevant nutritional columns
  4. Clean and standardize scientific names
  5. Extract `Gênero` and `Espécie` columns
  6. Identify columns with missing values and sort by frequency
  7. Export cleaned dataset and imputation order

### 02_data_imputation.ipynb
- **Libraries:** pandas, numpy, fancyimpute, scikit-learn, tqdm, concurrent.futures
- **Sections:**
  1. Imports and settings
  2. Configuration of file paths and imputer lists
  3. Data loading and one-hot encoding
  4. Utility functions for cross-validation imputation
  5. Parallel execution across CPU cores
  6. Aggregation of metrics and export of results
  7. Final data assembly and CSV output

## Results
- **Imputation Metrics:** `data/metrics_results.csv` contains per-column performance metrics for each algorithm.
- **Imputed Dataset:** `data/imputed_values.csv` holds the final completed dataset for downstream analysis.

## Contributing
Contributions are welcome! Please open issues or submit pull requests to improve data processing, add new imputation methods, or enhance documentation.

## License
This project is licensed under the [MIT License](LICENSE).
