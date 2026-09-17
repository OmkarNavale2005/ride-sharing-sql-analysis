create database ride_sharing_2;
use ride_sharing_2;

select * from drivers;
select * from locations;
select * from payments;
select * from promo_codes; 
select * from promo_usage;
select * from ratings;
select * from riders;
select * from rides;
select * from vehicles;

-- adding a primary key

ALTER TABLE riders
ADD PRIMARY KEY (rider_id);

ALTER TABLE drivers
ADD PRIMARY KEY (driver_id);

ALTER TABLE vehicles
ADD PRIMARY KEY (vehicle_id);

ALTER TABLE locations
ADD PRIMARY KEY (location_id);
ALTER TABLE rides
ADD PRIMARY KEY (ride_id);

ALTER TABLE payments
ADD PRIMARY KEY (payment_id);

ALTER TABLE ratings
ADD PRIMARY KEY (rating_id);

ALTER TABLE promo_codes
ADD PRIMARY KEY (promo_id);

ALTER TABLE promo_usage
ADD PRIMARY KEY (ride_id, promo_id);


-- adding foreign key  and conncting the tables -- 

-- Rides -> Riders
ALTER TABLE rides
ADD CONSTRAINT fk_rides_rider
FOREIGN KEY (rider_id)
REFERENCES riders(rider_id);

-- Rides -> Drivers
ALTER TABLE rides
ADD CONSTRAINT fk_rides_driver
FOREIGN KEY (driver_id)
REFERENCES drivers(driver_id);

-- Vehicles → Drivers
ALTER TABLE vehicles
ADD CONSTRAINT fk_vehicles_driver
FOREIGN KEY (driver_id)
REFERENCES drivers(driver_id);

-- Rides -> Locations
ALTER TABLE rides
ADD CONSTRAINT fk_rides_pickup
FOREIGN KEY (pickup_location_id)
REFERENCES locations(location_id);

ALTER TABLE rides
ADD CONSTRAINT fk_rides_drop
FOREIGN KEY (drop_location_id)
REFERENCES locations(location_id);

-- Payments -> Rides
ALTER TABLE payments
ADD CONSTRAINT fk_payments_ride
FOREIGN KEY (ride_id)
REFERENCES rides(ride_id);

-- Ratings → Rides
ALTER TABLE ratings
ADD CONSTRAINT fk_ratings_ride
FOREIGN KEY (ride_id)
REFERENCES rides(ride_id);

-- Promo Usage -> Rides
ALTER TABLE promo_usage
ADD CONSTRAINT fk_promo_usage_ride
FOREIGN KEY (ride_id)
REFERENCES rides(ride_id);

-- Promo Usage -> Promo Codes
ALTER TABLE promo_usage
ADD CONSTRAINT fk_promo_usage_promo
FOREIGN KEY (promo_id)
REFERENCES promo_codes(promo_id);





