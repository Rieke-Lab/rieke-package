classdef OldSliceWithMicrodisplayAboveWithTwoAmps < edu.washington.riekelab.rigs.OldSliceTwoAmp
    
    methods
        
        function obj = OldSliceWithMicrodisplayAboveWithTwoAmps()
            import symphonyui.builtin.devices.*;
            import symphonyui.core.*;
            import edu.washington.*;
            
            daq = obj.daqController;
            
            ramps = containers.Map();
            ramps('minimum') = linspace(0, 65535, 256);
            ramps('low')     = 65535 * importdata(riekelab.Package.getCalibrationResource('rigs', 'old_slice', 'microdisplay_above_low_gamma_ramp.txt'));
            ramps('medium')  = 65535 * importdata(riekelab.Package.getCalibrationResource('rigs', 'old_slice', 'microdisplay_above_medium_gamma_ramp.txt'));
            ramps('high')    = 65535 * importdata(riekelab.Package.getCalibrationResource('rigs', 'old_slice', 'microdisplay_above_high_gamma_ramp.txt'));
            ramps('maximum') = linspace(0, 65535, 256);

            microdisplay = riekelab.devices.MicrodisplayDevice('gammaRamps', ramps, 'micronsPerPixel', 1.65, 'comPort', 'COM3');
            microdisplay.bindStream(daq.getStream('doport1'));
            daq.getStream('doport1').setBitPosition(microdisplay, 15);
            microdisplay.addConfigurationSetting('ndfs', {}, ...
                'type', PropertyType('cellstr', 'row', {'F1', 'F2', 'F3', 'F4', 'F5'}));
            microdisplay.addResource('ndfAttenuations', containers.Map( ...
                {'white', 'red', 'green', 'blue'}, { ...
                containers.Map( ...
                    {'F1', 'F2', 'F3', 'F4', 'F5'}, ...
                    {0.29, 0.29, 0.59, 1.09, 1.93}), ...
                containers.Map( ...
                    {'F1', 'F2', 'F3', 'F4', 'F5'}, ...
                    {0.29, 0.29, 0.62, 1.08, 1.86}), ...
                containers.Map( ...
                    {'F1', 'F2', 'F3', 'F4', 'F5'}, ...
                    {0.29, 0.29, 0.58, 1.10, 1.94}), ...
                containers.Map( ...
                    {'F1', 'F2', 'F3', 'F4', 'F5'}, ...
                    {0.29, 0.29, 0.56, 1.11, 2.01})}));
            microdisplay.addResource('fluxFactorPaths', containers.Map( ...
                {'low', 'medium', 'high'}, { ...
                riekelab.Package.getCalibrationResource('rigs', 'old_slice', 'microdisplay_above_low_flux_factors.txt'), ...
                riekelab.Package.getCalibrationResource('rigs', 'old_slice', 'microdisplay_above_medium_flux_factors.txt'), ...
                riekelab.Package.getCalibrationResource('rigs', 'old_slice', 'microdisplay_above_high_flux_factors.txt')}));
            microdisplay.addConfigurationSetting('lightPath', 'above', 'isReadOnly', true);
            microdisplay.addResource('spectrum', containers.Map( ...
                {'white', 'red', 'green', 'blue'}, { ...
                importdata(riekelab.Package.getCalibrationResource('rigs', 'old_slice', 'microdisplay_above_white_spectrum.txt')), ...
                importdata(riekelab.Package.getCalibrationResource('rigs', 'old_slice', 'microdisplay_above_red_spectrum.txt')), ...
                importdata(riekelab.Package.getCalibrationResource('rigs', 'old_slice', 'microdisplay_above_green_spectrum.txt')), ...
                importdata(riekelab.Package.getCalibrationResource('rigs', 'old_slice', 'microdisplay_above_blue_spectrum.txt'))}));
            obj.addDevice(microdisplay);
            
            frameMonitor = UnitConvertingDevice('Frame Monitor', 'V').bindStream(daq.getStream('ai7'));
            obj.addDevice(frameMonitor);
        end
        
    end
    
end

