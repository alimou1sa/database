
select * from Accounts;

BEGIN TRANSACTION;

	BEGIN TRY
		-- Subtract $100 from Account 1
		UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 1;

		-- Add $100 to Account 2
		UPDATE Accounts SET Balance = Balance + 100 WHERE AccountID = 2;

		-- Log the transaction
		INSERT INTO Transactions (FromAccount, ToAccount, Amount, Date) VALUES (1, 2, 100, GETDATE());

		-- Commit the transaction
		COMMIT;

	END TRY
	BEGIN CATCH
		-- Rollback in case of error
		ROLLBACK;
		-- Error handling code here (e.g., logging the error)
	END CATCH;


	select * from Accounts;
	
use C21_DB1;

--Using CASE in ORDER BY (Custom Sorting)
SELECT * 
FROM Sales
ORDER BY 
    CASE 
        WHEN SaleAmount > 150 THEN 1
        ELSE 2
    END;


--Custom sorting of employees based on salary.
-- 10 x 10 Matrix Multiplication Table

DECLARE @row INT = 1;
DECLARE @col INT;
DECLARE @result INT;
DECLARE @rowString VARCHAR(255);
DECLARE @headerString VARCHAR(255);

-- Create the header row for the columns
SET @headerString = CHAR(9); -- Starting with a tab for the row header space
SET @col = 1;
WHILE @col <= 10
BEGIN
    SET @headerString = @headerString + CAST(@col AS VARCHAR) + CHAR(9); -- Append column headers
    SET @col = @col + 1;
END
PRINT @headerString;

-- Generate the multiplication table
WHILE @row <= 10
BEGIN
    SET @col = 1;
    SET @rowString = CAST(@row AS VARCHAR) + CHAR(9); -- Start each row with the row number

    WHILE @col <= 10
    BEGIN
        SET @result = @row * @col;
        SET @rowString = @rowString + CAST(@result AS VARCHAR) + CHAR(9); -- Append multiplication results
        SET @col = @col + 1;
    END

    PRINT @rowString; -- Print the row
    SET @row = @row + 1;
END

