%%%%% files and data for publish of ray-tracing synthesis of ionograms with spread F
%%%%neGrid_data.mat for figure 1,2,4
%%%%ionograms.mat for figure 3
%%%%plasma bubbles.sf is the binary data of Ne
%%%%plasma bubbles.sf is in two-dimension with a step time of 1 s (from 1s to 2350s), zonal distance -200:2:200, altitude 250:2:650
clear all;
datafile='plasma bubbles.sf';
fid=fopen(datafile,'r+');
nshow=2350;%max second in data
nignore=1000;%a start second for plotting data
subindex=1;
ionoindex=1;
t_run=0;
figure;
for i=1:max(nshow)
    datatmp=fread(fid, 201*201, 'float');
    disp(i);
    if i<nignore
        continue;
    end
    if rem(i,50) ~=0
        continue;
    end
    Ne_tmp=reshape(datatmp,201,201);
   
    contourf(-200:2:200,250:2:650,(Ne_tmp), 'LevelStep',0.05,'LineStyle','none');
    colorbar;
    caxis([8.5 12]);
    set(gca,'XTick',-200:100:200);
    set(gca,'YTick',250:100:650)
    axis([-200 200 250 650]);
    strtitle=sprintf('t=%ds',i);
    title([strtitle],'FontName','Helvetica', 'FontSize',15,'fontweight','bold');
    grid on;
    set(gca,'FontName','Helvetica', 'FontSize',15,'fontweight','bold' );
    ylabel('Altitude (km)','FontSize',15,'fontweight','bold');xlabel('Zonal Distance (km)','FontSize',15,'fontweight','bold');

    pause(2);
    %%%%%%
    neGrid_iono(ionoindex).x=0:2:400;
    neGrid_iono(ionoindex).y=0:2:650;
    neGrid_iono(ionoindex).Ne(1:length(neGrid_iono(ionoindex).y), 1:length(neGrid_iono(ionoindex).x))=0;
    neGrid_iono(ionoindex).Ne(250/2+1:end,:)=10.^Ne_tmp;
    t_run(ionoindex)=i;
    ionoindex=ionoindex+1;
    
end
fclose(fid);

figure;
contourf(-200:2:200,0:2:650,(neGrid_iono.Ne), 'LevelStep',0.05,'LineStyle','none');

%%%figure 1 typical ray tracing in plasma bubbles£¬and it requires neGrid_data.mat
fMaxrange=400;
hstep=0.1;%km
Tpos=200;%km
ionogram_info=[];
delta_freq=0.2;
max_freq=10;
nfreq=length(2:delta_freq:max_freq);
for timeindex=length(neGrid_iono):1:length(neGrid_iono)%round(timelen)
    figure;
    contourf(-200:2:200,0:2:650, 9*sqrt(neGrid_iono(timeindex).Ne)*1e-6, 'LevelStep',0.25,'LineStyle','none');
    colormap('jet');
    caxis([-2 12]);
    set(gca,'XTick',-200:50:200);
    set(gca,'XTickLabel',{'-200','','-100','','0','','100','','200'});
    set(gca,'YTick',0:100:650)
    axis([-200 200 0 650]);
    strtitle=sprintf('t=%ds',t_run(end));
    title([strtitle],'FontName','Helvetica', 'FontSize',15,'fontweight','bold');
    grid on;
    set(gca,'FontName','Helvetica', 'FontSize',15,'fontweight','bold' );
    ylabel('Altitude (km)','FontSize',15,'fontweight','bold');xlabel('Zonal Distance (km)','FontSize',15,'fontweight','bold');

    %%%tracing
    for fFreq=8:1:8 %2:delta_freq:max_freq
        elbgn=80;
        elend=100;
        elstep=1;
        N=length(raypath);

        path_index=1;
        clr=linspecer(N);
        groupPath=0;
        for i=1:N
            if isempty(raypath(i).data)
                continue;
            end
            hold on;
            plot(raypath(i).data(:,2)-200,raypath(i).data(:,1),'-','LineWidth',0.25,'Color',clr(i,:));
        end
    end
