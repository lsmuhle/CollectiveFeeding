%% reset
clear;
filesuffix = 'ZeroLeavingLowerFeedingRate';
relativeFeedingRate = 0.4
%% calculate means of needed time until 90 % of food is eaten for social and asocial worms and plot results

% load data and save variables
load(['L35N40patch1Npr1' filesuffix '.mat'])
timeNpr1patch1 = time90percentEatenNpr1;
FUsNpr1patch1 = FUsEatenNpr1;
allStepsNpr1patch1 = allStepsNpr1;

load(['L35N40patch2Npr1' filesuffix '.mat'])
timeNpr1patch2 = time90percentEatenNpr1;
FUsNpr1patch2 = FUsEatenNpr1;
allStepsNpr1patch2 = allStepsNpr1;

load(['L35N40patch4Npr1' filesuffix '.mat'])
timeNpr1patch4 = time90percentEatenNpr1;
FUsNpr1patch4 = FUsEatenNpr1;
allStepsNpr1patch4 = allStepsNpr1;

load(['L35N40patch1N2' filesuffix '.mat'])
timeN2patch1 = time90percentEatenN2;
FUsN2patch1 = FUsEatenN2;
allStepsN2patch1 = allStepsN2;

load(['L35N40patch2N2' filesuffix '.mat'])
timeN2patch2 = time90percentEatenN2;
FUsN2patch2 = FUsEatenN2;
allStepsN2patch2 = allStepsN2;

load(['L35N40patch4N2' filesuffix '.mat'])
timeN2patch4 = time90percentEatenN2;
FUsN2patch4 = FUsEatenN2;
allStepsN2patch4 = allStepsN2;


% calculate means and standard deviations
deltaT = 10; % set delta T at 10s (moving 2 lattice spacings of 1mm at 200mu/s in one time step)
meansTimeNpr1(1) = mean(timeNpr1patch1)*deltaT;
meansTimeNpr1(2) = mean(timeNpr1patch2)*deltaT;
meansTimeNpr1(3) = mean(timeNpr1patch4)*deltaT;

stdTimeNpr1(1) = std(timeNpr1patch1)*deltaT;
stdTimeNpr1(2) = std(timeNpr1patch2)*deltaT;
stdTimeNpr1(3) = std(timeNpr1patch4)*deltaT;

meansTimeN2(1) = mean(timeN2patch1)*deltaT;
meansTimeN2(2) = mean(timeN2patch2)*deltaT;
meansTimeN2(3) = mean(timeN2patch4)*deltaT;

stdTimeN2(1) = std(timeN2patch1)*deltaT;
stdTimeN2(2) = std(timeN2patch2)*deltaT;
stdTimeN2(3) = std(timeN2patch4)*deltaT;

% plot means with error bars of 1 SD
figure('pos',[0 0 1240 960]/2);
x = 0:2;
eNpr1 = errorbar(x,meansTimeNpr1,stdTimeNpr1,'--ob');
hold on
eN2 = errorbar(x,meansTimeN2,stdTimeN2,'--or');
eNpr1.LineWidth = 6/2;
eNpr1.MarkerSize = 15/2;
eNpr1.MarkerFaceColor = 'b';
eNpr1.CapSize = 25/2;
eN2.LineWidth = 6/2;
eN2.MarkerSize = 15/2;
eN2.MarkerFaceColor = 'r';
eN2.CapSize = 25/2; 
[lgd,objects] = legend('npr-1','N2');
set(findobj(objects,'-property','MarkerSize'),'MarkerSize',15/2)
set(findobj(objects,'-property','FontSize'),'FontSize',34/2)
set(lgd,'FontSize',40/2)
lgd.Position = [0.67 0.775 0.23 0.125];
xticks(x)
xticklabels({'1','2','4'})
axis([0 2 0 2e4])
set(gca,'FontSize',42/2)
ax = gca;
ax.LineWidth = 5/2;
xlabel('number of food patches')
ylabel('mean time (s)')
box off
%% calculate the sum of food units every worm has eaten in every simulation

% npr-1 worms, one food patch
FUsPerNpr1WormPatch1 = zeros(40,500);
FUsNpr1EffPatch1 = zeros(40,500);

for ii = 1:500
    FUsPerNpr1WormPatch1(:,ii) = sum(FUsNpr1patch1(:,1:timeNpr1patch1(ii),ii),2);
    FUsNpr1EffPatch1(:,ii) = sum(FUsNpr1patch1(:,2:timeNpr1patch1(ii),ii),2);
end

FUsPerNpr1WormPatch1 = reshape(FUsPerNpr1WormPatch1,[40*500,1]);
FUsNpr1EffPatch1 = reshape(FUsNpr1EffPatch1,[40*500,1]);


% npr-1 worms, two food patches
FUsPerNpr1WormPatch2 = zeros(40,500);
FUsNpr1EffPatch2 = zeros(40,500);

