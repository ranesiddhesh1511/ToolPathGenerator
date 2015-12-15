function[matrix_1] = readSTLexp8(filename)
% reads ASCII STL file and gives coordinates of vertices.
%filename-name of file(test.stl)
fid=fopen(filename);
C=textscan(fid,'%s');
%reads file and generates cell.
k = cellfun(@length,C);
%gives number length of the array.
m = 11;
i = 1;
 while(m < (k-3))
      
   j = 1;
     while (j < 4)    
     l = 1;
             while(l<4)
              coordinates(i,1) = str2double(C{1,1}{m,1});   
              % data in cells were in 'char' format .convert it to double as
              % matrix cant store 'char's.
              
                l = l+1;  % makes sure loop runs thrice.
                m = m+1;  % access corresponding row from cell'C'.
                i = i+1;  % row number in output matrix.
             
             end 
            
           
      m = m+1;
      j = j+1;
     end
   
   m = m+9;
 
 end
 
 % plotting file using patch command.
 
  S = size(coordinates,1);
  T = S(1,1);
  
       n = 1;
       o = 1;

       while(n<(T-1))
       X(o,1)= coordinates(n,1);
       o = o+1;
       n = n+3;
       end
       o=1;
       n =2;
       while(n<T)
       Y(o,1)= coordinates(n,1);            % 3 while loops separtates coordinates into 3 different arrays( X,Y and Z)
       o =o+1;
       n = n+3;
       end
       o=1;
       n = 3;
       while(n<=T)
       Z(o,1)= coordinates(n,1);
       o = o+1;
       n = n+3;
       end
     
     max_z = max(Z);
     T = T/3;
     f = 1;
     z = 0;
    
     
 while(z<max_z)
     
     u = 1;
     v = 2;
     w = 3;
     n = 1;
     Q_flag = 0;

 while(w<=T)
     
      
              
     if ((abs(Z(u,1) - z) < 0.001) & (abs(Z(v,1) - z) < 0.001) & (abs(Z(w,1) - z) < 0.001))
                                                           % case 1 = when triangle is parallel to cutting plane
             Q{1,f}{n,1} = X(u,1);
             Q{1,f}{n,2} = X(v,1);
             Q{1,f}{n,3} = Y(u,1);
             Q{1,f}{n,4} = Y(v,1);
             Q{1,f}{n,5} = -2;
             Q{1,f}{n,6} = z;
             n = n+1;
             Q{1,f}{n,1} = X(v,1);
             Q{1,f}{n,2} = X(w,1);
             Q{1,f}{n,3} = Y(v,1);
             Q{1,f}{n,4} = Y(w,1);
             Q{1,f}{n,5} = -2;
             Q{1,f}{n,6} = z;
             n = n+1;
             Q{1,f}{n,1} = X(w,1);
             Q{1,f}{n,2} = X(u,1);
             Q{1,f}{n,3} = Y(w,1);
             Q{1,f}{n,4} = Y(u,1);
             Q{1,f}{n,5} = -2;
             Q{1,f}{n,6} = z;
             n= n+1;
             Q_flag = 1;

             
           
     elseif  ((abs(Z(u,1) - z) < 0.001) & (abs(Z(v,1) - z) < 0.001))                    % next three conditions are for condition when when two points of the triangle are in cutting plane.
         
             Q{1,f}{n,1} = X(u,1);
             Q{1,f}{n,2} = X(v,1);
             Q{1,f}{n,3} = Y(u,1);
             Q{1,f}{n,4} = Y(v,1);
             Q{1,f}{n,5} = Z(w,1);
             Q{1,f}{n,6} = z;
             n = n+1;
             Q_flag = 1;
          
     elseif ((abs(Z(v,1) - z) < 0.001) & (abs(Z(w,1) - z) < 0.001))
          
             Q{1,f}{n,1} = X(v,1);
             Q{1,f}{n,2} = X(w,1);
             Q{1,f}{n,3} = Y(v,1);
             Q{1,f}{n,4} = Y(w,1);
             Q{1,f}{n,5} = Z(u,1);
             Q{1,f}{n,6} = z;
             n = n+1;
             Q_flag = 1;
          
     elseif ((abs(Z(u,1) - z) < 0.001) & (abs(Z(w,1) - z) < 0.001))
         
             Q{1,f}{n,1} = X(u,1);
             Q{1,f}{n,2} = X(w,1);
             Q{1,f}{n,3} = Y(u,1);
             Q{1,f}{n,4} = Y(w,1);
             Q{1,f}{n,5} = Z(v,1);
             Q{1,f}{n,6} = z;
             n = n+1;
             Q_flag = 1;
         
     elseif ((abs(Z(v,1) - z) < 0.001) & (((Z(u,1)>z)&(Z(w,1)<z))|((Z(u,1)<z)&(Z(w,1)>z))))             % when only one point is on palne..next three cases.
         
             p = (z- Z(u,1))/(Z(w,1)-Z(u,1));
             A = X(u,1)+p*(X(w,1)-X(u,1));
             B = Y(u,1)+p*(Y(w,1)-Y(u,1));
             C = Z(u,1)+p*(Z(w,1)-Z(u,1));
             
             Q{1,f}{n,1} = X(v,1);
             Q{1,f}{n,2} = A;
             Q{1,f}{n,3} = Y(v,1);
             Q{1,f}{n,4} = B;
             Q{1,f}{n,5} = -1;
             Q{1,f}{n,6} = z;
             n = n+1;
             Q_flag = 1;
         
     elseif (abs(Z(u,1) - z) < 0.001)& (((Z(v,1)>z)&(Z(w,1)<z))|((Z(v,1)<z)&(Z(w,1)>z)))
         
             p = (z- Z(v,1))/(Z(w,1)-Z(v,1));
             A = X(v,1)+p*(X(w,1)-X(v,1));
             B = Y(v,1)+p*(Y(w,1)-Y(v,1));
             C = Z(v,1)+p*(Z(w,1)-Z(v,1));
             
             Q{1,f}{n,1} = X(u,1);
             Q{1,f}{n,2} = A;
             Q{1,f}{n,3} = Y(u,1);
             Q{1,f}{n,4} = B;
             Q{1,f}{n,5} = -1;
             Q{1,f}{n,6} = z;
             n = n+1;
             Q_flag = 1;
     
     elseif  ((abs(Z(w,1) - z) < 0.001)&(((Z(v,1)>z)&(Z(u,1)<z))|((Z(v,1)<z)&(Z(u,1)>z))))
         
             p = (z- Z(u,1))/(Z(v,1)-Z(u,1));
             A = X(u,1)+p*(X(v,1)-X(u,1));
             B = Y(u,1)+p*(Y(v,1)-Y(u,1));
             C = Z(u,1)+p*(Z(v,1)-Z(u,1));
             
             Q{1,f}{n,1} = X(w,1);
             Q{1,f}{n,2} = A;
             Q{1,f}{n,3} = Y(w,1);
             Q{1,f}{n,4} = B;
             Q{1,f}{n,5} = -1;
             Q{1,f}{n,6} = z;
             n = n+1;
             Q_flag = 1;
         
     elseif (((z<Z(u,1)) & (z>Z(v,1)) & (z>Z(w,1))) | ((z>Z(u,1)) & (z<Z(v,1)) & (z<Z(w,1))))             % case 4 
         
              q = (z- Z(u,1))/(Z(v,1)-Z(u,1));
              D = X(u,1)+q*(X(v,1)-X(u,1));
              E = Y(u,1)+q*(Y(v,1)-Y(u,1));
              F = Z(u,1)+q*(Z(v,1)-Z(u,1));
              r = (z- Z(u,1))/(Z(w,1)-Z(u,1));
              G = X(u,1)+r*(X(w,1)-X(u,1));
              H = Y(u,1)+r*(Y(w,1)-Y(u,1));
              I = Z(u,1)+r*(Z(w,1)-Z(u,1));
              
              Q{1,f}{n,1} = D;
              Q{1,f}{n,2} = G;
              Q{1,f}{n,3} = E;
              Q{1,f}{n,4} = H;
              Q{1,f}{n,5} = -1;
              Q{1,f}{n,6} = z;
              n = n+1;
              Q_flag = 1;
         
     elseif (((z<Z(v,1)) & (z>Z(u,1)) & (z>Z(w,1))) | ((z>Z(v,1)) & (z<Z(u,1)) & (z<Z(w,1))))
         
              q = (z- Z(v,1))/(Z(u,1)-Z(v,1));
              D = X(v,1)+q*(X(u,1)-X(v,1));
              E = Y(v,1)+q*(Y(u,1)-Y(v,1));
              F = Z(v,1)+q*(Z(u,1)-Z(v,1));
              r = (z- Z(v,1))/(Z(w,1)-Z(v,1));
              G = X(v,1)+r*(X(w,1)-X(v,1));
              H = Y(v,1)+r*(Y(w,1)-Y(v,1));
              I = Z(v,1)+r*(Z(w,1)-Z(v,1));
              
              Q{1,f}{n,1} = D;
              Q{1,f}{n,2} = G;
              Q{1,f}{n,3} = E;
              Q{1,f}{n,4} = H;
              Q{1,f}{n,5} = -1;
              Q{1,f}{n,6} = z;
              n = n+1;
              Q_flag = 1;
      
     elseif (((z<Z(w,1)) & (z>Z(u,1)) & (z>Z(v,1))) | ((z>Z(w,1)) & (z<Z(u,1)) & (z<Z(v,1))))
         
             
              t = linspace(0,1);
              q = (z- Z(w,1))/(Z(u,1)-Z(w,1));
              D = X(w,1)+q*(X(u,1)-X(w,1));
              E = Y(w,1)+q*(Y(u,1)-Y(w,1));
              F = Z(w,1)+q*(Z(u,1)-Z(w,1));
              r = (z- Z(w,1))/(Z(v,1)-Z(w,1));
              G = X(w,1)+r*(X(v,1)-X(w,1));
              H = Y(w,1)+r*(Y(v,1)-Y(w,1));
              I = Z(w,1)+r*(Z(v,1)-Z(w,1));
              
              Q{1,f}{n,1} = D;
              Q{1,f}{n,2} = G;
              Q{1,f}{n,3} = E;
              Q{1,f}{n,4} = H;
              Q{1,f}{n,5} = -1;
              Q{1,f}{n,6} = z;
              n = n+1;
              Q_flag = 1;
         
     else
         
         
     end                                                         % AHA !!
    
     
     u = u+3;
     v = v+3;
     w = w+3;
     
 end 

 % repeating line removal.
 if(Q_flag ==1)
 
 cell_dim = cellfun('size',Q,1);
 S = cell_dim(1,f);
 t = 1;
 s = 2;
 
 
  while(t<S)
 
      while(s<=S)     
            
     
            if (Q{1,f}{t,5}==-3)
 
            elseif((((abs(Q{1,f}{t,1}-Q{1,f}{s,2})<0.001)&(abs(Q{1,f}{t,2}-Q{1,f}{s,1})<0.001)&(abs(Q{1,f}{t,3}-Q{1,f}{s,4})<0.001)&(abs(Q{1,f}{t,4}-Q{1,f}{s,3})<0.001))...
                    |((abs(Q{1,f}{t,1}-Q{1,f}{s,1})<0.001)&(abs(Q{1,f}{t,2}-Q{1,f}{s,2})<0.001)&((Q{1,f}{t,3}-Q{1,f}{s,3})<0.001)&(abs(Q{1,f}{t,4}-Q{1,f}{s,4})<0.001)))...
                    &((Q{1,f}{t,5}==-2)&(Q{1,f}{s,5}==-2)))
       
                 Q{1,f}{t,5}= -3;
                 Q{1,f}{s,5}= -3;
     
            elseif ((((abs(Q{1,f}{t,1}-Q{1,f}{s,2})<0.001)&(abs(Q{1,f}{t,2}-Q{1,f}{s,1})<0.001)&(abs(Q{1,f}{t,3}-Q{1,f}{s,4})<0.001)&(abs(Q{1,f}{t,4}-Q{1,f}{s,3})<0.001))...
                    |((abs(Q{1,f}{t,1}-Q{1,f}{s,1})<0.001)&(abs(Q{1,f}{t,2}-Q{1,f}{s,2})<0.001)&(abs(Q{1,f}{t,3}-Q{1,f}{s,3})<0.001)&(abs(Q{1,f}{t,4}-Q{1,f}{s,4})<0.001)))& ...
                    (((Q{1,f}{t,5}==-2)&(Q{1,f}{s,5}~=-2))|((Q{1,f}{t,5}~=-2)&(Q{1,f}{s,5}==-2))))
         
                 Q{1,f}{t,5}= -3;
         
            elseif ((((abs(Q{1,f}{t,1}-Q{1,f}{s,2})<0.001)&(abs(Q{1,f}{t,2}-Q{1,f}{s,1})<0.001)&(abs(Q{1,f}{t,3}-Q{1,f}{s,4})<0.001)&(abs(Q{1,f}{t,4}-Q{1,f}{s,3})<0.001))|...
                    ((abs(Q{1,f}{t,1}-Q{1,f}{s,1})<0.001)&(abs(Q{1,f}{t,2}-Q{1,f}{s,2})<0.001)&(abs(Q{1,f}{t,3}-Q{1,f}{s,3})<0.001)&(abs(Q{1,f}{t,4}-Q{1,f}{s,4})<0.001)))&...
                    (((Q{1,f}{t,5}<z)&(Q{1,f}{s,5}>z))|((Q{1,f}{t,5}>z)&(Q{1,f}{s,5}<z))))
          
                 Q{1,f}{t,5}= -3;
 
            elseif ((((abs(Q{1,f}{t,1}-Q{1,f}{s,2})<0.001)&(abs(Q{1,f}{t,2}-Q{1,f}{s,1})<0.001)&(abs(Q{1,f}{t,3}-Q{1,f}{s,4})<0.001)&(abs(Q{1,f}{t,4}-Q{1,f}{s,3})<0.001))|...
                    ((abs(Q{1,f}{t,1}-Q{1,f}{s,1})<0.001)&(abs(Q{1,f}{t,2}-Q{1,f}{s,2})<0.001)&(abs(Q{1,f}{t,3}-Q{1,f}{s,3})<0.001)&(abs(Q{1,f}{t,4}-Q{1,f}{s,4})<0.001)))&...
                    (((Q{1,f}{t,5}>z)&(Q{1,f}{s,5}>z))|((Q{1,f}{t,5}<z)&(Q{1,f}{s,5}<z))))
         
                 Q{1,f}{t,5}= -3;
                 Q{1,f}{s,5}= -3;
            else
     
            end
            
            s = s+1;
            
      end
            
      t = t+1;
      s = t+1;
  end
  
  t=1;
  
  while(t<=S)                      % delete rows with zref = -3
      
      if (Q{1,f}{t,5} == -3)
          
          Q{1,f}(t,:) = [];
          t = t-1;
          S = S-1;
      else
      
      end
      
      t =t+1;
      
  end
  
      max_Y = 0;      % maximum and minimum value of Y
      temp_3 = 0;
  
 for column = 3:4
     
      for p = 1:t-1
         
         if(Q{1,f}{p,column} > temp_3)
             max_Y = Q{1,f}{p,column};
             temp_3 = max_Y;
         else
             
         end
      end    
         
  end

  g = 1;
  for y_slice =0:25:max_Y
    
    for row= 1:t-1  
      
       if ((abs(Q{1,f}{row,4} - Q{1,f}{row,3})< 0.001)&(abs(Q{1,f}{row,4} - y_slice) < 0.001))
          
          code_raw{1,f}{g,1} = Q{1,f}{row,1};
          code_raw{1,f}{g,2} = Q{1,f}{row,3};
          g = g + 1;
          code_raw{1,f}{g,1} = Q{1,f}{row,2};
          code_raw{1,f}{g,2} = Q{1,f}{row,4};
          g = g + 1;
      
      elseif ((abs(Q{1,f}{row,1} - Q{1,f}{row,2})<0.001)&...
              (((y_slice<=Q{1,f}{row,4})&(y_slice>=Q{1,f}{row,3}))|((y_slice>=Q{1,f}{row,4})&(y_slice<=Q{1,f}{row,3}))))
          
          code_raw{1,f}{g,1} = Q{1,f}{row,1};
          code_raw{1,f}{g,2} = y_slice;
          g = g + 1;
      
      else
  
          temp_1 = (Q{1,f}{row,1}) + ((y_slice - Q{1,f}{row,3})*((Q{1,f}{row,2}-Q{1,f}{row,1})/(Q{1,f}{row,4}-Q{1,f}{row,3})));
          temp_2 = y_slice;
          
          if ((((Q{1,f}{row,1}<=temp_1)&(temp_1<=Q{1,f}{row,2}))|((Q{1,f}{row,2}<=temp_1)&(temp_1<=Q{1,f}{row,1})))&...
                  ((Q{1,f}{row,3}<=temp_2<=Q{1,f}{row,4})|(Q{1,f}{row,4}<=temp_2<=Q{1,f}{row,3})))
              
              code_raw{1,f}{g,1} = temp_1;
              code_raw{1,f}{g,2} = temp_2;
              g = g + 1; 
          else
              
          end
  
      end
                                  
    end
  
  end
  
  % assign -4 value to repeating rows.
  
  mat_size = cellfun('size',code_raw,1);
  no_rows = mat_size(1,f);
  G = 1;
  B = 2;
  
 
  while(G < no_rows)
      
      while(B <= no_rows)
          
          if((abs(code_raw{1,f}{G,1}-code_raw{1,f}{B,1}) < 0.1)&(abs(code_raw{1,f}{G,2}-code_raw{1,f}{B,2}) < 0.1))
              
               code_raw{1,f}{G,3} = -4;
              
          else
              
          
          end 
          
          B = B + 1;
      end
      
      G = G + 1;
      B = G + 1;
  end
  
  count = 1;
  
  while(count <= no_rows)                      % delete rows with ref = -4
      
      if (code_raw{1,f}{count,3} == -4)
          
          code_raw{1,f}(count,:) = [];
          count = count-1;
          no_rows = no_rows - 1;
      
      else
      
      end
      
      count = count + 1;
      
  end
  
  % arrange co-ordinates in ascending order 
  
  new_row = 1;
  row_no = 1;
  new_column = 1;
  
  for y_slice = 0:25:max_Y
      
      no_coordinates = cellfun('size',code_raw,1);  
      no_of_rows = no_coordinates(1,f);
      points_count = 1; 
         
         while(points_count < no_of_rows)
           
             if ((code_raw{1,f}{row_no,2}-y_slice) < 0.001)
               
                 points_count = points_count + 1;
                 matrix_1{new_column,1}{new_row,1} = points_count;
                 row_no = row_no + 1;
             
             else    
                 
                 new_row = new_row + 1;
             
             end
             
             points_count = 1;
            
         end
      
      new_column = new_column + 1;
         
  end
  
    f = f + 1;                                     % next matrix in cell
    z = z + 1;                                     % increment slice height
 
 end                                               % next slice
 
 
 end                                               % program end



