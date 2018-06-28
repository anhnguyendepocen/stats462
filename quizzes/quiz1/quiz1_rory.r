
# This seems to default to good values. The index column gets labeled as "X"
insects <- read.csv("insects.csv")

print(insects)

# I explored this file in the R command line
png(file = "quiz1_r.png")

# This is gross. There must be a better way.
# columns: A-F
plot(insects[,"X"], insects[,"A"], col = "blue", type="l", xlab="Time", ylab="Insects Remaining", ylim=c(min(insects[,-1]), max(insects[,-1])))
lines(insects[,"X"], insects[,"B"], col = "red")
lines(insects[,"X"], insects[,"C"], col = "black")
lines(insects[,"X"], insects[,"D"], col = "green")
lines(insects[,"X"], insects[,"E"], col = "yellow")
lines(insects[,"X"], insects[,"F"], col = "orange")

# Legend doesn't work and I'm losing patience.
#legend()

dev.off()
