filename = "Measles.txt";
fileID = fopen(filename, 'r');
data = fscanf(fileID, "%f");
disp(data);
fclose(fileID);