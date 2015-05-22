## CodeBook

## The Tidy Dataset
```
##    subject activity domain    instrument acceleration jerk magnitude axis
## 1        1   LAYING   Freq Accelerometer         Body <NA>      <NA>    X
## 2        1   LAYING   Freq Accelerometer         Body <NA>      <NA>    X
## 3        1   LAYING   Freq Accelerometer         Body <NA>      <NA>    Y
## 4        1   LAYING   Freq Accelerometer         Body <NA>      <NA>    Y
## 5        1   LAYING   Freq Accelerometer         Body <NA>      <NA>    Z
## 6        1   LAYING   Freq Accelerometer         Body <NA>      <NA>    Z
##            statistics number_of_measurement average
## 1                Mean                    50 -0.9391
## 2  Standard Deviation                    50 -0.9244
## 3                Mean                    50 -0.8671
## 4  Standard Deviation                    50 -0.8336
## 5                Mean                    50 -0.8827
## 6  Standard Deviation                    50 -0.8129
```

## The Variables
```
Variables  | Description | Value
------------- | ------------- | -------------
subject  | subjects | 1 - 30
activity  | activity names | LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
domain | signal obtained in time/frequency domain | Freq, Time
instrument | signal obtained from accelerometer/gyroscope | Accelerometer, Gyroscope
acceleration | gravitational/body motion signal | Body, Gravity
jerk | jerk signal indication | NA, Jerk
magnitude | magnitude indication | NA, Magnitude
axis | which of the 3-axial measured | X, Y, Z, NA
statistics | mean or standard deviation calculated | Mean, Standard Deviation
measurements | count of data points used to calculate each average | see below
average | mean of each feature for each subject and each activity | see below
```

## Data Structure
```
Classes ‘data.table’ and 'data.frame':	11880 obs. of  11 variables:
 $ subject     : int  1 1 1 1 1 1 1 1 1 1 ...
 $ activity    : chr  "LAYING" "LAYING" "LAYING" "LAYING" ...
 $ domain      : chr  "Freq" "Freq" "Freq" "Freq" ...
 $ instrument  : chr  "Accelerometer" "Accelerometer" "Accelerometer" "Accelerometer" ...
 $ acceleration: chr  "Body" "Body" "Body" "Body" ...
 $ jerk        : chr  NA NA NA NA ...
 $ magnitude   : chr  NA NA NA NA ...
 $ axis        : chr  "X" "X" "Y" "Y" ...
 $ statistics  : chr  "Mean" "Standard Deviation" "Mean" "Standard Deviation" ...
 $ measurements: int  50 50 50 50 50 50 50 50 50 50 ...
 $ average     : num  -0.939 -0.924 -0.867 -0.834 -0.883 ...
 - attr(*, "sorted")= chr  "subject" "activity" "domain" "instrument" ...
 - attr(*, ".internal.selfref")=<externalptr> 
```
