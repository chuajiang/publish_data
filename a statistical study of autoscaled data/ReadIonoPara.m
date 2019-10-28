% %????????????????
% %???????????? fullname ????????????
% %?????????? iono_para ????????
% %         iono_para.datenum ?????????? ;
% %         iono_para.fxI;
% %         iono_para.foF2;
% %         iono_para.foF1;
% %         iono_para.foE;
% %         iono_para.foEs;
% %         iono_para.hvF2;
% %         iono_para.hvF1;
% %         iono_para.hvE;
% %         iono_para.hvEs;
% %         iono_para.hmF2;
% %         iono_para.hmF1;
% %         iono_para.hmE ;
% %         iono_para.hbF2;
% %         iono_para.hbF1;
% %         iono_para.hbE;
% %         iono_para.iTEC;

function [iono_para] = ReadIonoPara(fullname)
        iono_para = [];
        fileID = fopen(fullname,'rt');

        if fileID==-1
            return;
        end

        datestr=fgetl(fileID);
        datestr=fgetl(fileID);
        datestr=fgetl(fileID);
        datestr=fgetl(fileID);
        datestr=fgetl(fileID);
        datestr=fgetl(fileID);
        datestr=fgetl(fileID);
        [strcontent, count] = fscanf(fileID, '%c',inf);

        fclose(fileID);
        
        

        pat = 'PP.*';
        PPVV_str = regexp(strcontent, pat, 'match');

        float_pat = '[-+]?[0-9]*\.?[0-9]+';
        para_cell = regexp(PPVV_str, float_pat, 'match');
        para_ = para_cell{1,1};

        iono_para.filename=fullname;
        iono_para.datenum = datenum(str2num(datestr(4:7)), str2num(datestr(8:9)), str2num(datestr(10:11)), str2num(datestr(13:14)), str2num(datestr(15:16)), str2num(datestr(17:18)))-datenum(0, 0, 0, 8,0, 0);
        iono_para.fxI = str2num(cell2mat(para_(1)));
        iono_para.foF2 = str2num(cell2mat(para_(2)));
        iono_para.foF1  = str2num(cell2mat(para_(3)));
        iono_para.foE  = str2num(cell2mat(para_(4)));
        iono_para.foEs  = str2num(cell2mat(para_(5)));
        iono_para.hvF2  = str2num(cell2mat(para_(6)));
        iono_para.hvF1  = str2num(cell2mat(para_(7)));
        iono_para.hvE  = str2num(cell2mat(para_(8)));
        iono_para.hvEs  = str2num(cell2mat(para_(9)));
        iono_para.hmF2  = str2num(cell2mat(para_(10)));
        iono_para.hmF1  = str2num(cell2mat(para_(11)));
        iono_para.hmE  = str2num(cell2mat(para_(12)));
        iono_para.hbF2  = str2num(cell2mat(para_(13)));
        iono_para.hbF1  = str2num(cell2mat(para_(14)));
        iono_para.hbE  = str2num(cell2mat(para_(15)));
        iono_para.iTEC  = str2num(cell2mat(para_(16)));
        
        return;
%         iono_POLAN.
        
        %%%????
        pat = 'VV.*';
        VV_str = regexp(strcontent, pat, 'match');

        float_pat = '[-+]?[0-9]*\.?[0-9]+';
        para_cell = regexp(VV_str, float_pat, 'match');
        para_ = para_cell{1,1};
        
        iono_para.startFreq=str2num(cell2mat(para_(1)));
        iono_para.stepFreq=str2num(cell2mat(para_(2)));
        iono_para.countFreq=str2num(cell2mat(para_(3)));
        iono_para.Hv=[];
        
        for i=1:iono_para.countFreq
            iono_para.Hv(i)=str2num(cell2mat(para_(3+i)));
        end
        
        %%%????
        pat = 'TT.*';
        TT_str = regexp(strcontent, pat, 'match');

        float_pat = '[-+]?[0-9]*\.?[0-9]+';
        para_cell = regexp(TT_str, float_pat, 'match');
        para_ = para_cell{1,1};
        
        iono_para.startHeight=str2num(cell2mat(para_(1)));
        iono_para.stepHeight=str2num(cell2mat(para_(2)));
        iono_para.countHeight=str2num(cell2mat(para_(3)));
        iono_para.fNe=[];
        iono_para.Ht=[];

        for i=1:iono_para.countHeight
            iono_para.fNe(i)=str2num(cell2mat(para_(3+i)));
        end
        
        for i=1:iono_para.countFreq
            if length(iono_para.fNe)<1
                break;
            end
            foF=iono_para.startFreq+(i-1)*iono_para.stepFreq/1000;
            foFabs = abs(iono_para.fNe-foF);%????????????????
            [fvalue,ipos] = min(foFabs);
            iono_para.Ht(i)= iono_para.startHeight + (ipos-1)*iono_para.stepHeight;% str2num(cell2mat(para_(3+i)));
        end
        
        fNm = iono_para.foF2;%(iono_para.foF2*1e6)^2/80.6;
        fHm0 = (iono_para.hmF2-iono_para.hbF2);
        topindex=1;
%         bsize = length(iono_para.fNe);
        for hindex=iono_para.hmF2+0.1:0.1:1200
            fHm = fHm0 + 0*(hindex-iono_para.hmF2);
            fZ = (hindex-iono_para.hmF2)/fHm;
            fNeTop = fNm*exp(0.5*(1-fZ-exp(-fZ)));
            iono_para.fNe(iono_para.countHeight+topindex)=fNeTop;
            topindex = topindex+1;
        end
        
        
        
        
        %%%%%POLAN
        %%%????????
        pat = 'FP.*-1.00';
        VV_str = regexp(strcontent, pat, 'match');

        float_pat = '[-+]?[0-9]*\.?[0-9]+';
        para_cell = regexp(VV_str, float_pat, 'match');
        if isempty(para_cell)
           iono_para.POLAN_VH.Freq=0;
           iono_para.POLAN_VH.Height=0;
           iono_para.POLAN_TH.Freq=0;
           iono_para.POLAN_TH.Height=0;
           return;
        end
        para_ = para_cell{1,1};
        FP_data=0;
        for i=1:length(para_)
           FP_data(i) = str2num(cell2mat(para_(i)));
        end
        
        iono_para.POLAN_VH.Freq=FP_data(1:2:end);
        iono_para.POLAN_VH.Height=FP_data(2:2:end);
        
        if length(para_)>1
           iono_para.POLAN_VH.Freq=FP_data(1:2:end-2);
           iono_para.POLAN_VH.Height=FP_data(2:2:end-1);
        else
           iono_para.POLAN_VH.Freq=0;
           iono_para.POLAN_VH.Height=0;
        end
        
        %%%????
        pat = 'POLAN_TT.*';
        VV_str = regexp(strcontent, pat, 'match');

        float_pat = '[-+]?[0-9]*\.?[0-9]+';
        para_cell = regexp(VV_str, float_pat, 'match');
        if isempty(para_cell)
           iono_para.POLAN_TH.Freq=0;
           iono_para.POLAN_TH.Height=0;
           return;
        end
        para_ = para_cell{1,1};
        FP_data=[];
        for i=1:length(para_)
           FP_data(i) = str2num(cell2mat(para_(i)));
        end
        if length(para_)>1
           iono_para.POLAN_TH.Freq=FP_data(2:2:end);
           iono_para.POLAN_TH.Height=FP_data(3:2:end);
        else
           iono_para.POLAN_TH.Freq=0;
           iono_para.POLAN_TH.Height=0;
        end

%         plot(iono_para.POLAN_TH.Freq, iono_para.POLAN_TH.Height,'r');hold on;
%         plot(iono_para.POLAN_VH.Freq, iono_para.POLAN_VH.Height,'b');hold on;
        

        
        a=[];
        