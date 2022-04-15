USE s02_t01_w22_schema;
#1
SELECT DISTINCT customerID, cardNo 
FROM orders JOIN customer ON orders.CUSTOMER_customerID=customer.customerID JOIN payment ON customer.customerID=payment.CUSTOMER_customerID  
WHERE cardNo IS NULL;

#2
SELECT itemName, menuName  
FROM  menu_item  
WHERE menuName = "Lex Mex" AND itemName NOT IN ("steak tacos", "steak burrito", "chicken burrito", "chicken tacos")  
ORDER BY itemName;

#3
SELECT MAX(price) 
FROM menu_item 
WHERE menuName REGEXP ‘oink’; 

#4
SELECT DISTINCT truckName, COUNT(CUSTOMER_customerID) 
FROM truck JOIN menu ON truckID=TRUCK_truckID JOIN menu_item ON MENU_mitemID=mitemID JOIN orders ON mitemID=MENU_ITEM_itemID 
GROUP BY CUSTOMER_customerID 
HAVING COUNT(CUSTOMER_customerID)>2; 

#5
SELECT DISTINCT itemName, ingredientName, price 
FROM ingredients JOIN recipe ON ingredientID=INGREDIENTS_ingredientID JOIN menu_item ON MENU_itemID=mitemID 
WHERE price = (SELECT MAX(price) FROM menu_item);

#6
SELECT DISTINCT ingredientName, invQuant 
FROM menu_item JOIN recipe ON menu_item.mitemID=recipe.MENU_itemID JOIN ingredients ON ingredients.ingredientID=recipe.INGREDIENTS_ingredientID  
WHERE invQuant >(SELECT AVG(invQuant) FROM recipe JOIN ingredients ON ingredients.ingredientID=recipe.INGREDIENTS_ingredientID ) 
ORDER BY invQuant;

#7
SELECT DISTINCT itemName, orderStatus, price 
FROM menu_item JOIN orders ON mitemID=MENU_ITEM_itemID WHERE orderStatus="Delivered" 
ORDER BY price;

#8
SELECT DATE(pay_date) 
FROM payment 
WHERE cardNo IS NOT NULL;

#9
SELECT paymentform, COUNT(paymentform) 
FROM payment 
GROUP BY paymentform;

#10
SELECT itemName, price, itemCategory, menuName 
FROM menu_item 
WHERE price < (SELECT AVG(PRICE) FROM menu_item);

SELECT *
FROM payment;

SELECT *
FROM ingredients;