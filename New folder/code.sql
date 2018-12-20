1. How many campaigns and sources does CoolTShirts use? Which source is used for each campaign?

SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;

SELECT COUNT(DISTINCT utm_source)
FROM page_visits;

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;



2. What pages are on the CoolTShirts website?

SELECT DISTINCT page_name
FROM page_visits;


3. How many first touches is each campaign responsible for?

WITH first_touch AS (
  SELECT user_id,
      MIN(timestamp) AS first_touch_at
  FROM page_visits
  GROUP BY 1),
  ft_attr AS (
SELECT ft.user_id,
       ft.first_touch_at,
       pv.utm_source,
       pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source AS [FT source],
     ft_attr.utm_campaign AS [FT Campaign],
     COUNT(*) AS Counts
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

4. How many last touches is each campaign responsible for?



WITH last_touch AS (
  SELECT user_id,
      MAX(timestamp) as last_touch_at
  FROM page_visits
  GROUP BY 1),
 lt_attr AS (
SELECT lt.user_id,
       lt.last_touch_at,
       pv.utm_source,
       pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
  ON lt.user_id = pv.user_id
AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source AS [LT Source],
     lt_attr.utm_campaign AS [LT Campaign],
     COUNT(*) AS Counts
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

5.) How many visitors make a purchase?

SELECT COUNT(DISTINCT user_id)
FROM page_visits
WHERE page_name = '4 - purchase';


6. How many last touches on the purchase page is each campaign responsible for?

WITH last_touch AS (
  SELECT user_id,
      MAX(timestamp) AS last_touch_at
  FROM page_visits
  GROUP BY user_id)
 SELECT COUNT(DISTINCT user_id)as Users,utm_campaign as Campaign
 FROM page_visits
 WHERE page_name = '4 - purchase'
 GROUP BY utm_campaign
ORDER BY 1 DESC;






