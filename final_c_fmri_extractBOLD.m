%% HCP imaging genetics 
%   :  Extracting regional information of fMRI using workbench in HCP
%   Atlas: Human connectome project multi-modal parcellation (i.e. 360 brain regions)
%           - Vertex to voxel convertion
%           - Extracting regional infomation 
% 
%   Measurements: average BOLD signal and BC/DC/EC with connectivity
%   analysis
%
%  Functional connectivity 
%  1. Preprocessing : deoblique, motion correction, registration, normailation
%  2. Connectivity matrix: pearson correlation or parital correlation
%
%  Created : Apr-15-2019
%  Author : Mansu Kim, mansooru@skku.edu or mansooru.kim@gmail.com 
%  @ Sungkyunkwan University


%% Mean BOLD signal
clear; clc;

flist = [100206	100307	100408	100610	101107	102109	102311	102513	102614	102715	103111	103212	103414	103818	104012	105014	105115	105216	105620	105923	106016	106319	106521	106824	107018	108020	108222	108323	109123	110411	110613	111009	111211	111312	111413	111514	112516	112920	113215	113619	113922	114217	114419	114621	114823	115320	115724	116726	117021	117930	118225	118730	118831	118932	119025	120111	120414	120717	122317	122620	122822	123521	124220	124624	124826	125222	125424	125525	126325	126426	127226	127832	127933	128632	128935	129028	129129	130013	130114	130316	130417	130619	130720	131217	131722	131823	133019	133625	134021	134425	134728	135124	135528	135629	135932	136227	136631	136732	136833	137229	137532	138130	138231	139233	139435	139637	139839	140117	140319	141422	141826	143224	143325	143830	144125	144428	144731	144832	144933	145632	145834	146129	146432	146735	146836	146937	147030	147636	147737	148133	148840	148941	149337	149539	149741	150625	150726	150928	151223	151425	151526	151627	151728	151829	151930	152225	152427	153025	153126	153227	153429	154431	154532	154734	154835	155635	155938	156334	156435	156637	157336	157437	158035	158136	158338	158540	158843	159138	159239	159744	161731	162026	162228	162329	162733	162935	163129	163331	164030	164131	164636	165436	165638	166438	167036	167238	167440	168139	168240	168947	169040	169444	169545	169949	170631	171330	171633	172029	172130	172433	172534	173334	173435	173536	173940	174841	175136	175237	175439	175742	176037	176441	176542	177140	177241	177645	178142	178647	179346	180432	180735	180937	181232	182436	182739	185139	185341	185947	186848	187547	188145	188751	189349	189652	191033	191336	191841	191942	192136	192237	192540	192641	192843	193239	193845	194443	194847	195445	195849	195950	196144	196346	196750	197348	198047	198249	198451	198653	199150	199655	200008	200109	200311	200513	200614	201515	201818	202113	202719	203418	203923	204016	205220	205725	205826	206222	206323	206727	206828	206929	207123	207426	208226	208327	209127	209228	209329	210011	210112	210415	210617	211922	212419	212823	213421	214423	214524	214726	217429	220721	227533	228434	231928	233326	238033	239944	246133	250427	250932	251833	255639	255740	257542	257845	263436	268749	274542	275645	283543	285345	285446	286650	287248	298051	299154	300719	303624	304020	304727	307127	308129	308331	310621	314225	316835	320826	321323	325129	330324	333330	341834	342129	346137	346945	349244	352132	353740	358144	360030	361234	365343	366042	371843	377451	378756	380036	381038	381543	385046	385450	386250	387959	389357	391748	392447	393247	393550	394956	395756	397154	397760	397861	401422	406836	412528	413934	414229	422632	424939	429040	432332	433839	436239	436845	445543	448347	453441	453542	454140	456346	459453	461743	463040	467351	468050	469961	479762	481042	481951	495255	499566	500222	506234	510225	510326	512835	513130	516742	519647	519950	520228	522434	525541	529953	530635	531536	541640	553344	555954	557857	558657	558960	559053	561949	562446	567759	568963	572045	573249	576255	579867	581450	583858	586460	587664	588565	590047	597869	598568	599065	609143	613538	615744	616645	617748	618952	622236	627549	627852	633847	635245	638049	645450	654552	656253	656657	660951	663755	664757	665254	668361	671855	672756	673455	675661	677766	677968	679568	680452	690152	692964	695768	698168	700634	702133	704238	705341	707749	709551	715950	723141	724446	725751	728454	731140	732243	734045	735148	742549	744553	748258	749058	753150	759869	761957	765056	765864	767464	770352	771354	773257	774663	779370	783462	784565	788674	789373	792564	800941	803240	810843	812746	814548	816653	818859	826353	826454	828862	833249	835657	841349	844961	849971	852455	856766	856968	859671	861456	865363	869472	870861	871762	871964	872562	878877	882161	886674	887373	894673	896778	896879	898176	899885	901139	901442	902242	904044	907656	908860	910241	910443	911849	912447	917255	917558	919966	922854	923755	927359	932554	933253	942658	957974	958976	959574	966975	969476	971160	983773	990366	991267	992673	992774	993675	994273	996782];
load atlas_idx.mat
   
