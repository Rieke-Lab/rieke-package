classdef SharedTwoPhotonWithMicrodisplay < edu.washington.riekelab.rigs.SharedTwoPhoton
    
    methods
        
        function obj = SharedTwoPhotonWithMicrodisplay()
            import symphonyui.builtin.devices.*;
            import edu.washington.*;
            
            daq = obj.daqController;
            
            ramps = containers.Map();
            ramps('minimum') = linspace(0, 65535, 256);
            ramps('low')     = 65535 * importdata(riekelab.Package.getResource('calibration', 'shared_two_photon', 'microdisplay_low_gamma_ramp.txt'));
            ramps('medium')  = 65535 * importdata(riekelab.Package.getResource('calibration', 'shared_two_photon', 'microdisplay_medium_gamma_ramp.txt'));
            ramps('high')    = 65535 * importdata(riekelab.Package.getResource('calibration', 'shared_two_photon', 'microdisplay_high_gamma_ramp.txt'));
            ramps('maximum') = linspace(0, 65535, 256);
            microdisplay = riekelab.devices.MicrodisplayDevice('gammaRamps', ramps, 'micronsPerPixel', 3.3, 'comPort', 'COM1');
            microdisplay.bindStream(daq.getStream('doport1'));
            daq.getStream('doport1').setBitPosition(microdisplay, 15);
            obj.addDevice(microdisplay);
            
            frameMonitor = UnitConvertingDevice('Frame Monitor', 'V').bindStream(daq.getStream('ai7'));
            obj.addDevice(frameMonitor);
        end
        
    end
    
end

