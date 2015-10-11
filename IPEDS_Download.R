#Purpose: Dowloand/Extract/Merge/Transform IPEDS Datasets 
#Data Source: IPEDS Data Center http://nces.ed.gov/ipeds/datacenter/DataFiles.aspx
#Years 1980 to date
#Not all years of interest
#Goal: Single IPEDS dataset for Knitr project
#Start date: 3/10/15
#End date:
#Time in development: 3.5hr
#Development progression:
#1) Functioning download and extraction of webfile 1hr (3/10/15)
#Outstanding process flow:
#Overall process
#1) Determine short list of variables of interest (3/10/15)
#a) Total tuition by student class (FTIC, others?)
#b) Total fees by student class
#c) Intstitutional grant aid Institutional, athletic, employee remission if applicable
#d) College navigator type data
#1) Demographics
#2) Financial aid
#3) Retention and graduation rates
#4) Default rates
#5) Net price by income
#2) Comparison grou
# a) Peer 11
# b) NW competitors
# c) Carnegie classification
# d) Althletic conference
# e) AJCU members
# f) ICW members
#Datafiles
#1) Functioning mock up of download/extract url datafiles (3/10/15)
#2) Directory of IPEDS excel file (3/10/15)
#3) Process to dynamically update file names download/extract 2.5hr (3/13/15)
#UPDATE  (3/11/15): Cannot access directory file on IPEDS to use RCurl package
#4) Transform by file 
#Dynamic file by year (knitr)

#List of variables to get
#1) Directory information
# UNITID
# INSTNM
# OBEREG
# WEBADDR
# SECTOR
# ICLEVEL
# CONTROL
# INSTCAT
# CCBASIC --Carnegie Classification 2010 Update



##Download all then extract then stack
#Website path

IPEDSFD <- read.csv("~/WorkingDirectory/IPEDSFileDirectory.csv")
#Excel file with IPEDS file directory

IPEDSFD_Current <-subset(IPEDSFD, IPEDSFD$Year >=2000) 
#View(IPEDSFD_Current)

# IC2013 <-subset(IPEDSFD, Year == '2013'
#                   & IPEDSFD$Survey == 'Institutional Characteristics')


#DirInfo <-subset(IPEDSFD, IPEDSFD$Survey == 'Enrollments')

DirInfo <-subset(IPEDSFD, IPEDSFD$Survey == 'Institutional Characteristics') 
DirInfo <-subset(DirInfo, IPEDSFD$Completed == 0) 
DirInfo <-DirInfo[complete.cases(DirInfo),]#Remove NA lines
View(DirInfo)
URL <- c(paste("http://nces.ed.gov/ipeds/datacenter/data/",DirInfo$Data.File,".zip",sep=''))
URL
#options(timeout = 6000)

#For future development: Scrape a table from the website. If changed download new files

url_test <- function(URL) {
  
  require(rgdal)
  
  wd <- getwd()
  td <- tempdir()
  setwd(td)
  options(timeout = 6000)
  temp <- tempfile(fileext = ".zip")
  download.file(URL, temp) #,quiet = TRUE --Surpresses download popups
  ##
  # get the name of the first file in the zip archive
  #fname = unzip(temp, list=TRUE)$Name[1]
  # unzip the file to the temporary directory
  #unzip(temp, files=fname, exdir=td, overwrite=TRUE)
  # fpath is the full path to the extracted file
  #fpath = file.path(td, fname)
  
}

#http://nces.ed.gov/ipeds/datacenter/data/EF2009A.zip where it failed
y <- lapply(URL, url_test)

getwd()
z <- unlist(unlist(y))
