# Quiz 1 - Gwen

# read data into R
insects = read.csv(file = "insects.csv", sep=",")

# check the class of the object, its structure, number of rows, etc
class(insects)
str(insects)
nrow(insects)

# R names the rows by number, sometimes this is annoying
rownames(insects)
# The column names are...
colnames(insects)

# I am going to assume that each row is an agricultural plot
colnames(insects)[1] = "AgrPlot"

# print the first 6 rows of the data.frame to see what it looks like
head(insects)

# make the file to which the plot will be saved
pdf(file = "quiz1_boxplot.pdf", useDingbats = FALSE)

# make a box plot (without the argicultural plot column)
boxplot(insects[, -1], ylab="Insects Remaining after Treatment of Insecticide", xlab = "Insecticide", main="Quiz 1: Insecticide Example")

# close the device making the file
dev.off()