for ii = 1:500
    FUsPerNpr1WormPatch2(:,ii) = sum(FUsNpr1patch2(:,1:timeNpr1patch2(ii),ii),2);
    FUsNpr1EffPatch2(:,ii) = sum(FUsNpr1patch2(:,2:timeNpr1patch2(ii),ii),2);
end

FUsPerNpr1WormPatch2 = reshape(FUsPerNpr1WormPatch2,[40*500,1]);
FUsNpr1EffPatch2 = reshape(FUsNpr1EffPatch2,[40*500,1]);

% npr-1 worms, four food patches
FUsPerNpr1WormPatch4 = zeros(40,500);
FUsNpr1EffPatch4 = zeros(40,500);

for ii = 1:500
    FUsPerNpr1WormPatch4(:,ii) = sum(FUsNpr1patch4(:,1:timeNpr1patch4(ii),ii),2);
    FUsNpr1EffPatch4(:,ii) = sum(FUsNpr1patch4(:,2:timeNpr1patch4(ii),ii),2);
end

FUsPerNpr1WormPatch4 = reshape(FUsPerNpr1WormPatch4,[40*500,1]);
FUsNpr1EffPatch4 = reshape(FUsNpr1EffPatch4,[40*500,1]);


% N2 worms, one food patch
FUsPerN2WormPatch1 = zeros(40,500);
FUsN2EffPatch1 = zeros(40,500);

for ii = 1:500
    FUsPerN2WormPatch1(:,ii) = sum(FUsN2patch1(:,1:timeN2patch1(ii),ii),2);
    FUsN2EffPatch1(:,ii) = sum(FUsN2patch1(:,2:timeN2patch1(ii),ii),2);
end

FUsPerN2WormPatch1 = reshape(FUsPerN2WormPatch1,[40*500,1]);
FUsN2EffPatch1 = reshape(FUsN2EffPatch1,[40*500,1]);


% N2 worms, two food patches
FUsPerN2WormPatch2 = zeros(40,500);
FUsN2EffPatch2 = zeros(40,500);

for ii = 1:500
    FUsPerN2WormPatch2(:,ii) = sum(FUsN2patch2(:,1:timeN2patch2(ii),ii),2);
    FUsN2EffPatch2(:,ii) = sum(FUsN2patch2(:,2:timeN2patch2(ii),ii),2);
end

FUsPerN2WormPatch2 = reshape(FUsPerN2WormPatch2,[40*500,1]);
FUsN2EffPatch2 = reshape(FUsN2EffPatch2,[40*500,1]);


% N2 worms, four food patches
FUsPerN2WormPatch4 = zeros(40,500);
FUsN2EffPatch4 = zeros(40,500);

for ii = 1:500
    FUsPerN2WormPatch4(:,ii) = sum(FUsN2patch4(:,1:timeN2patch4(ii),ii),2);
    FUsN2EffPatch4(:,ii) = sum(FUsN2patch4(:,2:timeN2patch4(ii),ii),2);
end

FUsPerN2WormPatch4 = reshape(FUsPerN2WormPatch4,[40*500,1]);
FUsN2EffPatch4 = reshape(FUsN2EffPatch4,[40*500,1]);

%% plot histograms for number of individually eaten food units for npr-1 worms

edges = 0:10:450;

