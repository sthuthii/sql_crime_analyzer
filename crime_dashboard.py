
import streamlit as st
import sqlite3
import pandas as pd

# Connect to SQLite DB
conn = sqlite3.connect('crime_analysis.db')

st.set_page_config(page_title="Crime Data Dashboard", layout="wide")
st.title("🕵️‍♀️ Crime Data Analysis Dashboard")

# Fetch total stats
col1, col2, col3 = st.columns(3)
total_crimes = pd.read_sql("SELECT COUNT(*) as total FROM Crimes", conn)
open_cases = pd.read_sql("SELECT COUNT(*) as open_cases FROM Crimes WHERE status = 'Open'", conn)
closed_cases = pd.read_sql("SELECT COUNT(*) as closed_cases FROM Crimes WHERE status = 'Closed'", conn)

col1.metric("Total Crimes", total_crimes['total'][0])
col2.metric("Open Cases", open_cases['open_cases'][0])
col3.metric("Closed Cases", closed_cases['closed_cases'][0])

# Top crime types
st.subheader("🔍 Top Crime Types")
top_crimes = pd.read_sql("""
    SELECT crime_type, COUNT(*) as count 
    FROM Crimes 
    GROUP BY crime_type 
    ORDER BY count DESC 
    LIMIT 5
""", conn)
st.bar_chart(top_crimes.set_index('crime_type'))

# Crime by city
st.subheader("📍 Crimes by City")
city_crimes = pd.read_sql("""
    SELECT l.city, COUNT(*) as total 
    FROM Crime_Reports cr
    JOIN Locations l ON cr.location_id = l.location_id
    GROUP BY l.city
    ORDER BY total DESC
""", conn)
st.bar_chart(city_crimes.set_index('city'))

# Monthly trend
st.subheader("📆 Monthly Crime Trend")
monthly = pd.read_sql("""
    SELECT strftime('%Y-%m', date_reported) as month, COUNT(*) as total
    FROM Crimes
    GROUP BY month
    ORDER BY month
""", conn)
st.line_chart(monthly.set_index('month'))

# Officer performance
st.subheader("👮 Officer Performance")
officer_perf = pd.read_sql("""
    SELECT o.name, COUNT(*) as cases_handled
    FROM Crime_Reports cr
    JOIN Officers o ON cr.officer_id = o.officer_id
    GROUP BY o.name
    ORDER BY cases_handled DESC
    LIMIT 5
""", conn)
st.dataframe(officer_perf)

# Long open cases
st.subheader("🚨 Open Cases > 90 Days")
long_open = pd.read_sql("""
    SELECT crime_id, crime_type, date_reported
    FROM Crimes
    WHERE status = 'Open' AND julianday('now') - julianday(date_reported) > 90
""", conn)
st.dataframe(long_open)
