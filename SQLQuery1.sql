--скрипт проверяет, какое сейчас время суток, и выдаёт приветствие "добрый вечер!", "добрый день!" и тп
SELECT
    CASE
        WHEN DATENAME(HOUR, GETDATE()) >= 5 AND DATENAME(HOUR, GETDATE()) < 12 THEN 'Доброе утро!'
        WHEN DATENAME(HOUR, GETDATE()) >= 12 AND DATENAME(HOUR, GETDATE()) < 17 THEN 'Добрый день!'
        WHEN DATENAME(HOUR, GETDATE()) >= 17 AND DATENAME(HOUR, GETDATE()) < 22 THEN 'Добрый вечер!'
        ELSE 'Доброй ночи!'
    END AS greeting;

--скрипт генерирует случайный пароль длиной 10 символов
DECLARE @password VARCHAR(100) = ''
DECLARE @length INT = 10
WHILE @length > 0
BEGIN 
SET @password += CHAR(ROUND(RAND()*100,0))
SET @length -= 1
END
PRINT @password

--показать факториалы всех чисел от 0 до 25
DECLARE @temp BIGINT = 1
DECLARE @iterator INT = 0
WHILE @iterator <= 25
BEGIN
if(@iterator = 0)
BEGIN
PRINT 1
END
else
BEGIN
SET @temp = @temp * @iterator
PRINT @temp
END
SET @iterator += 1
END

--показать все простые числа от 3 до 1.000.000

DECLARE @number INT = 3;
DECLARE @is_prime BIT;

WHILE (@number <= 1000000)
BEGIN
    SET @is_prime = 1;
    
    IF (@number % 2 = 0)
    BEGIN
        SET @is_prime = 0;
    END
    ELSE
    BEGIN
        DECLARE @i INT = 3;
        
        WHILE (@i <= SQRT(@number))
        BEGIN
            IF (@number % @i = 0)
            BEGIN
                SET @is_prime = 0;
                BREAK;
            END
            
            SET @i = @i + 2;
        END
    END
    
    IF (@is_prime = 1)
    BEGIN
        PRINT @number;
    END
    
    SET @number = @number + 2;
END

--реализовать на языке Transact-SQL игровой автомат "однорукий бандит".
--в начале игры есть некий стартовый капитал, например, 500 кредитов. для начала игры необходимо нажать F5.
--стоимость одного нажатия - 10 кредитов. при нажатии генерируются три случайных числа (от 0 до 6). если все три числа одинаковы, назначить приз (например, 50 кредитов). если нет - то и приз никакой не назначается (просто теряем 10 кредитов).
--кроме трёх случайных чисел показывать текущее состояние счёта. игра завершается поражением, если закончились деньги.
--игра завершается победой, если выпало 777. выдать сообщение о победе или проигрыше.

DECLARE @capital INT = 500;
DECLARE @cost INT = 10;
DECLARE @number1 INT;
DECLARE @number2 INT;
DECLARE @number3 INT;
DECLARE @prize INT = 50;

WHILE (@capital >= @cost)
BEGIN
    SET @number1 = ROUND(RAND() * 6, 0);
    SET @number2 = ROUND(RAND() * 6, 0);
    SET @number3 = ROUND(RAND() * 6, 0);
    
    PRINT 'Current capital: ' + CAST(@capital AS VARCHAR(10));
    PRINT 'Numbers: ' + CAST(@number1 AS VARCHAR(1)) + ', ' + CAST(@number2 AS VARCHAR(1)) + ', ' + CAST(@number3 AS VARCHAR(1));
    
    IF (@number1 = @number2 AND @number2 = @number3)
    BEGIN
        SET @capital = @capital + @prize;
        PRINT 'You won! Prize: ' + CAST(@prize AS VARCHAR(10));
        
        IF (@number1 = 7)
        BEGIN
            PRINT 'JACKPOT!!!';
        END
    END
    ELSE
    BEGIN
        SET @capital = @capital - @cost;
        PRINT 'You lost! Cost: ' + CAST(@cost AS VARCHAR(10));
    END
END

IF (@capital <= 0)
BEGIN
    PRINT 'Game over. You lost all your money.';
END
ELSE
BEGIN
    PRINT 'Congratulations! You won the game with capital: ' + CAST(@capital AS VARCHAR(10));
END