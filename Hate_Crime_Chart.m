%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Personal Project - Hate Crime statistics
% 
% Create graphs showing rates of hate crimes in the US over time
%
% Author: Dani Agramonte
% Last Updated: 05.18.222
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialize MATLAB
clear; % Clear variables
clc;  % Clear command window.
workspace;  % Make sure the workspace panel is showing.

% adds Windows API function to MATLAB path
addpath(genpath('C:\Users\Dani\Documents\Hate-Crimes-Data-US\Windows_API'))

%% Data

% Hate crime data from FBI statistics
Hate_Crime_Data = [...
    3263	913	    405	    0	0	0	8;... % 1991
    4725	1165	771	    0	0	0	1;... % 1992
    5441	1296	860	    0	0	0	7;... % 1993
    4197	1068	686	    0	0	0	2;... % 1994
    5644	1276	1019	0	0	0	6;... % 1995
    6331	1426	1015	0	0	0	6;... % 1996
    5583	1388	1108	13	0	0	4;... % 1997
    5170	1396	1292	26	0	0	5;... % 1998
    5176	1418	1323	17	0	0	6;... % 1999
    5350	1492	1331	38	0	0	6;... % 2000
    6424	1858	1403	37	0	0   9;... % 2001
    4761	1425	1246	49	0	0	3;... % 2002
    4897	1342	1250	46	0	0	4;... % 2003
    5049	1383	1190	55	0	0	7;... % 2004
    4936	1340	1076	56	0	0	3;... % 2005
    4973	1459	1198	83	0	0	2;... % 2006
    4888	1396	1277	59	0	0	3;... % 2007
    5055	1552	1336	93	0	0	3;... % 2008
    3988	1298	1227	94	0	0	6;... % 2009
    3984	1322	1279	44	0	0	4;... % 2010
    3685	1235	1306	64	0	0	9;... % 2011
    3853	1318	1297	110	2	4	7;... % 2012
    3582	1048	1264	93	20	31	6;... % 2013
    3279	1031	1042	95	34	101	17;... % 2014
    3330	1252	1066	76	24	114	9;... % 2015 
    3556	1297	1108	101	28	126	60;... % 2016
    4157	1588	1143	152	75	121	85;... % 2017
    4002	1411	1216	159	61	167	75;... % 2018
    3954	1536	1191	144	67	189	206;... % 2019
    5227	1244	1110	130	75	266	211]; % 2020

% years
years = 1991:2020;

%% Figure 1

% make new figure
fig1 = figure;

% make figure fullsize
WindowAPI(fig1,'Maximize');

% plot line area graph
area(years,Hate_Crime_Data);

% xline labels with important times
label = {'9/11','Trump Wins','BLM Protests'};
xline([2001 2017 2020],'--',label,'LabelHorizontalAlignment','left');

% turn on grid
grid on
% summer colormap
colormap summer
set(gca,'Layer','top')
title('Hate crime data 1991-2022')
xlim([years(1) years(end)])
lgd = legend('Race/Ethnicity/Ancestry','Religion','Sexual Oreintation','Disability','Gender','Gender Identity','location','northwest');
lgd.FontSize = 8;
xlabel('Year')
ylabel('Number of Crimes')

%% Figure 2

% make new figure
fig2 = figure;

% make figure fullsize
WindowAPI(fig2,'Maximize');

for i = 1:3
    plot(years,Hate_Crime_Data(:,i))
    hold on
end

% xline labels with important times
label = {'9/11','Trump Wins','BLM Protests'};
xline([2001 2017 2020],'--',label,'LabelHorizontalAlignment','left');

% turn on grid
grid on
% summer colormap
colormap summer
set(gca,'Layer','top')
title('Hate crime data 1991-2022')
xlim([years(1) years(end)])
lgd = legend('Race/Ethnicity/Ancestry','Religion','Sexual Oreintation','Multiple','location','northwest');
lgd.FontSize = 8;
xlabel('Year')
ylabel('Number of Crimes')

%% Figure 3

% make new figure
fig3 = figure;

% make figure fullsize
WindowAPI(fig3,'Maximize');

for i = 4:7
    plot(years,Hate_Crime_Data(:,i))
    hold on
end

% xline labels with important times
label = {'9/11','Trump Wins','BLM Protests'};
xline([2001 2017 2020],'--',label,'LabelHorizontalAlignment','left');

% turn on grid
grid on
% summer colormap
colormap summer
set(gca,'Layer','top')
title('Hate crime data 1991-2022')
xlim([years(1) years(end)])
lgd = legend('Disability','Gender','Gender Identity','Multiple','location','northwest');
lgd.FontSize = 8;
xlabel('Year')
ylabel('Number of Crimes')