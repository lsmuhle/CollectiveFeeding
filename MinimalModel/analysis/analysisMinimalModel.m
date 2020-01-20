%% reset
clear;
%% calculate means of needed time until 90 % of food is eaten for social and solitary worms and plot results

% load data and create variables
load('L35N40gamma0timeSocial.mat')
timeSocialGamma0 = time90percentEatenSocial;
load('L35N40gamma1timeSocial.mat')
timeSocialGamma1 = time90percentEatenSocial;
load('L35N40gamma1point5timeSocial.mat')
timeSocialGamma1point5 = time90percentEatenSocial;
load('L35N40gamma2timeSocial.mat')
timeSocialGamma2 = time90percentEatenSocial;
load('L35N40gamma3timeSocial.mat')
timeSocialGamma3 = time90percentEatenSocial;

load('L35N40gamma0timeSolitary.mat')
timeSolitaryGamma0 = time90percentEatenSolitary;
load('L35N40gamma1timeSolitary.mat')
timeSolitaryGamma1 = time90percentEatenSolitary;
load('L35N40gamma1point5timeSolitary.mat')
timeSolitaryGamma1point5 = time90percentEatenSolitary;
load('L35N40gamma2timeSolitary.mat')
timeSolitaryGamma2 = time90percentEatenSolitary;
load('L35N40gamma3timeSolitary.mat')
timeSolitaryGamma3 = time90percentEatenSolitary;

%calculate mean and confidence interval 
meansTimeSocial(1) = mean(timeSocialGamma0);
meansTimeSocial(2) = mean(timeSocialGamma1);
meansTimeSocial(3) = mean(timeSocialGamma1point5);
meansTimeSocial(4) = mean(timeSocialGamma2);
meansTimeSocial(5) = mean(timeSocialGamma3);

stdTimeSocial(1) = std(timeSocialGamma0);
stdTimeSocial(2) = std(timeSocialGamma1);
stdTimeSocial(3) = std(timeSocialGamma1point5);
stdTimeSocial(4) = std(timeSocialGamma2);
stdTimeSocial(5) = std(timeSocialGamma3);

meansTimeSolitary(1) = mean(timeSolitaryGamma0);
meansTimeSolitary(2) = mean(timeSolitaryGamma1);
meansTimeSolitary(3) = mean(timeSolitaryGamma1point5);
meansTimeSolitary(4) = mean(timeSolitaryGamma2);
meansTimeSolitary(5) = mean(timeSolitaryGamma3);


stdTimeSolitary(1) = std(timeSolitaryGamma0);
stdTimeSolitary(2) = std(timeSolitaryGamma1);
stdTimeSolitary(3) = std(timeSolitaryGamma1point5);
stdTimeSolitary(4) = std(timeSolitaryGamma2);
stdTimeSolitary(5) = std(timeSolitaryGamma3);


% plot means with error bars of 1 SD
figure('pos',[0 0 1240 1748]);
x = [0 1 1.5 2 3];
eSocial = errorbar(x,meansTimeSocial,stdTimeSocial,'--ob');
hold on
eSolitary = errorbar(x,meansTimeSolitary,stdTimeSolitary,'--or');
eSocial.LineWidth = 6;
eSocial.MarkerSize = 15;
eSocial.MarkerFaceColor = 'b';
eSocial.CapSize = 25;
eSolitary.LineWidth = 6;
eSolitary.MarkerSize = 15;
eSolitary.MarkerFaceColor = 'r';
eSolitary.CapSize = 25; 
[lgd,objects] = legend('social agents','solitary agents');
set(findobj(objects,'-property','MarkerSize'),'MarkerSize',15)
set(findobj(objects,'-property','FontSize'),'FontSize',34)
set(lgd,'FontSize',40)
lgd.Position = [0.1579 0.7879 0.3000 0.1250];
xticks(0:0.5:3)
axis([0 3 0 1800])
set(gca,'FontSize',42)
ax = gca;
ax.LineWidth = 5;
xlabel('degree of food clustering determined by \gamma')
ylabel('mean time steps')
box off

%% analyse the number of food pieces eaten by every worms

