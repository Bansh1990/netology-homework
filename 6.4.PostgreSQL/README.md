# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

``` docker exec -ti -upostgres postgres_db_1  psql```

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
```\l```
- подключения к БД ```\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo} connect to new database```
- вывода списка таблиц ```\dt```
- вывода описания содержимого таблиц ```\d```
- выхода из psql ```\q```

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.
```shell
bansh@R2D2 ~/n/n/6/postgres (master)> docker exec -ti -upostgres postgres_db_1  bash
postgres@15ac038d1531:/$ cd /backup/
postgres@15ac038d1531:/backup$ psql -U postgres -d test_database -f ./test_dump.sql
postgres=# \c 
postgres       template0      template1      test_database  
postgres=# \c test_database 
test_database=# analyze orders;
ANALYZE
test_database=#  SELECT MAX(avg_width) max_avg_width FROM pg_stats WHERE tablename = 'orders';
 max_avg_width 
---------------
            16
(1 row)
```
**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.
```
BEGIN TRANSACTION;

CREATE TABLE public.orders_main (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
) PARTITION BY RANGE(price);

CREATE TABLE orders_1 PARTITION OF orders_main FOR VALUES FROM (500) TO (MAXVALUE);
CREATE TABLE orders_2 PARTITION OF orders_main FOR VALUES FROM (MINVALUE) TO (500);

INSERT INTO orders_main SELECT * FROM orders;

COMMIT;
```
Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
```shell
Да, таблицу изначально нужно было создать с поддержкой разбиения.
```

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.
```
postgres@15ac038d1531:/$ cd /backup/
postgres@15ac038d1531:/backup$ pg_dump -U postgres test_database -f ./test_database-mydump.sql
```
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?
```
CREATE UNIQUE INDEX title_unique ON orders_main (title, price);
```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
