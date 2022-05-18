%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Personal Project - Hate Crime statistics
% 
% Create graphs showing change in hate crime groups by ideology
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
addpath(genpath('C:\Users\Dani\Documents\Hate-Crimes-Data-US\Windows_API'));
addpath(genpath('C:\Users\Dani\Documents\Hate-Crimes-Data-US\hatchfill2_r8'));
addpath(genpath('C:\Users\Dani\Documents\Hate-Crimes-Data-US\legendflex-pkg-master'));
addpath('C:\Users\Dani\Documents\Hate-Crimes-Data-US\linspecer');

%% Load in data

% get number of unique ideologies

% initialize black separatist org array
black_se_org = [];

for i = 0:21
    import_opts = detectImportOptions(append('C:\Users\Dani\Documents\Hate-Crimes-Data-US\SPLC_Data\splc-hate-groups-',num2str(2000+i),'.csv'));
    current_data = readtable(append('C:\Users\Dani\Documents\Hate-Crimes-Data-US\SPLC_Data\splc-hate-groups-',num2str(2000+i),'.csv'),import_opts);
    
    ideol_temp = table2cell(current_data(:,5));
    org_temp = table2cell(current_data(:,1));
    
    for j = 1:size(table2cell(current_data(:,5)),1)
        if i == 0
            ideol{j,1} = ideol_temp{j};
        else
            ideol{end+1,1} = ideol_temp{j};
        end
    end

    for j = 1:size(table2cell(current_data(:,1)),1)
        if (i == 0)&&(strcmp("",ideol_temp{j}))
            if isempty(black_se_org)
                black_se_org{1,1} = org_temp{j};
            end
            black_se_org{end+1,1} = org_temp{j};
        elseif (strcmp("",ideol_temp{j}))
            black_se_org{end+1,1} = org_temp{j};
        end
    end
end

% get unique ideologies
ideol_unique = unique(unique(ideol));

% get unique black separatist orgs
org_unique = unique(unique(black_se_org));

% initialize ideology tracking array
ideol_array_time = zeros(size(ideol_unique,1),22);

for i = 0:21
    import_opts = detectImportOptions(append('C:\Users\Dani\Documents\Hate-Crimes-Data-US\SPLC_Data\splc-hate-groups-',num2str(2000+i),'.csv'));
    current_data = readtable(append('C:\Users\Dani\Documents\Hate-Crimes-Data-US\SPLC_Data\splc-hate-groups-',num2str(2000+i),'.csv'),import_opts);
    
    org_temp = table2cell(current_data(:,1));
    ideol_temp = table2cell(current_data(:,5));
    
    for j = 1:size(table2cell(current_data(:,5)),1)
        for k = 1:size(ideol_unique,1)
            if strcmp(ideol_unique{k},ideol_temp(j))&&~(sum(strcmp(org_unique,org_temp{j})))&&(k~=1)
                ideol_array_time(k,i+1) = ideol_array_time(k,i+1)+1;
            end
        end
        if (sum(strcmp(org_unique,org_temp{j})))
            ideol_array_time(1,i+1) = ideol_array_time(1,i+1)+1;
        end
    end
end

%% Data analysis

% years over which data is relevant
years = 2000:2021;

% relabel black separatist ideologies
ideol_unique(1) = {'Black separatist'};

% hate group break down by year
hate_groups_anno = sum(ideol_array_time,1);

% total number of hate groups in each category (allowing for mulitples)
[~,hate_groups_sort] = sort(sum(ideol_array_time,2));

% sort ideology array by year by size of movement
ideol_array_time = ideol_array_time(hate_groups_sort,:);
ideol_unique = ideol_unique(hate_groups_sort);

% split data for readability

% initialize new array
ideol_array_time_1 = ideol_array_time;

% sum over 'other' sections
ideol_array_time_1(9,:) = sum(ideol_array_time(1:9,:),1);

