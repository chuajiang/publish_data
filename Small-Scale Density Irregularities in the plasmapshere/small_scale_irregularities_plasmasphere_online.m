%%%data 
clear all;
close all;
%%plasmasphere
load('Ne_nt.mat');%unit ln(N(m-3))  size:101*201*9
nx=101; 
ny=201;
dx=5;
dy=0.01;
hbase=2;

%%%%%Figure 1.Nonlinear evolution of small-scale density irregularities in the plasmasphere.
figure; 
figindex=1;
%%data at runtime unit 0.2s 
runtime=[1  5000 10000 15000 20000 24000 26000 28000 30000];
for i=1:length(runtime)
    
    subplot(3,3,figindex);
    phy_tmp2=reshape(Ne_nt(:,:,figindex),ny,nx);%reshape(datatmp2,ny,nx);
    %Ne_nt(:,:,figindex)=phy_tmp2;
    contourf((0:nx-1)*dx,hbase+(0:ny-1)*dy,log10((exp(phy_tmp2))./1e6), 'LevelStep',0.1);
%     ylabel('L','FontSize',14,'fontweight','bold');
%     xlabel('Zontal distance (km)','FontSize',14,'fontweight','bold');
    set(gca,'FontWeight','bold','FontSize',14);
    strtime=sprintf('%d s',runtime(figindex)*0.2);
    if figindex==1
        strtime=sprintf('%0.1f s',runtime(figindex)*0.2);
    end
    
    title(strtime);
    

    caxis([1.0 4.0]);
    colormap('jet');
    if figindex==1 || figindex==4 || figindex==7
        ylabel('L','FontSize',14,'fontweight','bold');
    end
    if figindex==7 || figindex==8 || figindex==9
        xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');
    end
    if figindex==3 || figindex==6 || figindex==9
        colorbar;
    end

    disp(i);
    
    figindex=figindex+1;
end

%%%%Figure 2.Density profiles along the L-shell direction.
figure;
phy_tmp0=Ne_nt(:,:,1);
semilogy(hbase+(0:ny-1)*dy,(exp(phy_tmp2(:,[10,40,60,80])))./1e6,':','linewidth',2);hold on;grid on;
semilogy(hbase+(0:ny-1)*dy,(exp(phy_tmp0(:,[10])))./1e6,'k','linewidth',2);hold on;grid on;
ylabel('Density (cm^-^3)','FontSize',14,'fontweight','bold');
xlabel('L ','FontSize',14,'fontweight','bold');
set(gca,'FontWeight','bold','FontSize',14);
legend('50 km at t=6000s','200 km at t=6000s','300 km at t=6000s','400 km at t=6000s','50 km at t=0.2s');
