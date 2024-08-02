% Prompt the user to select a CSV file
[filename, pathname] = uigetfile('*.csv', 'Select the CSV file');
if isequal(filename, 0)
    disp('User selected Cancel');
    return;
else
    disp(['User selected ', fullfile(pathname, filename)]);
end

% Read the CSV file
data = readtable(fullfile(pathname, filename));

% Extract data for TrodeId 0 and 1
data0 = data(data.TrodeId == 0, :);
data1 = data(data.TrodeId == 1, :);

% Create a figure with 3 subplots
figure;

% Top plot: vBAT from TrodeId=0
subplot(3, 1, 1);
plot(data0.Millis, data0.vBAT, 'LineWidth', 1.5);
title('vBAT from TrodeId=0');
xlabel('Millis');
ylabel('vBAT (V)');
grid on;

% Second plot: All 7 Mag values from TrodeId=0
subplot(3, 1, 2);
hold on;
plot(data0.Millis, data0.Mag1, 'DisplayName', 'Mag1');
plot(data0.Millis, data0.Mag2, 'DisplayName', 'Mag2');
plot(data0.Millis, data0.Mag3, 'DisplayName', 'Mag3');
plot(data0.Millis, data0.Mag4, 'DisplayName', 'Mag4');
plot(data0.Millis, data0.Mag5, 'DisplayName', 'Mag5');
plot(data0.Millis, data0.Mag6, 'DisplayName', 'Mag6');
plot(data0.Millis, data0.Mag7, 'DisplayName', 'Mag7');
hold off;
title('Mag values from TrodeId=0');
xlabel('Millis');
ylabel('Mag Values');
legend show;
grid on;

% Third plot: All 7 Mag values from TrodeId=1
subplot(3, 1, 3);
hold on;
plot(data1.Millis, data1.Mag1, 'DisplayName', 'Mag1');
plot(data1.Millis, data1.Mag2, 'DisplayName', 'Mag2');
plot(data1.Millis, data1.Mag3, 'DisplayName', 'Mag3');
plot(data1.Millis, data1.Mag4, 'DisplayName', 'Mag4');
plot(data1.Millis, data1.Mag5, 'DisplayName', 'Mag5');
plot(data1.Millis, data1.Mag6, 'DisplayName', 'Mag6');
plot(data1.Millis, data1.Mag7, 'DisplayName', 'Mag7');
hold off;
title('Mag values from TrodeId=1');
xlabel('Millis');
ylabel('Mag Values');
legend show;
grid on;