% delete summed over rows
ideol_array_time_1(1:8,:)=[];
ideol_unique_1 = ideol_unique;
ideol_unique_1(9) = {'Other'};
ideol_unique_1(1:8) = [];

% choose data outright from old array
ideol_array_time_2 = ideol_array_time(1:9,:);
ideol_unique_2 = ideol_unique(1:9);


%% plot data

%% tiled layout showing trends for each ideology

% create figure handle
fig0 = figure;

% initialize tiled layout
tiledlayout(4,5)

% loop through all ideologies
for i = 17:-1:1
    % start next tiles
    nexttile
    
    % plot
    plot(years,ideol_array_time(i,:)')
    
    % control plot limits
    xlim([years(1) years(end)])
    ylim([0 1.2*max(ideol_array_time(i,:))])
    
    % labeling
    xlabel('year')
    ylabel('number of hate groups')
    t = title(sprintf('Number of groups with %saffiliation/ideology',ideol_unique{i}));
    t.FontSize = 9;
end

% make figure fullsize
WindowAPI(fig0,'Maximize');

%% first group + others

% create figure handle
fig1 = figure;

% order color according to Cynthia Brewer's research
colororder(linspecer(9,'sequential'));

% area plot
ar1 = area(years,ideol_array_time_1');

% reorder 
for i = 9:-1:1
    uistack(ar1(i),'top');
end

% create legend
legend(ar1,ideol_unique_1,'Location','Northwest');

% labeling and scaling
xlim([years(1) years(end)])
xlabel('years')
ylabel('number of hate groups')
title('Number of hate groups in the US (Group 1) according to the SPLC')

% make figure fullsize
WindowAPI(fig1,'Maximize');

%% second group w/o others

% create second figure handle
fig2 = figure;

% order color according to Cynthia Brewer's research
colororder(linspecer(9,'sequential'));

% create area plot
ar2 = area(years,ideol_array_time_2');

% reorder
for i = 9:-1:1
    uistack(ar2(i),'top');
end

% create legend
legend(ar2,ideol_unique_2,'Location','Northwest');

% labeling and scaling
xlim([years(1) years(end)])
xlabel('years')
ylabel('number of hate groups')
title('Number of hate groups in the US (Group 2) according to the SPLC')

% make figure fullsize
WindowAPI(fig2,'Maximize');

%% normalized first group + others

% create figure handle
fig3 = figure;

% order color according to Cynthia Brewer's research
colororder(linspecer(9,'sequential'));

% normalize dataset
ideol_array_time_1 = bsxfun(@rdivide, ideol_array_time_1, sum(ideol_array_time_1,1));

% area plot
ar3 = area(years,ideol_array_time_1');

% reorder 
for i = 9:-1:1
    uistack(ar3(i),'top');
end

% create legend
legend(ar3,ideol_unique_1,'Location','Southwest');

% labeling and scaling
xlim([years(1) years(end)])
ylim([0 1])
xlabel('years')
ylabel('number of hate groups')
title('Number of hate groups in the US (Group 1) according to the SPLC')

% make figure fullsize
WindowAPI(fig3,'Maximize');

%% normalized second group w/o others

% create second figure handle
fig4 = figure;

% order color according to Cynthia Brewer's research
colororder(linspecer(9,'sequential'));

% normalize dataset
ideol_array_time_2 = bsxfun(@rdivide, ideol_array_time_2, sum(ideol_array_time_2,1));

% create area plot
ar4 = area(years,ideol_array_time_2');

% reorder
for i = 9:-1:1
    uistack(ar4(i),'top');
end

% create legend
legend(ar4,ideol_unique_2,'Location','Southwest');

% labeling and scaling
xlim([years(1) years(end)])
ylim([0 1]);
xlabel('years')
ylabel('number of hate groups')
title('Number of hate groups in the US (Group 2) according to the SPLC')

% make figure fullsize
WindowAPI(fig4,'Maximize');