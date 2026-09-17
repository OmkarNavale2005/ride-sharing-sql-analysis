use ride_sharing_2;

                                                            -- tables --
select * from drivers;
select * from locations;
select * from payments;
select * from promo_codes; 
select * from promo_usage;
select * from ratings;
select * from riders;
select * from rides;
select * from vehicles;

                                                             -- QUERIES --
															
														-- SELECT COMMANDS --

-- 1. Top 10 most expensive rides
-- Purpose: Identifies the highest-value rides.
select ride_id , rider_id , driver_id , distance_km , fare
from rides
order by fare desc
limit 10 ;

-- 2. Show completed rides in 2025
-- Purpose: Shows completed ride activity during 2025.
select ride_id , rider_id , driver_id , ride_date , fare , status 
from rides 
where year(ride_date) = 2025 and status = "Completed"
order by ride_date desc;

-- 3. Show riders from Mumbai
-- Purpose: Identifies customers registered in Mumbai.
select * from riders
where city = "Mumbai" ;	

                                                         -- UPDATE COMMANDS --

--  4. Update a driver's ratings;
update drivers
set driver_rating = 4.80
where driver_id = 10; 

-- 5. Increase fare for a particular vehicle type
-- Purpose: Demonstrates updating ride fares based on vehicle category.
update rides r
join vehicles v
on r.driver_id = v.driver_id
set r.fare = r.fare * 1.10
where v.vehicle_type = 'Premium'
and r.status = 'Completed';

-- 6. Update payment status
-- Purpose: Demonstrates updating payment records.
update payments
set payment_status = 'Paid'
where payment_status = 'Failed'
and amount > 0;

                                                           -- ALTER COMMANDS --

-- 7. Add email column
-- Purpose: Adds an email field to the riders table.
alter table riders
add column email varchar(100);

-- 8. Modify driver rating precision
-- Purpose: Ensures driver ratings can be stored with two decimal places.
alter table drivers
modify column driver_rating decimal(3,2);

-- 9. Add index to rides
-- Purpose: Improves searches and JOIN operations involving driver_id.
alter table rides
add index idx_driver_id (driver_id);


											 -- GROUP BY & AGGREGATE FUNCTIONS --

-- 10 . Number of rides by status
-- Purpose: Understands completed and cancelled ride distribution.
select status , count(*) as total_rides
from rides
group by status
order by total_rides desc;

-- 11. Count rides by vehicle type
-- Purpose: Helps the company understand which vehicle types are most frequently used by customers.
select v.vehicle_type, count(r.ride_id) as total_rides
from rides r
join vehicles v on r.driver_id = v.driver_id
where r.status = 'Completed'
group by v.vehicle_type
order by total_rides desc;

-- 12.Total revenue by city
-- Purpose: Helps identify which cities generate the highest revenue.
select l.city,sum(r.fare) as total_revenue
from rides r
join locations l on r.pickup_location_id = l.location_id
where r.status = 'Completed'
group by l.city
order by total_revenue desc;

-- 13. Top 5 drivers by completed rides
-- Purpose: Finds the most active drivers.
select driver_id, count(*) as total_completed_rides
from rides
where status = 'Completed'
group by driver_id
order by total_completed_rides desc
limit 5;

                                                        -- LOGICAL OPERATORS --

-- 14. Rides that are completed OR cancelled
-- operator used -> OR
select * from rides 
where status  = "Completed" or status =  "Cancelled";

-- 15. Completed rides above ₹500
-- operator use -> AND
select * from rides 
where status = "Completed" and fare > 500;

-- 16. Rides that are NOT cancelled
-- operator use -> NOT
select * from rides
where not status = "Cancelled";


-- 6. JOINS 

-- 17. Rider and driver details for every ride
-- Purpose: Combines ride, rider and driver information.
select r.ride_id, rd.rider_name, d.driver_name, r.distance_km, r.fare, r.status
from rides r
join riders rd
on r.rider_id = rd.rider_id
join drivers d
on r.driver_id = d.driver_id;

-- 18 . INNER JOIN: Show ride, rider and driver details
-- Purpose: Displays rides where matching rider and driver records exist.
select r.ride_id, rd.rider_name, d.driver_name, r.fare, r.status
from rides r
inner join riders rd on r.rider_id = rd.rider_id
inner join drivers d on r.driver_id = d.driver_id;
    
