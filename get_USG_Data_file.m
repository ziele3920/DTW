function [Data_raw]=get_USG_Data_file_MEAS(name1,pname)
%WCZYTYWANIE DANYCH Z ULTRASOUND SYSTEM z nag³owkiem

%Choose .txt file 
            [name1,pname]=uigetfile('*.txt' , 'Chose txt file'); %wybor pliku do analizy; name-nazwa; pname-scizka dostepu
            file1 = [pname name1];                                 
            fid = fopen(file1,'r');           %fid identyfikuje plik otwarty do odczytu
            count = 1;
%initialise Matrix with the Data
            Data=[];
            tline = fgetl(fid);    %linijka z pliku wskazywanego przez fid (jak bedzie ostatnia do tline=-1)
            %procedure for files with header
            if length(tline) > 25
                while 1
                tline = fgetl(fid);
                    if tline == -1
                        fclose(fid);
                        break
                    else
            %store sampling frequency in variable fs
                    if count == 4  %odczyt czestotliwosci probkowania
                        fs = strcat(tline(16),tline(17),tline(18)); %sklejanie do jednego wiersza
                        fs = str2num(fs);
                        count = count+1;
            %write first element twice into Data matrix zastapienie zer z pierwszego wiersza elementami z nastepnego
                   elseif count == 8
                        newtline = strrep(tline,',','.');           %zastepowanie przecinkow kropkami
                        row = str2num(newtline);
                        Data = [row];
                        Data = [Data;row];
                        count = count+1; 
            %fill Data matrix with values
                    elseif count > 8 
                        newtline = strrep(tline, ',','.');
                        newrow = str2num(newtline);
                        Data = [Data;newrow];
                        count = count+1;   
                    else
                        count = count+1;
                    end
                end
                end
 %procedure for files without header
            else 
                newtline = strrep(tline,',','.');
                row = str2num(newtline);
                Data = [row];
                while 1
                    tline = fgetl(fid);
                    if tline == -1
                        fclose(fid);
                        break
                    else
                        newtline = strrep(tline, ',','.');
                        newrow = str2num(newtline)
                        Data = [Data;newrow];
                    end
                end
            end
    Data_raw=Data;