import pandas as pd

pd.set_option("display.max_columns", 500)


def symmetric_mape(y_true, y_pred):
    """
    Calculate SMAPE between two lists of values.

    Args:
        y_true (list): list of true values
        y_pred (list): list of predicted values

    Returns:
        float: SMAPE value
    """

    if len(y_true) != len(y_pred):
        raise ValueError("Input lists must have the same length.")

    n = len(y_true)
    smape_sum = 0

    for i in range(n):
        numerator = abs(y_true[i] - y_pred[i])
        denominator = (abs(y_true[i]) + abs(y_pred[i])) / 2
        smape_sum += numerator / denominator

    smape_value = (smape_sum / n) * 100
    return smape_value