% calculate the sum of food units eaten by every worm per simulation
load('L35N40gamma0FUsIndividuallyEatenSocial.mat')
FUsSocialGamma0 = FUsEatenSocial;
FUsPerSocialWormGamma0 = zeros(40,500);
FUsPerSocialWormEffGamma0 = zeros(40,500);

for ii = 1:500
    FUsPerSocialWormGamma0(:,ii) = sum(FUsSocialGamma0(:,1:timeSocialGamma0(ii),ii),2);
    FUsPerSocialWormEffGamma0(:,ii) = sum(FUsSocialGamma0(:,2:timeSocialGamma0(ii),ii),2);
end

FUsPerSocialWormGamma0 = reshape(FUsPerSocialWormGamma0,[40*500,1]);
FUsPerSocialWormEffGamma0 = reshape(FUsPerSocialWormEffGamma0,[40*500,1]);


% social worms, gamma 1
load('L35N40gamma1FUsIndividuallyEatenSocial.mat')
FUsSocialGamma1 = FUsEatenSocial;
FUsPerSocialWormGamma1 = zeros(40,500);
FUsPerSocialWormEffGamma1 = zeros(40,500);

for ii = 1:500
    FUsPerSocialWormGamma1(:,ii) = sum(FUsSocialGamma1(:,1:timeSocialGamma1(ii),ii),2);
    FUsPerSocialWormEffGamma1(:,ii) = sum(FUsSocialGamma1(:,2:timeSocialGamma1(ii),ii),2);
end

FUsPerSocialWormGamma1 = reshape(FUsPerSocialWormGamma1,[40*500,1]);
FUsPerSocialWormEffGamma1 = reshape(FUsPerSocialWormEffGamma1,[40*500,1]);

% social worms, gamma 2
load('L35N40gamma2FUsIndividuallyEatenSocial.mat')
FUsSocialGamma2 = FUsEatenSocial;
FUsPerSocialWormGamma2 = zeros(40,500);
FUsPerSocialWormEffGamma2 = zeros(40,500);

for ii = 1:500
    FUsPerSocialWormGamma2(:,ii) = sum(FUsSocialGamma2(:,1:timeSocialGamma2(ii),ii),2);
    FUsPerSocialWormEffGamma2(:,ii) = sum(FUsSocialGamma2(:,2:timeSocialGamma2(ii),ii),2);
end

FUsPerSocialWormGamma2 = reshape(FUsPerSocialWormGamma2,[40*500,1]);
FUsPerSocialWormEffGamma2 = reshape(FUsPerSocialWormEffGamma2,[40*500,1]);


% social worms, gamma3
load('L35N40gamma3FUsIndividuallyEatenSocial.mat')
FUsSocialGamma3 = FUsEatenSocial;
FUsPerSocialWormGamma3 = zeros(40,500);
FUsPerSocialWormEffGamma3 = zeros(40,500);

for ii = 1:500
    FUsPerSocialWormGamma3(:,ii) = sum(FUsSocialGamma3(:,1:timeSocialGamma3(ii),ii),2);
    FUsPerSocialWormEffGamma3(:,ii) = sum(FUsSocialGamma3(:,2:timeSocialGamma3(ii),ii),2);
end

FUsPerSocialWormGamma3 = reshape(FUsPerSocialWormGamma3,[40*500,1]);
FUsPerSocialWormEffGamma3 = reshape(FUsPerSocialWormEffGamma3,[40*500,1]);


% solitary worms, gamma 0
load('L35N40gamma0FUsIndividuallyEatenSolitary.mat')
FUsSolitaryGamma0 = FUsEatenSolitary;
FUsPerSolitaryWormGamma0 = zeros(40,500);
FUsPerSolitaryWormEffGamma0 = zeros(40,500);

for ii = 1:500
    FUsPerSolitaryWormGamma0(:,ii) = sum(FUsSolitaryGamma0(:,1:timeSolitaryGamma0(ii),ii),2);
    FUsPerSolitaryWormEffGamma0(:,ii) = sum(FUsSolitaryGamma0(:,2:timeSolitaryGamma0(ii),ii),2);
end

