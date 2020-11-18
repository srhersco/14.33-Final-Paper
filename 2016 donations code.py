#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd


# In[7]:


fp = '/Users/srhersco/Desktop/14.33 Paper/2016ContributionsClean.dta'


# In[8]:


df = pd.read_stata(fp)


# In[9]:


def trun_zips(z):
    s = str(int(z))
    if len(s) in {4, 8}:
        s = '0' + s
    return s[:5]


# In[10]:


df = df.dropna()


# In[12]:


df['contributor_zip'] = df['contributor_zip'].apply(trun_zips)


# In[13]:


df.columns


# In[16]:


zip_fp = '/Users/srhersco/Desktop/14.33 Paper/dataverse_files/DMA-zip.csv'


# In[17]:


zips = pd.read_csv(zip_fp)


# In[18]:


def to_str(x):
    s = str(x)
    if len(s) == 4:
        s = '0' + s
    return s
zips['ZIPCODE'] = zips['ZIPCODE'].apply(lambda x: to_str(x))


# In[19]:


dataframe = pd.merge(df, zips, how='left', left_on='contributor_zip', right_on='ZIPCODE')


# In[20]:


columns = ['committee_name','contribution_receipt_amount', 'DMA NAME']


# In[21]:


df_clean = dataframe[columns]


# In[22]:


df_count = df_clean.groupby(['committee_name','DMA NAME']).count().reset_index()
df_sum = df_clean.groupby(['committee_name','DMA NAME']).sum().reset_index()
df_by_dma = pd.merge(df_count, df_sum, how='left', on =['committee_name','DMA NAME'])


# In[28]:


set(df_by_dma.committee_name)


# In[30]:


df_bernie_2016 = df_by_dma[df_by_dma.committee_name == 'BERNIE 2016']


# In[31]:


df_clinton_2016 = df_by_dma[df_by_dma.committee_name == 'HILLARY FOR AMERICA']


# In[32]:


df_trump_2016 = df_by_dma[df_by_dma.committee_name == 'DONALD J. TRUMP FOR PRESIDENT, INC.']


# In[62]:


df_final = pd.merge(df_bernie_2016, df_trump_2016, how='left', on ='DMA NAME')


# In[63]:


columns = {
    'committee_name_x':'committee_name_x',
    'DMA NAME':'DMA NAME',
    'contribution_receipt_amount_x_x':'Bernie_Ind_Contributions_2016',
    'contribution_receipt_amount_y_x':'Biden_Total_Contributions_2016',
    'committee_name_y':'committee_name_y',
    'contribution_receipt_amount_x_y':'Trump_Ind_Contributions_2016',
    'contribution_receipt_amount_y_y':'Trump_Total_Contributions_2016',
}


# In[64]:


df_final = df_final.rename(columns=columns)


# In[66]:


keep_cols = ['DMA NAME', 'Bernie_Ind_Contributions_2016', 'Biden_Total_Contributions_2016',
             'Trump_Ind_Contributions_2016', 'Trump_Total_Contributions_2016']


# In[67]:


df_final = df_final[keep_cols]


# In[69]:


df_final = pd.merge(df_final, df_clinton_2016, how='left', on ='DMA NAME')


# In[71]:


columns = {
    'committee_name':'committee_name',
    'DMA NAME':'DMA NAME',
    'Bernie_Ind_Contributions_2016':'Bernie_Ind_Contributions_2016',
    'Biden_Total_Contributions_2016':'Bernie_Total_Contributions_2016',
    'Trump_Ind_Contributions_2016':'Trump_Ind_Contributions_2016',
    'Trump_Total_Contributions_2016':'Trump_Total_Contributions_2016',
    'contribution_receipt_amount_x':'Clinton_Ind_Contributions_2016',
    'contribution_receipt_amount_y': 'Clinton_Total_Contributions_2016'
}
df_final = df_final.rename(columns=columns)
df_final = df_final.drop(columns=['committee_name'])


# In[72]:


df_final.head(10)


# In[73]:


df_final.to_csv('/Users/srhersco/Desktop/14.33 Paper/2016ContributionsFinal.csv', index = False)


# In[ ]:




