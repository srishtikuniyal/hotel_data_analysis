use new;
select * from hotel_dataset;

-- total number of reservations in the hotel?
select count(booking_id) as total_reservation
from hotel_dataset;

-- which meal is most popular among guest?
select type_of_meal_plan, count(type_of_meal_plan) as count_of_meal_plan
from hotel_dataset
group by type_of_meal_plan
order by count_of_meal_plan DESC limit 1;

-- what is the average price per room for reservations involving children?
select round(avg(avg_price_per_room) ,2) as avg_per_room_involving_children
from hotel_dataset
where no_of_children is not null;

-- how many reservations were made in each year?
set sql_safe_updates=0;
update hotel_dataset
set arrival_date = str_to_date(arrival_date, '%d-%m-%Y');

select year(arrival_date) as year, count(*) as total_reservations
from hotel_dataset
group by year(arrival_date)
order by year(arrival_date);

-- what is the most commonly booked room?
select room_type_reserved, count(room_type_reserved) as count_of_room_reserved
from hotel_dataset
group by room_type_reserved
order by count_of_room_reserved desc limit 1;

-- how do guest reservations vary between weekend and weekday nights?
select sum(no_of_weekend_nights) as weekend, sum(no_of_week_nights) as weekday, 
abs(sum(no_of_weekend_nights)-sum(no_of_week_nights)) as diffrence
from hotel_dataset;

-- what is the highest, lowest and average lead time for reservation?
select max(lead_time) as highest_lead_time, min(lead_time) as lowest_lead_time, avg(lead_time) as average_lead_time
from hotel_dataset;

-- what is the distribution of market segments for guests making same day reservations versus those with long lead times (443 days)?
select market_segment_type, count(market_segment_type) as total_market_segment
from hotel_dataset
where lead_time = 0
group by market_segment_type;

select market_segment_type, count(market_segment_type) as total_market_segment
from hotel_dataset
where lead_time = 443
group by market_segment_type;

-- what is the most comman market segment type for reservations?
select market_segment_type, count(market_segment_type) as count
from hotel_dataset
group by market_segment_type
order by count desc limit 1;

-- What is the total number of confirmed reservations and what percentage of reservations have a "Confirmed" booking status?
select count(*)
from hotel_dataset
where booking_status='not_canceled';
select round((sum(case when booking_status='not_canceled' then 1 else 0 end) /count(*))*100,2) as prec
from hotel_dataset;

-- What is the total number of adults and children across all reservations?
select sum(no_of_adults) as adults, sum(no_of_children) as children
from hotel_dataset;

-- What is the average number of weekend nights for reservations involving children?
select round(avg(no_of_weekend_nights),2) as avg_weekend_nights
from hotel_dataset
where no_of_children>0;

-- How many reservations were made in each month of the year?
select month(arrival_date) as month, monthname(arrival_date) as month_name, count(*) as total_reservations
from hotel_dataset
group by month(arrival_date), monthname(arrival_date)
order by count(*);

-- What is the average number of nights (both weekend and weekday) spent by guests for each room type?
select room_type_reserved, round(avg(no_of_weekend_nights + no_of_week_nights),2) as avg_total_nights
from hotel_dataset
group by room_type_reserved
order by avg(no_of_weekend_nights + no_of_week_nights);















