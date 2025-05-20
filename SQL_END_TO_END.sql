create database ola_sql;
use ola_sql;
drop table bookings;
CREATE TABLE bookings (
    Date DATETIME,
    Time TIME,
    Booking_ID VARCHAR(20),
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(20),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT INT,
    C_TAT INT,
    Canceled_Rides_by_Customer VARCHAR(255),
    Canceled_Rides_by_Driver VARCHAR(255),
    Incomplete_Rides VARCHAR(10),
    Incomplete_Rides_Reason VARCHAR(255),
    Booking_Value INT,
    Payment_Method VARCHAR(50),
    Ride_Distance INT,
    Driver_Ratings FLOAT,
    Customer_Rating FLOAT,
    Vehicle_Images TEXT
);


SET SESSION sql_mode = '';    
    
load data infile 
"C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/End_To_End_Project/End_To_End_ProjectFile_Date+Cleaned.csv"
into table bookings
fields terminated by ','
lines terminated by '\n'
ignore 1 rows;  
select * from bookings;
SHOW VARIABLES LIKE 'secure_file_priv';
SELECT @@sql_mode;
-- 1. Retrieve all successful bookings
    select * from bookings where Booking_Status='Success';
-- 2. Find the average ride distance for each vehicle type
select Vehicle_Type,AVG(Ride_Distance) as Avg_Distance from bookings group by Vehicle_Type;

-- 3. Get the total number of canceled rides by customers
   select count(*) from bookings where Booking_Status='Canceled By Customer';

-- 4. List the top 5 customers who booked the highest number of rides
select Customer_id,count(Booking_Id) as total_rides from bookings group by customer_id order by total_rides desc limit 5;

-- 5. Get the number of rides canceled by drivers due to personal and car-related issues
Select count(*) from bookings where Canceled_Rides_by_Driver='Personal & Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings
select max(Driver_Ratings) as max_rating,min(Driver_Ratings) from bookings where Vehicle_Type='Prime Sedan';
-- 7. Retrieve all rides where payment was made using UPI
select * from bookings where payment_method='UPI';

-- 8. Find the average customer rating per vehicle type
select Vehicle_Type,AVG(Customer_Rating) as avg_customer_rating from bookings group by Vehicle_Type;

-- 9. Calculate the total booking value of rides completed successfully
select sum(Booking_Value) as total_booking_value from bookings where Booking_Status='Success';

-- 10. List all incomplete rides along with the reason
SELECT Booking_ID, Incomplete_Rides_Reason
FROM bookings
WHERE Incomplete_Rides = 'Yes'
LIMIT 0, 1000;

select * from bookings;



