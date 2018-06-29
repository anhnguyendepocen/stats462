import matplotlib.pyplot as plt
import pandas as pd

fname = "insects.csv"

# There are tons of options to read_csv... too many really. I've used pandas
# because it reads into "DataFrames", which seem to be similar to R, but there
# are tons of ways to read csvs in python.
data = pd.read_csv("insects.csv","r",header=0,index_col=0,delimiter=",")

# By default, "plot" will plot each column and label it as such.
# I don't normally use the plotting functions that are accessible through the
# data frame objects because it's harder to customize. But if you're just
# to get something on the screen, this works.
ax = data.plot()
ax.set_ylabel("Number Left")
ax.set_xlabel("Time")
fig = ax.get_figure()
fig.savefig('insects_python.png')

# Could also do:
#plt.plot(data.index,data.values,label=data.columns)
#plt.xlabel("Time")
#plt.ylabel("Number Left")
#plt.legend()
#plt.savefig("insects_python.png")

# My preferred method - slightly more code, but finer control of plotting. No
# benefits of this until you start to do non-standard plotting
#fig = plt.figure()
# "(111)" is (n_cols, n_rows, which one you're currently on)
#ax = fig.add_subplot(1,1,1)
#ax.plot(data.index, data.values, label=data.columns)
#ax.set_ylabel("Number Left")
#ax.set_xlabel("Time")
#ax.legend(data.columns)
#fig.savefig("insects_python.png")