% plot normalized combined histogram for npr-1 worms
figure('pos',[0 0 1240 1748]);
hNpr1(1) = histogram(FUsPerNpr1WormPatch1*relativeFeedingRate,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','r');
hold on
hNpr1(2) = histogram(FUsPerNpr1WormPatch2*relativeFeedingRate,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','k');
hNpr1(3) = histogram(FUsPerNpr1WormPatch4*relativeFeedingRate,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','b');
legend(hNpr1,'one food patch','two food patches','four food patches','Location','NorthWest');
hNpr1(1).LineWidth = 6;
hNpr1(2).LineWidth = 6;
hNpr1(3).LineWidth = 6;
ax = gca;
ax.FontSize = 42;
ax.LineWidth = 5;
ylim([0 0.20])
ylabel('relative frequency')
xlabel('individually eaten food units')
lgd = findobj(gcf, 'Type', 'Legend');
lgd.LineWidth = 6;
lgd.FontSize = 40;
box off

%% plot same histograms for N2 worms

edges = 0:10:450;

% plot normalized combined histogram for N2 worms
figure('pos',[0 0 1240 1748]);
hN2(1) = histogram(FUsPerN2WormPatch1*relativeFeedingRate,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','r');
hold on
hN2(2) = histogram(FUsPerN2WormPatch2*relativeFeedingRate,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','k');
hN2(3) = histogram(FUsPerN2WormPatch4*relativeFeedingRate,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','b');
legend(hN2,'one food patch','two food patches','four food patches','Location','NorthWest');
hN2(1).LineWidth = 6;
hN2(2).LineWidth = 6;
hN2(3).LineWidth = 6;
ax = gca;
ax.FontSize = 42;
ax.LineWidth = 5;
ylim([0 0.20])
ylabel('relative frequency')
xlabel('individually eaten food units')
lgd = findobj(gcf, 'Type', 'Legend');
lgd.LineWidth = 6;
lgd.FontSize = 40;
box off
%% calculate efficiencies 

% npr-1, one food patch
summedStepsNpr1patch1 = zeros(40,500);

for ii = 1:500
    summedStepsNpr1patch1(:,ii) = sum(allStepsNpr1patch1(:,1:timeNpr1patch1(ii)-1,ii),2);
end

summedStepsNpr1patch1 = reshape(summedStepsNpr1patch1,[40*500,1]);

% npr-1, two food patches
summedStepsNpr1patch2 = zeros(40,500);

for ii = 1:500
    summedStepsNpr1patch2(:,ii) = sum(allStepsNpr1patch2(:,1:timeNpr1patch2(ii)-1,ii),2);
end

summedStepsNpr1patch2 = reshape(summedStepsNpr1patch2,[40*500,1]);

% npr-1, four food patches
summedStepsNpr1patch4 = zeros(40,500);

for ii = 1:500
    summedStepsNpr1patch4(:,ii) = sum(allStepsNpr1patch4(:,1:timeNpr1patch4(ii)-1,ii),2);
end

summedStepsNpr1patch4 = reshape(summedStepsNpr1patch4,[40*500,1]);

% N2, one food patch
summedStepsN2patch1 = zeros(40,500);

for ii = 1:500
    summedStepsN2patch1(:,ii) = sum(allStepsN2patch1(:,1:timeN2patch1(ii)-1,ii),2);
end

summedStepsN2patch1 = reshape(summedStepsN2patch1,[40*500,1]);

% N2, two food patches
summedStepsN2patch2 = zeros(40,500);

for ii = 1:500
    summedStepsN2patch2(:,ii) = sum(allStepsN2patch2(:,1:timeN2patch2(ii)-1,ii),2);
end

summedStepsN2patch2 = reshape(summedStepsN2patch2,[40*500,1]);

% N2, four food patches
summedStepsN2patch4 = zeros(40,500);

for ii = 1:500
    summedStepsN2patch4(:,ii) = sum(allStepsN2patch4(:,1:timeN2patch4(ii)-1,ii),2);
end

summedStepsN2patch4 = reshape(summedStepsN2patch4,[40*500,1]);


% compute efficiencies 
efficienciesNpr1patch1 = FUsNpr1EffPatch1*relativeFeedingRate./summedStepsNpr1patch1;
efficienciesNpr1patch2 = FUsNpr1EffPatch2*relativeFeedingRate./summedStepsNpr1patch2;
efficienciesNpr1patch4 = FUsNpr1EffPatch4*relativeFeedingRate./summedStepsNpr1patch4;
efficienciesN2patch1 = FUsN2EffPatch1*relativeFeedingRate./summedStepsN2patch1;
efficienciesN2patch2 = FUsN2EffPatch2*relativeFeedingRate./summedStepsN2patch2;
efficienciesN2patch4 = FUsN2EffPatch4*relativeFeedingRate./summedStepsN2patch4;

%% plot histograms of individual efficiencies of npr-1 worms

edges = 0:0.01:1;

figure('pos',[0 0 1240 1748]);
hisNpr1(1) = histogram(efficienciesNpr1patch1,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','r');
hold on
hisNpr1(2) = histogram(efficienciesNpr1patch2,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','k');
hisNpr1(3) = histogram(efficienciesNpr1patch4,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','b');
legend(hisNpr1,'one food patch','two food patches','four food patches');
hisNpr1(1).LineWidth = 6;
hisNpr1(2).LineWidth = 6;
hisNpr1(3).LineWidth = 6;
ax = gca;
ax.FontSize = 42;
ax.LineWidth = 5;
ylim([0 0.1])
ylabel('relative frequency')
xlabel('individual foraging efficiency')
lgd = findobj(gcf, 'Type', 'Legend');
lgd.LineWidth = 6;
lgd.FontSize = 40;
box off

%% do same for individual efficiencies of N2 worms

edges = 0:0.01:1;

figure('pos',[0 0 1240 1748]);
hisN2(1) = histogram(efficienciesN2patch1,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','r');
hold on
hisN2(2) = histogram(efficienciesN2patch2,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','k');
hisN2(3) = histogram(efficienciesN2patch4,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','b');
legend(hisN2,'one food patch','two food patches','four food patches');
hisN2(1).LineWidth = 6;
hisN2(2).LineWidth = 6;
hisN2(3).LineWidth = 6;
ax = gca;
ax.FontSize = 42;
ax.LineWidth = 5;
ylim([0 0.1])
ylabel('relative frequency')
xlabel('individual foraging efficiency')
lgd = findobj(gcf, 'Type', 'Legend');
lgd.LineWidth = 6;
lgd.FontSize = 40;
box off