FUsPerSolitaryWormGamma0 = reshape(FUsPerSolitaryWormGamma0,[40*500,1]);
FUsPerSolitaryWormEffGamma0 = reshape(FUsPerSolitaryWormEffGamma0,[40*500,1]);


% solitary worms, gamma 1
load('L35N40gamma1FUsIndividuallyEatenSolitary.mat')
FUsSolitaryGamma1 = FUsEatenSolitary;
FUsPerSolitaryWormGamma1 = zeros(40,500);
FUsPerSolitaryWormEffGamma1 = zeros(40,500);

for ii = 1:500
    FUsPerSolitaryWormGamma1(:,ii) = sum(FUsSolitaryGamma1(:,1:timeSolitaryGamma1(ii),ii),2);
    FUsPerSolitaryWormEffGamma1(:,ii) = sum(FUsSolitaryGamma1(:,2:timeSolitaryGamma1(ii),ii),2);
end

FUsPerSolitaryWormGamma1 = reshape(FUsPerSolitaryWormGamma1,[40*500,1]);
FUsPerSolitaryWormEffGamma1 = reshape(FUsPerSolitaryWormEffGamma1,[40*500,1]);


% solitary worms, gamma 2
load('L35N40gamma2FUsIndividuallyEatenSolitary.mat')
FUsSolitaryGamma2 = FUsEatenSolitary;
FUsPerSolitaryWormGamma2 = zeros(40,500);
FUsPerSolitaryWormEffGamma2 = zeros(40,500);

for ii = 1:500
    FUsPerSolitaryWormGamma2(:,ii) = sum(FUsSolitaryGamma2(:,1:timeSolitaryGamma2(ii),ii),2);
    FUsPerSolitaryWormEffGamma2(:,ii) = sum(FUsSolitaryGamma2(:,2:timeSolitaryGamma2(ii),ii),2);
end

FUsPerSolitaryWormGamma2 = reshape(FUsPerSolitaryWormGamma2,[40*500,1]);
FUsPerSolitaryWormEffGamma2 = reshape(FUsPerSolitaryWormEffGamma2,[40*500,1]);


% solitary worms, gamma3 
load('L35N40gamma3FUsIndividuallyEatenSolitary.mat')
FUsSolitaryGamma3 = FUsEatenSolitary;
FUsPerSolitaryWormGamma3 = zeros(40,500);
FUsPerSolitaryWormEffGamma3 = zeros(40,500);

for ii = 1:500
    FUsPerSolitaryWormGamma3(:,ii) = sum(FUsSolitaryGamma3(:,1:timeSolitaryGamma3(ii),ii),2);
    FUsPerSolitaryWormEffGamma3(:,ii) = sum(FUsSolitaryGamma3(:,2:timeSolitaryGamma3(ii),ii),2);
end

FUsPerSolitaryWormGamma3 = reshape(FUsPerSolitaryWormGamma3,[40*500,1]);
FUsPerSolitaryWormEffGamma3 = reshape(FUsPerSolitaryWormEffGamma3,[40*500,1]);

%% plot histograms for eaten FUs

edges = 0:10:800;

