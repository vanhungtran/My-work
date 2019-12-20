
# DATA EXPLORATION


# Ultra-sharp genetic group portrait of the Dutch
What genetic variation is to be found in the Dutch indigenous population? 
Detailed knowledge about this is not only interesting in itself, it also helps to extract useful biomedical information
from Dutch biobanks. 
The Dutch biobank collaboration BBMRI-NL has initiated the extensive Rainbow Project “Genome of the Netherlands” (GoNL) 
because it offers unique opportunities for science and for the development of new treatments and diagnostic techniques.
A close-up look at the DNA of 750 Dutch people-250 trio’s of two parents and an adult child-plus a global 
genetic profile of large numbers of Dutch will disclose a wealth of new information, new insights,
and possible applications.



```python
from IPython.display import Image
from IPython.core.display import HTML 
Image(url= "http://www.genoomvannederland.nl/wp-content/uploads/2012/11/GoNL_DataSources_Flowchart_04.png")
# Set up the cell
#For futher information, visit the website by clicking below
from IPython.core.display import display, HTML
display(HTML("""<a href="http://www.nlgenome.nl/">click here to visit website</a>"""))

```




<img src="http://www.genoomvannederland.nl/wp-content/uploads/2012/11/GoNL_DataSources_Flowchart_04.png"/>




<a href="http://www.nlgenome.nl/">click here to visit website</a>


<font color='blue'>**It should be noted that, in this analyse, I tried to use SQL in Python to manipulate the data (chromosome 22) instead of using MYSQL/PostgreSQL/SQLite separately**</font>

**Set up notebook cells : Display all outputs**



```python
from IPython.core.interactiveshell import InteractiveShell
InteractiveShell.ast_node_interactivity = "all"
```

### Import the required packages


```python
import os as os
import pandas as pd
import sqlite3
from pandasql import sqldf
```

### Set pathwork drive


```python

os.chdir("C:\\Users\\HP\\OneDrive\\BIOTRAN\\") 

```


Data file 'gonl.chr22.snps_indels.r5.vcf' was downloaded from "http://www.nlgenome.nl/"

We also could handle data with **Linux**
+ Print the first 30 lines of the file <br/>
zcat gonl.chr22.snps_indels.r5.vcf|head -30  <br/>
+ Print the last 30 lines of the file <br/>
zcat gonl.chr22.snps_indels.r5.vcf|tail -30  <br/>

+ check the size of file <br/>
wc gonl.chr22.snps_indels.r5.vcf.gz$ <br/>


12191 65240 3063654 gonl.chr22.snps_indels.r5.vcf.gz <br/>
The outputs:  12191   65240 3063654 <br/> <br/>
    in which 12191   = number of lines <br/>
              65240  = number of words <br/>
             3063654 = number of bytes <br/>
    
    





  
    

### Import data file 


```python
# Import pandas and check it current version
pd.__version__

colnames = ['CHROM','CHROM_POS',        'ID'       ,    'REF' ,'ALT' ,'QUAL', 'FILTER','Genotype section' ]

df = pd.read_csv('C:\\Users\\HP\\OneDrive\\BIOTRAN\\gonl.chr22.snps_indels.r5.vcf', #compression='gzip',
                         sep='\t', comment='#', low_memory=False, names = colnames,
                         header=None)
```




    '0.24.2'



**Print the first 100 lines of file <font color='blue'>gonl.chr22.snps_indels.r5.vcf**<font>




