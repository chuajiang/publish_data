%%%%%%simulation data for MARS topside layer 
clear all;
close all;

alt=125:299;
load('case1.mat'); %unit cm-3 size:1000*175 t*altitude
load('case2.mat');%unit cm-3 size:1000*175 t*altitude
load('Te_mean0.mat');%unit  T size:1*175 1*altitude
load('Te_mean.mat');%unit  T size:1*175 1*altitude
%%%case1
%  Electric_density_case1=Electric_density;
%  Electric_density_case2=Electric_density;
 figure;
 subplot(1,2,1);
 plot(Electric_density_case1(end,:),alt,'linewidth',1);hold on;
 plot(Electric_density_case2(end,:),alt,'linewidth',1);
 xlabel('Ne (cm^-^3)','FontSize',14,'fontweight','bold');
 ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
 title('Electron Density','FontSize',14);
 set(gca,'FontWeight','bold','FontSize',14);
 subplot(1,2,2);
 plot(Te_mean0,alt,'linewidth',1);hold on;
 plot(Te_mean,alt,'linewidth',1);
 xlabel('Te (K)','FontSize',14,'fontweight','bold');
 ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
 title('Electron Temperature','FontSize',14);
 set(gca,'FontWeight','bold','FontSize',14);

 runtime=1:1000;%s
 alt=125:299;
 figure;
 subplot(1,2,1);
 contourf(runtime,alt,log(Electric_density_case1'),'LevelStep',0.05);
  xlabel('runing time (s)','FontSize',14,'fontweight','bold');
 ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
  title('Electron Density in Case 1','FontSize',14);
 set(gca,'FontWeight','bold','FontSize',14);
 colormap('jet');
 colorbar;
 caxis([8 12]);
 subplot(1,2,2);
 contourf(runtime,alt,log(Electric_density_case2'),'LevelStep',0.05);
  xlabel('runing time (s)','FontSize',14,'fontweight','bold');
 ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
 title('Electron Density in Case 2','FontSize',14);
 set(gca,'FontWeight','bold','FontSize',14);
 colormap('jet');
 colorbar;
 caxis([8 12]);