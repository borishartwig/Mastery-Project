WITH
  valid_users AS (
    WITH
      recent_sessions AS (
        SELECT
          *
        FROM
          sessions
        WHERE
          DATE_TRUNC('day',session_start) >= '2023-01-04'
      )
    SELECT
      user_id,
      count(session_id) AS num_sessions
    FROM
      recent_sessions
      JOIN users USING (user_id)
    GROUP BY
      1
    HAVING
      count(session_id) > 7
  )
SELECT
  *
FROM
  valid_users
  JOIN users USING (user_id)
  JOIN sessions USING (user_id)
  LEFT JOIN flights USING (trip_id)
  LEFT JOIN hotels USING (trip_id)
WHERE
  DATE_TRUNC('day',session_start) >= '2023-01-04'