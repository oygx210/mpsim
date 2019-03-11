function [coeff_direct, coeff_interf, snr_simul_trend, snr_meas_detrended, pre] = snr_bias_fit (...
snr_meas, indep, graz, ...
snr_simul_trend, snr_simul_trend2, snr_simul, pre, ...
idx_lim_trend, idx_lim_fringe, ...
degree_trend, degree_fringe_aux, ...
inv_ratio, trend_only, refine_peak, ...
height_domain, wavelength, ...
prefit_trend, postfit_trend, ...
plotit, num_obs_min)
    if (nargin < 07),  pre = struct();  end
    if (nargin < 08),  idx_lim_trend = [];  end
    if (nargin < 09),  idx_lim_fringe = [];  end
    if (nargin < 10),  degree_trend = [];  end
    if (nargin < 11),  degree_fringe_aux = [];  end
    if (nargin < 12),  inv_ratio = [];  end
    if (nargin < 13),  trend_only = [];  end
    if (nargin < 14),  refine_peak = [];  end
    if (nargin < 15),  height_domain = [];  end
    if (nargin < 16),  wavelength = [];  end
    if (nargin < 17),  prefit_trend = [];  end
    if (nargin < 18),  postfit_trend = [];  end
    if (nargin < 19) || isempty(plotit),  plotit = false;  end
    if (nargin < 20),  num_obs_min = [];  end
    %plotit = true;  % DEBUG

    snr_meas_trend = setel(snr_meas, idx_lim_trend, NaN);
    [coeff_direct, snr_ratio_trend] = snr_bias_trend_fit (...
        snr_meas_trend, indep, ...
        snr_simul_trend, snr_simul_trend2, ...
        degree_trend, prefit_trend, postfit_trend, plotit);

    %snr_simul_trend = snr_simul_trend .* snr_ratio_trend;  % WRONG!
    %snr_simul       = snr_simul       .* snr_ratio_trend;  % WRONG!
    snr_simul_trend = snr_simul_trend ./ snr_ratio_trend;
    snr_simul       = snr_simul       ./ snr_ratio_trend;
      if plotit,  figure, hold on, plot(snr_meas, 'b'), plot(setel(snr_simul_trend, isnan(snr_meas), NaN), 'r'), plot(setel(snr_simul, isnan(snr_meas), NaN), 'g');  end

    if ~isfield(pre, 'fringe'),  pre.fringe = [];  end
    snr_meas_fringe = setel(snr_meas, idx_lim_fringe, NaN);
    [coeff_interf, snr_meas_detrended, ~, pre.fringe] = snr_bias_fringe_fit (...
        snr_meas_fringe, graz, ...
        snr_simul_trend, snr_simul, ...
        pre.fringe, trend_only, num_obs_min, ...
        degree_fringe_aux, ...
        refine_peak, height_domain, wavelength, plotit, inv_ratio);
end
