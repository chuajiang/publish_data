%%%data 
clear all;
close all;

%%data at runtime=[0 10 500 1000 2000 3000 4000 5000 7000 8000 10000]);%unit 0.1s 
load('Potential_nt.mat'); %unit V size:101*201*11
load('Ne_nt.mat');%unit ln(N) m-3 size:101*201*11
load('B_nt.mat');%unit  T size:101*201*11

%%%%%plots for papers
%datadir='..\Release-cosx-u100-n3e3-H15-10nT\';
nx=101; 
ny=201;
dx=0.5;
dy=0.2;
hbase=130;
figure; 
figindex=1;
figtime=[1 10 500 1000 2000 3000 5000 7000 8000 10000];

%%%Figure 1 t=1s density electric potential and magnetic field
subplot(1,3,1);
for i=2:2
    datatmp1=Ne_nt(:,:,i);
    %subplot(3,3,figindex);
    phy_tmp1=reshape(datatmp1,ny,nx);
    contourf((0:nx-1)*dx,hbase+(0:ny-1)*dy,log10(exp(phy_tmp1)), 'LevelStep',0.02);% , 'Lines','none'
    colorbar;
    caxis([9.0 9.6]);
    colormap('jet');
    if figindex==1 || figindex==4 || figindex==7
        ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    end
    %if figindex==7 || figindex==8 || figindex==9
        xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');
    %end
    set(gca,'FontWeight','bold','FontSize',14);
    stitle=sprintf('t=%d s',figtime(i)/10);
    title(stitle);
    figindex=figindex+1;
    disp(i);
%    pause(1);
end
%fclose(fid1);

subplot(1,3,2);
figindex=1;
figtime=[1 10 500 1000 2000 3000 5000 7000 8000 10000];
%fid1=fopen([ datadir 'Phy_nt_mars.mir'],'r+');
for i=2:2
    datatmp1=Potential_nt(:,:,i);%fread(fid1, nx*ny, 'float');
    %subplot(3,3,figindex);
    phy_tmp1=reshape(datatmp1,ny,nx);
    contourf((0:nx-1)*dx,hbase+(0:ny-1)*dy,(phy_tmp1), 'LevelStep',0.002);%, 'LevelStep',0.1 , 'Lines','none'
    colorbar;
    caxis([-0.05 -0.01]);
    colormap('jet');
    if figindex==1 || figindex==4 || figindex==7
        ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    end
    %if figindex==7 || figindex==8 || figindex==9
        xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');
    %end
    set(gca,'FontWeight','bold','FontSize',14);
    stitle=sprintf('t=%d s',figtime(i)/10);
    title(stitle);
    figindex=figindex+1;
    disp(i);
%     pause(1);
end
% fclose(fid1);

nx=101; 
ny=201;
dx=0.5;
dy=0.2;
hbase=130;
figindex=1;
figtime=[1 10 500 1000 2000 3000 5000 7000 8000 10000];

subplot(1,3,3);
% fid1=fopen([ datadir 'B_nt_mars.mir'],'r+');
for i=2:2
    datatmp1=B_nt(:,:,i);%fread(fid1, nx*ny, 'float');
    %subplot(3,3,figindex);
    phy_tmp1=reshape(datatmp1,ny,nx);
    contourf((0:nx-1)*dx,hbase+(0:ny-1)*dy,(phy_tmp1)./1e-9);%, 'LevelStep',0.1 , 'Lines','none'
    colorbar;
    caxis([9.0 10.6]);
    colormap('jet');
    if figindex==1 || figindex==4 || figindex==7
        ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    end
    %if figindex==7 || figindex==8 || figindex==9
        xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');
    %end
    set(gca,'FontWeight','bold','FontSize',14);
    stitle=sprintf('t=%d s',figtime(i)/10);
    title(stitle);
    figindex=figindex+1;
    disp(i);
%     pause(1);
end
% fclose(fid1);


%%%%%%%%Figure 2 O2+ density variation
%%data
nx=101; 
ny=201;
dx=0.5;
dy=0.2;
hbase=130;
cMax=9.6;%logN
cMin=9.0;
figure; 
figindex=1;
% figtime=[0 500 1000 2000 3000 5000 7000 8000 10000];
% clevel=[0.03 0.03 0.03 0.01 0.01 0.01 0.01 0.01 0.01];
%data index [1 10 500 1000 2000 3000 4000 5000 7000 8000 10000]
figtimeshow=[1  1000  3000 5000 7000 10000 ];
figtime=[1  4  6 8 9 11 ];
clevel=[0.03  0.03  0.01 0.01 0.01 0.01];
% fid1=fopen([ datadir 'NE_nt_mars.mir'],'r+');
for i=1:length(figtime)
   if figindex>length(figtime)
        break;
    end
    datatmp1=Ne_nt(:,:,figtime(i));%fread(fid1, nx*ny, 'float');

    subplot(2,3,figindex);
    phy_tmp1=reshape(datatmp1,ny,nx);
    contourf((0:nx-1)*dx,hbase+(0:ny-1)*dy,log10(exp(phy_tmp1)), 'LevelStep',clevel(figindex)); %'Lines','none'
    caxis([cMin cMax]);
    colormap('jet');
    if figindex==1 || figindex==4 || figindex==7
        ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    end
    if figindex==4 || figindex==5 || figindex==6
        xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');
    end
    set(gca,'FontWeight','bold','FontSize',14);
    stitle=sprintf('t=%d s',round(figtimeshow(i)/10));
    title(stitle);
    figindex=figindex+1;
    disp(i);
