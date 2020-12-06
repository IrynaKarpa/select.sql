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