```python
df[1:100]
df.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CHROM</th>
      <th>CHROM_POS</th>
      <th>ID</th>
      <th>REF</th>
      <th>ALT</th>
      <th>QUAL</th>
      <th>FILTER</th>
      <th>Genotype section</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>22</td>
      <td>16050650</td>
      <td>.</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>2</th>
      <td>22</td>
      <td>16051065</td>
      <td>.</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>3</th>
      <td>22</td>
      <td>16051134</td>
      <td>.</td>
      <td>A</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>4</th>
      <td>22</td>
      <td>16051249</td>
      <td>rs62224609</td>
      <td>T</td>
      <td>C</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=85;AF=0.085;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>5</th>
      <td>22</td>
      <td>16051347</td>
      <td>rs62224610</td>
      <td>G</td>
      <td>C</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=332;AF=0.333;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>6</th>
      <td>22</td>
      <td>16051477</td>
      <td>rs192339082</td>
      <td>C</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=6;AF=6.012e-03;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>7</th>
      <td>22</td>
      <td>16051493</td>
      <td>.</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>8</th>
      <td>22</td>
      <td>16051497</td>
      <td>rs141578542</td>
      <td>A</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=354;AF=0.355;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>9</th>
      <td>22</td>
      <td>16051556</td>
      <td>.</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=11;AF=0.011;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>10</th>
      <td>22</td>
      <td>16052080</td>
      <td>rs4965031</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=99;AF=0.099;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>11</th>
      <td>22</td>
      <td>16052239</td>
      <td>rs6518413</td>
      <td>A</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=363;AF=0.364;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>12</th>
      <td>22</td>
      <td>16052250</td>
      <td>rs4965019</td>
      <td>A</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=40;AF=0.040;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>13</th>
      <td>22</td>
      <td>16052500</td>
      <td>.</td>
      <td>A</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>14</th>
      <td>22</td>
      <td>16052513</td>
      <td>rs149255970</td>
      <td>G</td>
      <td>C</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=323;AF=0.324;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>15</th>
      <td>22</td>
      <td>16052575</td>
      <td>.</td>
      <td>C</td>
      <td>G</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>16</th>
      <td>22</td>
      <td>16052618</td>
      <td>rs148015672</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=245;AF=0.245;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>17</th>
      <td>22</td>
      <td>16052684</td>
      <td>rs139918843</td>
      <td>A</td>
      <td>C</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=24;AF=0.024;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>18</th>
      <td>22</td>
      <td>16052715</td>
      <td>.</td>
      <td>A</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>19</th>
      <td>22</td>
      <td>16053001</td>
      <td>rs142324053</td>
      <td>A</td>
      <td>T</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=35;AF=0.035;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>20</th>
      <td>22</td>
      <td>16053249</td>
      <td>.</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=3;AF=3.006e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>21</th>
      <td>22</td>
      <td>16053326</td>
      <td>.</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>22</th>
      <td>22</td>
      <td>16053444</td>
      <td>rs80167676</td>
      <td>A</td>
      <td>T</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=84;AF=0.084;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>23</th>
      <td>22</td>
      <td>16053659</td>
      <td>rs141264943</td>
      <td>A</td>
      <td>C</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=333;AF=0.334;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>24</th>
      <td>22</td>
      <td>16053730</td>
      <td>rs117569664</td>
      <td>C</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=58;AF=0.058;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>25</th>
      <td>22</td>
      <td>16053758</td>
      <td>rs915677</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=61;AF=0.061;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>26</th>
      <td>22</td>
      <td>16053791</td>
      <td>rs11703994</td>
      <td>C</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=270;AF=0.271;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>27</th>
      <td>22</td>
      <td>16053862</td>
      <td>rs62224614</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=85;AF=0.085;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>28</th>
      <td>22</td>
      <td>16054667</td>
      <td>rs3013006</td>
      <td>C</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=246;AF=0.246;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>29</th>
      <td>22</td>
      <td>16054671</td>
      <td>rs188793777</td>
      <td>A</td>
      <td>T</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=3;AF=3.006e-03;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>30</th>
      <td>22</td>
      <td>16054679</td>
      <td>.</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>70</th>
      <td>22</td>
      <td>16060995</td>
      <td>rs2843244</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=10;AF=0.010;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>71</th>
      <td>22</td>
      <td>16061016</td>
      <td>rs9617528</td>
      <td>T</td>
      <td>C</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=269;AF=0.270;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>72</th>
      <td>22</td>
      <td>16061289</td>
      <td>.</td>
      <td>AC</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=3;AF=3.006e-03;AN=998;NUMALT=1;set=INDEL</td>
    </tr>
    <tr>
      <th>73</th>
      <td>22</td>
      <td>16061647</td>
      <td>rs150986859</td>
      <td>A</td>
      <td>T</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=255;AF=0.256;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>74</th>
      <td>22</td>
      <td>16061746</td>
      <td>.</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>75</th>
      <td>22</td>
      <td>16062270</td>
      <td>rs182063228</td>
      <td>G</td>
      <td>T</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=20;AF=0.020;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>76</th>
      <td>22</td>
      <td>16062394</td>
      <td>.</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>77</th>
      <td>22</td>
      <td>16063154</td>
      <td>rs79600304</td>
      <td>T</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=394;AF=0.395;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>78</th>
      <td>22</td>
      <td>16063369</td>
      <td>rs2844853</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=61;AF=0.061;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>79</th>
      <td>22</td>
      <td>16063753</td>
      <td>rs149906115</td>
      <td>A</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=24;AF=0.024;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>80</th>
      <td>22</td>
      <td>16065714</td>
      <td>rs117032860</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=64;AF=0.064;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>81</th>
      <td>22</td>
      <td>16067507</td>
      <td>.</td>
      <td>T</td>
      <td>C</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>82</th>
      <td>22</td>
      <td>16067555</td>
      <td>rs141208996</td>
      <td>A</td>
      <td>G</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=262;AF=0.263;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>83</th>
      <td>22</td>
      <td>16067736</td>
      <td>.</td>
      <td>G</td>
      <td>C</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>84</th>
      <td>22</td>
      <td>16069707</td>
      <td>rs1811028</td>
      <td>C</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=303;AF=0.304;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>85</th>
      <td>22</td>
      <td>16069771</td>
      <td>rs1811029</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=281;AF=0.282;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>86</th>
      <td>22</td>
      <td>16070003</td>
      <td>rs140813654</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=72;AF=0.072;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>87</th>
      <td>22</td>
      <td>16071990</td>
      <td>.</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>88</th>
      <td>22</td>
      <td>16072033</td>
      <td>rs78295774</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=304;AF=0.305;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>89</th>
      <td>22</td>
      <td>16078632</td>
      <td>.</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=2;AF=2.004e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>90</th>
      <td>22</td>
      <td>16078974</td>
      <td>rs188606948</td>
      <td>T</td>
      <td>A</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=510;AF=0.511;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>91</th>
      <td>22</td>
      <td>16079732</td>
      <td>rs2508061</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=41;AF=0.041;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>92</th>
      <td>22</td>
      <td>16079768</td>
      <td>rs3132732</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=10;AF=0.010;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>93</th>
      <td>22</td>
      <td>16079770</td>
      <td>rs7284370</td>
      <td>A</td>
      <td>G</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=2;AF=2.004e-03;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>94</th>
      <td>22</td>
      <td>16079795</td>
      <td>rs2508062</td>
      <td>T</td>
      <td>C</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=290;AF=0.291;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>95</th>
      <td>22</td>
      <td>16091784</td>
      <td>rs80167289</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=35;AF=0.035;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>96</th>
      <td>22</td>
      <td>16096650</td>
      <td>rs28739567</td>
      <td>C</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=6;AF=6.012e-03;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>97</th>
      <td>22</td>
      <td>16098016</td>
      <td>.</td>
      <td>G</td>
      <td>C</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=38;AF=0.038;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>98</th>
      <td>22</td>
      <td>16113000</td>
      <td>rs12106660</td>
      <td>C</td>
      <td>A</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=78;AF=0.078;AN=998;DB;set=SNP</td>
    </tr>
    <tr>
      <th>99</th>
      <td>22</td>
      <td>16113002</td>
      <td>rs2508077</td>
      <td>A</td>
      <td>C</td>
      <td>.</td>
      <td>Inaccessible</td>
      <td>AC=110;AF=0.110;AN=998;DB;set=SNP</td>
    </tr>
  </tbody>
</table>
<p>99 rows × 8 columns</p>
</div>






<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CHROM</th>
      <th>CHROM_POS</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>279493.0</td>
      <td>2.794930e+05</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>22.0</td>
      <td>3.475240e+07</td>
    </tr>
    <tr>
      <th>std</th>
      <td>0.0</td>
      <td>1.013783e+07</td>
    </tr>
    <tr>
      <th>min</th>
      <td>22.0</td>
      <td>1.605061e+07</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>22.0</td>
      <td>2.593938e+07</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>22.0</td>
      <td>3.486194e+07</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>22.0</td>
      <td>4.409734e+07</td>
    </tr>
    <tr>
      <th>max</th>
      <td>22.0</td>
      <td>5.124330e+07</td>
    </tr>
  </tbody>
</table>
</div>



**Number of variants* between two positions **m** and **n** (**m** <**n*) is given by 
df1 = pysqldf("SELECT * FROM df WHERE CHROM_POS > m AND  CHROM_POS < n  ;")

**number of variants** = df1.shape[0]


**For example, the number of variants between the positions 16079000 AND 16113000
        is calculated as the following:**


```python
df1 = pysqldf("SELECT * FROM df WHERE CHROM_POS > 16079000 AND  CHROM_POS < 16113000  ;")
# number of variants = 
df1.shape[0]
```




    7



**Thus, there are 7 variants between 2 given positions**

**In next step, we will remove all the variants with FILTER = 'inacessible'**


```python
from pandasql import sqldf
pysqldf = lambda q: sqldf(q, globals())
df2 = pysqldf("SELECT * FROM df WHERE FILTER != 'inacessible'  ;")
df2.shape
df2.head()
```




    (279493, 8)






<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CHROM</th>
      <th>CHROM_POS</th>
      <th>ID</th>
      <th>REF</th>
      <th>ALT</th>
      <th>QUAL</th>
      <th>FILTER</th>
      <th>Genotype section</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>22</td>
      <td>16050607</td>
      <td>.</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=3;AF=3.006e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>1</th>
      <td>22</td>
      <td>16050650</td>
      <td>.</td>
      <td>C</td>
      <td>T</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>2</th>
      <td>22</td>
      <td>16051065</td>
      <td>.</td>
      <td>G</td>
      <td>A</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>3</th>
      <td>22</td>
      <td>16051134</td>
      <td>.</td>
      <td>A</td>
      <td>G</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=1;AF=1.002e-03;AN=998;set=SNP</td>
    </tr>
    <tr>
      <th>4</th>
      <td>22</td>
      <td>16051249</td>
      <td>rs62224609</td>
      <td>T</td>
      <td>C</td>
      <td>.</td>
      <td>PASS</td>
      <td>AC=85;AF=0.085;AN=998;DB;set=SNP</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 279493 entries, 0 to 279492
    Data columns (total 8 columns):
    CHROM               279493 non-null int64
    CHROM_POS           279493 non-null int64
    ID                  279493 non-null object
    REF                 279493 non-null object
    ALT                 279493 non-null object
    QUAL                279493 non-null object
    FILTER              279493 non-null object
    Genotype section    279493 non-null object
    dtypes: int64(2), object(6)
    memory usage: 17.1+ MB
    

### OTHER OPERATION WITH SQL


```python
import sqlite3
connection = sqlite3.connect("NLGENOME.db")
```


```python
c = connection.cursor()
# Create table
c.execute('''CREATE TABLE NLGENOME1 ( 
CHROM INTEGER,
CHROM_POS INTEGER, 
ID VARCHAR, 
REF VARCHAR, 
ALT VARCHAR, 
QUAL VARCHAR,
FILTER VARCHAR, 
GENOTYPE_SECTION VARCHAR)''')
#######CHROM_POS INTEGER PRIMARY KEY, 
# Insert a row of data
c.execute('INSERT INTO NLGENOME VALUES(22, 27000, "Shakespeare", "m", "1961-10-25","aaaa","ddd","GA")')

