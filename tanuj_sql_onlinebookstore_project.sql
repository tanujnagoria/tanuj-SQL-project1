-- create database
create database OnlineBookstore;

-- create Tables
create table Books (
 Book_ID serial primary key,
 Title varchar(100),
 Author varchar(100),
 Genre varchar(50),
 Published_Year int,
 Price numeric(10, 2),
 Stock int);
 
 create table Customers (
  Customer_ID serial primary key,
  Name varchar(100),
  Email varchar(100),
  Phone varchar(15),
  City varchar(50),
  Country varchar(150));
  
  create table Orders (
   Order_ID serial primary key,
   Customer_ID int references Customers(Customer_ID),
   Book_ID int references Books(Book_ID),
   Order_Date date,
   Quantity int,
   Total_Amount numeric(10, 2));
   
   select* from books;
   select* from customers;
   select* from orders;
   
   -- 1) Retrieve all books in the "Fiction" genre:
   select* from books
   where Genre='Fiction'; 
   
-- 2) Find books published after the year 1950:
   select* from books
   where Published_Year='1950';
   
-- 3) List all customers from the Canada:
   select* from customers
   where Country='Canada';
   
-- 4) Show orders placed in November 2023:
   select* from orders
   where Order_Date between '2023-11-01' and '2023-11-30';
   
-- 5) Retrieve the total stock of books available:
   select sum(stock) as Total_Stock
   from books;
   
  -- 6) Find the details of the most expensive book:
   select* from books
   order by Price desc
   limit 1;
   
-- 7) Show all customers who ordered more than 1 quantity of a book:
   select* from orders
   where Quantity>1;
  
-- 8) Retrieve all orders where the total amount exceeds $20:
   select* from orders
   where Total_Amount>20;
  
-- 9) List all genres available in the Books table:
    select distinct genre from books;
    
-- 10) Find the book with the lowest stock:

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as Revenue 
from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select * from orders;

select books.Genre, sum(orders.Quantity) as Total_books_Sold
from orders
join books on orders.Book_ID = books.Book_ID
group by books.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) as Average_Price
from books
where Genre='Fantasy';

-- 3) List customers who have placed at least 2 orders:
select orders.Customer_ID, customers.Name, count(orders.Order_ID) as Order_Count
from orders
join customers on orders.Customer_ID = customers.Customer_ID
group by orders.Customer_ID, customers.Name
having count(Order_ID) >=2;

-- 4) Find the most frequently ordered book:d
select orders.Book_ID, books.Title, count(orders.Order_ID) as Order_Count
from orders
join books on orders.Book_ID = books.Book_ID
group by  orders.Book_ID, books.Title
order by order_count desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books
where genre = 'Fantasy'
order by price desc limit 1;

-- 6) Retrieve the total quantity of books sold by each author:
select books.Author, sum(orders.Quantity) as Total_Book_Sold
From orders
join books on orders.Book_ID = books.Book_ID
group by books.Author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct customers.City, Total_Amount
from orders
join customers on customers.Customer_ID=orders.Customer_ID
where orders.Total_Amount >30;

-- 8) Find the customer who spent the most on orders:
select customers.Customer_ID, customers.Name, sum(orders.Total_Amount) as Total_Amount_Spent
from orders
join customers on orders.Customer_ID = customers.Customer_ID
group by customers.Customer_ID, customers.Name
order by Total_Amount_Spent desc limit 1;

-- 9)Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;