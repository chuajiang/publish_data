%%%%%%simulation data for MARS topside layer 
clear all;
close all;

alt=125:299;
load('case1.mat'); %unit cm-3 size:1000*175 t*altitude
load('case2.mat');%unit cm-3 size:1000*175 t*altitude
load('Te_mean0.mat');%unit  T size:1*175 1*altitude
load('Te_mean.mat');%unit  T size:1*175 1*altitude

load('Electric_density_sza.mat');
load('Electric_density_sza_Chapman_model.mat');
 %%%%%%figure 1
  
 sza=0:10:80;
 figure;plot((Electric_density_sza(1:2:end,:)),125:299,'-.x','linewidth',1);
 xlabel('Ne (cm^-^3)','FontSize',14,'fontweight','bold');
 ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
 title('Electron Density','FontSize',14);
 set(gca,'FontWeight','bold','FontSize',14);
 hold on;
 %%%%½âÎöÄ£ÐÍ
 clear Electric_density_sza_Chapman_model;
 altitude_z=125:300;
 n0=1.76e5;%1.58e5;
 z0=125;
 H=11;
 for sza_index=1:length(sza)
     set_SZA=sza(sza_index);
      Electric_density_sza_Chapman_model(sza_index,:)=n0.*exp(0.5.*(1-(altitude_z-z0)./H-(1/cos(set_SZA*pi/180)).*exp(-(altitude_z-z0)./H)));
 end
 
 plot((Electric_density_sza_Chapman_model(1:2:end,:)),125:300,'-.o','linewidth',1);
 xlabel('Ne (cm^-^3)','FontSize',14,'fontweight','bold');
 ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
 title('Electron Density','FontSize',14);
 set(gca,'FontWeight','bold','FontSize',14);
 legend('SZA=0','SZA=20','SZA=40','SZA=60','SZA=80','SZA=0','SZA=20','SZA=40','SZA=60','SZA=80');
 
 axis([0 2e5 120 300]);

%%%figure 3
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

 
 %%%figure 4
 load('vik.mat');
 runtime=1:1000;%s
 alt=125:299;
 figure;
 subplot(1,2,1);
 contourf(runtime,alt,log(Electric_density_case1'),'LevelStep',0.05);
  xlabel('runing time (s)','FontSize',14,'fontweight','bold');
 ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
  title('Electron Density in Case 1','FontSize',14);
 set(gca,'FontWeight','bold','FontSize',14);
 colormap(vik);
 colorbar;
 caxis([8 12]);
 subplot(1,2,2);
 contourf(runtime,alt,log(Electric_density_case2'),'LevelStep',0.05);
  xlabel('runing time (s)','FontSize',14,'fontweight','bold');
 ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
 title('Electron Density in Case 2','FontSize',14);
 set(gca,'FontWeight','bold','FontSize',14);
 colormap(vik);
 colorbar;
 caxis([8 12]);