# Save (commit) the changes
connection.commit()

# We can also close the connection if we are done with it.
# Just be sure any changes have been committed or they will be lost.
connection.close()
```




    <sqlite3.Cursor at 0x1db0b0418f0>






    <sqlite3.Cursor at 0x1db0b0418f0>




```python
import sqlite3
connection = sqlite3.connect("NLGENOME1.db")

#sqlite> .schema genomes
#CREATE TABLE genomes(
###  "Chrom" INTERGER,
##  "Chrom_position" INTERGER
#);



cursor = connection.cursor()

# delete 
#cursor.execute("""DROP TABLE employee;""")

sql_command = """
CREATE TABLE NLGENOME ( 
CHROM INTEGER,
CHROM_POS INTEGER PRIMARY KEY, 
ID VARCHAR, 
REF VARCHAR, 
ALT VARCHAR, 
QUAL VARCHAR,
FILTER VARCHAR, 
Genotype_section VARCHAR);"""

cursor.execute(sql_command)

sql_command = """INSERT INTO NLGENOME (CHROM, CHROM_POS, ID, REF, ALT, QUAL, FILTER, Genotype_section)
    VALUES (22, 190000, "Shakespeare", "m", "1961-10-25","aaaa","ddd","GA");"""
cursor.execute(sql_command)

