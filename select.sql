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
