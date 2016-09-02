classdef Cell < edu.washington.riekelab.sources.Cell
    
    methods
        
        function obj = Cell()
            import symphonyui.core.*;
            
            obj.addProperty('type', 'unknown', ...
                'type', PropertyType('char', 'row', containers.Map( ...
                    {'unknown', 'RGC', 'amacrine', 'bipolar', 'horizontal', 'photoreceptor'}, ...
                    { ...
                        {}, ...
                        {}, ...
                        {}, ...
                        {'VSX1', 'VSX2'}, ...
                        {}, ...
                        {'UV cone', 'S cone', 'M cone', 'rod'} ...
                    })), ...
                'description', 'The confirmed type of the recorded cell');
            
            obj.addAllowableParentType('edu.washington.riekelab.sources.zebrafish.Preparation');
        end
        
    end
    
end

