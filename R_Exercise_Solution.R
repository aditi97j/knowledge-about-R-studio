


av <- read.csv('C:\\Users\\Dell\\Downloads\\R_Programming\\ggplot\\avocado.csv')

View(av)
dim(av)
colnames(av)

str(av)

av$Date <- as.Date(av$Date)

a1 <- av%>%
  filter(region=="SanFrancisco" & type=="conventional" &
           Date>='2015-01-01' & Date<="2015-06-01")
table(a1$region)
table(a1$type)


# Q2) Plot Line Chart for avocado data for Date vs Total Volume 
# for SanFransisco Region where type is conventional
# between Jan1, 2015 and Jun1, 2015

a1 <- av%>%filter(region == "SanFrancisco" & type == "conventional" & 
                    Date >= "2015-01-01" & Date <= "2015-06-01")
dim(a1) # rows=22 cols=14

# Method - 1
ggplot(a1, aes(x=Date, y=Total.Volume)) +
  geom_line(size = 2, color='brown') +
  geom_point(size=3,color='blue')

# Method - 2

str(a1)
r1 <- a1%>%
  ggplot(aes(x=Date, y=Total.Volume)) +
  geom_line(size = 2, color='orange') +
  geom_point(size=3) + ggtitle('Total Volume vs Date')
r1

# Q3) Evaluate Region wise Mean of SmallBags. Plot the result on Bar Chart
# using Barplot and using ggplot
colnames(av)

a2 <- av%>%group_by(region)%>%summarise(Avg_SB = mean(Small.Bags))
a2

View(a2)
class(a2)

barplot(a2$Avg_SB,names.arg=a2$region,xlab='Region',
        ylab='Avg_Small Bags',col='blue')  # rotation
legend('topleft','Sales',fill='blue')

help(barplot)

barplot(a2$Avg_SB,names.arg=a2$region,xlab='Region',
        ylab='Avg_Small Bags',col='blue',las=2)  # rotation
legend('topleft','Sales',fill='blue')

# cex.lab=1,cex.lab=1, cex.axis=1,
# ggplot(a2, aes(x=region, y=Avg_SB )) 
# + geom_bar(stat='identity') + coord_flip()

ggplot(a2, aes(x=region, y=Avg_SB )) +
  geom_bar(stat="identity", color="blue") +
  theme(axis.text.x = element_text(angle = 90))

# 4) Create month and Quarter based on date in Avocado data

help(strftime)
av$Month = strftime(av$Date, format="%b")
av$Qtr = quarters(av$Date)

View(av)

colnames(av)
View(av)


# Q5) Compute Quarter mean of Total bags for the year 2015 and 2016.
# Arrange result in descending order of mean of Total bags

a5 <- av %>% 
      filter(year %in% c(2015,2016)) %>%
      group_by(Qtr)%>%
      summarise(MeanTotal_Bags = mean(Total.Bags))%>%
      arrange(desc(MeanTotal_Bags))
a5

# r1 <- av %>% filter(year %in% c(2015,2016,2017))
# table(r1$year)

# Q6)  Scatter chart between Total bags and Small bags for the year 2017.
# Color the result based on type. Use ggplot

table(av$type) # conventional organic

a6 <- av%>% filter(year==2017)
table(a6$year)

ggplot(a6, aes(x=Total.Bags, y=Small.Bags,color=type)) + 
  geom_point()
      
# Q7) Plot Percentage distribution of different Regions on a Pie Chart
# between 2017 Mar to 2017 Apr for where the Average Price is more than
# 2.5

a7 <-  av%>%
filter(Date >= "2017-03-01" & Date <= "2017-04-30" & AveragePrice>2.5)
dim(a7)  # rows = 22, col= 16

table(a7$region)

t1 <- data.frame(table(a7$region))
t1

colnames(t1) <- c('Region','Count')
t1

pie(t1$Count,labels=t1$Region)
pie(t1[,2],labels=t1[,1])

pie_lab <- paste0(t1[,1],": ",round(100*t1[,2]/sum(t1[,2]),2),"%")
pie(t1$Count,labels=pie_lab)


#ggplot(a7, aes(x="", y=region, fill=name)) +
#  geom_bar(stat="identity", width=1) +
#  coord_polar("y", start=0)


# Q8) Plot boxplot for Large Bags for the Quarter 3 for the regions - 
# Atlanta,Detroit, Orlando and Tampa. Fill color should be month

a8 <- av%>%
filter(Qtr=='Q3' & region %in% c('Atlanta','Detroit', 'Orlando','Tampa'))

table(a8$region)
table(a8$Qtr)

ggplot(a8, aes(x=region, y=Large.Bags,color=region)) +
  geom_boxplot()

ggplot(a8, aes(x=region, y=Large.Bags,color=region,fill=Month)) +
  geom_boxplot()


# Q9) Plot Histogram for Small Bags for the month Mar, Apr and May 
# where the type is Conventional

a9 <- av%>%
      filter(Month %in% c('Mar','Apr','May') & type=='conventional')
table(a9$Month)
View(a9)

help(geom_histogram)

ggplot(a9,aes(x=Small.Bags)) +  
  geom_histogram(binwidth=30,fill='orange')
    


  

# table(a5$year)





