CREATE TABLE BOOKS(
		Book_ID	SERIAL PRIMARY KEY,
		Title VARCHAR(100),	
		Author VARCHAR(100),	
		Genre VARCHAR(100),	
		Published_Year	INT,	
		Price NUMERIC(10,2),	
		Stock INT	
)

CREATE TABLE CUSTOMER(
		Customer_ID	SERIAL PRIMARY KEY,
		Name VARCHAR(100),	
		Email VARCHAR(100),	
		Phone VARCHAR(100),	
		City VARCHAR(100),	
		Country VARCHAR(100)

)

CREATE TABLE ORDERS(
		Order_ID SERIAL	PRIMARY KEY,	
		Customer_ID	INT	REFERENCES CUSTOMER(CUSTOMER_ID),
		Book_ID	INT	REFERENCES BOOKS(BOOK_ID),
		Order_Date DATE,		
		Quantity INT,		
		Total_Amount NUMERIC(10,2)		
)

SELECT * FROM BOOKS;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;

COPY BOOKS(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
FROM'C:\Aelish\SQL\Prctise file\ST - SQL ALL PRACTICE FILES SD61\ST - SQL ALL PRACTICE FILES-2\All Excel Practice Files\Books.csv'
CSV HEADER;

COPY CUSTOMER(Customer_ID,Name,Email,Phone,City,Country)
FROM'C:\Aelish\SQL\Prctise file\ST - SQL ALL PRACTICE FILES SD61\ST - SQL ALL PRACTICE FILES-2\All Excel Practice Files\Customers.csv'
CSV HEADER;

COPY ORDERS(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
FROM'C:\Aelish\SQL\Prctise file\ST - SQL ALL PRACTICE FILES SD61\ST - SQL ALL PRACTICE FILES-2\All Excel Practice Files\Orders.csv'
CSV HEADER;


__1

SELECT book_id,GENRE FROM BOOKS
WHERE GENRE = 'Fiction';

--2

select book_id,author,published_year from books
where published_year>1950;

--3
select * from CUSTOMER
where country = 'Canada';

--4
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

--5
select sum(stock) as total_stock
from books;

--6
select * from books 
order by price  desc limit 1;

--7
select * from orders
where quantity > 1;

--8
select * from orders
where total_amount > 20;

--9
select distinct genre 
from books;

--10
select * from books 
order by stock asc;

--11
select sum(total_amount) as revenue
from orders


select * from books;
select * from customer;
select * from orders;


--1 Retrieve the total number of books sold for each genre:
SELECT b.genre,count(o.quantity)as totaal_sold_books
from orders o
join
books b on b.book_id=o.book_id
group by b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) book_price_avg
from books
where genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
select o.customer_id,c.name,count(o.order_id) as total_order
from orders o
join
customer c on c.customer_id=o.customer_id
group by c.name,o.customer_id
having count(o.order_id) =2

-- 4) Find the most frequently ordered book:
select o.book_id,b.title,count(o.order_id) as total_book
from orders o
join
books b on b.book_id=o.book_id
group by o.book_id,b.title
order by total_book desc limit 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books
where genre = 'Fantasy'
order by price desc limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select b.author,sum(o.quantity) as total_sold_books
from books b
join 
orders o on o.book_id = b.book_id
group  by b.author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city,o.total_amount
from customer c
join 
orders o on o.customer_id=c.customer_id
where o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
select c.customer_id,c.name,sum(o.total_amount) as total_spent
from customer c
join
orders o on o.customer_id=c.customer_id
group by c.customer_id,c.name
order by total_spent desc limit 1;

--9) Calculate the stock remaining after fulfilling all orders:
select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0)as order_quantity,
	   b.stock - coalesce(sum(o.quantity),0) as remaining_orders
from books b
left join
orders o on b.book_id=o.book_id
group by b.book_id
order by b.book_id;
