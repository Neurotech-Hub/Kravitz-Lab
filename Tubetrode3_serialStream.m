%% !! This is old code. It will need to be updated based on latest firmware.

% Define the serial port and baud rate
% serialportlist
% Clear any existing serial port connections
ports = serialportlist("all");
for i = 1:length(ports)
    portObj = serialport(ports(i), 9600); % Baud rate is irrelevant here
    clear portObj;
end


serialPort = '/dev/cu.usbmodem111301'; % Change to the appropriate serial port
baudRate = 9600;

% Create a serialport object
s = serialport(serialPort, baudRate);

% Define the number of channels and buffer size
numChannels = 7;
bufferSize = 200;

% Initialize circular buffers for each device
buffer0 = zeros(bufferSize, numChannels);
buffer1 = zeros(bufferSize, numChannels);

% Create a figure for plotting
fig = figure;

% Register the cleanup function to run when script exits
cleanupObj = onCleanup(@() cleanupSerialPort(s));

% Continuously read and plot data
while true
    % Check if the figure window is closed
    if ~isvalid(fig)
        break;
    end

    % Read a line of data from the serial stream
    dataLine = readline(s);

    % Parse the data into numerical values
    data = sscanf(dataLine, '%d,');

    % Ensure we have 14 values
    if numel(data) == 14
        % Split the data into two sets of 7 channels
        data0 = data(1:7);
        data1 = data(8:14);

        % Update circular buffers
        buffer0 = [buffer0(2:end, :); data0'];
        buffer1 = [buffer1(2:end, :); data1'];

        % Plot data for device 0
        subplot(2, 1, 1);
        plot(buffer0);
        title('Device 0');
        xlabel('Sample');
        ylabel('Value');
        legend(arrayfun(@(x) sprintf('Channel %d', x), 1:numChannels, 'UniformOutput', false));

        % Plot data for device 1
        subplot(2, 1, 2);
        plot(buffer1);
        title('Device 1');
        xlabel('Sample');
        ylabel('Value');
        legend(arrayfun(@(x) sprintf('Channel %d', x), 1:numChannels, 'UniformOutput', false));

        % Pause to allow for plotting
        pause(0.01);
    end
end

function cleanupSerialPort(s)
    clear s;
    disp('Serial port closed.');
end