for i = 3:576
    
    disp(strcat(['list = ',int2str(i),' -- ',int2str(flist(i))]));
    
    
    fmri_path = strcat('/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/fMRI/',int2str(flist(i)));
    system(['fslmaths ',fmri_path,'/REST1.nii.gz -Tmean ',fmri_path,'/mean_REST.nii']);
    fmri_tmp = load_nii([fmri_path,'mean_REST.nii.gz']);
    for roi_idx = 1:180
        tmp_left = fmri_tmp.img(left_atlas{roi_idx});
        tmp_left(tmp_left==0) = [];
        fmri_bold(i,roi_idx) = mean(tmp_left);
        clear tmp_left
        
        tmp_right = fmri_tmp.img(right_atlas{roi_idx});
        tmp_right(tmp_right==0) = [];
        fmri_bold(i,roi_idx+180) = mean(tmp_right);
        clear tmp_right
    end
    
end

for i = 1:576
    
    disp(strcat(['list = ',int2str(i),' -- ',int2str(flist(i))]));
    
    
    fmri_path = strcat('/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/fMRI/',int2str(flist(i)));
%    system(['fslmaths ',fmri_path,'/REST1.nii.gz -Tmean ',fmri_path,'/mean_REST.nii']);
    fmri_tmp = load_nii([fmri_path,'/mean_REST.nii.gz']);
    for roi_idx = 1:180
        tmp_left = fmri_tmp.img(left_atlas{roi_idx});
        tmp_left(tmp_left==0) = [];
        fmri_bold(i,roi_idx) = mean(tmp_left);
        clear tmp_left
        
        tmp_right = fmri_tmp.img(right_atlas{roi_idx});
        tmp_right(tmp_right==0) = [];
        fmri_bold(i,roi_idx+180) = mean(tmp_right);
        clear tmp_right
    end
    
end


%% Functional connectivity analysis
clear; clc;

