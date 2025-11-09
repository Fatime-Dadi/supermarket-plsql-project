-- Simple Supermarket System
SET SERVEROUTPUT ON;

DECLARE
    -- 1. RECORD for product
    TYPE Product_Record IS RECORD (
        id NUMBER,
        name VARCHAR2(50),
        price NUMBER
    );
    my_product Product_Record;
    
    -- 2. COLLECTIONS (all 3 types)
    -- VARRAY for categories
    TYPE Category_Array IS VARRAY(3) OF VARCHAR2(20);
    categories Category_Array;
    
    -- Nested Table for items
    TYPE Item_Table IS TABLE OF VARCHAR2(20);
    items Item_Table;
    
    -- Associative Array for prices
    TYPE Price_List IS TABLE OF NUMBER INDEX BY VARCHAR2(20);
    prices Price_List;
    
    -- Other variables
    total NUMBER := 0;
    discount NUMBER := 0;

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== SUPERMARKET SYSTEM ===');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- A. RECORD EXAMPLE
    DBMS_OUTPUT.PUT_LINE('1. PRODUCT RECORD:');
    my_product.id := 101;
    my_product.name := 'Milk';
    my_product.price := 2.50;
    DBMS_OUTPUT.PUT_LINE('   Product: ' || my_product.name);
    DBMS_OUTPUT.PUT_LINE('   Price: $' || my_product.price);
    DBMS_OUTPUT.PUT_LINE('');
    
    -- B. COLLECTIONS EXAMPLES
    -- VARRAY
    DBMS_OUTPUT.PUT_LINE('2. VARRAY - CATEGORIES:');
    categories := Category_Array('Food', 'Drinks', 'Snacks');
    FOR i IN 1..categories.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('   ' || i || '. ' || categories(i));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Nested Table
    DBMS_OUTPUT.PUT_LINE('3. NESTED TABLE - ITEMS:');
    items := Item_Table('Bread', 'Juice', 'Chips');
    FOR i IN 1..items.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('   ' || i || '. ' || items(i));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Associative Array
    DBMS_OUTPUT.PUT_LINE('4. ASSOCIATIVE ARRAY - PRICES:');
    prices('Bread') := 1.50;
    prices('Juice') := 2.00;
    prices('Chips') := 1.25;
    
    IF prices.EXISTS('Bread') THEN
        DBMS_OUTPUT.PUT_LINE('   Bread: $' || prices('Bread'));
    END IF;
    IF prices.EXISTS('Juice') THEN
        DBMS_OUTPUT.PUT_LINE('   Juice: $' || prices('Juice'));
    END IF;
    DBMS_OUTPUT.PUT_LINE('');
    
    -- C. GOTO EXAMPLE
    DBMS_OUTPUT.PUT_LINE('5. GOTO - DISCOUNT CALCULATION:');
    total := 100;
    
    -- Simple GOTO logic
    IF total > 50 THEN
        GOTO give_discount;
    ELSE
        GOTO no_discount;
    END IF;
    
    <<give_discount>>
    discount := total * 0.10;
    DBMS_OUTPUT.PUT_LINE('   Discount: 10%');
    GOTO show_result;
    
    <<no_discount>>
    discount := 0;
    DBMS_OUTPUT.PUT_LINE('   No discount');
    GOTO show_result;
    
    <<show_result>>
    DBMS_OUTPUT.PUT_LINE('   Total: $' || total);
    DBMS_OUTPUT.PUT_LINE('   Final: $' || (total - discount));
    DBMS_OUTPUT.PUT_LINE('');
    
    DBMS_OUTPUT.PUT_LINE('=== SYSTEM END ===');

END;
/