end
% fclose(fid1);


%%%Figure 3 magnetic field
figure; 
figindex=1;
figtimeshow=[10  1000  3000 5000 7000 10000 ];
figtime=[2  4  6 8 9 11 ];
% figtime=[10  1000  3000 5000 7000 10000 ];
clevel=[0.05  0.25 0.25  0.25 0.25 0.25];
% fid1=fopen([ datadir 'B_nt_mars.mir'],'r+');
for i=1:length(figtime)
   if figindex>length(figtime)
        break;
    end
    datatmp1=B_nt(:,:,figtime(i));%fread(fid1, nx*ny, 'float');

    subplot(2,3,figindex);
    phy_tmp1=reshape(datatmp1,ny,nx);
    contourf((0:nx-1)*dx,hbase+(0:ny-1)*dy,(phy_tmp1)./1e-9, 'LevelStep',clevel(figindex));% , 'Lines','none'
%     caxis([14 16]);
    caxis([8 11]);
    colormap('jet');
    if figindex==1 || figindex==4 || figindex==7
        ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    end
    if figindex==4 || figindex==5 || figindex==6
        xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');
    end
    set(gca,'FontWeight','bold','FontSize',14);
    stitle=sprintf('t=%d s',figtimeshow(i)/10);
    title(stitle);
    figindex=figindex+1;
    disp(i);
end


%%%%%%%%Figure 4 O2+ density profiles 
%%data
nx=101; 
ny=201;
dx=0.5;
dy=0.2;
hbase=130;
figure; 
figindex=1;
figtimeshow=[7000 10000 ];
figtime=[9 11 ];
% figtime=[ 7000 10000];
% fid1=fopen([ datadir 'NE_nt_mars.mir'],'r+');
linec={'r','b','g'};
for i=1:length(figtime)
   if figindex>length(figtime)
        break;
    end
    datatmp1=Ne_nt(:,:,figtime(i));%fread(fid1, nx*ny, 'float');

    phy_tmp1=reshape(datatmp1,ny,nx);
    phy_tmp1=exp(phy_tmp1)./1e6;
    subplot(1,2,1);
    %%%density-altitude
    dis=[20];
    dispos=(dis)./dx+1;
    plot(phy_tmp1(:,dispos),hbase+(0:ny-1)*dy,cell2mat(linec(figindex)),'linewidth',2); hold on;
    
    ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    %end
    %if figindex==7 || figindex==8 || figindex==9
        xlabel('Ne (cm^-^3)','FontSize',14,'fontweight','bold');
   % end
    set(gca,'FontWeight','bold','FontSize',14);
    stitle=sprintf('Plasma density');
    title(stitle);
    axis([2000 3200 130 170]);
    grid on;
    legend({'700s','1000s'},'FontSize',12);
    figindex=figindex+1;
    disp(i);
end
% fclose(fid1);

%%%Figure 4  magnetic field profile
% figure; 
figindex=1;
figtimeshow=[7000 10000 ];
figtime=[9 11 ];
clevel=[0.01 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25];
% fid1=fopen([ datadir 'B_nt_mars.mir'],'r+');
for i=1:length(figtime)
   if figindex>length(figtime)
        break;
    end
    datatmp1=B_nt(:,:,figtime(i));%fread(fid1, nx*ny, 'float');

    phy_tmp1=reshape(datatmp1,ny,nx);
    phy_tmp1=phy_tmp1./1e-9;%nT
    
    dis=[20];
    dispos=(dis)./dx+1;
    subplot(1,2,2);
    plot(phy_tmp1(:,dispos),hbase+(0:ny-1)*dy,cell2mat(linec(figindex)),'linewidth',2); hold on;
    
    ylabel('Altitude (km)','FontSize',14,'fontweight','bold');

    xlabel('|B| (nT)','FontSize',14,'fontweight','bold');
    set(gca,'FontWeight','bold','FontSize',14);
    stitle=sprintf('Magnetic field');
    title(stitle);
    axis([8 11 130 170]);
    grid on;
    legend({'700s','1000s'},'FontSize',12);
    figindex=figindex+1;
    disp(i);

end
% fclose(fid1);