flist = [100206	100307	100408	100610	101107	102109	102311	102513	102614	102715	103111	103212	103414	103818	104012	105014	105115	105216	105620	105923	106016	106319	106521	106824	107018	108020	108222	108323	109123	110411	110613	111009	111211	111312	111413	111514	112516	112920	113215	113619	113922	114217	114419	114621	114823	115320	115724	116726	117021	117930	118225	118730	118831	118932	119025	120111	120414	120717	122317	122620	122822	123521	124220	124624	124826	125222	125424	125525	126325	126426	127226	127832	127933	128632	128935	129028	129129	130013	130114	130316	130417	130619	130720	131217	131722	131823	133019	133625	134021	134425	134728	135124	135528	135629	135932	136227	136631	136732	136833	137229	137532	138130	138231	139233	139435	139637	139839	140117	140319	141422	141826	143224	143325	143830	144125	144428	144731	144832	144933	145632	145834	146129	146432	146735	146836	146937	147030	147636	147737	148133	148840	148941	149337	149539	149741	150625	150726	150928	151223	151425	151526	151627	151728	151829	151930	152225	152427	153025	153126	153227	153429	154431	154532	154734	154835	155635	155938	156334	156435	156637	157336	157437	158035	158136	158338	158540	158843	159138	159239	159744	161731	162026	162228	162329	162733	162935	163129	163331	164030	164131	164636	165436	165638	166438	167036	167238	167440	168139	168240	168947	169040	169444	169545	169949	170631	171330	171633	172029	172130	172433	172534	173334	173435	173536	173940	174841	175136	175237	175439	175742	176037	176441	176542	177140	177241	177645	178142	178647	179346	180432	180735	180937	181232	182436	182739	185139	185341	185947	186848	187547	188145	188751	189349	189652	191033	191336	191841	191942	192136	192237	192540	192641	192843	193239	193845	194443	194847	195445	195849	195950	196144	196346	196750	197348	198047	198249	198451	198653	199150	199655	200008	200109	200311	200513	200614	201515	201818	202113	202719	203418	203923	204016	205220	205725	205826	206222	206323	206727	206828	206929	207123	207426	208226	208327	209127	209228	209329	210011	210112	210415	210617	211922	212419	212823	213421	214423	214524	214726	217429	220721	227533	228434	231928	233326	238033	239944	246133	250427	250932	251833	255639	255740	257542	257845	263436	268749	274542	275645	283543	285345	285446	286650	287248	298051	299154	300719	303624	304020	304727	307127	308129	308331	310621	314225	316835	320826	321323	325129	330324	333330	341834	342129	346137	346945	349244	352132	353740	358144	360030	361234	365343	366042	371843	377451	378756	380036	381038	381543	385046	385450	386250	387959	389357	391748	392447	393247	393550	394956	395756	397154	397760	397861	401422	406836	412528	413934	414229	422632	424939	429040	432332	433839	436239	436845	445543	448347	453441	453542	454140	456346	459453	461743	463040	467351	468050	469961	479762	481042	481951	495255	499566	500222	506234	510225	510326	512835	513130	516742	519647	519950	520228	522434	525541	529953	530635	531536	541640	553344	555954	557857	558657	558960	559053	561949	562446	567759	568963	572045	573249	576255	579867	581450	583858	586460	587664	588565	590047	597869	598568	599065	609143	613538	615744	616645	617748	618952	622236	627549	627852	633847	635245	638049	645450	654552	656253	656657	660951	663755	664757	665254	668361	671855	672756	673455	675661	677766	677968	679568	680452	690152	692964	695768	698168	700634	702133	704238	705341	707749	709551	715950	723141	724446	725751	728454	731140	732243	734045	735148	742549	744553	748258	749058	753150	759869	761957	765056	765864	767464	770352	771354	773257	774663	779370	783462	784565	788674	789373	792564	800941	803240	810843	812746	814548	816653	818859	826353	826454	828862	833249	835657	841349	844961	849971	852455	856766	856968	859671	861456	865363	869472	870861	871762	871964	872562	878877	882161	886674	887373	894673	896778	896879	898176	899885	901139	901442	902242	904044	907656	908860	910241	910443	911849	912447	917255	917558	919966	922854	923755	927359	932554	933253	942658	957974	958976	959574	966975	969476	971160	983773	990366	991267	992673	992774	993675	994273	996782];
load atlas_idx.mat

