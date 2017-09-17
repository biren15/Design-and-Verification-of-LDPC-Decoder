clear all, close all, clc;
max_num_frame = 100;
quantized = 1;
SNR = 1:0.4:4.4;
frac_range = [3];
iteration =0
biterror = zeros(length(frac_range),length(SNR));
frameerror = zeros(length(frac_range),length(SNR));
ber = zeros(length(frac_range),length(SNR));
fer = zeros(length(frac_range),length(SNR));

for SNR_index = 1:length(SNR);%--- Max. LLR For Output of Detector
    W = 7;
    for F_ind=1:length(frac_range)
        F = frac_range(F_ind);
        fl = F;
        il = W - F;
        DetectorMaxLLR=2^(W-F-1);
        PacketPeriod=1;%------- Packet Period
        BS='576';%------------ LDPC Output Block Size
        %%II=25;%---------------- LDPC Max. Num. of Iterations
        
        rate='1/2';%------------- LDPC Code Rate
        switch (BS)
            case '576'
                BSN=576;
            case '1920'
                BSN=1920;
            otherwise
                BSN=2304;
        end
        load H_matrices_802_16e
        % for rate 1/2 code load the following matrix
        if (rate=='1/2')
            H_load=H_1_2;
            % Seting Parity Check Matrix
            ind = []; %0:A, 1:B
            Rate=1/2;
        elseif (rate=='2/3')
            H_load=H_2_3;
            % Seting Parity Check Matrix
            ind = [0]; %0:A, 1:B
            Rate=2/3;
        elseif (rate=='2B3')
            H_load=H_2_3_B;
            % Seting Parity Check Matrix
            ind = [1]; %0:A, 1:B
            Rate=2/3;
        elseif (rate=='3A4')
            H_load=H_3_4_A;
            % Seting Parity Check Matrix
            ind = [0]; %0:A, 1:B
            Rate=3/4;
        elseif (rate=='3B4')
            H_load=H_3_4_B;
            % Seting Parity Check Matrix
            ind = [1]; %0:A, 1:B
            Rate=3/4;
        elseif (rate=='5/6')
            H_load=H_5_6;
            % Seting Parity Check Matrix
            ind = []; %0:A, 1:B
            Rate=5/6;
        end
        %-------------- Calculationg Values of Model Variables Based on Parameters
        BSNr=BSN*Rate;
        bP=PacketPeriod/BSNr;%-- bit Period
        % target code length is 1920 hence z = 1920/24 = 80
        z=BSN/24;
        zmat=eye(z);
        [no_rows no_cols]=size(H_load);
        nullmat=zeros(size(zmat));
        nz = no_cols * z;
        mz = no_rows * z;
        kz = nz - mz;
        n = nz/z;
        m = mz/z;
        k = kz/z;
        % For Cml decoder
        % rate should come out as 1/2
        rate = kz/nz;
        Rate = rate;
        [Henc] = InitializeWiMaxLDPC( rate, nz, ind );
        [Mm,Nn]=size(Henc);
        NumAdd=sum(Henc);
        NumComp=sum(Henc,2);
        MaxAddSize=max(NumAdd);
        MaxCompSize=max(NumComp);
        FnmComp=zeros(Mm,MaxCompSize);
        FnmCompIdx=zeros(Mm,MaxCompSize);
        EmnComp=zeros(MaxAddSize,Nn);
        EmnCompIdx=zeros(MaxAddSize,Nn);
        for i=1:Mm
            [RF,CF,FnmComp(i,1:NumComp(i))]=find(Henc(i,:));
            FnmCompIdx(i,1:NumComp(i))=(CF(1:NumComp(i))-1)*Mm+i;
        end
        [FnmCompIdxR,FnmCompIdxC,FnmCompIdxV] = find(FnmCompIdx);
        IndxF=sub2ind([Mm,MaxCompSize],FnmCompIdxR,FnmCompIdxC);
        for i=1:Nn
            [RE,CE,EmnComp(1:NumAdd(i),i)]=find(Henc(:,i));
            EmnCompIdx(1:NumAdd(i),i)=(RE(1:NumAdd(i)))+Mm*(i-1);
        end
        [EmnCompIdxR,EmnCompIdxC,EmnCompIdxV] = find(EmnCompIdx);
        IndxE=sub2ind([MaxAddSize,Nn],EmnCompIdxR,EmnCompIdxC);
        MinsumOrder=(NumComp-1).*Mm+(1:Mm)';
        SubMinsumOrder=MinsumOrder-Mm;
        [temp,tempIdx]=sort(FnmCompIdxV);
        SortedIndxF=IndxF(tempIdx);
        [temp,tempIdx]=sort(EmnCompIdxV);
        SortedIndxE=IndxE(tempIdx);
        Imax=20;
        Stop=0;
        Offset=0;
        H=Henc;
        SpHenc=sparse(Henc);
        noise_var = 0.5*10^(-SNR(SNR_index)/10)*(1/Rate);

        %% simulating
    for frame_index = 1:max_num_frame
    
        %---------------Transmitter Encoding-----------------------------------
        x_after_enco = zeros(1,BSN);                      %Pending Convolution Code
        modulated = 1-x_after_enco.*2;         %Modulating BPSK

        %---------------Channel Transmitting-----------------------------------
        received = modulated + sqrt(noise_var)*(randn(1,BSN)); 

        %---------------Receiver Detection-------------------------------------
        demodulated=real(received);        % Detector
        llr = 2.*demodulated./noise_var;      % LLR Calculation

        %---------------Receiver Decoding--------------------------------------
        %if quantized    
         %   llr = round(llr*2^10);% TODO: process llr if you want run quantized version
        %end
       %%
        % TODO: here is the enter to your function
        % your function should get inputs from llr, H, and return the
        % decoded LLR output, example is as below:
        %pause
        Output = ldpc_decoder(llr, H);
      %pause
        %output- (llr>0)
       
       iteration = iteration+1;
        
        %%
        
        %[Output, Itr, NuCkNoEr] = LDPC(llr_pri_polar.', Stop,Mm,Nn, Offset, Imax, H, W, F,MinsumOrder,SubMinsumOrder,MaxCompSize,MaxAddSize,SortedIndxE,SortedIndxF);
        
        
dec = Output > 0;
        biterror(F_ind, SNR_index) = biterror(F_ind, SNR_index) + sum(dec);
        if sum(dec) ~= 0
            frameerror(F_ind, SNR_index)= frameerror(F_ind, SNR_index) + 1;
        end
        if biterror(F_ind, SNR_index) >= 500 && frameerror(F_ind, SNR_index)>=100
            ber(F_ind, SNR_index)=biterror(F_ind, SNR_index)/(BSN*frame_index);
            fer(F_ind, SNR_index)=frameerror(F_ind, SNR_index)/frame_index;
            fprintf('SNR is %d: ber: %f; fer: %f\n', SNR(SNR_index), biterror(SNR_index)/(BSN*frame_index), frameerror(SNR_index)/frame_index);
            break;
        end
%         if mod(frame_index,1000)==0
             fprintf('SNR is %d: ber: %f; fer: %f\n', SNR(SNR_index), biterror(SNR_index)/(BSN*frame_index), frameerror(SNR_index)/frame_index);
%         end
    end
%     %% output
%         fid = fopen('Script_BPSK_LDPC.txt','a+');
%         
%         fclose(fid);
    end
end