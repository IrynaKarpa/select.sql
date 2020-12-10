use lviv_croissant;
-- 1 Вибрати поля з таблиці Персонал,у яких зарплата більше 15000.
select * from staff
where salary > 15000

-- 2 Знайти сумарну кількість позицій у замовленнях.
select sum(order_details.qty) sum_qty 
from order_details;

-- 3 Знайти інформацію по заборгованості від 30 жовтня до 17 листопада 2020 р.
select * from debts
where dates between '20201030' and '20201117';
  
-- 4 Об'єднання таблиць Магазини та Персонал.
select * from shops tb1
right join staff tb2
on tb1.id_shops = tb2.id_shops; 

-- 5 Знайти, які інгредієнти наповнюють кожен з продуктів.
select p.id_prod, p.name, i.name 
from products as p
inner join composition_of_croissant as coc 
ON coc.id_prod= p.id_prod
inner join ingredients as i 
ON i.id_ingr = coc.id_ingr
order by p.id_prod;

-- 6 Сума накладних по переміщеннях по складах.
select w.id_war, SUM(mdet.price) sum
from warehouses as w
inner join movings as m
ON m.id_war = w.id_war
inner join moving_details as mdet 
ON m.id_mov = mdet.id_mov
group by w.id_war
order by sum asc;

-- 7) Вибираємо всі атрибути з таблиці debts, де дата більша за 1 січня 2020 року.
select *from debts
where dates > '20200101'
-- 8) Визначаємо номер "Переміщення" та номер складу, де номер інгредієнту - 2.
select id_mov,id_war
from movings
where id_mov =(select id_mov
from moving_details
where id_ingr = 2)


-- 9) Знаходження загальної заборгованості контрагентів.
select id_contr, sum(summ) sum
from debts
group by id_contr;
  
-- 10) Сортуваня полів таблиці moving_details по спаданню ціни.
 select id_movdet, id_ingr, price
  from moving_details
  order by price DESC;
  
-- 11)  Дістаємо "Продажі", де сума продажу більша 2500 та менша 4500.
select id_det, id_salins,price
  from salin_details
  where price between 2500 and 4500; 
  
-- 12) Вибираємо з таблички staff імена, які починаються на букву "А".
select name, position
  FROM staff
  WHERE name LIKE 'Т%'; 
  
-- 13) Об'єднуємо таблиці "Заборгованість" та "Погашення заборгованості".
select * from debts tbl1
    left outer join debts_repayment tbl2
    on tbl1.id_debts = tbl2.id_debts;
-- 14) Вибрати всі записи з таблиці composition_of_сroissant де id_ingr дорівнює 4 або 5.
select * from composition_of_croissant
  where id_ingr = 4 or id_ingr = 5;
-- 15) Шукаємо різницю між кредиторською та дебіторською заборгованостю
  select 
  t1.id_debts, t1.id_contr, t1.summ,
  t2.id_debts, t2.summ, 
  t1.summ - t2.summ difference
  from debts t1
  left join debts_repayment t2
    on t1.id_debts = t2.id_debts;
    -- 18) Вибрати всі доставки з другого складу
select t1.date, t1.id_war, t2.id_ingr, t2.qty, t2.price
  from movings t1, moving_details t2
    where t1.id_mov = t2.id_mov AND t1.id_war = 2; 
-- 16) Згрупувати всі адреси з таблиці warehouses, що містять цифру 3.
select address
from warehouses
group by address
having address like '%3%';
-- 17) Вибрати унікальні записи позицій та зарплат з таблиці staff де зарплата більша 5000 та сортувати за спаданням.
select distinct position, salary 
from staff
where salary > '5000'
order by salary desc;
-- 18) Вибрати всі доставки з другого складу
select t1.date, t1.id_war, t2.id_ingr, t2.qty, t2.price
  from movings t1, moving_details t2
    where t1.id_mov = t2.id_mov AND t1.id_war = 2;
-- 19) Вибрати всі продажі з сумою більше 100, але менше 300 грошових одиниць.
select id_salouts, id_shops, id_cust, sum 
  from salouts
    where sum > 100 and sum < 300;
-- 20) Вибрати загальну кількість замовлень круасана "Класичний" у всіх магазинах.
select count(t1.id_order) all_orders, t2.id_prod
  from orders t1
   right outer join order_details t2
    on t2.id_order = t1.id_order 
	where t2.id_prod = 1
	group by t2.id_prod
    
-- 21) Вибрати магазини і загальну кількість замовлень в них.
select count(t2.id_shops) all_orders, t2.id_shops
  from orders t1 
  right join salouts t2 
  on t1.id_order = t2.id_order
    group by t2.id_shops;

-- 22) Вибрати покупців і порахувати загальну кількість замовлень, що вони зробили, посортувати за спаданням.
select count(t2.id_cust) total, t1.name
  from customers t1
  right outer join salouts t2 
  on t1.id_cust = t2.id_cust
    group by t1.name
    order by count(t1.id_cust) desc;
-- 23) Вибираємо покупців,чи ім'я закінчується на "а".
select name,phone, birth
from customers
where name like '%а'
-- 24) Визначаємо ціну інгредієнтів більше 100.
select name,price
from ingredients
where price > 100
-- 25)Визначаємо ціну продукції менше 40
select name, price
from products
where price < 40
order by price desc
--26)Визначаємо к-ть продуктів в кожному інгредієнті.
select t1.name, count(t2.id_prod) as quality
  from products t1
   inner join composition_of_croissant t2
    on t2.id_prod = t1.id_prod 
	group by t1.name
--27)Визначити номера телефонів персоналу які мають оператор Kyivstar.
select name, phone
from staff
where phone like '+380[6,9][7,8,6]%'
--28)Показати імена покупців, дата народження яких з 1999 по 2001 роки.
select name, birth
from customers
where birth between '1999-01-01' and '2001-01-01'
