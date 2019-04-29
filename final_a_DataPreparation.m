%% HCP imaging genetics 
%   : Fluid Intelligence prediction
%   Data preparation
%   Get T1, DTI, fMRI file with freesurfer
%   and workbench adjust file

clear; clc;

flist = [100206	100307	100408	100610	101107	102109	102311	102513	102614	102715	103111	103212	103414	103818	104012	105014	105115	105216	105620	105923	106016	106319	106521	106824	107018	108020	108222	108323	109123	110411	110613	111009	111211	111312	111413	111514	112516	112920	113215	113619	113922	114217	114419	114621	114823	115320	115724	116726	117021	117930	118225	118730	118831	118932	119025	120111	120414	120717	122317	122620	122822	123521	124220	124624	124826	125222	125424	125525	126325	126426	127226	127832	127933	128632	128935	129028	129129	130013	130114	130316	130417	130619	130720	131217	131722	131823	133019	133625	134021	134425	134728	135124	135528	135629	135932	136227	136631	136732	136833	137229	137532	138130	138231	139233	139435	139637	139839	140117	140319	141422	141826	143224	143325	143830	144125	144428	144731	144832	144933	145632	145834	146129	146432	146735	146836	146937	147030	147636	147737	148133	148840	148941	149337	149539	149741	150625	150726	150928	151223	151425	151526	151627	151728	151829	151930	152225	152427	153025	153126	153227	153429	154431	154532	154734	154835	155635	155938	156334	156435	156637	157336	157437	158035	158136	158338	158540	158843	159138	159239	159744	161731	162026	162228	162329	162733	162935	163129	163331	164030	164131	164636	165436	165638	166438	167036	167238	167440	168139	168240	168947	169040	169444	169545	169949	170631	171330	171633	172029	172130	172433	172534	173334	173435	173536	173940	174841	175136	175237	175439	175742	176037	176441	176542	177140	177241	177645	178142	178647	179346	180432	180735	180937	181232	182436	182739	185139	185341	185947	186848	187547	188145	188751	189349	189652	191033	191336	191841	191942	192136	192237	192540	192641	192843	193239	193845	194443	194847	195445	195849	195950	196144	196346	196750	197348	198047	198249	198451	198653	199150	199655	200008	200109	200311	200513	200614	201515	201818	202113	202719	203418	203923	204016	205220	205725	205826	206222	206323	206727	206828	206929	207123	207426	208226	208327	209127	209228	209329	210011	210112	210415	210617	211922	212419	212823	213421	214423	214524	214726	217429	220721	227533	228434	231928	233326	238033	239944	246133	250427	250932	251833	255639	255740	257542	257845	263436	268749	274542	275645	283543	285345	285446	286650	287248	298051	299154	300719	303624	304020	304727	307127	308129	308331	310621	314225	316835	320826	321323	325129	330324	333330	341834	342129	346137	346945	349244	352132	353740	358144	360030	361234	365343	366042	371843	377451	378756	380036	381038	381543	385046	385450	386250	387959	389357	391748	392447	393247	393550	394956	395756	397154	397760	397861	401422	406836	412528	413934	414229	422632	424939	429040	432332	433839	436239	436845	445543	448347	453441	453542	454140	456346	459453	461743	463040	467351	468050	469961	479762	481042	481951	495255	499566	500222	506234	510225	510326	512835	513130	516742	519647	519950	520228	522434	525541	529953	530635	531536	541640	553344	555954	557857	558657	558960	559053	561949	562446	567759	568963	572045	573249	576255	579867	581450	583858	586460	587664	588565	590047	597869	598568	599065	609143	613538	615744	616645	617748	618952	622236	627549	627852	633847	635245	638049	645450	654552	656253	656657	660951	663755	664757	665254	668361	671855	672756	673455	675661	677766	677968	679568	680452	690152	692964	695768	698168	700634	702133	704238	705341	707749	709551	715950	723141	724446	725751	728454	731140	732243	734045	735148	742549	744553	748258	749058	753150	759869	761957	765056	765864	767464	770352	771354	773257	774663	779370	783462	784565	788674	789373	792564	800941	803240	810843	812746	814548	816653	818859	820745	825048	825553	826353	826454	828862	833249	835657	841349	844961	849971	852455	856766	856968	859671	861456	865363	869472	870861	871762	871964	872562	878877	882161	886674	887373	894673	896778	896879	898176	899885	901139	901442	902242	904044	907656	908860	910241	910443	911849	912447	917255	917558	919966	922854	923755	927359	932554	933253	942658	957974	958976	959574	966975	969476	971160	983773	990366	991267	992673	992774	993675	994273	996782];
% load matlab.mat

