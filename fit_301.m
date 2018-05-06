clear
clc

fit301=csvread('FIT301_6days_dec2015.csv');

plot(fit301)

mn=mean(fit301(133800:135000))

var=var(fit301(133800:135000))