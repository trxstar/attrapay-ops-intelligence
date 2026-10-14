import streamlit as st
import pandas as pd
st.title("AttraPay Labs-QC & Ops Intelligence Dashboard")
df=pd.read_csv('attrapay_qc_ops_dataset_2024.csv')
st.metric("Total Batches", len(df))
st.metric("Critical Escalations", len(df[df['ops_priority']=='Critical']))
st.dataframe(df.head(100))
st.bar_chart(df['ops_priority'].value_counts())