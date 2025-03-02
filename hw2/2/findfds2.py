sql_query = """
SELECT 'Rentals: %s --> %s' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT P.%s
        FROM Rentals P
        GROUP BY P.%s
        HAVING COUNT(DISTINCT P.%s) > 1
) X;
"""

def print_sql(att1, att2):
    print (sql_query % (att1, att2, att1, att1, att2))

R = ['PID', 'HID', 'PN', 'S', 'HS', 'HZ', 'HC']
for i in range(len(R)):
    for j in range(len(R)):
        if (i != j):
            print_sql(R[i], R[j])