connection.commit()

connection.close()

```




    <sqlite3.Cursor at 0x1db0b0416c0>






    <sqlite3.Cursor at 0x1db0b0416c0>




```python
import pandas as pd
import io
import requests
url="https://molgenis26.target.rug.nl/downloads/gonl_public/variants/release5/"
s=requests.get(url).content
c=pd.read_csv(io.StringIO(s.decode('utf-8')))
```


```python
import sqlite3 as db

DB = db.connect('NLGENOME.db')

df.to_sql(name='Orders', con=DB, if_exists='replace')
#replace is one of three options available for the if_exists parameter
DB.close()
```

    C:\Users\HP\AppData\Local\Continuum\anaconda3\lib\site-packages\pandas\core\generic.py:2531: UserWarning: The spaces in these column names will not be changed. In pandas versions < 0.14, spaces were converted to underscores.
      dtype=dtype, method=method)
    


```python

```


```python
pwd()
```




    'C:\\Users\\HP'




```python
import urllib.request as urllib2
url="https://molgenis26.target.rug.nl/downloads/gonl_public/variants/release5/"
response = urllib2.urlopen(url)
html = response.read()
```


```python
html[3000:4000]
```




    b'></tr><tr><td class="fb-i"><img src="/_h5ai/public/images/fallback/file.png" alt="file"/></td><td class="fb-n"><a href="/downloads/gonl_public/variants/release5/gonl.chr10.snps_indels.r5.vcf.gz">gonl.chr10.snps_indels.r5.vcf.gz</a></td><td class="fb-d">2019-10-15 07:28</td><td class="fb-s">10936 KB</td></tr><tr><td class="fb-i"><img src="/_h5ai/public/images/fallback/file.png" alt="file"/></td><td class="fb-n"><a href="/downloads/gonl_public/variants/release5/gonl.chr10.snps_indels.r5.vcf.gz.md5">gonl.chr10.snps_indels.r5.vcf.gz.md5</a></td><td class="fb-d">2019-10-15 07:28</td><td class="fb-s">0 KB</td></tr><tr><td class="fb-i"><img src="/_h5ai/public/images/fallback/file.png" alt="file"/></td><td class="fb-n"><a href="/downloads/gonl_public/variants/release5/gonl.chr10.snps_indels.r5.vcf.gz.tbi">gonl.chr10.snps_indels.r5.vcf.gz.tbi</a></td><td class="fb-d">2019-10-15 07:28</td><td class="fb-s">77 KB</td></tr><tr><td class="fb-i"><img src="/_h5ai/public/images/fallback/file.png" alt="'




```python
import requests
chromosome = 22
#gonl.chr10.snps_indels.r5.vcf.gz.md5
url1 = "https://molgenis26.target.rug.nl/downloads/gonl_public/variants/release5/gonl.chr{}.snps_indels.r5.vcf.gz"
#url = "http://nppes.viva-it.com/NPPES_Data_Dissemination_{}_{}.zip"
r = requests.get(url1.format(chromosome))
#r.text
```


```python
r
```




    <Response [200]>


