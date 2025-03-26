import duckdb
from pathlib import Path


def load_db(db: duckdb.DuckDBPyConnection, csv_f: Path):
    try:
        # Read the csv file into a dataframe
        wind_df = duckdb.read_csv(csv_f).to_df()

        # Register the dataframe in duckdb and create a table from it
        duckdb.register('wind_df', wind_df)
        db.execute(f"CREATE TABLE wind_turbine_production AS SELECT * FROM wind_df")

        # Test to check if the created table has the same number of rows
        db.execute(f'SELECT * FROM wind_turbine_production')
        assert len(wind_df) == len(db.fetchall())

        return db
    except Exception as error:
        raise error


def get_distinct_turbines(db: duckdb.DuckDBPyConnection):
    try:
        rows = db.execute(
                    """
                    SELECT DISTINCT(turbine_id)
                    FROM wind_turbine_production
                    ORDER BY turbine_id
                    """
                ).fetchall()
        return [t[0] for t in rows]
    except Exception as error:
        print(error)


def get_turbine_info_from_date(db: duckdb.DuckDBPyConnection, date: str):
    # TODO: Task 1
    # TODO: Retrieve the turbine ids and power outputs from a given date 
    try:
        rows = db.execute(
                """
                select turbine_id, power_output
                from wind_turbine_production
                where production_date = ?
                order by turbine_id
                """,
                [date]
            ).fetchall()
        return [t[0] for t in rows]
    
    except Exception as error:
        print(error)




def get_highest_power_wind_turbine(db: duckdb.DuckDBPyConnection, date: str):
    # TODO: Task 2
    # TODO: Retrieve the wind turbine with the highest power output for a given date
    # TODO: Return a tuple with the wind turbine name and its power output e.g. ('WT-0001', 28.507)
    try:
        rows = db.execute(
            """
            select turbine_id, power_output
            from wind_turbine_production
            where production_date = ?
            order by power_output desc
            limit 1
            """,
            [date]
        ).fetchall()
        return rows[0]
    except Exception as error:
        print(error)

    

def add_or_update_wind_turbine_entry(db: duckdb.DuckDBPyConnection, turbine_id: str, p_date: str, pwr: float):
    # TODO: Task 3
    # TODO: Add a new row in the wind_turbine_production table
    # TODO: If there already exists a row within the table for the wind turbine on the given day update that rows power output instead
    try:
        count = db.execute(
            """
            select count(*) from(
            select turbine_id, power_output
            from wind_turbine_production
            where turbine_id=? and production_date = ?
            )
            """,
            [turbine_id, p_date]
        ).fetchall()

        if count[0][0] < 1:
            db.execute(
            """
            insert into wind_turbine_production(turbine_id, production_date, power_output)
            values (?, ?, ?)
            """,
            [turbine_id, p_date, pwr]
            )
            print("inserted") #debugging
        else:
            db.execute(
            """
            update wind_turbine_production
            set power_output = ?
            where turbine_id = ? and production_date = ?
            """,
            [pwr, turbine_id, p_date]
            )
            print("updated") #debuggin

    except Exception as error:
        print(error)

    
def get_total_power_from_turbines_for_dates(db: duckdb.DuckDBPyConnection, turbines: list[str], dates: list[str]):
    try:
        turbine_placeholders = ", ".join(["?"] * len(turbines))
        date_placeholders = ", ".join(["?"] * len(dates))
        
        query = f"""
        SELECT turbine_id, SUM(power_output) as total_power
        FROM wind_turbine_production
        WHERE turbine_id IN ({turbine_placeholders})
        AND production_date IN ({date_placeholders})
        GROUP BY turbine_id
        ORDER BY total_power DESC
        """
        
        params = turbines + dates
        
        rows = db.execute(query, params).fetchall()
        
        return [(row[0], row[1]) for row in rows]
    except Exception as error:
        print(error)
        return []





#########
# Main
#########

db = None
# Path to wind_turbine_production.csv
wind_turbine_f = Path('/Users/jakobeg/Uni/SD/2 sem/db/hw/hw3/wind_turbine_production.csv')

try:
    # Create an in memory database
    db = duckdb.connect(':memory:', read_only=False)
    load_db(db, wind_turbine_f)

    print(f"Distinct wind turbines: {get_distinct_turbines(db)}")

    print(f"Get turbine info for 2025-01-10: {get_turbine_info_from_date(db, '2025-01-10')}")

    print(f"Highest wind turbine output for 2025-01-03: {get_highest_power_wind_turbine(db, '2025-01-03')}")

    add_or_update_wind_turbine_entry(db, "WT-002", "2025-01-01", 1234.013)
    add_or_update_wind_turbine_entry(db, "WT-001", "2025-08-01", 1235.013)

    print(f"Total wind production for WT-001 and WT-002 for dates 2025-01-03 and 2025-01-02: {get_total_power_from_turbines_for_dates(db, ['WT-001', 'WT-002'], ['2025-01-03', '2025-01-02'])}")

except Exception as error:
    print(error)
    # NOTE: Uncomment the next line to get full exception output
    # raise error
finally:
    if db is not None:
        db.close()