for list = 1:length(flist)
    %%%%%%%%%%%%%%%%%%%%%%%%% Setting %%%%%%%%%%%%%%%%%%%%%%%%%
    path_anat = strcat('/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/T1/',int2str(flist(i)));
    anat_name = 'T1';
    anat_ext = '.nii';
    path_func = strcat('/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/fMRI/',int2str(flist(i)));
    func_name = 'scram1';
    func_ext = '.nii';
    template = '//store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/MNI152_T1_3mm_brain.nii.gz';
    num_dim = 0;    % 20~100 (typically 70: Salimi-Khorshidi et al. 2014)
    fix_train = '/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/HCP_hp2000.RData';
    
    % Standard: TR=3s, Res=3.5mm3, Sess=6min, default FEAT
    % HCP_hp2000: TR=0.7s, Res=2mm3, Sess=15min, no spatial smoothing, 2000s FWMH highpass temporal filtering
    % UKBiobank: TR=0.735s, Res=2.4mm3, Sess=6min, no spatial smoothing, 100s FWMH highpass temporal filtering
    FWHM = 4;   % spatial smoothing factor
    %%%%%%%%%%%%%%%%%%%%%%%%% Setting %%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%%%%%%%%% Start processing %%%%%%%%%%
    disp(' ');
    disp('%%%%% Basic Settings %%%%%');
    disp(strcat(['path_anat = ',path_anat]));
    disp(strcat(['anat_name = ',anat_name,anat_ext]));
    disp(strcat(['path_func = ',path_func]));
    disp(strcat(['func_name = ',func_name,func_ext]));
    disp(strcat(['template = ',template]));
    disp('%%%%% Basic Settings %%%%%');
    disp(' ');  disp(' ');
    
    %%%%%%%%%% Functional preprocessing
    disp('%%%%% Functional processing %%%%%');
    disp(' ');
    
    path_anat_results = strcat(path_anat,'anat_results/');
    path_func_results = strcat(path_func,func_name,'_func_results/');
    mkdir(path_func_results);
    
    cd(path_func_results);
    
    system(strcat(['3dcopy ',path_func,func_name,func_ext,' ',path_func_results,'1_',func_name,func_ext]));
    disp(' ');
    
    disp('%%%%% Deoblique Data');
    system(strcat(['3drefit -deoblique ',path_func_results,'1_',func_name,func_ext]));
    disp(' ');
    
    disp('%%%%% Reorient to RPI');
    system(strcat(['3dresample -orient RPI -prefix ',path_func_results,'2_RPI_',func_name,func_ext,' -inset ',path_func_results,'1_',func_name,func_ext]));
    disp(' ');

    system(strcat(['fslmaths ',path_func_results,'2_RPI_',func_name,func_ext,' ',path_func_results,'3_Orig',func_name,func_ext,' -odt float']));
    system(strcat(['fslinfo ',path_func_results,'3_Orig',func_name,func_ext, '| grep ''dim4'' > ',path_func_results,'4_File.1D']));
    
    func_info = importdata('4_File.1D');
    TR = func_info.data(2);
    Vol = func_info.data(1);
    vd = ceil(10/TR);   % number of volumes to be deleted
    Fina = Vol - vd;
    delete_time = vd * TR;
    
    disp(strcat(['%%%%% Delete ',int2str(vd),' volumes (',int2str(delete_time),'s)']));   disp(' ');
    system(strcat(['fslroi ',path_func_results,'3_Orig',func_name,func_ext,' ',path_func_results,'5_BR_',func_name,func_ext,' ',int2str(vd),' ', int2str(Fina)]));
    
    disp('%%%%% Motion scrubbing: FD > 0.5');
    system(strcat(['fsl_motion_outliers -i ',path_func_results,'5_BR_',func_name,func_ext,' -o 6_mot_confound -s 6_metric -p 6_metric_plot --fd --thresh=0.5']));
    metric = importdata('6_metric');
    severe_mot_vol = find(metric > 0.5);
    if isempty(severe_mot_vol) ~= 1
        disp(strcat(['      - Scrub ',int2str(numel(severe_mot_vol)),' volumes with severe head motion']));
        system(strcat(['fslsplit ',path_func_results,'5_BR_',func_name,func_ext,' temp -t']));
        temp_flist = dir(strcat(path_func_results,'temp*.nii.gz'));
        for rm_list = 1:length(severe_mot_vol)
            system(strcat(['rm -rf ',path_func_results,temp_flist(severe_mot_vol(rm_list)).name]));
        end
        system(strcat(['fslmerge -t ',path_func_results,'6_MS_',func_name,func_ext,' ',path_func_results,'temp*.nii.gz']));
        system(strcat(['rm -rf ',path_func_results,'temp*']));
    else
        disp(strcat(['      - Not need to scrub volumes']));
        copyfile(strcat(path_func_results,'5_BR_',func_name,func_ext), strcat(path_func_results,'6_MS_',func_name,func_ext));
    end

    system(strcat(['fslinfo ',path_func_results,'6_MS_',func_name,func_ext, '| grep ''dim4'' > ',path_func_results,'6_File.1D']));
    
    func_info = importdata('6_File.1D');
    Vol = func_info.data(1);
    SBRef = ceil(Vol/2);
    
    disp('%%%%% Make SBRef image');
    system(strcat(['fslroi ',path_func_results,'6_MS_',func_name,func_ext,' ',path_func_results,'7_SBRef_',func_name,func_ext,' ',path_func_results,int2str(SBRef),' 1']));
    disp(' ');
    
    disp('%%%%% Motion correction');
    system(strcat(['mcflirt -in ',path_func_results,'6_MS_',func_name,func_ext,' -out ',path_func_results,'8_MC_',func_name,' -mats -plots -refvol ',int2str(SBRef),' -rmsrel -rmsabs']));
    copyfile(strcat(path_func_results,'8_MC_',func_name,'.par '), strcat(path_func_results,'8_MC_',func_name,'.1D'));
    % *.par: 1~3: translation (mm_x, mm_y, mm_z), 4~6: rotation (deg_x, deg_y, deg_z)
    disp(' ');

    disp('%%%%% Slice timing correction');
    system(strcat(['slicetimer -i ',path_func_results,'8_MC_',func_name,func_ext,' --out=',path_func_results,'9_STC_',func_name,func_ext,' -r ',num2str(TR)]));
    disp(' ');
    
    disp('%%%%% Mean image');
    system(strcat(['fslmaths ',path_func_results,'9_STC_',func_name,func_ext,' -Tmean ',path_func_results,'10_Mean_',func_name,func_ext]));
    disp(' ');
    
    disp('%%%%% Generate binary brain mask');
    system(strcat(['bet2 ',path_func_results,'10_Mean_',func_name,func_ext,' ',path_func_results,'11_',func_name,' -f 0.3 -n -m']));
    % -m generate binary brain mask, -n don't generate the default brain image output, -f fractional intensity threshold (0->1); default=0.5; smaller values give larger brain outline estimates
    system(strcat(['fslmaths ',path_func_results,'9_STC_',func_name,func_ext,' -mas ',path_func_results,'11_',func_name,'_mask',func_ext,' ',path_func_results,'12_BET_',func_name,func_ext]));
    
    system(strcat(['fslstats ',path_func_results,'12_BET_',func_name,func_ext,' -p 2 -p 98 > ',path_func_results,'13_thres_val.txt']));
    thres_val = textread(strcat(path_func_results,'13_thres_val.txt'));
    Th = thres_val(2) / 10;
    system(strcat(['fslmaths ',path_func_results,'12_BET_',func_name,func_ext,' -thr ',int2str(Th),' -Tmin -bin ',path_func_results,'11_',func_name,'_mask',func_ext,' -odt char']));
    system(strcat(['fslstats ',path_func_results,'9_STC_',func_name,func_ext,' -k ',path_func_results,'11_',func_name,'_mask',func_ext,' -p 50']));
    system(strcat(['fslmaths ',path_func_results,'11_',func_name,'_mask',func_ext,' -dilF ',path_func_results,'12_BET_',func_name,func_ext]));
    system(strcat(['fslmaths ',path_func_results,'9_STC_',func_name,func_ext,' -mas ',path_func_results,'12_BET_',func_name,func_ext,' ',path_func_results,'13_Thr_',func_name,func_ext]));
    disp(' ');
    
    disp('%%%%% Intensity normalization');
    system(strcat(['fslmaths ',path_func_results,'13_Thr_',func_name,func_ext,' -inm 10000 ',path_func_results,'14_IntNorm_',func_name,func_ext]));
    
    system(strcat(['fslmaths ',path_func_results,'14_IntNorm_',func_name,func_ext,' ',path_func_results,'15_Filtered_',func_name,func_ext]));
    system(strcat(['fslhd -x ',path_func_results,'15_Filtered_',func_name,func_ext,' | sed ''s/ dt = .*/ dt = ''',num2str(TR,'%.1f'),'''/g'' > ',path_func_results,'15_tmpHeader']));
    system(strcat(['fslcreatehd ',path_func_results,'15_tmpHeader ',path_func_results,'15_Filtered_',func_name,func_ext]));
    system(strcat(['fslmaths ',path_func_results,'15_Filtered_',func_name,func_ext,' -Tmean ',path_func_results,'15_Mean_',func_name,func_ext]));
    % -Tmean: mean across time
    disp(' ');
    
    disp('%%%%% Initial registration');
    system(strcat(['fslmaths ',path_anat_results,'5_Template_SS_RPI_',anat_name,anat_ext,' ',path_func_results,'16_highres_',func_name,func_ext]));
    system(strcat(['fslmaths ',template,' ',path_func_results,'16_standard_',func_name,func_ext]));
    system(strcat(['flirt -ref ',path_func_results,'16_highres_',func_name,func_ext,' -in ',path_func_results,'7_SBRef_',func_name,func_ext,...
        ' -out ',path_func_results,'17_Func2HR_',func_name,func_ext,' -omat ',path_func_results,'17_Func2HR_',func_name,'.mat',...
        ' -cost corratio -dof 12 -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -interp trilinear']));
    system(strcat(['convert_xfm -inverse -omat ',path_func_results,'17_HR2Func_',func_name,'.mat ',path_func_results,'17_Func2HR_',func_name,'.mat']));
    disp(' ');
    
%     disp('%%%%% ICA-FIX');
%     mkdir(strcat(path_func_results,'18_ICAFIX'));
%     mkdir(strcat(path_func_results,'18_ICAFIX/mc'));
%     mkdir(strcat(path_func_results,'18_ICAFIX/reg'));
%     copyfile(strcat(path_func_results,'15_Filtered_',func_name,'.nii.gz'), strcat(path_func_results,'18_ICAFIX/filtered_func_data.nii.gz'));
%     copyfile(strcat(path_func_results,'8_MC_',func_name,'.par'), strcat(path_func_results,'18_ICAFIX/mc/prefiltered_func_data_mcf.par'));
%     copyfile(strcat(path_func_results,'15_Mean_',func_name,'.nii.gz'), strcat(path_func_results,'18_ICAFIX/mean_func.nii.gz'));
%     system(strcat(['fslmaths ',path_func_results,'18_ICAFIX/mean_func.nii.gz -bin ',path_func_results,'18_ICAFIX/mask.nii.gz']));
%     copyfile(strcat(path_func_results,'15_Mean_',func_name,'.nii.gz'), strcat(path_func_results,'18_ICAFIX/reg/example_func.nii.gz'));
%     copyfile(strcat(path_func_results,'16_highres_',func_name,'.nii.gz'), strcat(path_func_results,'18_ICAFIX/reg/highres.nii.gz'));
%     copyfile(strcat(path_func_results,'17_HR2Func_',func_name,'.mat'), strcat(path_func_results,'18_ICAFIX/reg/highres2example_func.mat'));
%     system(strcat(['melodic -i ',path_func_results,'18_ICAFIX/filtered_func_data.nii.gz -o ',path_func_results,'18_ICAFIX/filtered_func_data.ica ',...
%         ' -v --nobet --bgthreshold=3 --tr=',num2str(TR,'%.1f'),' --report -d ',int2str(num_dim),' --mmthresh=0.5 --Ostats']));
%     system(strcat(['fix -f ',path_func_results,'18_ICAFIX']));
%     system(strcat(['fix -c ',path_func_results,'18_ICAFIX ',fix_train,' 20']));
%     temp = strsplit(fix_train, '/');    temp = strsplit(temp{end}, '.');    fix_train_name = temp{1};
%     system(strcat(['fix -a ',path_func_results,'18_ICAFIX/fix4melview_',fix_train_name,'_thr20.txt -m -h 0 -A']));
%     % bad component, motion condounds aggressive cleanup + linear detrending
%     copyfile(strcat(path_func_results,'18_ICAFIX/filtered_func_data_clean.nii.gz'), strcat(path_func_results,'18_Filtered_clean_',func_name,'.nii.gz'));
%     disp(' ');
    
    disp('%%%%% Final registration');
    system(strcat(['flirt -ref ',path_func_results,'16_standard_',func_name,'.nii.gz',' -in ',path_func_results,'16_highres_',func_name,'.nii.gz',...
        ' -out ',path_func_results,'19_HR2STD_',func_name,'.nii.gz',' -omat ',path_func_results,'19_HR2STD_',func_name,'.mat',...
        ' -cost corratio -dof 12 -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -interp trilinear']));
    system(strcat(['convert_xfm -inverse -omat ',path_func_results,'20_STD2HR_',func_name,'.mat ',path_func_results,'19_HR2STD_',func_name,'.mat']));
    system(strcat(['convert_xfm -omat ',path_func_results,'21_Func2STD_',func_name,'.mat -concat ',path_func_results,'19_HR2STD_',func_name,'.mat ',path_func_results,'17_Func2HR_',func_name,'.mat']));
    system(strcat(['flirt -ref ',path_func_results,'16_standard_',func_name,'.nii.gz',' -in ',path_func_results,'7_SBRef_',func_name,'.nii.gz',...
        ' -out ',path_func_results,'21_Func2STD_',func_name,'.nii.gz',' -applyxfm -init ',path_func_results,'21_Func2STD_',func_name,'.mat -interp trilinear']));
    system(strcat(['flirt -applyxfm -init ',path_func_results,'21_Func2STD_',func_name,'.mat -in ',path_func_results,'18_Filtered_clean_',func_name,'.nii.gz',...
        ' -ref ',path_func_results,'16_standard_',func_name,'.nii.gz',' -out ',path_func_results,'21_Func2STD_4D_',func_name,'.nii.gz',' -interp trilinear']));
    disp(' ');
    
    disp('%%%%% Band-pass Filtering');
    system(strcat(['3dFourier -lowpass 0.08 -highpass 0.009 -prefix ',path_func_results,'22_BPF_',func_name,'.nii.gz -retrend ',path_func_results,'21_Func2STD_4D_',func_name,'.nii.gz']));
    disp(' ');
    
    disp(strcat(['%%%%% Spatial smoothing with FWHM = ',num2str(FWHM,'%.1f')]));
    system(strcat(['3dmerge -quiet -1blur_fwhm ',num2str(FWHM,'%.1f'),' -doall -prefix ',path_func_results,'23_Smooth_',func_name,'.nii.gz ',path_func_results,'22_BPF_',func_name,'.nii.gz']));
    disp(' ');
    
    system(strcat(['chmod 777 -R ',path_func_results]));
    
    disp('%%%%% Functional Processing Finished %%%%%');
    disp(' ');  disp(' ');
end