for i = 517:579    
    
    DBPath = '/store6/Public/Database/HCP_S1200';
    out_t1_path = strcat('/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/T1/',int2str(flist(i)));
    out_dti_path = strcat('/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/DTI/',int2str(flist(i)));
    out_fmri_path = strcat('/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/fMRI/',int2str(flist(i)));
    
    if ~exist([DBPath,'/',int2str(flist(i)),'_3T_rfMRI_REST1_fixextended.zip'],'file')
        continue;
    elseif ~exist([DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip'],'file')
        continue;
    elseif ~exist([DBPath,'/',int2str(flist(i)),'_3T_Diffusion_preproc.zip'],'file')
       continue;
    elseif ~exist([DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc_extended.zip'],'file')
        continue;
    end
    disp(strcat(['list = ',int2str(i),' -- ',int2str(flist(i))]));
    mkdir(out_dti_path); mkdir(out_t1_path); mkdir(out_fmri_path);mkdir([out_t1_path,'/wb_adjust']);
    
    % unzip file
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_rfMRI_REST1_fixextended.zip ',int2str(flist(i)),'/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR_hp2000_clean.nii.gz -d ',out_fmri_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_rfMRI_REST1_fixextended.zip ',int2str(flist(i)),'/MNINonLinear/Results/rfMRI_REST1_RL/rfMRI_REST1_RL_hp2000_clean.nii.gz -d ',out_fmri_path]));
    
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/T1w_restore_brain.nii.gz -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc_extended.zip ',int2str(flist(i)),'/T1w/',int2str(flist(i)),'/* -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.midthickness.32k_fs_LR.surf.gii -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.pial.32k_fs_LR.surf.gii -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.thickness.32k_fs_LR.shape.gii -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.sulc.32k_fs_LR.shape.gii -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.curvature.32k_fs_LR.shape.gii -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.white.32k_fs_LR.surf.gii -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.midthickness.32k_fs_LR.surf.gii -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.pial.32k_fs_LR.surf.gii -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.thickness.32k_fs_LR.shape.gii -d ',out_t1_path]));    
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.sulc.32k_fs_LR.shape.gii -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.curvature.32k_fs_LR.shape.gii -d ',out_t1_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.white.32k_fs_LR.surf.gii -d ',out_t1_path]));    
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Structural_preproc.zip ',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.32k_fs_LR.wb.spec -d ',out_t1_path]));

    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Diffusion_preproc.zip ',int2str(flist(i)),'/T1w/Diffusion/data.nii.gz -d ',out_dti_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Diffusion_preproc.zip ',int2str(flist(i)),'/T1w/Diffusion/bvals -d ',out_dti_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Diffusion_preproc.zip ',int2str(flist(i)),'/T1w/Diffusion/bvecs -d ',out_dti_path]));
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_3T_Diffusion_preproc.zip ',int2str(flist(i)),'/T1w/Diffusion/nodif_brain_mask.nii.gz -d ',out_dti_path]));
    
    % move file
    movefile( strcat(out_dti_path,'/',int2str(flist(i)),'/T1w/Diffusion/data.nii.gz'), out_dti_path );
    movefile( strcat(out_dti_path,'/',int2str(flist(i)),'/T1w/Diffusion/bvals'), out_dti_path );
    movefile( strcat(out_dti_path,'/',int2str(flist(i)),'/T1w/Diffusion/bvecs'), out_dti_path );
    movefile( strcat(out_dti_path,'/',int2str(flist(i)),'/T1w/Diffusion/nodif_brain_mask.nii.gz'), out_dti_path );
    
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/T1w_restore_brain.nii.gz'), out_t1_path );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/T1w/',int2str(flist(i)),'/*'), [out_t1_path,'/freesurfer']);
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.midthickness.32k_fs_LR.surf.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.pial.32k_fs_LR.surf.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.thickness.32k_fs_LR.shape.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.sulc.32k_fs_LR.shape.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.curvature.32k_fs_LR.shape.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.L.white.32k_fs_LR.surf.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.midthickness.32k_fs_LR.surf.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.pial.32k_fs_LR.surf.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.thickness.32k_fs_LR.shape.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.sulc.32k_fs_LR.shape.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.curvature.32k_fs_LR.shape.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.R.white.32k_fs_LR.surf.gii'), [out_t1_path,'/wb_adjust'] );
    movefile( strcat(out_t1_path,'/',int2str(flist(i)),'/MNINonLinear/fsaverage_LR32k/',int2str(flist(i)),'.32k_fs_LR.wb.spec'), [out_t1_path,'/wb_adjust'] );

    movefile( strcat(out_fmri_path,'/',int2str(flist(i)),'/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR_hp2000_clean.nii.gz'), out_fmri_path );
    movefile( strcat(out_fmri_path,'/',int2str(flist(i)),'/MNINonLinear/Results/rfMRI_REST1_RL/rfMRI_REST1_RL_hp2000_clean.nii.gz'), out_fmri_path );
    
    % remove folder
    rmdir(strcat(out_fmri_path,'/',int2str(flist(i))), 's');
    rmdir(strcat(out_t1_path,'/',int2str(flist(i))), 's');
    rmdir(strcat(out_dti_path,'/',int2str(flist(i))), 's');
    
    % Average LR/RL phase encoded data
    system(strcat(['3dMean -prefix ',out_fmri_path,'/REST1.nii.gz -fscale ',out_fmri_path,'/rfMRI_REST1_*.nii.gz']));
    system(strcat(['rm -rf ',out_fmri_path,'/rfMRI_REST1_*']));
    
    % Resample data
    %system(strcat(['flirt -applyxfm -init /store5/bypark/ETC/2mmto6mm.mat -in ',out_fmri_path,'/REST1 -ref /store5/bypark/ETC/MNI152_T1_6mm_brain -out ',out_fmri_path,'/REST1_6mm']));
end




%% Addintional data: Bedpostx
clear;clc

flist = [100206	100307	100408	100610	101107	102109	102311	102513	102614	102715	103111	103212	103414	103818	104012	105014	105115	105216	105620	105923	106016	106319	106521	106824	107018	108020	108222	108323	109123	110411	110613	111009	111211	111312	111413	111514	112516	112920	113215	113619	113922	114217	114419	114621	114823	115320	115724	116726	117021	117930	118225	118730	118831	118932	119025	120111	120414	120717	122317	122620	122822	123521	124220	124624	124826	125222	125424	125525	126325	126426	127226	127832	127933	128632	128935	129028	129129	130013	130114	130316	130417	130619	130720	131217	131722	131823	133019	133625	134021	134425	134728	135124	135528	135629	135932	136227	136631	136732	136833	137229	137532	138130	138231	139233	139435	139637	139839	140117	140319	141422	141826	143224	143325	143830	144125	144428	144731	144832	144933	145632	145834	146129	146432	146735	146836	146937	147030	147636	147737	148133	148840	148941	149337	149539	149741	150625	150726	150928	151223	151425	151526	151627	151728	151829	151930	152225	152427	153025	153126	153227	153429	154431	154532	154734	154835	155635	155938	156334	156435	156637	157336	157437	158035	158136	158338	158540	158843	159138	159239	159744	161731	162026	162228	162329	162733	162935	163129	163331	164030	164131	164636	165436	165638	166438	167036	167238	167440	168139	168240	168947	169040	169444	169545	169949	170631	171330	171633	172029	172130	172433	172534	173334	173435	173536	173940	174841	175136	175237	175439	175742	176037	176441	176542	177140	177241	177645	178142	178647	179346	180432	180735	180937	181232	182436	182739	185139	185341	185947	186848	187547	188145	188751	189349	189652	191033	191336	191841	191942	192136	192237	192540	192641	192843	193239	193845	194443	194847	195445	195849	195950	196144	196346	196750	197348	198047	198249	198451	198653	199150	199655	200008	200109	200311	200513	200614	201515	201818	202113	202719	203418	203923	204016	205220	205725	205826	206222	206323	206727	206828	206929	207123	207426	208226	208327	209127	209228	209329	210011	210112	210415	210617	211922	212419	212823	213421	214423	214524	214726	217429	220721	227533	228434	231928	233326	238033	239944	246133	250427	250932	251833	255639	255740	257542	257845	263436	268749	274542	275645	283543	285345	285446	286650	287248	298051	299154	300719	303624	304020	304727	307127	308129	308331	310621	314225	316835	320826	321323	325129	330324	333330	341834	342129	346137	346945	349244	352132	353740	358144	360030	361234	365343	366042	371843	377451	378756	380036	381038	381543	385046	385450	386250	387959	389357	391748	392447	393247	393550	394956	395756	397154	397760	397861	401422	406836	412528	413934	414229	422632	424939	429040	432332	433839	436239	436845	445543	448347	453441	453542	454140	456346	459453	461743	463040	467351	468050	469961	479762	481042	481951	495255	499566	500222	506234	510225	510326	512835	513130	516742	519647	519950	520228	522434	525541	529953	530635	531536	541640	553344	555954	557857	558657	558960	559053	561949	562446	567759	568963	572045	573249	576255	579867	581450	583858	586460	587664	588565	590047	597869	598568	599065	609143	613538	615744	616645	617748	618952	622236	627549	627852	633847	635245	638049	645450	654552	656253	656657	660951	663755	664757	665254	668361	671855	672756	673455	675661	677766	677968	679568	680452	690152	692964	695768	698168	700634	702133	704238	705341	707749	709551	715950	723141	724446	725751	728454	731140	732243	734045	735148	742549	744553	748258	749058	753150	759869	761957	765056	765864	767464	770352	771354	773257	774663	779370	783462	784565	788674	789373	792564	800941	803240	810843	812746	814548	816653	818859	826353	826454	828862	833249	835657	841349	844961	849971	852455	856766	856968	859671	861456	865363	869472	870861	871762	871964	872562	878877	882161	886674	887373	894673	896778	896879	898176	899885	901139	901442	902242	904044	907656	908860	910241	910443	911849	912447	917255	917558	919966	922854	923755	927359	932554	933253	942658	957974	958976	959574	966975	969476	971160	983773	990366	991267	992673	992774	993675	994273	996782];

for i = 2:576
    DBPath = strcat('/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/03.bedpostx');
    out_dti_path = strcat('/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/DTI/',int2str(flist(i)),'/tractography');
    mkdir(out_dti_path);
    
    % Prepare data
    system(strcat(['unzip ',DBPath,'/',int2str(flist(i)),'_bedpostx.zip ',int2str(flist(i)),'/T1w/Diffusion.bedpostX/* -d ',out_dti_path]));


    mkdir([ out_dti_path,'/native_space.bedpostX'] );
    movefile( strcat(out_dti_path,'/',int2str(flist(i)),'/T1w/Diffusion.bedpostX/*'),[ out_dti_path,'/native_space.bedpostX/'] );

    rmdir(strcat(out_dti_path,'/',int2str(flist(i))), 's');
    
    % Resample data
    %system(strcat(['flirt -applyxfm -init /store5/bypark/ETC/2mmto6mm.mat -in ',out_fmri_path,'/REST1 -ref /store5/bypark/ETC/MNI152_T1_6mm_brain -out ',out_fmri_path,'/REST1_6mm']));
end