end

%%%%figure 2 plasma bubbles, and it requires neGrid_data.mat
plottime=[];
figure;
plotindex=1;
for i=17:length(neGrid_iono)
    subplot(3,4,plotindex)
    zdata=log10(neGrid_iono(i).Ne);
    zdata(isinf(zdata))=0;
    contourf(-200:2:200,0:2:650,zdata, 'LevelStep',0.25,'LineStyle','none');
    colormap('jet')
%     colorbar;
    caxis([0 15]);
    set(gca,'XTick',-200:50:200);
    set(gca,'XTickLabel',{'-200','','-100','','0','','100','','200'});
    set(gca,'YTick',250:100:650)
    axis([-200 200 250 650]);
    plottime(plotindex)=t_run(i);
    strtitle=sprintf('t=%ds',t_run(i));
    title([strtitle],'FontName','Helvetica', 'FontSize',15,'fontweight','bold');
    grid on;
    set(gca,'FontName','Helvetica', 'FontSize',15,'fontweight','bold' );
    ylabel('Altitude (km)','FontSize',15,'fontweight','bold');xlabel('Zonal Distance (km)','FontSize',15,'fontweight','bold');
    set(gca,'FontName','Helvetica', 'FontSize',15,'fontweight','bold' );  
    plotindex=plotindex+1;
end

%%%figure 3 ionograms, and it requires ionograms.mat
delta_freq=0.2;
max_freq=10;
nfreq=length(2:delta_freq:max_freq);
freq_vec=2:delta_freq:max_freq;
figindex=1;
figure;
for ionoindex=1+16*nfreq:nfreq:length(ionogram_info)

    subplot(3,4,figindex);
    for freqindex=0:nfreq-1
        
        path_index=1;
        scatter(ionogram_info(ionoindex+freqindex).x_freq,ionogram_info(ionoindex+freqindex).y_vheight, 'filled','b');
        axis([2 12 300 700]);
        hold on;
    end
    set(gca,'FontName','Helvetica', 'FontSize',15,'fontweight','bold' ,'YTick',...
    [300 400 500 600 700]);
    ylabel('Altitude (km)','FontSize',15,'fontweight','bold');xlabel('Frequency (MHz)','FontSize',15,'fontweight','bold');
    strtitle=sprintf('t=%ds',plottime(figindex));
    title([strtitle],'FontName','Helvetica', 'FontSize',15,'fontweight','bold');
    grid on;
    box on;

    figindex= figindex+1; 
end


%%%%Figure 4 plot of electron density, and it requires neGrid_data.mat
figure;
plottime=[];
plotindex=1;
for i=17:length(neGrid_iono)
    subplot(3,4,plotindex)
    zdata=log10(neGrid_iono(i).Ne);
    zdata(isinf(zdata))=0;
    hindex=(350:10:450)/2;
    plot(-200:2:200,zdata(hindex(1:5),:),'-.','linewidth',1);hold on;
    plot(-200:2:200,zdata(hindex(6:end),:),'-','linewidth',0.5);
    set(gca,'XTick',-200:50:200);
    set(gca,'XTickLabel',{'-200','','-100','','0','','100','','200'});
    set(gca,'YTick',8:0.5:13)
    set(gca,'YTickLabel',{'8','','9','','10','','11','','12','','13'});
    axis([-200 200 8 13]);
    plottime(plotindex)=t_run(i);
    strtitle=sprintf('t=%ds',t_run(i));
    title([strtitle],'FontName','Helvetica', 'FontSize',15,'fontweight','bold');
    grid on;
    set(gca,'FontName','Helvetica', 'FontSize',12,'fontweight','bold' );
    ylabel('log10(N)','FontSize',12,'fontweight','bold');xlabel('Zonal Distance (km)','FontSize',12,'fontweight','bold');
    set(gca,'FontName','Helvetica', 'FontSize',12,'fontweight','bold' );  
    plotindex=plotindex+1;
end
legend('350 km','360 km','370 km','380 km','390 km','400 km','410 km','420 km','430 km','440 km','450 km');
