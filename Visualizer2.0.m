classdef Visualizer < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        GridLayout                    matlab.ui.container.GridLayout
        LeftPanel                     matlab.ui.container.Panel
        Image                         matlab.ui.control.Image
        Choosemp3fileButton           matlab.ui.control.Button
        PlayPauseButton               matlab.ui.control.Button
        TextArea                      matlab.ui.control.TextArea
        RightPanel                    matlab.ui.container.Panel
        Timescope2Button              matlab.ui.control.Button
        SpectrumscopeButton           matlab.ui.control.Button
        ArrayScopeButton              matlab.ui.control.Button
        YLimitsLabel_2                matlab.ui.control.Label
        YLimitsDropDown               matlab.ui.control.DropDown
        TimeSpanSpinnerLabel          matlab.ui.control.Label
        TimeSpanSpinner               matlab.ui.control.Spinner
        FullAxesDropDownLabel         matlab.ui.control.Label
        FullAxesDropDown              matlab.ui.control.DropDown
        YLimitsDropDown_2Label        matlab.ui.control.Label
        YLimitsDropDown_2             matlab.ui.control.DropDown
        XoffsetLabel                  matlab.ui.control.Label
        XoffsetSpinner                matlab.ui.control.Spinner
        YLimitsLabel                  matlab.ui.control.Label
        YLimitsDropDown_3             matlab.ui.control.DropDown
        PlotTypeDropDownLabel         matlab.ui.control.Label
        PlotTypeDropDown              matlab.ui.control.DropDown
        XScaleSwitchLabel             matlab.ui.control.Label
        XScaleSwitch                  matlab.ui.control.Switch
        PlorasMagnitudePhaseSwitchLabel  matlab.ui.control.Label
        PlorasMagnitudePhaseSwitch    matlab.ui.control.Switch
        ViewTypeDropDownLabel         matlab.ui.control.Label
        ViewTypeDropDown              matlab.ui.control.DropDown
        DomainSwitchLabel             matlab.ui.control.Label
        DomainSwitch                  matlab.ui.control.Switch
        FrScaleandSidesDropDownLabel  matlab.ui.control.Label
        FrScaleandSidesDropDown       matlab.ui.control.DropDown
        FriquencySpamDropDownLabel    matlab.ui.control.Label
        FriquencySpamDropDown         matlab.ui.control.DropDown
        WindowLengthSpinnerLabel      matlab.ui.control.Label
        WindowLengthSpinner           matlab.ui.control.Spinner
        WindowDropDownLabel           matlab.ui.control.Label
        WindowDropDown                matlab.ui.control.DropDown
        PlotTypeSwitchLabel           matlab.ui.control.Label
        PlotTypeSwitch                matlab.ui.control.Switch
        TimeSpanSpinner_2Label        matlab.ui.control.Label
        TimeSpanSpinner_2             matlab.ui.control.Spinner
        GridLinesSwitchLabel          matlab.ui.control.Label
        GridLinesSwitch               matlab.ui.control.Switch
        GridLinesSwitch_2Label        matlab.ui.control.Label
        GridLinesSwitch_2             matlab.ui.control.Switch
        YScaleSwitchLabel             matlab.ui.control.Label
        YScaleSwitch                  matlab.ui.control.Switch
        FrameLengthDropDownLabel      matlab.ui.control.Label
        FrameLengthDropDown           matlab.ui.control.DropDown
        TimescopeButton               matlab.ui.control.Button
        TimeSpanSpinner_3Label        matlab.ui.control.Label
        TimeSpanSpinner_3             matlab.ui.control.Spinner
        YLimitsDropDown_4Label        matlab.ui.control.Label
        YLimitsDropDown_4             matlab.ui.control.DropDown
        PlotTypeSwitch_2Label         matlab.ui.control.Label
        PlotTypeSwitch_2              matlab.ui.control.Switch
        SpectrumUnitsDropDownLabel    matlab.ui.control.Label
        SpectrumUnitsDropDown         matlab.ui.control.DropDown
        AxesLayoutDropDownLabel       matlab.ui.control.Label
        AxesLayoutDropDown            matlab.ui.control.DropDown
        GridLinesSwitch_3Label        matlab.ui.control.Label
        GridLinesSwitch_3             matlab.ui.control.Switch
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    
    properties (Access = private)
        player
        gurdian = 1 ;% metabliti frouros gia to stateButton
        filename 
        
       
        frameLength = 1024;
        
       % metablites gia to TimeScope 1 
       showgrid_tms1 = true;
       ylimits_tms1 =  [-10 10] ;
       timespan_tms1 = 1;
       plottype_tms1 = 'Line';
       maxAxes_tms1 = 'Auto';
       
       
      % Metablites gia to TimeScope 2
      ylimits_tsm2 = [-10 10];
      timespan_tsm2 = 1;
      showgrid_tsm2 = true;
      
      % Metablites gia to Array Plot
      xOffset_Arpl = -10;
      ylimits_Arpl = [-10 10];
      plottype_Arpl = 'Stem';
      xscale_Arpl = 'Linear';
      yscale_Arpl = 'Linear';
      magnitudePhase_Arpl = false;
      
      
      %metablites gia to SpectrumScope
      viewtype_SpSc = 'Spectrum';
      inputDomain_SpSc = 'Time';
      twosidePlot_SpSc = true;
      freqScale_SpSc = 'linear';
      freqSpan_SpSc = 'Full';
      window_SpSc ='Hann';
      windowLength_SpSc = 1024;
      SpectrumUnits_SpSc = 'Auto';
      timespan_SpSc = 1;
      plottype_SpSc = 'Line'
      axesLayout_SpSc = 'Vertical';
      ylimits_SpSc = [-80 20];
      showgrid_SpSc = true;
      span_SpSc = 10e3;
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: Choosemp3fileButton
        function Choosemp3fileButtonPushed(app, event)
            % Kodikas gia to "Choose .mp3 or .wav file"  Button
            
            [file, path]=uigetfile({'*.mp3';'*.wav'});
            app.filename = [path file];      
            
            [data, fs] = audioread(app.filename);
            
            
            app.player = audioplayer(data, fs);
            
            
            app.TextArea.Value = app.filename;
            
        end

        % Callback function
        function Timrscope1ButtonPushed(app, event)
            

             
        end

        % Button pushed function: Timescope2Button
        function Timescope2ButtonPushed(app, event)
            
          %kodikas gia to TimeScope 2 Button 
            
            fileReader = dsp.AudioFileReader( ...   % xrish tou  fileReader gia na diavasei to kommati                                      
                app.filename, ...                   % me to frameLength pou theloume
                'SamplesPerFrame',app.frameLength);
            
            deviceWriter = audioDeviceWriter( ...     % me to deviceWriter grafete to kommati stin suskeui
                'SampleRate',fileReader.SampleRate);  % eksodou to mousiko kommati, diladi paizei apo ta hxeia
            
            scope = dsp.TimeScope('SampleRate',fileReader.SampleRate,... 
                'TimeSpanOverrunAction','Scroll', ...
                'AxesScaling','Manual', ...
                'BufferLength',4*fileReader.SampleRate, ...   
                'ShowLegend',true, ...
                'ChannelNames',{'Channel 1','Channel 2'}); 
            scope.TimeSpan = app.timespan_tsm2;
            scope.Title = app.filename;
            scope.ShowGrid = app.showgrid_tsm2;
            scope.YLimits = app.ylimits_tsm2;
            
            
            
            while ~isDone(fileReader)  
                signal = fileReader();
                deviceWriter(signal);
                scope(signal)
            end
            
            release(fileReader);
            release(deviceWriter);
            release(scope);     
        end

        % Button pushed function: PlayPauseButton
        function PlayPauseButtonPushed(app, event)
            if app.player.Running() == "off"
                if app.gurdian == 1
                    play(app.player);
                    app.gurdian =0;
                else
                    resume(app.player);
                end
            elseif app.player.Running() == "on"
                pause(app.player);
                
            end      
        end

        % Button pushed function: SpectrumscopeButton
        function SpectrumscopeButtonPushed(app, event)

           
          % Kwdikas gia to Spectrum Scope Button

            fileReader = dsp.AudioFileReader( ...
                app.filename, ...
                'SamplesPerFrame',app.frameLength);
            
            deviceWriter = audioDeviceWriter( ...
                'SampleRate',fileReader.SampleRate);
                
           
         
           scope = dsp.SpectrumAnalyzer('SampleRate',fileReader.SampleRate, ...
                'PlotAsTwoSidedSpectrum',app.twosidePlot_SpSc, ...
                'FrequencyScale',app.freqScale_SpSc, ...
                'ShowLegend',true, ... 
                'InputDomain',app.inputDomain_SpSc,...
                'ViewType',app.viewtype_SpSc,...
                'ChannelNames',{'Channel 1','Channel 2'}, ...
                'Title',app.filename,...
                'FrequencySpan',app.freqSpan_SpSc,...
                'Window',app.window_SpSc,...
                'WindowLength',app.windowLength_SpSc,...
                'YLimits',app.ylimits_SpSc, ...
                'Span',app.span_SpSc,...
                'ShowGrid',app.showgrid_SpSc);
       
         
             
            
            
            
            while ~isDone(fileReader)
                signal = fileReader();
                deviceWriter(signal);
                scope(signal)
            end
            
            
            
            release(fileReader);
            release(deviceWriter);
            release(scope);    
        end

        % Callback function
        function SwitchValueChanged2(app, event)
            
         
           
            
        end

        % Callback function
        function FrameLengthSliderValueChanged(app, event)
         
        end

        % Callback function
        function SwitchValueChanged3(app, event)
        
        end

        % Value changed function: GridLinesSwitch
        function GridLinesSwitchValueChanged(app, event)
            % Switch gia ta grid lines sto Timescope 1
            
            value = app.GridLinesSwitch.Value;
            
            if strcmp(value,'On')
                app.showgrid_tms1 = true;
            elseif strcmp(value,'Off')
                app.showgrid_tms1 = false;
            end 
            
        end

        % Value changed function: YLimitsDropDown
        function YLimitsDropDownValueChanged(app, event)
         % Drop-down menu gia ta y-limits gia to Timescope 1
         
            value = app.YLimitsDropDown.Value;
         
            
            if strcmp(value,'[-10 10]')
                app.ylimits_tms1 = [-10 10];
            elseif strcmp(value,'[-5 5]')
                app.ylimits_tms1 = [-5 5];
            elseif strcmp(value,'[-1 1]')
                app.ylimits_tms1 = [-1 1];
            elseif strcmp(value,'[-0.5 0.5]')
                app.ylimits_tms1 = [-0.5 0.5];
            end
        end

        % Value changed function: TimeSpanSpinner
        function TimeSpanSpinnerValueChanged(app, event)
           % Spinner gia to Timespan sto Timescope 1
           
            value = app.TimeSpanSpinner.Value;
            
            app.timespan_tms1 = value ;
            
            
        end

        % Value changed function: PlotTypeSwitch
        function PlotTypeSwitchValueChanged(app, event)
           % Switch gia to Plot Type sto Timescope 1
           
            value = app.PlotTypeSwitch.Value;
           
             
            if strcmp(value,'Line')
                app.plottype_tms1 = 'line';
            elseif strcmp(value,'Stairs')
                app.plottype_tms1 = 'stairs';
            end 
            
        end

        % Value changed function: FullAxesDropDown
        function FullAxesDropDownValueChanged(app, event)
            % Drop-down menu gia to Full Axes sto Timescope 1
            
            value = app.FullAxesDropDown.Value;
            
            if strcmp(value,'Auto')
                app.maxAxes_tms1 = 'Auto';
            elseif strcmp(value,'On')
                app.maxAxes_tms1 = 'On';
            end 
        end

        % Value changed function: YLimitsDropDown_2
        function YLimitsDropDown_2ValueChanged(app, event)
            % Drop-down menu gia ta y limits sto Timescope 2 
            
            value = app.YLimitsDropDown_2.Value;
            
            if strcmp(value,'[-10 10]')
                app.ylimits_tms2 = [-10 10];
            elseif strcmp(value,'[-5 5]')
                app.ylimits_tsm2 = [-5 5];
            elseif strcmp(value,'[-1 1]')
                app.ylimits_tsm2 = [-1 1];
            elseif strcmp(value,'[-0.5 0.5]')
                app.ylimits_tsm2 = [-0.5 0.5];
            end
            
        end

        % Value changed function: TimeSpanSpinner_2
        function TimeSpanSpinner_2ValueChanged(app, event)
            %Spinner gia to TimeSpan sto Timescope 2
            
            value = app.TimeSpanSpinner_2.Value;
            
            app.timespan_tsm2 = value;
        end

        % Value changed function: GridLinesSwitch_2
        function GridLinesSwitch_2ValueChanged(app, event)
           %Switch gia ta Grid lines sto Timescope 2
           
            value = app.GridLinesSwitch_2.Value;
            
            if strcmp(value,'On')
                app.showgrid_tsm2 = 'On';
            elseif strcmp(value,'Off')
                app.showgrid_tms2 = 'Off';
            end 
        end

        % Value changed function: XoffsetSpinner
        function XoffsetSpinnerValueChanged(app, event)
            %Spinner gia to X offset sto Array plot Button 
            
            value = app.XoffsetSpinner.Value;
            
            app.xOffset_Arpl = value;
        end

        % Button pushed function: ArrayScopeButton
        function ArrayScopeButtonPushed(app, event)
            %Kwdikas gia to Array Plot button
            
            fileReader = dsp.AudioFileReader( ...
                app.filename, ...
                'SamplesPerFrame',app.frameLength);
            
            deviceWriter = audioDeviceWriter( ...
                'SampleRate',fileReader.SampleRate);
                
           
         
            scope = dsp.ArrayPlot( ...
                  'Name','Array Plot',...
                  'XOffset',app.xOffset_Arpl, ...       
                  'YLimits',app.ylimits_Arpl, ...
                  'XScale',app.xscale_Arpl,...
                  'YScale',app.yscale_Arpl,...
                  'PlotType',app.plottype_Arpl,...
                  'XLabel','',...
                  'YLabel','Amplitude',...
                  'PlotAsMagnitudePhase',app.magnitudePhase_Arpl);
       
         
                    
            
            while ~isDone(fileReader)
                signal = fileReader();
                deviceWriter(signal);
                scope(signal)
            end
            
            
            
            release(fileReader);
            release(deviceWriter);
            release(scope);    
        end

        % Value changed function: YLimitsDropDown_3
        function YLimitsDropDown_3ValueChanged(app, event)
           %dropdown menu gia ta y-limits  
           
            value = app.YLimitsDropDown_3.Value;
            
            if strcmp(value,'[-10 10]')
                app.ylimits_Arpl = [-10 10];
            elseif strcmp(value,'[-5 5]')
                app.ylimits_Arpl = [-5 5];
            elseif strcmp(value,'[-1 1]')
                app.ylimits_Arpl = [-1 1];
            elseif strcmp(value,'[-0.5 0.5]')
                app.ylimits_Arpl = [-0.5 0.5];
            end
        end

        % Value changed function: PlotTypeDropDown
        function PlotTypeDropDownValueChanged(app, event)
           %Drop down menu gia to Plot type sto Array plot Button 
            
            value = app.PlotTypeDropDown.Value;
            
            if strcmp(value,'Stem')
                app.plottype_Arpl = 'Stem';
            elseif strcmp(value,'Stairs')
                app.plottype_Arpl = 'Stairs';
            elseif strcmp(value,'Line')
                app.plottype_Arpl = 'Line';
            end
        end

        % Value changed function: XScaleSwitch
        function XScaleSwitchValueChanged(app, event)
           % Switch gia to x-scale sto Array plot Button
           
            value = app.XScaleSwitch.Value;
            
            if strcmp(value,'Linear')
                app.xscale_Arpl = 'Linear';
            elseif strcmp(value,'Log')
                app.xscale_Arpl = 'Log';
            end
        end

        % Value changed function: YScaleSwitch
        function YScaleSwitchValueChanged(app, event)
           % Switch gia to y-scale sto Array plot Button
           
            value = app.YScaleSwitch.Value;
            
            if strcmp(value,'Linear')
                app.yscale_Arpl = 'Linear';
            elseif strcmp(value,'Log')
                app.yscale_Arpl = 'Log';
            end
        end

        % Value changed function: PlorasMagnitudePhaseSwitch
        function PlorasMagnitudePhaseSwitchValueChanged(app, event)
            % Switch gia to Magnitude Phase sto Array plot Button
            
            value = app.PlorasMagnitudePhaseSwitch.Value;
            
            if strcmp(value,'Off')
                app.magnitudePhase_Arpl = false;
            elseif strcmp(value,'On')
                app.magnitudePhase_Arpl = true;
            end
        end

        % Value changed function: ViewTypeDropDown
        function ViewTypeDropDownValueChanged(app, event)
          % Drop-down menu gia to View Type sto SpectrumScope 
          
            value = app.ViewTypeDropDown.Value;
            
            if strcmp(value,'Spectrum')
                app.viewtype_SpScl = 'Spectrum';
            elseif strcmp(value,'Spectrogram')
                app.viewtype_SpSc = 'Spectrogram';
            elseif strcmp(value,'Spectrum and spectrogram')
                app.viewtype_SpSc = 'Spectrum and spectrogram';
            end
        end

        % Value changed function: DomainSwitch
        function DomainSwitchValueChanged(app, event)
           % Swich gia to Domain sto SpectrumScope
           
            value = app.DomainSwitch.Value;
            
            if strcmp(value,'Time')
                app.inputDomain_SpScl = 'Time';
            elseif strcmp(value,'Frequency')
                app.inputDomain_SpSc = 'Frequency';
            end
        end

        % Value changed function: FrScaleandSidesDropDown
        function FrScaleandSidesDropDownValueChanged(app, event)
            % Drop-down menu gia to  Frequency Scale kai to an tha einai One i Two Sided to grafima sto SpectrumScope 
            
            value = app.FrScaleandSidesDropDown.Value;
            
            if strcmp(value,'Two-sides & Linear scale')
                app.twosidePlot_SpSc = true;
                app.freqScale_SpSc = 'Linear';
            elseif strcmp(value,'One-side & Linear Scale')
                app.twosidePlot_SpSc = false;
                app.freqScale_SpSc = 'Linear';
            elseif strcmp(value,'One-side & Logarithmic Scale')
                app.twosidePlot_SpSc = false;
                app.freqScale_SpSc = 'Linear';
            end
        end

        % Value changed function: FriquencySpamDropDown
        function FriquencySpamDropDownValueChanged(app, event)
            % Drop-down menu gia to Frequency Span sto SpectrumScope
            
            value = app.FriquencySpamDropDown.Value;
            
            if strcmp(value,'Full')
                app.freqSpan_SpSc = 'Full';
            elseif strcmp(value,'Span & Center Frequency(Span=10e3(default))')
                app.freqSpan_SpSc = 'Span and center frequency';
                app.span_SpSc = 10e3;
            elseif strcmp(value,'Span & Center Frequency(Span=5e3)')
                app.freqSpan_SpSc = 'Span and center frequency';
                app.span_SpSc = 5e3;
            elseif strcmp(value,'Span & Center Frequency(Span=12e3)')
                app.freqSpan_SpSc = 'Span and center frequency';
                app.span_SpSc = 12e3;  
            elseif strcmp(value,'Span & Center Frequency(Span=15e3)')
                app.freqSpan_SpSc = 'Span and center frequency';
                app.span_SpSc = 15e3;    
            end
        end

        % Value changed function: WindowLengthSpinner
        function WindowLengthSpinnerValueChanged(app, event)
          % Spinner gia to Window length sto SpectrumScope
            
            value = app.WindowLengthSpinner.Value;
            
            app.windowLength_SpSc = value ;
        end

        % Value changed function: WindowDropDown
        function WindowDropDownValueChanged(app, event)
            % Drop-down menu gia to Window Type sto SpectrumScope
            
            value = app.WindowDropDown.Value;
            
            if strcmp(value,'Hann')
                app.window_SpSc = 'Hann';
            elseif strcmp(value,'Rectangular')
                app.window_SpSc = 'Rectangular';
            elseif strcmp(value,'Chebyshev')
                app.window_SpSc = 'Chebyshev';    
            elseif strcmp(value,'Flat Top')
                app.window_SpSc = 'Flat Top';
            elseif strcmp(value,'Kaiser')
                app.window_SpSc = 'Kaiser'; 
            elseif strcmp(value,'Blackman-Harris')
                app.window_SpSc = 'Blackman-Harris';
            end
        end

        % Value changed function: FrameLengthDropDown
        function FrameLengthDropDownValueChanged(app, event)
           %Drop-down menu gia to Frame Length sto SpectrumScope
           
           value = app.FrameLengthDropDown.Value;
            
            if strcmp(value,'200')
                app.frameLength = 200;
            elseif strcmp(value,'500')
                app.frameLength = 500;
            elseif strcmp(value,'700')
                app.frameLength = 700; 
            elseif strcmp(value,'1024')
                app.frameLength = 1024; 
            elseif strcmp(value,'2000')
                app.frameLength = 2000;
            elseif strcmp(value,'3000')
                app.frameLength = 3000;   
            elseif strcmp(value,'4000')
                app.frameLength = 4000; 
            elseif strcmp(value,'5000')
                app.frameLength = 5000; 
            end
            
        end

        % Button pushed function: TimescopeButton
        function TimescopeButtonPushed(app, event)
            % Kwdikas gia to TimeScope 1 Button
            
              fileReader = dsp.AudioFileReader( ...
                app.filename, ...
                'SamplesPerFrame',app.frameLength);
            
            deviceWriter = audioDeviceWriter( ...
                'SampleRate',fileReader.SampleRate);
            
            scope = timescope( ...    
                  'SampleRate',fileReader.SampleRate,...    
                  'TimeSpan',app.timespan_tms1, ... 
                  'ShowGrid',app.showgrid_tms1,...
                  'YLimits',app.ylimits_tms1, ... 
                  'Title',app.filename,...
                  'PlotType',app.plottype_tms1,...
                  'MaximizeAxes',app.maxAxes_tms1,...
                  'ChannelNames',{'channel 1','channel 2'},...
                  'TimeSpanOverrunAction',"Scroll");
            
            
            while ~isDone(fileReader)
                signal = fileReader();
                deviceWriter(signal);
                scope(signal)
            end
            
            release(fileReader);
            release(deviceWriter);
            release(scope);     
        end

        % Value changed function: TimeSpanSpinner_3
        function TimeSpanSpinner_3ValueChanged(app, event)
           
            %Spinner gia to Time Span sto Spectumscope  
            
            value = app.TimeSpanSpinner_3.Value;
            
            app.timespan_SpSc = value;
        end

        % Value changed function: YLimitsDropDown_4
        function YLimitsDropDown_4ValueChanged(app, event)
            
            % Drop-down menu gia to Y-limits sto Spectrumscope
            value = app.YLimitsDropDown_4.Value;
            
             if strcmp(value,'[-80 20](default)')
                app.ylimits_SpSc = [-80 20];
            elseif strcmp(value,'[-10 20]')
                app.ylimits_SpSc = [-10 20];
            elseif strcmp(value,'[-80 80]')
                app.ylimits_SpSc = [-80 80];
            elseif strcmp(value,'[-100 100]')
                app.ylimits_SpSc = [-100 100];
            elseif strcmp(value,'[-100 120]')
                app.ylimits_SpSc = [-100 120];
            end
        end

        % Value changed function: PlotTypeSwitch_2
        function PlotTypeSwitch_2ValueChanged(app, event)
            
            % Diakoptis switch gia to plot type sto Spectrumscope
            value = app.PlotTypeSwitch_2.Value;
            
              if strcmp(value,'Line')
                app.plottype_SpSc = 'Line';
              elseif strcmp(value,'Stem')
                app.plottype_SpSc = 'Stem';
              end
        end

        % Value changed function: SpectrumUnitsDropDown
        function SpectrumUnitsDropDownValueChanged(app, event)
            
            % Drop-down menu gia to Spectrum Units sto Spectrumscope
            value = app.SpectrumUnitsDropDown.Value;
            
            if strcmp(value,'Auto(default)')
                app.SpectrumUnits_SpSc = 'Auto';
            elseif strcmp(value,'dBFS')
                app.SpectrumUnits_SpSc = 'dBFS';
            elseif strcmp(value,'dBm')
                app.SpectrumUnits_SpSc = 'dBm';
            elseif strcmp(value,'dBW')
                app.SpectrumUnits_SpSc = 'dBW';
            elseif strcmp(value,'Watts')
                app.SpectrumUnits_SpSc = 'Watts';
            end
            
        end

        % Value changed function: AxesLayoutDropDown
        function AxesLayoutDropDownValueChanged(app, event)
           
          %Drop-down menu gia to Axes layout sto Spectrumscope 
            value = app.AxesLayoutDropDown.Value;
            
            if strcmp(value,'Vertical')
                app.axesLayout_SpSc = 'Vertical';
            elseif strcmp(value,'Horizontal')
                app.axesLayout_SpSc = 'Horizontal';
            end
        end

        % Value changed function: GridLinesSwitch_3
        function GridLinesSwitch_3ValueChanged(app, event)
            
            %Diakoptis Switch gia ta grid lines sto Spectrumscope
            value = app.GridLinesSwitch_3.Value;
            
            
            if strcmp(value,'On')
                app.showgrid_SpSc = true;
            else
                app.showgrid_SpSc = false;
            end
            
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {780, 780};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {271, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 946 780];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {271, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.ForegroundColor = [0.149 0.149 0.149];
            app.LeftPanel.BackgroundColor = [0.251 0.251 0.251];
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create Image
            app.Image = uiimage(app.LeftPanel);
            app.Image.Position = [1 409 265 370];
            app.Image.ImageSource = '2cf20e0618ae6f3536d3bd344e1234b6.jpg';

            % Create Choosemp3fileButton
            app.Choosemp3fileButton = uibutton(app.LeftPanel, 'push');
            app.Choosemp3fileButton.ButtonPushedFcn = createCallbackFcn(app, @Choosemp3fileButtonPushed, true);
            app.Choosemp3fileButton.BackgroundColor = [0.9098 0.7294 0.2];
            app.Choosemp3fileButton.Position = [39 255 183 22];
            app.Choosemp3fileButton.Text = 'Choose .mp3 file';

            % Create PlayPauseButton
            app.PlayPauseButton = uibutton(app.LeftPanel, 'push');
            app.PlayPauseButton.ButtonPushedFcn = createCallbackFcn(app, @PlayPauseButtonPushed, true);
            app.PlayPauseButton.BackgroundColor = [0.9098 0.7294 0.2];
            app.PlayPauseButton.Position = [58 109 151 22];
            app.PlayPauseButton.Text = 'Play/Pause';

            % Create TextArea
            app.TextArea = uitextarea(app.LeftPanel);
            app.TextArea.BackgroundColor = [0.9098 0.7294 0.2];
            app.TextArea.Position = [39 170 183 73];

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Title = 'cv';
            app.RightPanel.BackgroundColor = [0.251 0.251 0.251];
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create Timescope2Button
            app.Timescope2Button = uibutton(app.RightPanel, 'push');
            app.Timescope2Button.ButtonPushedFcn = createCallbackFcn(app, @Timescope2ButtonPushed, true);
            app.Timescope2Button.BackgroundColor = [0.9098 0.7294 0.2];
            app.Timescope2Button.Tooltip = {'Timescope displays a plot which shows the amplitude (y-label) throught the time( x-label)'};
            app.Timescope2Button.Position = [256 611 102 31];
            app.Timescope2Button.Text = 'Timescope 2';

            % Create SpectrumscopeButton
            app.SpectrumscopeButton = uibutton(app.RightPanel, 'push');
            app.SpectrumscopeButton.ButtonPushedFcn = createCallbackFcn(app, @SpectrumscopeButtonPushed, true);
            app.SpectrumscopeButton.BackgroundColor = [0.9098 0.7294 0.2];
            app.SpectrumscopeButton.Tooltip = {'The Spectrum Analyzer displays the frequency spectrum of time-domain signals.'};
            app.SpectrumscopeButton.Position = [256 339 102 31];
            app.SpectrumscopeButton.Text = 'Spectrumscope ';

            % Create ArrayScopeButton
            app.ArrayScopeButton = uibutton(app.RightPanel, 'push');
            app.ArrayScopeButton.ButtonPushedFcn = createCallbackFcn(app, @ArrayScopeButtonPushed, true);
            app.ArrayScopeButton.BackgroundColor = [0.9098 0.7294 0.2];
            app.ArrayScopeButton.Tooltip = {'The Array Plot block plots vectors or arrays of data.'};
            app.ArrayScopeButton.Position = [21 339 102 31];
            app.ArrayScopeButton.Text = 'Array Scope';

            % Create YLimitsLabel_2
            app.YLimitsLabel_2 = uilabel(app.RightPanel);
            app.YLimitsLabel_2.BackgroundColor = [0.251 0.251 0.251];
            app.YLimitsLabel_2.HorizontalAlignment = 'right';
            app.YLimitsLabel_2.FontColor = [0.9098 0.7294 0.2];
            app.YLimitsLabel_2.Tooltip = {'Change the limits of the y-axes'};
            app.YLimitsLabel_2.Position = [21 525 48 22];
            app.YLimitsLabel_2.Text = 'Y-Limits';

            % Create YLimitsDropDown
            app.YLimitsDropDown = uidropdown(app.RightPanel);
            app.YLimitsDropDown.Items = {'[-10 10]', '[-5 5]', '[-1 1]', '[-0.5 0.5]'};
            app.YLimitsDropDown.ValueChangedFcn = createCallbackFcn(app, @YLimitsDropDownValueChanged, true);
            app.YLimitsDropDown.Tooltip = {'Change the limits of the y-axes'};
            app.YLimitsDropDown.FontColor = [0.9098 0.7294 0.2];
            app.YLimitsDropDown.BackgroundColor = [0.251 0.251 0.251];
            app.YLimitsDropDown.Position = [84 525 95 22];
            app.YLimitsDropDown.Value = '[-10 10]';

            % Create TimeSpanSpinnerLabel
            app.TimeSpanSpinnerLabel = uilabel(app.RightPanel);
            app.TimeSpanSpinnerLabel.BackgroundColor = [0.251 0.251 0.251];
            app.TimeSpanSpinnerLabel.HorizontalAlignment = 'right';
            app.TimeSpanSpinnerLabel.FontColor = [0.9098 0.7294 0.2];
            app.TimeSpanSpinnerLabel.Tooltip = {'Time span, in seconds, specified as a positive, numeric scalar value'};
            app.TimeSpanSpinnerLabel.Position = [21 485 63 22];
            app.TimeSpanSpinnerLabel.Text = 'Time Span';

            % Create TimeSpanSpinner
            app.TimeSpanSpinner = uispinner(app.RightPanel);
            app.TimeSpanSpinner.Limits = [1 1024];
            app.TimeSpanSpinner.ValueChangedFcn = createCallbackFcn(app, @TimeSpanSpinnerValueChanged, true);
            app.TimeSpanSpinner.FontColor = [0.9098 0.7294 0.2];
            app.TimeSpanSpinner.BackgroundColor = [0.251 0.251 0.251];
            app.TimeSpanSpinner.Tooltip = {'Time span, in seconds, specified as a positive, numeric scalar value'};
            app.TimeSpanSpinner.Position = [122 485 57 22];
            app.TimeSpanSpinner.Value = 1;

            % Create FullAxesDropDownLabel
            app.FullAxesDropDownLabel = uilabel(app.RightPanel);
            app.FullAxesDropDownLabel.BackgroundColor = [0.251 0.251 0.251];
            app.FullAxesDropDownLabel.HorizontalAlignment = 'right';
            app.FullAxesDropDownLabel.FontColor = [0.9098 0.7294 0.2];
            app.FullAxesDropDownLabel.Tooltip = {'Specify whether to display the scope in the maximized-axes mode. In this mode, the axes are expanded to fit into the entire display.'};
            app.FullAxesDropDownLabel.Position = [21 409 55 22];
            app.FullAxesDropDownLabel.Text = 'Full Axes';

            % Create FullAxesDropDown
            app.FullAxesDropDown = uidropdown(app.RightPanel);
            app.FullAxesDropDown.Items = {'Auto', 'On'};
            app.FullAxesDropDown.ValueChangedFcn = createCallbackFcn(app, @FullAxesDropDownValueChanged, true);
            app.FullAxesDropDown.Tooltip = {'Specify whether to display the scope in the maximized-axes mode. In this mode, the axes are expanded to fit into the entire display.'};
            app.FullAxesDropDown.FontColor = [0.9098 0.7294 0.2];
            app.FullAxesDropDown.BackgroundColor = [0.251 0.251 0.251];
            app.FullAxesDropDown.Position = [91 409 88 22];
            app.FullAxesDropDown.Value = 'Auto';

            % Create YLimitsDropDown_2Label
            app.YLimitsDropDown_2Label = uilabel(app.RightPanel);
            app.YLimitsDropDown_2Label.BackgroundColor = [0.251 0.251 0.251];
            app.YLimitsDropDown_2Label.HorizontalAlignment = 'right';
            app.YLimitsDropDown_2Label.FontColor = [0.9098 0.7294 0.2];
            app.YLimitsDropDown_2Label.Tooltip = {'Change the limits of the y-axes'};
            app.YLimitsDropDown_2Label.Position = [256 569 48 22];
            app.YLimitsDropDown_2Label.Text = 'Y Limits';

            % Create YLimitsDropDown_2
            app.YLimitsDropDown_2 = uidropdown(app.RightPanel);
            app.YLimitsDropDown_2.Items = {'[-10 10]', '[-5 5]', '[-1 1]', '[-0.5 0.5]'};
            app.YLimitsDropDown_2.ValueChangedFcn = createCallbackFcn(app, @YLimitsDropDown_2ValueChanged, true);
            app.YLimitsDropDown_2.Tooltip = {'Change the limits of the y-axes'};
            app.YLimitsDropDown_2.FontColor = [0.9098 0.7294 0.2];
            app.YLimitsDropDown_2.BackgroundColor = [0.251 0.251 0.251];
            app.YLimitsDropDown_2.Position = [319 569 95 22];
            app.YLimitsDropDown_2.Value = '[-10 10]';

            % Create XoffsetLabel
            app.XoffsetLabel = uilabel(app.RightPanel);
            app.XoffsetLabel.BackgroundColor = [0.251 0.251 0.251];
            app.XoffsetLabel.HorizontalAlignment = 'right';
            app.XoffsetLabel.FontColor = [0.9098 0.7294 0.2];
            app.XoffsetLabel.Position = [21 298 47 22];
            app.XoffsetLabel.Text = 'X-offset';

            % Create XoffsetSpinner
            app.XoffsetSpinner = uispinner(app.RightPanel);
            app.XoffsetSpinner.Step = 0.5;
            app.XoffsetSpinner.Limits = [-10 10];
            app.XoffsetSpinner.ValueChangedFcn = createCallbackFcn(app, @XoffsetSpinnerValueChanged, true);
            app.XoffsetSpinner.FontColor = [0.9098 0.7294 0.2];
            app.XoffsetSpinner.BackgroundColor = [0.251 0.251 0.251];
            app.XoffsetSpinner.Tooltip = {'The x-offset represents the first value on the x-axis. '};
            app.XoffsetSpinner.Position = [92 298 60 22];
            app.XoffsetSpinner.Value = -10;

            % Create YLimitsLabel
            app.YLimitsLabel = uilabel(app.RightPanel);
            app.YLimitsLabel.BackgroundColor = [0.251 0.251 0.251];
            app.YLimitsLabel.HorizontalAlignment = 'right';
            app.YLimitsLabel.FontColor = [0.9098 0.7294 0.2];
            app.YLimitsLabel.Tooltip = {'Change the limits of the y-axes'};
            app.YLimitsLabel.Position = [21 255 48 22];
            app.YLimitsLabel.Text = 'Y-Limits';

            % Create YLimitsDropDown_3
            app.YLimitsDropDown_3 = uidropdown(app.RightPanel);
            app.YLimitsDropDown_3.Items = {'[-10 10]', '[-5 5]', '[-1 1]', '[-0.5 0.5]'};
            app.YLimitsDropDown_3.ValueChangedFcn = createCallbackFcn(app, @YLimitsDropDown_3ValueChanged, true);
            app.YLimitsDropDown_3.Tooltip = {'Change the limits of the y-axes'};
            app.YLimitsDropDown_3.FontColor = [0.9098 0.7294 0.2];
            app.YLimitsDropDown_3.BackgroundColor = [0.251 0.251 0.251];
            app.YLimitsDropDown_3.Position = [84 255 95 22];
            app.YLimitsDropDown_3.Value = '[-10 10]';

            % Create PlotTypeDropDownLabel
            app.PlotTypeDropDownLabel = uilabel(app.RightPanel);
            app.PlotTypeDropDownLabel.BackgroundColor = [0.251 0.251 0.251];
            app.PlotTypeDropDownLabel.HorizontalAlignment = 'right';
            app.PlotTypeDropDownLabel.FontColor = [0.9098 0.7294 0.2];
            app.PlotTypeDropDownLabel.Tooltip = {'"Stem" – The scope displays the input signal as circles with vertical lines extending down to the x-axis at each of the sampled values.'; '"Line" – The scope displays the input signal as lines connecting each of the sampled values.'; '"Stairs" – The scope displays the input signal as a stair-step graph. A stair-step graph is made up of only horizontal lines and vertical lines. Each horizontal line represents the signal value for a discrete sample period and is connected to two vertical lines. Each vertical line represents a change in values occurring at a sample. Stair-step graphs are useful for drawing time history graphs of digitally sampled data. '};
            app.PlotTypeDropDownLabel.Position = [21 213 56 22];
            app.PlotTypeDropDownLabel.Text = 'Plot Type';

            % Create PlotTypeDropDown
            app.PlotTypeDropDown = uidropdown(app.RightPanel);
            app.PlotTypeDropDown.Items = {'Stem', 'Stairs', 'Line'};
            app.PlotTypeDropDown.ValueChangedFcn = createCallbackFcn(app, @PlotTypeDropDownValueChanged, true);
            app.PlotTypeDropDown.Tooltip = {'"Stem" – The scope displays the input signal as circles with vertical lines extending down to the x-axis at each of the sampled values.'; '"Line" – The scope displays the input signal as lines connecting each of the sampled values.'; '"Stairs" – The scope displays the input signal as a stair-step graph. A stair-step graph is made up of only horizontal lines and vertical lines. Each horizontal line represents the signal value for a discrete sample period and is connected to two vertical lines. Each vertical line represents a change in values occurring at a sample. Stair-step graphs are useful for drawing time history graphs of digitally sampled data. '};
            app.PlotTypeDropDown.FontColor = [0.9098 0.7294 0.2];
            app.PlotTypeDropDown.BackgroundColor = [0.251 0.251 0.251];
            app.PlotTypeDropDown.Position = [92 213 86 22];
            app.PlotTypeDropDown.Value = 'Stem';

            % Create XScaleSwitchLabel
            app.XScaleSwitchLabel = uilabel(app.RightPanel);
            app.XScaleSwitchLabel.HorizontalAlignment = 'center';
            app.XScaleSwitchLabel.FontColor = [0.9098 0.7294 0.2];
            app.XScaleSwitchLabel.Tooltip = {'Specify whether the scale of the x-axis is "Linear" or "Log".'};
            app.XScaleSwitchLabel.Position = [21 170 48 22];
            app.XScaleSwitchLabel.Text = 'X-Scale';

            % Create XScaleSwitch
            app.XScaleSwitch = uiswitch(app.RightPanel, 'slider');
            app.XScaleSwitch.Items = {'Linear', 'Log'};
            app.XScaleSwitch.ValueChangedFcn = createCallbackFcn(app, @XScaleSwitchValueChanged, true);
            app.XScaleSwitch.Tooltip = {'Specify whether the scale of the x-axis is "Linear" or "Log".'};
            app.XScaleSwitch.FontColor = [0.9098 0.7294 0.2];
            app.XScaleSwitch.Position = [110 171 45 20];
            app.XScaleSwitch.Value = 'Linear';

            % Create PlorasMagnitudePhaseSwitchLabel
            app.PlorasMagnitudePhaseSwitchLabel = uilabel(app.RightPanel);
            app.PlorasMagnitudePhaseSwitchLabel.HorizontalAlignment = 'center';
            app.PlorasMagnitudePhaseSwitchLabel.FontColor = [0.9098 0.7294 0.2];
            app.PlorasMagnitudePhaseSwitchLabel.Tooltip = {'on– The scope plots the magnitude and phase of the input signal on two separate axes within the same active display.'; 'off– The scope plots the real and imaginary parts of the input signal on two separate axes within the same active display'};
            app.PlorasMagnitudePhaseSwitchLabel.Position = [21 98 140 22];
            app.PlorasMagnitudePhaseSwitchLabel.Text = 'Plor as Magnitude Phase';

            % Create PlorasMagnitudePhaseSwitch
            app.PlorasMagnitudePhaseSwitch = uiswitch(app.RightPanel, 'slider');
            app.PlorasMagnitudePhaseSwitch.ValueChangedFcn = createCallbackFcn(app, @PlorasMagnitudePhaseSwitchValueChanged, true);
            app.PlorasMagnitudePhaseSwitch.Tooltip = {'on– The scope plots the magnitude and phase of the input signal on two separate axes within the same active display.'; 'off– The scope plots the real and imaginary parts of the input signal on two separate axes within the same active display.'};
            app.PlorasMagnitudePhaseSwitch.FontColor = [0.9098 0.7294 0.2];
            app.PlorasMagnitudePhaseSwitch.Position = [102 62 53 23];

            % Create ViewTypeDropDownLabel
            app.ViewTypeDropDownLabel = uilabel(app.RightPanel);
            app.ViewTypeDropDownLabel.BackgroundColor = [0.251 0.251 0.251];
            app.ViewTypeDropDownLabel.HorizontalAlignment = 'right';
            app.ViewTypeDropDownLabel.FontColor = [0.9098 0.7294 0.2];
            app.ViewTypeDropDownLabel.Tooltip = {'"Spectrum" — shows the power spectrum.'; '"Spectrogram" — shows frequency content over time. Each line of the spectrogram is one periodogram. Time scrolls from the bottom to the top of the display. The most recent spectrogram update is at the bottom of the display. '; '"Spectrum and Spectrogram" — shows a dual view of a spectrum and spectrogram.'};
            app.ViewTypeDropDownLabel.Position = [254 308 61 22];
            app.ViewTypeDropDownLabel.Text = 'View Type';

            % Create ViewTypeDropDown
            app.ViewTypeDropDown = uidropdown(app.RightPanel);
            app.ViewTypeDropDown.Items = {'Spectrum', 'Spectogram', 'Spectrum and Spectogram'};
            app.ViewTypeDropDown.ValueChangedFcn = createCallbackFcn(app, @ViewTypeDropDownValueChanged, true);
            app.ViewTypeDropDown.Tooltip = {'"Spectrum" — shows the power spectrum.'; '"Spectrogram" — shows frequency content over time. Each line of the spectrogram is one periodogram. Time scrolls from the bottom to the top of the display. The most recent spectrogram update is at the bottom of the display. '; '"Spectrum and Spectrogram" — shows a dual view of a spectrum and spectrogram.'};
            app.ViewTypeDropDown.FontColor = [0.9098 0.7294 0.2];
            app.ViewTypeDropDown.BackgroundColor = [0.251 0.251 0.251];
            app.ViewTypeDropDown.Position = [330 308 100 22];
            app.ViewTypeDropDown.Value = 'Spectrum';

            % Create DomainSwitchLabel
            app.DomainSwitchLabel = uilabel(app.RightPanel);
            app.DomainSwitchLabel.HorizontalAlignment = 'center';
            app.DomainSwitchLabel.FontColor = [0.9098 0.7294 0.2];
            app.DomainSwitchLabel.Tooltip = {'The domain of the input signal you want to visualize.'};
            app.DomainSwitchLabel.Position = [256 266 47 22];
            app.DomainSwitchLabel.Text = 'Domain';

            % Create DomainSwitch
            app.DomainSwitch = uiswitch(app.RightPanel, 'slider');
            app.DomainSwitch.Items = {'Time', 'Frequency'};
            app.DomainSwitch.ValueChangedFcn = createCallbackFcn(app, @DomainSwitchValueChanged, true);
            app.DomainSwitch.Tooltip = {'The domain of the input signal you want to visualize.'};
            app.DomainSwitch.FontColor = [0.9098 0.7294 0.2];
            app.DomainSwitch.Position = [346 269 41 18];
            app.DomainSwitch.Value = 'Time';

            % Create FrScaleandSidesDropDownLabel
            app.FrScaleandSidesDropDownLabel = uilabel(app.RightPanel);
            app.FrScaleandSidesDropDownLabel.BackgroundColor = [0.251 0.251 0.251];
            app.FrScaleandSidesDropDownLabel.HorizontalAlignment = 'right';
            app.FrScaleandSidesDropDownLabel.FontColor = [0.9098 0.7294 0.2];
            app.FrScaleandSidesDropDownLabel.Tooltip = {'true — Compute and plot two-sided spectral estimates. When the input signal is complex-valued, you must set this property to true.'; 'false — Compute and plot one-sided spectral estimates. If you set this property to false, then the input signal must be real-valued.'; '"Log" — displays the frequencies on the x-axis on a logarithmic scale. '; '"Linear" — displays the frequencies on the x-axis on a linear scale. To use the "Linear" setting, you must also set the PlotAsTwoSidedSpectrum property to true.'; 'To use the "Log" setting the plot has to be one-sided.'};
            app.FrScaleandSidesDropDownLabel.Position = [254 234 108 22];
            app.FrScaleandSidesDropDownLabel.Text = 'Fr-Scale and Sides';

            % Create FrScaleandSidesDropDown
            app.FrScaleandSidesDropDown = uidropdown(app.RightPanel);
            app.FrScaleandSidesDropDown.Items = {'Two-sides & Linear scale', 'One-side & Linear Scale', 'One-side & Logarithmic Scale'};
            app.FrScaleandSidesDropDown.ValueChangedFcn = createCallbackFcn(app, @FrScaleandSidesDropDownValueChanged, true);
            app.FrScaleandSidesDropDown.Tooltip = {'true — Compute and plot two-sided spectral estimates. When the input signal is complex-valued, you must set this property to true.'; 'false — Compute and plot one-sided spectral estimates. If you set this property to false, then the input signal must be real-valued.'; '"Log" — displays the frequencies on the x-axis on a logarithmic scale. '; '"Linear" — displays the frequencies on the x-axis on a linear scale. To use the "Linear" setting, you must also set the PlotAsTwoSidedSpectrum property to true.'; 'To use the "Log" setting the plot has to be one-sided.'};
            app.FrScaleandSidesDropDown.FontColor = [0.9098 0.7294 0.2];
            app.FrScaleandSidesDropDown.BackgroundColor = [0.251 0.251 0.251];
            app.FrScaleandSidesDropDown.Position = [377 234 94 22];
            app.FrScaleandSidesDropDown.Value = 'Two-sides & Linear scale';

            % Create FriquencySpamDropDownLabel
            app.FriquencySpamDropDownLabel = uilabel(app.RightPanel);
            app.FriquencySpamDropDownLabel.BackgroundColor = [0.251 0.251 0.251];
            app.FriquencySpamDropDownLabel.HorizontalAlignment = 'right';
            app.FriquencySpamDropDownLabel.FontColor = [0.9098 0.7294 0.2];
            app.FriquencySpamDropDownLabel.Position = [254 195 93 22];
            app.FriquencySpamDropDownLabel.Text = 'Friquency Spam';

            % Create FriquencySpamDropDown
            app.FriquencySpamDropDown = uidropdown(app.RightPanel);
            app.FriquencySpamDropDown.Items = {'Full', 'Span & Center Frequency(Span=10e3(default))', 'Span & Center Frequency(Span=5e3)', 'Span & Center Frequency(Span=12e3)', 'Span & Center Frequency(Span=15e3)'};
            app.FriquencySpamDropDown.ValueChangedFcn = createCallbackFcn(app, @FriquencySpamDropDownValueChanged, true);
            app.FriquencySpamDropDown.FontColor = [0.9098 0.7294 0.2];
            app.FriquencySpamDropDown.BackgroundColor = [0.251 0.251 0.251];
            app.FriquencySpamDropDown.Position = [362 195 100 22];
            app.FriquencySpamDropDown.Value = 'Full';

            % Create WindowLengthSpinnerLabel
            app.WindowLengthSpinnerLabel = uilabel(app.RightPanel);
            app.WindowLengthSpinnerLabel.BackgroundColor = [0.251 0.251 0.251];
            app.WindowLengthSpinnerLabel.HorizontalAlignment = 'right';
            app.WindowLengthSpinnerLabel.FontColor = [0.9098 0.7294 0.2];
            app.WindowLengthSpinnerLabel.Tooltip = {'Control the frequency resolution by specifying the window length, in samples used to compute the spectral estimates'};
            app.WindowLengthSpinnerLabel.Position = [254 161 88 22];
            app.WindowLengthSpinnerLabel.Text = 'Window Length';

            % Create WindowLengthSpinner
            app.WindowLengthSpinner = uispinner(app.RightPanel);
            app.WindowLengthSpinner.Limits = [2 8000];
            app.WindowLengthSpinner.ValueChangedFcn = createCallbackFcn(app, @WindowLengthSpinnerValueChanged, true);
            app.WindowLengthSpinner.FontColor = [0.9098 0.7294 0.2];
            app.WindowLengthSpinner.BackgroundColor = [0.251 0.251 0.251];
            app.WindowLengthSpinner.Tooltip = {'Control the frequency resolution by specifying the window length, in samples used to compute the spectral estimates'};
            app.WindowLengthSpinner.Position = [357 161 100 22];
            app.WindowLengthSpinner.Value = 1024;

            % Create WindowDropDownLabel
            app.WindowDropDownLabel = uilabel(app.RightPanel);
            app.WindowDropDownLabel.BackgroundColor = [0.251 0.251 0.251];
            app.WindowDropDownLabel.HorizontalAlignment = 'right';
            app.WindowDropDownLabel.FontColor = [0.9098 0.7294 0.2];
            app.WindowDropDownLabel.Position = [256 130 48 22];
            app.WindowDropDownLabel.Text = 'Window';

            % Create WindowDropDown
            app.WindowDropDown = uidropdown(app.RightPanel);
            app.WindowDropDown.Items = {'Hann', 'Rectangular', 'Chebyshev', 'Flat Top', 'Hamming', 'Kaiser', 'Blackman-Harris'};
            app.WindowDropDown.ValueChangedFcn = createCallbackFcn(app, @WindowDropDownValueChanged, true);
            app.WindowDropDown.FontColor = [0.9098 0.7294 0.2];
            app.WindowDropDown.BackgroundColor = [0.251 0.251 0.251];
            app.WindowDropDown.Position = [319 130 100 22];
            app.WindowDropDown.Value = 'Hann';

            % Create PlotTypeSwitchLabel
            app.PlotTypeSwitchLabel = uilabel(app.RightPanel);
            app.PlotTypeSwitchLabel.HorizontalAlignment = 'center';
            app.PlotTypeSwitchLabel.FontColor = [0.9098 0.7294 0.2];
            app.PlotTypeSwitchLabel.Tooltip = {'Line graph or Stair-step graph. Zoom-in to see the stairs or the line graph.'};
            app.PlotTypeSwitchLabel.Position = [21 453 56 22];
            app.PlotTypeSwitchLabel.Text = 'Plot Type';

            % Create PlotTypeSwitch
            app.PlotTypeSwitch = uiswitch(app.RightPanel, 'slider');
            app.PlotTypeSwitch.Items = {'Line', 'Stairs'};
            app.PlotTypeSwitch.ValueChangedFcn = createCallbackFcn(app, @PlotTypeSwitchValueChanged, true);
            app.PlotTypeSwitch.Tooltip = {'Line graph or Stair-step graph. Zoom-in to see the stairs or the line graph.'};
            app.PlotTypeSwitch.FontColor = [0.9098 0.7294 0.2];
            app.PlotTypeSwitch.Position = [122 455 43 19];
            app.PlotTypeSwitch.Value = 'Line';

            % Create TimeSpanSpinner_2Label
            app.TimeSpanSpinner_2Label = uilabel(app.RightPanel);
            app.TimeSpanSpinner_2Label.BackgroundColor = [0.251 0.251 0.251];
            app.TimeSpanSpinner_2Label.HorizontalAlignment = 'right';
            app.TimeSpanSpinner_2Label.FontColor = [0.9098 0.7294 0.2];
            app.TimeSpanSpinner_2Label.Tooltip = {'Time span, in seconds, specified as a positive, numeric scalar value'};
            app.TimeSpanSpinner_2Label.Position = [256 525 65 22];
            app.TimeSpanSpinner_2Label.Text = 'Time Span';

            % Create TimeSpanSpinner_2
            app.TimeSpanSpinner_2 = uispinner(app.RightPanel);
            app.TimeSpanSpinner_2.Limits = [1 200];
            app.TimeSpanSpinner_2.ValueChangedFcn = createCallbackFcn(app, @TimeSpanSpinner_2ValueChanged, true);
            app.TimeSpanSpinner_2.FontColor = [0.9098 0.7294 0.2];
            app.TimeSpanSpinner_2.BackgroundColor = [0.251 0.251 0.251];
            app.TimeSpanSpinner_2.Tooltip = {'Time span, in seconds, specified as a positive, numeric scalar value'};
            app.TimeSpanSpinner_2.Position = [367 525 51 22];
            app.TimeSpanSpinner_2.Value = 1;

            % Create GridLinesSwitchLabel
            app.GridLinesSwitchLabel = uilabel(app.RightPanel);
            app.GridLinesSwitchLabel.HorizontalAlignment = 'center';
            app.GridLinesSwitchLabel.FontColor = [0.9098 0.7294 0.2];
            app.GridLinesSwitchLabel.Tooltip = {'Active or de-active grid lines on graph'};
            app.GridLinesSwitchLabel.Position = [21 566 60 22];
            app.GridLinesSwitchLabel.Text = 'Grid Lines';

            % Create GridLinesSwitch
            app.GridLinesSwitch = uiswitch(app.RightPanel, 'slider');
            app.GridLinesSwitch.Items = {'On', 'Off'};
            app.GridLinesSwitch.ValueChangedFcn = createCallbackFcn(app, @GridLinesSwitchValueChanged, true);
            app.GridLinesSwitch.Tooltip = {'Active or de-active grid lines on graph'};
            app.GridLinesSwitch.FontColor = [0.9098 0.7294 0.2];
            app.GridLinesSwitch.Position = [126 570 45 20];
            app.GridLinesSwitch.Value = 'On';

            % Create GridLinesSwitch_2Label
            app.GridLinesSwitch_2Label = uilabel(app.RightPanel);
            app.GridLinesSwitch_2Label.HorizontalAlignment = 'center';
            app.GridLinesSwitch_2Label.FontColor = [0.9098 0.7294 0.2];
            app.GridLinesSwitch_2Label.Tooltip = {'Active or de-active grid lines on graph'};
            app.GridLinesSwitch_2Label.Position = [256 485 60 22];
            app.GridLinesSwitch_2Label.Text = 'Grid Lines';

            % Create GridLinesSwitch_2
            app.GridLinesSwitch_2 = uiswitch(app.RightPanel, 'slider');
            app.GridLinesSwitch_2.Items = {'On', 'Off'};
            app.GridLinesSwitch_2.ValueChangedFcn = createCallbackFcn(app, @GridLinesSwitch_2ValueChanged, true);
            app.GridLinesSwitch_2.Tooltip = {'Active or de-active grid lines on graph'};
            app.GridLinesSwitch_2.FontColor = [0.9098 0.7294 0.2];
            app.GridLinesSwitch_2.Position = [339 486 45 20];
            app.GridLinesSwitch_2.Value = 'On';

            % Create YScaleSwitchLabel
            app.YScaleSwitchLabel = uilabel(app.RightPanel);
            app.YScaleSwitchLabel.HorizontalAlignment = 'center';
            app.YScaleSwitchLabel.FontColor = [0.9098 0.7294 0.2];
            app.YScaleSwitchLabel.Tooltip = {'Specify whether the scale of the y-axis is "Linear" or "Log".'};
            app.YScaleSwitchLabel.Position = [21 130 46 22];
            app.YScaleSwitchLabel.Text = 'Y-Scale';

            % Create YScaleSwitch
            app.YScaleSwitch = uiswitch(app.RightPanel, 'slider');
            app.YScaleSwitch.Items = {'Linear', 'Log'};
            app.YScaleSwitch.ValueChangedFcn = createCallbackFcn(app, @YScaleSwitchValueChanged, true);
            app.YScaleSwitch.Tooltip = {'Specify whether the scale of the y-axis is "Linear" or "Log".'};
            app.YScaleSwitch.FontColor = [0.9098 0.7294 0.2];
            app.YScaleSwitch.Position = [109 131 45 20];
            app.YScaleSwitch.Value = 'Linear';

            % Create FrameLengthDropDownLabel
            app.FrameLengthDropDownLabel = uilabel(app.RightPanel);
            app.FrameLengthDropDownLabel.BackgroundColor = [0.9098 0.7294 0.2];
            app.FrameLengthDropDownLabel.HorizontalAlignment = 'right';
            app.FrameLengthDropDownLabel.Position = [225 728 80 22];
            app.FrameLengthDropDownLabel.Text = 'Frame Length';

            % Create FrameLengthDropDown
            app.FrameLengthDropDown = uidropdown(app.RightPanel);
            app.FrameLengthDropDown.Items = {'200', '500', '700', '1024', '2000', '3000', '4000', '5000'};
            app.FrameLengthDropDown.ValueChangedFcn = createCallbackFcn(app, @FrameLengthDropDownValueChanged, true);
            app.FrameLengthDropDown.BackgroundColor = [0.9098 0.7294 0.2];
            app.FrameLengthDropDown.Position = [174 686 196 22];
            app.FrameLengthDropDown.Value = '1024';

            % Create TimescopeButton
            app.TimescopeButton = uibutton(app.RightPanel, 'push');
            app.TimescopeButton.ButtonPushedFcn = createCallbackFcn(app, @TimescopeButtonPushed, true);
            app.TimescopeButton.BackgroundColor = [0.9098 0.7294 0.2];
            app.TimescopeButton.Tooltip = {'Timescope displays a plot which shows the amplitude (y-label) throught the time( x-label)'};
            app.TimescopeButton.Position = [21 611 102 31];
            app.TimescopeButton.Text = 'Timescope';

            % Create TimeSpanSpinner_3Label
            app.TimeSpanSpinner_3Label = uilabel(app.RightPanel);
            app.TimeSpanSpinner_3Label.BackgroundColor = [0.251 0.251 0.251];
            app.TimeSpanSpinner_3Label.HorizontalAlignment = 'right';
            app.TimeSpanSpinner_3Label.FontColor = [0.9098 0.7294 0.2];
            app.TimeSpanSpinner_3Label.Tooltip = {'Time span, in seconds, specified as a positive, numeric scalar value'};
            app.TimeSpanSpinner_3Label.Position = [254 98 63 22];
            app.TimeSpanSpinner_3Label.Text = 'Time Span';

            % Create TimeSpanSpinner_3
            app.TimeSpanSpinner_3 = uispinner(app.RightPanel);
            app.TimeSpanSpinner_3.Limits = [1 200];
            app.TimeSpanSpinner_3.ValueChangedFcn = createCallbackFcn(app, @TimeSpanSpinner_3ValueChanged, true);
            app.TimeSpanSpinner_3.FontColor = [0.9098 0.7294 0.2];
            app.TimeSpanSpinner_3.BackgroundColor = [0.251 0.251 0.251];
            app.TimeSpanSpinner_3.Tooltip = {'Time span, in seconds, specified as a positive, numeric scalar value'};
            app.TimeSpanSpinner_3.Position = [361 98 71 22];
            app.TimeSpanSpinner_3.Value = 1;

            % Create YLimitsDropDown_4Label
            app.YLimitsDropDown_4Label = uilabel(app.RightPanel);
            app.YLimitsDropDown_4Label.BackgroundColor = [0.251 0.251 0.251];
            app.YLimitsDropDown_4Label.HorizontalAlignment = 'right';
            app.YLimitsDropDown_4Label.FontColor = [0.9098 0.7294 0.2];
            app.YLimitsDropDown_4Label.Tooltip = {'Change the limits of the y-axes'};
            app.YLimitsDropDown_4Label.Position = [488 308 48 22];
            app.YLimitsDropDown_4Label.Text = 'Y-Limits';

            % Create YLimitsDropDown_4
            app.YLimitsDropDown_4 = uidropdown(app.RightPanel);
            app.YLimitsDropDown_4.Items = {'[-80 20](default)', '[-10 20]', '[-80 80]', '[-100 100]', '[-100 120]'};
            app.YLimitsDropDown_4.ValueChangedFcn = createCallbackFcn(app, @YLimitsDropDown_4ValueChanged, true);
            app.YLimitsDropDown_4.Tooltip = {'Change the limits of the y-axes'};
            app.YLimitsDropDown_4.FontColor = [0.9098 0.7294 0.2];
            app.YLimitsDropDown_4.BackgroundColor = [0.251 0.251 0.251];
            app.YLimitsDropDown_4.Position = [550 308 100 22];
            app.YLimitsDropDown_4.Value = '[-80 20](default)';

            % Create PlotTypeSwitch_2Label
            app.PlotTypeSwitch_2Label = uilabel(app.RightPanel);
            app.PlotTypeSwitch_2Label.HorizontalAlignment = 'center';
            app.PlotTypeSwitch_2Label.FontColor = [0.9098 0.7294 0.2];
            app.PlotTypeSwitch_2Label.Tooltip = {'Line graph or Stair-step graph. Zoom-in to see the stairs or the line graph.'};
            app.PlotTypeSwitch_2Label.Position = [256 27 56 22];
            app.PlotTypeSwitch_2Label.Text = 'Plot Type';

            % Create PlotTypeSwitch_2
            app.PlotTypeSwitch_2 = uiswitch(app.RightPanel, 'slider');
            app.PlotTypeSwitch_2.Items = {'Line', 'Stem'};
            app.PlotTypeSwitch_2.ValueChangedFcn = createCallbackFcn(app, @PlotTypeSwitch_2ValueChanged, true);
            app.PlotTypeSwitch_2.Tooltip = {'Line graph or Stair-step graph. Zoom-in to see the stairs or the line graph.'};
            app.PlotTypeSwitch_2.FontColor = [0.9098 0.7294 0.2];
            app.PlotTypeSwitch_2.Position = [363 30 36 16];
            app.PlotTypeSwitch_2.Value = 'Line';

            % Create SpectrumUnitsDropDownLabel
            app.SpectrumUnitsDropDownLabel = uilabel(app.RightPanel);
            app.SpectrumUnitsDropDownLabel.BackgroundColor = [0.251 0.251 0.251];
            app.SpectrumUnitsDropDownLabel.HorizontalAlignment = 'right';
            app.SpectrumUnitsDropDownLabel.FontColor = [0.9098 0.7294 0.2];
            app.SpectrumUnitsDropDownLabel.Tooltip = {'Specify the units in which the Spectrum Analyzer displays power values.'};
            app.SpectrumUnitsDropDownLabel.Position = [256 62 88 22];
            app.SpectrumUnitsDropDownLabel.Text = 'Spectrum Units';

            % Create SpectrumUnitsDropDown
            app.SpectrumUnitsDropDown = uidropdown(app.RightPanel);
            app.SpectrumUnitsDropDown.Items = {'Auto(default)', 'dBFS', 'dBm', 'dBW', 'Watts'};
            app.SpectrumUnitsDropDown.ValueChangedFcn = createCallbackFcn(app, @SpectrumUnitsDropDownValueChanged, true);
            app.SpectrumUnitsDropDown.Tooltip = {'Specify the units in which the Spectrum Analyzer displays power values.'};
            app.SpectrumUnitsDropDown.FontColor = [0.9098 0.7294 0.2];
            app.SpectrumUnitsDropDown.BackgroundColor = [0.251 0.251 0.251];
            app.SpectrumUnitsDropDown.Position = [359 62 100 22];
            app.SpectrumUnitsDropDown.Value = 'Auto(default)';

            % Create AxesLayoutDropDownLabel
            app.AxesLayoutDropDownLabel = uilabel(app.RightPanel);
            app.AxesLayoutDropDownLabel.BackgroundColor = [0.251 0.251 0.251];
            app.AxesLayoutDropDownLabel.HorizontalAlignment = 'right';
            app.AxesLayoutDropDownLabel.FontColor = [0.9098 0.7294 0.2];
            app.AxesLayoutDropDownLabel.Tooltip = {'A vertical layout stacks the spectrum above the spectrogram. A horizontal layout puts the two views side-by-side.'};
            app.AxesLayoutDropDownLabel.Position = [473 27 72 22];
            app.AxesLayoutDropDownLabel.Text = 'Axes Layout';

            % Create AxesLayoutDropDown
            app.AxesLayoutDropDown = uidropdown(app.RightPanel);
            app.AxesLayoutDropDown.Items = {'Vertical', 'Horizontal'};
            app.AxesLayoutDropDown.ValueChangedFcn = createCallbackFcn(app, @AxesLayoutDropDownValueChanged, true);
            app.AxesLayoutDropDown.Tooltip = {'A vertical layout stacks the spectrum above the spectrogram. A horizontal layout puts the two views side-by-side.'};
            app.AxesLayoutDropDown.FontColor = [0.9098 0.7294 0.2];
            app.AxesLayoutDropDown.BackgroundColor = [0.251 0.251 0.251];
            app.AxesLayoutDropDown.Position = [560 27 100 22];
            app.AxesLayoutDropDown.Value = 'Vertical';

            % Create GridLinesSwitch_3Label
            app.GridLinesSwitch_3Label = uilabel(app.RightPanel);
            app.GridLinesSwitch_3Label.HorizontalAlignment = 'center';
            app.GridLinesSwitch_3Label.FontColor = [0.9098 0.7294 0.2];
            app.GridLinesSwitch_3Label.Tooltip = {'Active or de-active grid lines on graph'};
            app.GridLinesSwitch_3Label.Position = [488 267 60 22];
            app.GridLinesSwitch_3Label.Text = 'Grid Lines';

            % Create GridLinesSwitch_3
            app.GridLinesSwitch_3 = uiswitch(app.RightPanel, 'slider');
            app.GridLinesSwitch_3.Items = {'On', 'Off'};
            app.GridLinesSwitch_3.ValueChangedFcn = createCallbackFcn(app, @GridLinesSwitch_3ValueChanged, true);
            app.GridLinesSwitch_3.Tooltip = {'Active or de-active grid lines on graph'};
            app.GridLinesSwitch_3.FontColor = [0.9098 0.7294 0.2];
            app.GridLinesSwitch_3.Position = [576 268 45 20];
            app.GridLinesSwitch_3.Value = 'On';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Visualizer

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end