% plot normalized combined histogram for social worms
figure('pos',[0 0 1240 1748]);
hSocial(1) = histogram(FUsPerSocialWormGamma0,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','r');
hold on
hSocial(2) = histogram(FUsPerSocialWormGamma1,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','k');
hSocial(3) = histogram(FUsPerSocialWormGamma2,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','b');
hSocial(4) = histogram(FUsPerSocialWormGamma3,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','g');
legend(hSocial,'\gamma = 0','\gamma = 1','\gamma = 2','\gamma = 3');
hSocial(1).LineWidth = 6;
hSocial(2).LineWidth = 6;
hSocial(3).LineWidth = 6;
hSocial(4).LineWidth = 6;
ax = gca;
ax.FontSize = 42;
ax.LineWidth = 5;
ylim([0 0.20])
ylabel('relative frequency')
xlabel('individually eaten food units')
lgd = findobj(gcf, 'Type', 'Legend');
lgd.LineWidth = 6;
lgd.FontSize = 50;
box off

%% plot same for solitary worms 

edges = 0:10:800;

figure('pos',[0 0 1240 1748]);
hSolitary(1) = histogram(FUsPerSolitaryWormGamma0,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','r');
hold on
hSolitary(2) = histogram(FUsPerSolitaryWormGamma1,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','k');
hSolitary(3) = histogram(FUsPerSolitaryWormGamma2,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','b');
hSolitary(4) = histogram(FUsPerSolitaryWormGamma3,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','g');
legend(hSolitary,'\gamma = 0','\gamma = 1','\gamma = 2','\gamma = 3');
hSolitary(1).LineWidth = 6;
hSolitary(2).LineWidth = 6;
hSolitary(3).LineWidth = 6;
hSolitary(4).LineWidth = 6;
ax = gca;
ax.FontSize = 42;
ax.LineWidth = 5;
ylim([0 0.20])
ylabel('relative frequency')
xlabel('individually eaten food units')
lgd = findobj(gcf, 'Type', 'Legend');
lgd.LineWidth = 6;
lgd.FontSize = 50;
box off
%% calculate efficiencies 

% social, gamma 0
load('L35N40gamma0stepsSocial.mat')
allStepsSocialGamma0 = allStepsSocial;
summedStepsSocialGamma0 = zeros(40,500);

for ii = 1:500
    summedStepsSocialGamma0(:,ii) = sum(allStepsSocialGamma0(:,1:timeSocialGamma0(ii)-1,ii),2);
end

summedStepsSocialGamma0 = reshape(summedStepsSocialGamma0,[40*500,1]);

% social, gamma 1
load('L35N40gamma1stepsSocial.mat')
allStepsSocialGamma1 = allStepsSocial;
summedStepsSocialGamma1 = zeros(40,500);

for ii = 1:500
    summedStepsSocialGamma1(:,ii) = sum(allStepsSocialGamma1(:,1:timeSocialGamma1(ii)-1,ii),2);
end

summedStepsSocialGamma1 = reshape(summedStepsSocialGamma1,[40*500,1]);

% social, gamma 2
load('L35N40gamma2stepsSocial.mat')
allStepsSocialGamma2 = allStepsSocial;
summedStepsSocialGamma2 = zeros(40,500);

for ii = 1:500
    summedStepsSocialGamma2(:,ii) = sum(allStepsSocialGamma2(:,1:timeSocialGamma2(ii)-1,ii),2);
end

summedStepsSocialGamma2 = reshape(summedStepsSocialGamma2,[40*500,1]);

% social, gamma 3 
load('L35N40gamma3stepsSocial.mat')
allStepsSocialGamma3 = allStepsSocial;
summedStepsSocialGamma3 = zeros(40,500);

for ii = 1:500
    summedStepsSocialGamma3(:,ii) = sum(allStepsSocialGamma3(:,1:timeSocialGamma3(ii)-1,ii),2);
end

summedStepsSocialGamma3 = reshape(summedStepsSocialGamma3,[40*500,1]);

% solitary, gamma 0
load('L35N40gamma0stepsSolitary.mat')
allStepsSolitaryGamma0 = allStepsSolitary;
summedStepsSolitaryGamma0 = zeros(40,500);

for ii = 1:500
    summedStepsSolitaryGamma0(:,ii) = sum(allStepsSolitaryGamma0(:,1:timeSolitaryGamma0(ii)-1,ii),2);
end

summedStepsSolitaryGamma0 = reshape(summedStepsSolitaryGamma0,[40*500,1]);

% solitary, gamma 1
load('L35N40gamma1stepsSolitary.mat')
allStepsSolitaryGamma1 = allStepsSolitary;
summedStepsSolitaryGamma1 = zeros(40,500);

for ii = 1:500
    summedStepsSolitaryGamma1(:,ii) = sum(allStepsSolitaryGamma1(:,1:timeSolitaryGamma1(ii)-1,ii),2);
end

summedStepsSolitaryGamma1 = reshape(summedStepsSolitaryGamma1,[40*500,1]);

% solitary, gamma 2
load('L35N40gamma2stepsSolitary.mat')
allStepsSolitaryGamma2 = allStepsSolitary;
summedStepsSolitaryGamma2 = zeros(40,500);

for ii = 1:500
    summedStepsSolitaryGamma2(:,ii) = sum(allStepsSolitaryGamma2(:,1:timeSolitaryGamma2(ii)-1,ii),2);
end

summedStepsSolitaryGamma2 = reshape(summedStepsSolitaryGamma2,[40*500,1]);

% solitary, gamma 3
load('L35N40gamma3stepsSolitary.mat')
allStepsSolitaryGamma3 = allStepsSolitary;
summedStepsSolitaryGamma3 = zeros(40,500);

for ii = 1:500
    summedStepsSolitaryGamma3(:,ii) = sum(allStepsSolitaryGamma3(:,1:timeSolitaryGamma3(ii)-1,ii),2);
end

summedStepsSolitaryGamma3 = reshape(summedStepsSolitaryGamma3,[40*500,1]);

% compute individual efficiencies 
efficienciesSocialGamma0 = FUsPerSocialWormEffGamma0./summedStepsSocialGamma0;
efficienciesSocialGamma1 = FUsPerSocialWormEffGamma1./summedStepsSocialGamma1;
efficienciesSocialGamma2 = FUsPerSocialWormEffGamma2./summedStepsSocialGamma2;
efficienciesSocialGamma3 = FUsPerSocialWormEffGamma3./summedStepsSocialGamma3;
efficienciesSolitaryGamma0 = FUsPerSolitaryWormEffGamma0./summedStepsSolitaryGamma0;
efficienciesSolitaryGamma1 = FUsPerSolitaryWormEffGamma1./summedStepsSolitaryGamma1;
efficienciesSolitaryGamma2 = FUsPerSolitaryWormEffGamma2./summedStepsSolitaryGamma2;
efficienciesSolitaryGamma3 = FUsPerSolitaryWormEffGamma3./summedStepsSolitaryGamma3;

%% plot histograms of individual efficiencies of social worms
edges = 0:0.01:1;

figure('pos',[0 0 1240 1748]);
hisSocial(1) = histogram(efficienciesSocialGamma0,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','r');
hold on
hisSocial(2) = histogram(efficienciesSocialGamma1,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','k');
hisSocial(3) = histogram(efficienciesSocialGamma2,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','b');
hisSocial(4) = histogram(efficienciesSocialGamma3,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','g');
legend(hisSocial,'\gamma = 0','\gamma = 1','\gamma = 2','\gamma = 3');
hisSocial(1).LineWidth = 6;
hisSocial(2).LineWidth = 6;
hisSocial(3).LineWidth = 6;
hisSocial(4).LineWidth = 6;
ax = gca;
ax.FontSize = 42;
ax.LineWidth = 5;
ylim([0 0.1])
ylabel('relative frequency')
xlabel('individual foraging efficiency')
lgd = findobj(gcf, 'Type', 'Legend');
lgd.LineWidth = 6;
lgd.FontSize = 50;
box off
%% plot histograms of individual foraging efficiencies of solitary agents
edges = 0:0.01:1;

figure('pos',[0 0 1240 1748]);
hisSolitary(1) = histogram(efficienciesSolitaryGamma0,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','r');
hold on
hisSolitary(2) = histogram(efficienciesSolitaryGamma1,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','k');
hisSolitary(3) = histogram(efficienciesSolitaryGamma2,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','b');
hisSolitary(4) = histogram(efficienciesSolitaryGamma3,'BinEdges',edges,'Normalization','probability','DisplayStyle','stairs','EdgeColor','g');
legend(hisSolitary,'\gamma = 0','\gamma = 1','\gamma = 2','\gamma = 3');
hisSolitary(1).LineWidth = 6;
hisSolitary(2).LineWidth = 6;
hisSolitary(3).LineWidth = 6;
hisSolitary(4).LineWidth = 6;
ax = gca;
ax.FontSize = 42;
ax.LineWidth = 5;
ylim([0 0.1])
ylabel('relative frequency')
xlabel('individual foraging efficiency')
lgd = findobj(gcf, 'Type', 'Legend');
lgd.LineWidth = 6;
lgd.FontSize = 50;
box off