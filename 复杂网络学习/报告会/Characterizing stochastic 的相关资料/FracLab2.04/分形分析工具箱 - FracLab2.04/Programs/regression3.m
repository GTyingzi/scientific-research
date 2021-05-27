function [a_hat,b_hat]=regression3(vect_ech1,vect_log1)
   X=vect_ech1;
   Y=vect_log1;
   test=1;
   while test==1
      t=polyfit(X,Y,1);
      a_hat=t(1);
      b_hat=t(2);
      vect_ech=[];
      vect_log=[];
      for j=1:length(Y)
         if Y(j)>=t(1)*X(j)+t(2)
            vect_ech=[vect_ech X(j)];
            vect_log=[vect_log Y(j)];
         end;
      end;
      if length(vect_ech)<=2 
         test=0;
         else   
            t2=polyfit(vect_ech,vect_log,1);
            if t2==t
               test=0;
            end;   
            X=vect_ech; 
            Y=vect_log;
            a_hat=t2(1);
            b_hat=t2(2);
      end;
   end;
   
    