%% reset
clear
%% calculate means of needed time until 90 % of food is eaten for social and asocial worms and plot results
relativeFeedingRateN2 = 0.4
relativeFeedingRateNpr1 = 0.4%0.62*relativeFeedingRateN2
deltaT = 10; % set delta T at 10s (moving 2 lattice spacings of 1mm at 200mu/s in one time step)

gammaValues = [0 0.5 1 1.5 2 3 4 5 6 8 10];
ngamma = length(gammaValues);

meansTimeNpr1 = zeros(ngamma,1);
stdTimeNpr1 = zeros(ngamma,1);

meansTimeN2 = zeros(ngamma,1);
stdTimeN2 = zeros(ngamma,1);
    
for gammaCtr = 1:ngamma
    gamma = gammaValues(gammaCtr);
    % load data
    load(['L35N40gamma' num2str(gamma) 'Npr1SameFeedingRatesGamma.mat'])
    load(['L35N40gamma' num2str(gamma) 'N2SameFeedingRatesGamma.mat'])
    % calculate means and standard deviations
    meansTimeNpr1(gammaCtr) = nanmean(time90percentEatenNpr1)*deltaT;
    stdTimeNpr1(gammaCtr) = nanstd(time90percentEatenNpr1)*deltaT;
    
    meansTimeN2(gammaCtr) = nanmean(time90percentEatenN2)*deltaT;
    stdTimeN2(gammaCtr) = nanstd(time90percentEatenN2)*deltaT;
    
end

%% plot means with error bars of 1 SD
figure('pos',[0 0 1240 960]/2);
eNpr1 = errorbar(gammaValues,meansTimeNpr1,stdTimeNpr1,'--ob');
hold on
eN2 = errorbar(gammaValues,meansTimeN2,stdTimeN2,'--or');
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
lgd.Position = [0.67 0.225 0.23 0.125];

axis([0 max(gammaValues) 7e3 1.1e4])
set(gca,'FontSize',42/2)
ax = gca;
ax.LineWidth = 5/2;
xlabel('\gamma')
ylabel('mean time (s)')
box off

savefig("feeding_times_strain_specific_samerates_gamma")

