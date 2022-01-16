CREATE TABLE example
(
    id INT GENERATED ALWAYS AS IDENTITY,
    test_col TEXT,
    test_col_2 TEXT,
    PRIMARY KEY(id)
);