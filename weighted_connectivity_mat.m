function weighted_matrix = weighted_connectivity_mat(tracks_head,tracks,atlas,low_thre,high_thre,roi_num)
%% Basic setting
if isempty(low_thre), low_thre = 0; end
if isempty(high_thre), high_thre = 500; end

result_sc = zeros(roi_num);
result_fi = zeros(roi_num);
result_le = zeros(roi_num);

trk_mean_scalars = zeros(length(tracks),roi_num);
% Find start and end point of entire fiber
for i = 1 : length(tracks)
    le = sqrt(sum((tracks(i).matrix(2:end,1:3) - tracks(i).matrix(1:(end-1),1:3)).^2, 2));
    scalars = (tracks(i).matrix(1:end-1,4) + tracks(i).matrix(2:end,4))./2;
    mean_scalars = sum(le.*scalars,1)/sum(le,1);
    
    lengths = sum(sqrt(sum((tracks(i).matrix(2:end,1:3) - tracks(i).matrix(1:(end-1),1:3)).^2, 2)));
    if lengths <= low_thre
        
    elseif lengths >= high_thre
        
    else
        
        vox = floor(tracks(i).matrix(:,1:3) ./ repmat(tracks_head.voxel_size, tracks(i).nPoints,1))+1;
        
        startpoint = atlas(vox(1,1),vox(1,2),vox(1,3));
        endpoint = atlas(vox(tracks(i).nPoints,1),vox(tracks(i).nPoints,2),vox(tracks(i).nPoints,3));
        
        if startpoint > endpoint
            tmp = startpoint;
            startpoint = endpoint;
            endpoint = tmp;
        end;
        
        if startpoint ~= 0 && endpoint ~= 0
            result_sc(startpoint,endpoint) = result_sc(startpoint,endpoint) + mean_scalars;
            result_fi(startpoint,endpoint) = result_fi(startpoint,endpoint) + 1;
            result_le(startpoint,endpoint) = result_le(startpoint,endpoint) + 1/lengths;
        end
    end
end

weighted_matrix.we = result_sc./result_fi;
weighted_matrix.sc = result_sc;
weighted_matrix.fi = result_fi;
weighted_matrix.le = result_le;

surf = zeros(roi_num);

for i = 1 : roi_num
    for j = 1 : roi_num
        surf(i,j) = 2/(4*size(find(atlas == i),1) + 4*size(find(atlas == j),1));
    end;
end;

weighted_matrix.surf = surf;
weighted_matrix.wSC = surf.*result_le.*weighted_matrix.we;
end

