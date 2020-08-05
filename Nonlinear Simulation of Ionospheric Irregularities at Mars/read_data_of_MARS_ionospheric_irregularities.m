%%%%%%simulation data for MARS ionospehric irregularities
clear all;
close all;

%%data at runtime=[0 10 500 1000 2000 3000 5000 7000 8000 10000];%unit 0.1s 
load('Potential_nt.mat'); %unit V size:101*201*10
load('Ne_nt.mat');%unit m-3 size:101*201*10
load('B_nt.mat');%unit  T size:101*201*10

%Figure 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
hmin=130;%km
hmax=170;%km
%%%neutral CO2 density
deltH=0.05;%km
zm=120;%km
H=12;%km
n0=3e9;%cm3
z=120:deltH:200;
nn=n0*exp(-(z-zm)./H);%% 
subplot(1,3,1);
plot((nn),z,'linewidth',2);
axis([0 2e9 hmin hmax]);
ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
xlabel('Density (cm^-^3)','FontSize',14,'fontweight','bold');
set(gca,'FontWeight','bold','FontSize',14);
title('CO_2');
grid on;

%%%electron density figure;
deltH=0.05;%km
zh=120:deltH:200;
datasize=length(zh);
zm=150;%km
H=10;%km
Nm=3e3;%cm3
z=120:deltH:200;
N=Nm*exp(0.5*(1-(z-zm)/H-exp(-(z-zm)/H))); %% 
subplot(1,3,2);
plot((N),z,'linewidth',2);hold on;
axis([100 4e3 hmin hmax]);
ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
xlabel('Density (cm^-^3)','FontSize',14,'fontweight','bold');
set(gca,'FontWeight','bold','FontSize',14);
title('O_2^+');
grid on;

%%%  ion-neutral collision frequency
z=120:deltH:200;
vin=20*nn./(3e10);%cm-3;A review of observed variability in the dayside ionosphere of Mars
subplot(1,3,3);
plot(vin,z,'linewidth',2);
axis([0.01 1 hmin hmax]);
ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
xlabel('Frequency (Hz)','FontSize',14,'fontweight','bold');
set(gca,'FontWeight','bold','FontSize',14);
title('Collision Frequency of CO_2 and O_2^+');
grid on;

%%%Figure 2 Perturbation winds
nXlen=101;
clear u;
for i=1:nXlen
    u(i)=30*(cos(3.14159265./(nXlen/4).*(i-1)));
end
% 
figure;
plot(0.5*(0:100),u,'linewidth',2);
ylabel('Zonal wind fluctuation (m/s)','FontSize',14,'fontweight','bold');
xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');
set(gca,'FontWeight','bold','FontSize',14);
axis([0 50 -50 50]);
grid on;

%%%%%%%% O2+ density variation  m-3
%%data
nx=101; 
ny=201;
dx=0.5;
dy=0.2;
hbase=130;
cMax=9.5;
cMin=8.5;
figure; 
figindex=1;
figtime=[0 500 1000 2000 3000 5000 7000 8000 10000];
clevel=[0.1 0.1 0.1 0.03 0.03 0.03 0.03 0.03 0.03];
neindex=1;
for i=1:length(figtime)
    neindex=i;
    if i>1
        neindex=neindex+1;
    end
    subplot(3,3,figindex);
    contourf((0:nx-1)*dx,hbase+(0:ny-1)*dy,log10((Ne_nt(:,:,neindex)))', 'LevelStep',clevel(figindex)); %'Lines','none'
    caxis([cMin cMax]);
    if figindex==1 || figindex==4 || figindex==7
        ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    end
    if figindex==7 || figindex==8 || figindex==9
        xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');
    end
    set(gca,'FontWeight','bold','FontSize',14);
    stitle=sprintf('t=%d s',(figtime(i))/10);
    title(stitle);
    figindex=figindex+1;
   
end


%%%%%%%% Potential variation V
figure; 
figindex=1;
figtime=[10 500 1000 2000 3000 5000 7000 8000 10000];
neindex=1;
for i=1:length(figtime)
    neindex=i+1;
    if i>9
        break;
    end
    subplot(3,3,figindex);
    contourf((0:nx-1)*dx,hbase+(0:ny-1)*dy,(Potential_nt(:,:,neindex)'));%, 'LevelStep',0.1 , 'Lines','none'
    colorbar;
    if figindex==1 || figindex==4 || figindex==7
        ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    end
    if figindex==7 || figindex==8 || figindex==9
    xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');
    end
    set(gca,'FontWeight','bold','FontSize',14);
    stitle=sprintf('t=%d s',(figtime(i))/10);
    title(stitle);
    figindex=figindex+1;
end

%%% magnetic field  nT
figure; 
figindex=1;
figtime=[10 500 1000 2000 3000 5000 7000 8000 10000];
clevel=[0.01 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25];
neindex=1;
for i=1:length(figtime)
    neindex=i+1;
    if i>9
        break;
    end
    subplot(3,3,figindex);
    contourf((0:nx-1)*dx,hbase+(0:ny-1)*dy,(B_nt(:,:,neindex)')./1e-9, 'LevelStep',clevel(figindex));% , 'Lines','none'
    caxis([13 17]);
    if figindex==1 || figindex==4 || figindex==7
        ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    end
    if figindex==7 || figindex==8 || figindex==9
        xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');
    end
    set(gca,'FontWeight','bold','FontSize',14);
    stitle=sprintf('t=%d s',figtime(i)/10);
    title(stitle);
    figindex=figindex+1;

end



