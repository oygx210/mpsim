function [var, trend, den] = get_multipath_modulation3 (result, varargin)
    [var, trend, den] = get_multipath_modulation (...
        result.phasor_direct, result.phasor_reflected, ...
        true, false, result.phasor_direct, varargin{:});
end

