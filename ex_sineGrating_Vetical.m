
clc
clear all
close all
% load dphase1;
% h=dphase1;

I01 =imread('./GCface/VI01.bmp');
I02 =imread('./GCface/VI02.bmp');
I03 =imread('./GCface/VI03.bmp'); 
I04 =imread('./GCface/VI04.bmp'); 
I05 =imread('./GCface/VI05.bmp'); 
I01=double(I01);
I02=double(I02); 
I03=double(I03); 
I04=double(I04); 
I05=double(I05); 
a=I01*sin(2*pi/5)+I02*sin(4*pi/5)+I03*sin(6*pi/5)+I04*sin(8*pi/5)+I05*sin(10*pi/5);
b=I01*cos(2*pi/5)+I02*cos(4*pi/5)+I03*cos(6*pi/5)+I04*cos(8*pi/5)+I05*cos(10*pi/5);
phase0=atan2(a,b); 
figure
imshow(phase0)
title('reference wrapping phase')

[M, N] = size(phase0);
num_residual=zeros(size(phase0));   %解包
 for i=1:M
     for j=2:N
         if abs(phase0(i,j)-phase0(i,j-1))<pi
             num_residual(i,j)=num_residual(i,j-1);
         elseif phase0(i,j)-phase0(i,j-1)<=-pi
             num_residual(i,j)=num_residual(i,j-1)+1;
         elseif phase0(i,j)-phase0(i,j-1)>=pi
             num_residual(i,j)=num_residual(i,j-1)-1;
         end
     end
 end    
 absphase0=phase0+2*pi.*num_residual;
 figure
 mesh(1-mat2gray(absphase0(:, :, 1)))
 colormap cool
 title('absolute reference phase')


I1=imread('./GCface/VI1.bmp');
I2=imread('./GCface/VI2.bmp');
I3=imread('./GCface/VI3.bmp');
I4=imread('./GCface/VI4.bmp');
I5=imread('./GCface/VI5.bmp'); 
I1=double(I1);
I2=double(I2); 
I3=double(I3);
I4=double(I4);
I5=double(I5);
a=I1*sin(2*pi/5)+I2*sin(4*pi/5)+I3*sin(6*pi/5)+I4*sin(8*pi/5)+I5*sin(10*pi/5);
b=I1*cos(2*pi/5)+I2*cos(4*pi/5)+I3*cos(6*pi/5)+I4*cos(8*pi/5)+I5*cos(10*pi/5); 
phase=atan2(a,b); 
figure
imshow(phase)
title('modulated wrapping phase')

[M, N] = size(phase);
num_residual=zeros(size(phase));   %解包
 for i=1:M
     for j=2:N
         if abs(phase(i,j)-phase(i,j-1))<pi
             num_residual(i,j)=num_residual(i,j-1);
         elseif phase(i,j)-phase(i,j-1)<=-pi
             num_residual(i,j)=num_residual(i,j-1)+1;
         elseif phase(i,j)-phase(i,j-1)>=pi
             num_residual(i,j)=num_residual(i,j-1)-1;
         end
     end
 end    
 absphase=phase+2*pi.*num_residual;
 figure
 mesh(1-mat2gray(absphase(:, :, 1)))
 colormap cool
 title('absolute modulated phase')
 
 sample_phase = absphase - absphase0;
 figure
 mesh(1 - mat2gray(sample_phase(:, :, 1)));
 colormap cool
 title('sample height map')
 
 
%计算出相位差
dphase=phase-phase0; 
figure
imshow(mat2gray(dphase(:,:,1)));
title('wrapping phase')

[M, N] = size(I1);
num_res=zeros(size(dphase));   %解包

 for i=2:M
     for j=1:N
         if abs(dphase(i,j)-dphase(i-1,j))<pi
             num_res(i,j)=num_res(i-1,j);
         elseif dphase(i,j)-dphase(i-1,j)<=-pi
             num_res(i,j)=num_res(i-1,j)+1;
         elseif dphase(i,j)-dphase(i-1,j)>=pi
             num_res(i,j)=num_res(i-1,j)-1;
         end
     end
 end    

 pphase=dphase+2*pi.*num_res;

result = mat2gray(pphase(:, :, 1));
result1 = 1- result;
figure
imshow(result1)
title('unwrapping phase')

figure
mesh(result1); 
colormap cool;
title('heat map')
