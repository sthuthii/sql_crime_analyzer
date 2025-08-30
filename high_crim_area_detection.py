import sqlite3
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.preprocessing import LabelEncoder
import matplotlib.pyplot as plt
import seaborn as sns

# Connect to SQLite database
conn = sqlite3.connect('crime_analysis.db')

# Read city-wise crime data
df = pd.read_sql_query("""
    SELECT l.city, COUNT(*) as total_crimes
    FROM Crime_Reports cr
    JOIN Locations l ON cr.location_id = l.location_id
    GROUP BY l.city
""", conn)

# Encode city names
le = LabelEncoder()
df['city_encoded'] = le.fit_transform(df['city'])

# Prepare features
X = df[['city_encoded', 'total_crimes']]

# Apply KMeans clustering
kmeans = KMeans(n_clusters=3, random_state=42)
df['cluster'] = kmeans.fit_predict(X)

# Visualize clusters
plt.figure(figsize=(10, 6))
sns.scatterplot(data=df, x='city_encoded', y='total_crimes', hue='cluster', palette='Set2', s=100)
plt.xticks(df['city_encoded'], df['city'], rotation=45)
plt.title('🚨 High Crime Area Detection (Clustering)')
plt.xlabel('City')
plt.ylabel('Total Crimes')
plt.tight_layout()
plt.show()

# Show clusters in console
for i in range(3):
    print(f"\nCluster {i}:")
    print(df[df['cluster'] == i]['city'].values)