-- 19 . LEFT JOIN: Display all riders and their rides
-- Purpose: Shows all riders, even if they don't have a corresponding ride.
select rd.rider_id, rd.rider_name, r.ride_id, r.fare, r.status
from riders rd
left join rides r on rd.rider_id = r.rider_id;

-- 20 . RIGHT JOIN: Display all drivers and their rides
-- Purpose: Shows all drivers, even if they don't have a matching ride.
select d.driver_id, d.driver_name, r.ride_id, r.fare, r.status
from rides r
right join drivers d on r.driver_id = d.driver_id;


															-- SUBQUERIES --

-- 21 . Rides with above-average fare
-- Purpose: Finds rides costing more than the overall average.
select ride_id, distance_km, fare
from rides
where fare > (select avg(fare) from rides);

-- 23. Drivers with above-average rating
-- Purpose: Identifies highly rated drivers.
select driver_id, driver_name, driver_rating
from drivers
where driver_rating > (select avg(driver_rating) from drivers);

-- 24. Riders with more than 10 completed rides
-- Purpose: Identifies frequent customers.
select rider_id, rider_name
from riders
where rider_id in (select rider_id from rides
    where status = 'Completed'
    group by rider_id
    having count(*) > 10);
    
													   -- WINDOW FUNCTIONS --

-- 25 . Rank drivers by total revenue
-- Purpose: Ranks drivers according to their total earnings.
select driver_id, sum(fare) as total_revenue,rank() over( order by sum(fare) desc) as revenue_rank
from rides
where status = 'Completed'
group by driver_id;

-- 26.Running total of revenue for each driver
-- Purpose: Shows how each driver's revenue accumulates over time.
select driver_id, ride_id, ride_date, fare,sum(fare) over(partition by driver_id order by ride_date , ride_id) as cumulative_revenue
from rides
where status = 'Completed';

-- 27 . Number each ride for every rider
-- Purpose: Numbers each rider's rides chronologically.
select rider_id, ride_id, ride_date, fare, row_number() over(partition by rider_id order by ride_date) as ride_number
from rides;

-- 28 . Rank drivers within each city
-- Purpose: Finds the best-performing drivers separately within each city.
select city, driver_id, total_revenue, rank() over( partition by city order by total_revenue desc ) as city_rank
from (select d.city, d.driver_id,sum(r.fare) as total_revenue 
from drivers d 
join rides r 
on d.driver_id = r.driver_id
    where r.status = 'Completed'
    group by d.city, d.driver_id
) as driver_revenue;

													-- CONSTRAINT QUERIES --

-- 29. Add NOT NULL constraint
-- Purpose: Ensures every driver must have a name.
alter table drivers
modify driver_name varchar(100) not null;

-- 30 . Add UNIQUE constraint
-- Purpose: Prevents two vehicles from having the same registration number.
alter table vehicles
add constraint unique_registration
unique (registration_no);

-- 31. Add CHECK constraint
-- Purpose: Ensures driver ratings remain between 1 and 5.
alter table drivers
add constraint check_driver_rating
check (driver_rating between 1 and 5);

-- 32 . Add Foreign Key constraint
-- Purpose: Ensures every rider ID used in rides exists in the riders table.
alter table rides
add constraint fk_rides_rider
foreign key (rider_id) references riders(rider_id);

                                                -- CONDITIONAL STATEMENTS --

-- 33 . Categorize drivers based on rating
-- Purpose: To evaluate driver performance by grouping drivers according to their ratings, making it easier to identify top-performing and average drivers.
select driver_id, driver_name, driver_rating,
case
when driver_rating >= 4.5 then 'Excellent'
when driver_rating >= 4.0 then 'Good'
when driver_rating < 4.0 then 'Average'
end as driver_category
from drivers;

-- 34. Categorize rides based on fare
-- Purpose: To classify rides into different fare categories so the company can understand the distribution of low-cost, medium-cost, and high-cost rides.
select ride_id, fare,
case
when fare < 150 then'Low Fare'
when fare between 150 and 300 then 'Medium Fare'
when fare > 300 then 'High Fare'
end as fare_category
from rides;

-- 35 . Categorize rides based on distance
-- Purpose: To categorize rides by travel distance, helping the company analyze customer travel patterns and the demand for short and long trips.
select ride_id, distance_km,
case
when distance_km < 5 then 'Short Ride'
when distance_km between 5 and 15 then 'Medium Ride'
when distance_km > 15 then 'Long Ride'
end as ride_category
from  rides;


