%% HCP imaging genetics 
%   :  Extracting regional information of DTI using FSL, freesurfer, and workbench in HCP
%   
%  Atlas: Human connectome project multi-modal parcellation (i.e. 360 brain regions)
%  Measurements:  BC/DC/EC using structural connectivity analysis
%
%  DTI processing : Tractography (implemented in FSL)
%  1. DIFIT
%  2. BedpostX (with sun grid engine or gpu)
%  3. ProbatrackX (with sun grid engine or gpu)
%  4. Weighted connectivity analysis
%
%  Created : Apr-13-2019
%  Author : Mansu Kim, mansooru@skku.edu or mansooru.kim@gmail.com 
%  @ Sungkyunkwan University

%% DTFIT
clear; clc;
flist = [100206	100307	100408	100610	101107	102109	102311	102513	102614	102715	103111	103212	103414	103818	104012	105014	105115	105216	105620	105923	106016	106319	106521	106824	107018	108020	108222	108323	109123	110411	110613	111009	111211	111312	111413	111514	112516	112920	113215	113619	113922	114217	114419	114621	114823	115320	115724	116726	117021	117930	118225	118730	118831	118932	119025	120111	120414	120717	122317	122620	122822	123521	124220	124624	124826	125222	125424	125525	126325	126426	127226	127832	127933	128632	128935	129028	129129	130013	130114	130316	130417	130619	130720	131217	131722	131823	133019	133625	134021	134425	134728	135124	135528	135629	135932	136227	136631	136732	136833	137229	137532	138130	138231	139233	139435	139637	139839	140117	140319	141422	141826	143224	143325	143830	144125	144428	144731	144832	144933	145632	145834	146129	146432	146735	146836	146937	147030	147636	147737	148133	148840	148941	149337	149539	149741	150625	150726	150928	151223	151425	151526	151627	151728	151829	151930	152225	152427	153025	153126	153227	153429	154431	154532	154734	154835	155635	155938	156334	156435	156637	157336	157437	158035	158136	158338	158540	158843	159138	159239	159744	161731	162026	162228	162329	162733	162935	163129	163331	164030	164131	164636	165436	165638	166438	167036	167238	167440	168139	168240	168947	169040	169444	169545	169949	170631	171330	171633	172029	172130	172433	172534	173334	173435	173536	173940	174841	175136	175237	175439	175742	176037	176441	176542	177140	177241	177645	178142	178647	179346	180432	180735	180937	181232	182436	182739	185139	185341	185947	186848	187547	188145	188751	189349	189652	191033	191336	191841	191942	192136	192237	192540	192641	192843	193239	193845	194443	194847	195445	195849	195950	196144	196346	196750	197348	198047	198249	198451	198653	199150	199655	200008	200109	200311	200513	200614	201515	201818	202113	202719	203418	203923	204016	205220	205725	205826	206222	206323	206727	206828	206929	207123	207426	208226	208327	209127	209228	209329	210011	210112	210415	210617	211922	212419	212823	213421	214423	214524	214726	217429	220721	227533	228434	231928	233326	238033	239944	246133	250427	250932	251833	255639	255740	257542	257845	263436	268749	274542	275645	283543	285345	285446	286650	287248	298051	299154	300719	303624	304020	304727	307127	308129	308331	310621	314225	316835	320826	321323	325129	330324	333330	341834	342129	346137	346945	349244	352132	353740	358144	360030	361234	365343	366042	371843	377451	378756	380036	381038	381543	385046	385450	386250	387959	389357	391748	392447	393247	393550	394956	395756	397154	397760	397861	401422	406836	412528	413934	414229	422632	424939	429040	432332	433839	436239	436845	445543	448347	453441	453542	454140	456346	459453	461743	463040	467351	468050	469961	479762	481042	481951	495255	499566	500222	506234	510225	510326	512835	513130	516742	519647	519950	520228	522434	525541	529953	530635	531536	541640	553344	555954	557857	558657	558960	559053	561949	562446	567759	568963	572045	573249	576255	579867	581450	583858	586460	587664	588565	590047	597869	598568	599065	609143	613538	615744	616645	617748	618952	622236	627549	627852	633847	635245	638049	645450	654552	656253	656657	660951	663755	664757	665254	668361	671855	672756	673455	675661	677766	677968	679568	680452	690152	692964	695768	698168	700634	702133	704238	705341	707749	709551	715950	723141	724446	725751	728454	731140	732243	734045	735148	742549	744553	748258	749058	753150	759869	761957	765056	765864	767464	770352	771354	773257	774663	779370	783462	784565	788674	789373	792564	800941	803240	810843	812746	814548	816653	818859	826353	826454	828862	833249	835657	841349	844961	849971	852455	856766	856968	859671	861456	865363	869472	870861	871762	871964	872562	878877	882161	886674	887373	894673	896778	896879	898176	899885	901139	901442	902242	904044	907656	908860	910241	910443	911849	912447	917255	917558	919966	922854	923755	927359	932554	933253	942658	957974	958976	959574	966975	969476	971160	983773	990366	991267	992673	992774	993675	994273	996782];

path = '/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/DTI/';
path_output = 'tractography/';                                                 %% change if necessary.

for i = 1:length(flist)
    ResultFolder = [path '/' int2str(flist(i))];
    if ~exist([ResultFolder '/' path_output '/native_space'] , 'dir')
        mkdir([ResultFolder '/' path_output '/native_space']);
    else
        continue;
    end
    
    % Create binary brain mask
    %mask = ['fslmaths ' ResultFolder '/b0.nii.gz -bin ' ResultFolder '/native_space/nodif_brain_mask.nii.gz'];
    %disp(mask); system(mask);
    
    % Move file to Working Folder
    copyfile([ResultFolder '/nodif_brain_mask.nii.gz'],[ResultFolder '/' path_output  '/native_space/nodif_brain_mask.nii.gz']);
    copyfile([ResultFolder '/data.nii.gz'],[ResultFolder '/' path_output  '/native_space/data.nii.gz']);
    copyfile([ResultFolder '/bvals'],[ResultFolder '/' path_output  '/native_space/bvals']);
    copyfile([ResultFolder '/bvecs'],[ResultFolder '/' path_output  '/native_space/bvecs']);
    
    data_file = [ResultFolder '/data.nii.gz'];
    out_file = [ResultFolder '/' path_output  '/native_space/difit'];
    mask_file = [ResultFolder '/nodif_brain_mask'];
    bvec_file = [ResultFolder '/bvecs'];
    bval_file = [ResultFolder '/bvals'];
    cmd = cat(2, 'dtifit -k ', data_file,  ' -m ',mask_file, ' -r ',bvec_file, ' -b ', bval_file, ' -o ',out_file);
    disp(cmd);
    system(cmd);
end

%% BedpostX
clear; clc;

flist = [100206	100307	100408	100610	101107	102109	102311	102513	102614	102715	103111	103212	103414	103818	104012	105014	105115	105216	105620	105923	106016	106319	106521	106824	107018	108020	108222	108323	109123	110411	110613	111009	111211	111312	111413	111514	112516	112920	113215	113619	113922	114217	114419	114621	114823	115320	115724	116726	117021	117930	118225	118730	118831	118932	119025	120111	120414	120717	122317	122620	122822	123521	124220	124624	124826	125222	125424	125525	126325	126426	127226	127832	127933	128632	128935	129028	129129	130013	130114	130316	130417	130619	130720	131217	131722	131823	133019	133625	134021	134425	134728	135124	135528	135629	135932	136227	136631	136732	136833	137229	137532	138130	138231	139233	139435	139637	139839	140117	140319	141422	141826	143224	143325	143830	144125	144428	144731	144832	144933	145632	145834	146129	146432	146735	146836	146937	147030	147636	147737	148133	148840	148941	149337	149539	149741	150625	150726	150928	151223	151425	151526	151627	151728	151829	151930	152225	152427	153025	153126	153227	153429	154431	154532	154734	154835	155635	155938	156334	156435	156637	157336	157437	158035	158136	158338	158540	158843	159138	159239	159744	161731	162026	162228	162329	162733	162935	163129	163331	164030	164131	164636	165436	165638	166438	167036	167238	167440	168139	168240	168947	169040	169444	169545	169949	170631	171330	171633	172029	172130	172433	172534	173334	173435	173536	173940	174841	175136	175237	175439	175742	176037	176441	176542	177140	177241	177645	178142	178647	179346	180432	180735	180937	181232	182436	182739	185139	185341	185947	186848	187547	188145	188751	189349	189652	191033	191336	191841	191942	192136	192237	192540	192641	192843	193239	193845	194443	194847	195445	195849	195950	196144	196346	196750	197348	198047	198249	198451	198653	199150	199655	200008	200109	200311	200513	200614	201515	201818	202113	202719	203418	203923	204016	205220	205725	205826	206222	206323	206727	206828	206929	207123	207426	208226	208327	209127	209228	209329	210011	210112	210415	210617	211922	212419	212823	213421	214423	214524	214726	217429	220721	227533	228434	231928	233326	238033	239944	246133	250427	250932	251833	255639	255740	257542	257845	263436	268749	274542	275645	283543	285345	285446	286650	287248	298051	299154	300719	303624	304020	304727	307127	308129	308331	310621	314225	316835	320826	321323	325129	330324	333330	341834	342129	346137	346945	349244	352132	353740	358144	360030	361234	365343	366042	371843	377451	378756	380036	381038	381543	385046	385450	386250	387959	389357	391748	392447	393247	393550	394956	395756	397154	397760	397861	401422	406836	412528	413934	414229	422632	424939	429040	432332	433839	436239	436845	445543	448347	453441	453542	454140	456346	459453	461743	463040	467351	468050	469961	479762	481042	481951	495255	499566	500222	506234	510225	510326	512835	513130	516742	519647	519950	520228	522434	525541	529953	530635	531536	541640	553344	555954	557857	558657	558960	559053	561949	562446	567759	568963	572045	573249	576255	579867	581450	583858	586460	587664	588565	590047	597869	598568	599065	609143	613538	615744	616645	617748	618952	622236	627549	627852	633847	635245	638049	645450	654552	656253	656657	660951	663755	664757	665254	668361	671855	672756	673455	675661	677766	677968	679568	680452	690152	692964	695768	698168	700634	702133	704238	705341	707749	709551	715950	723141	724446	725751	728454	731140	732243	734045	735148	742549	744553	748258	749058	753150	759869	761957	765056	765864	767464	770352	771354	773257	774663	779370	783462	784565	788674	789373	792564	800941	803240	810843	812746	814548	816653	818859	826353	826454	828862	833249	835657	841349	844961	849971	852455	856766	856968	859671	861456	865363	869472	870861	871762	871964	872562	878877	882161	886674	887373	894673	896778	896879	898176	899885	901139	901442	902242	904044	907656	908860	910241	910443	911849	912447	917255	917558	919966	922854	923755	927359	932554	933253	942658	957974	958976	959574	966975	969476	971160	983773	990366	991267	992673	992774	993675	994273	996782];
path = '/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/DTI';
tic
for i = 1%:length(flist)
    ResultFolder = [path '/' int2str(flist(i)) '/t'];
    bedpostX = ['/usr/local/fsl/bin/bedpostx_gpu ' ResultFolder '/native_space --nf=3 --fudge=1  --bi=2000'];
    disp(bedpostX); system(bedpostX);
end
toc

%% Pre-porbtrackX
clear; clc;

flist = [100206	100307	100408	100610	101107	102109	102311	102513	102614	102715	103111	103212	103414	103818	104012	105014	105115	105216	105620	105923	106016	106319	106521	106824	107018	108020	108222	108323	109123	110411	110613	111009	111211	111312	111413	111514	112516	112920	113215	113619	113922	114217	114419	114621	114823	115320	115724	116726	117021	117930	118225	118730	118831	118932	119025	120111	120414	120717	122317	122620	122822	123521	124220	124624	124826	125222	125424	125525	126325	126426	127226	127832	127933	128632	128935	129028	129129	130013	130114	130316	130417	130619	130720	131217	131722	131823	133019	133625	134021	134425	134728	135124	135528	135629	135932	136227	136631	136732	136833	137229	137532	138130	138231	139233	139435	139637	139839	140117	140319	141422	141826	143224	143325	143830	144125	144428	144731	144832	144933	145632	145834	146129	146432	146735	146836	146937	147030	147636	147737	148133	148840	148941	149337	149539	149741	150625	150726	150928	151223	151425	151526	151627	151728	151829	151930	152225	152427	153025	153126	153227	153429	154431	154532	154734	154835	155635	155938	156334	156435	156637	157336	157437	158035	158136	158338	158540	158843	159138	159239	159744	161731	162026	162228	162329	162733	162935	163129	163331	164030	164131	164636	165436	165638	166438	167036	167238	167440	168139	168240	168947	169040	169444	169545	169949	170631	171330	171633	172029	172130	172433	172534	173334	173435	173536	173940	174841	175136	175237	175439	175742	176037	176441	176542	177140	177241	177645	178142	178647	179346	180432	180735	180937	181232	182436	182739	185139	185341	185947	186848	187547	188145	188751	189349	189652	191033	191336	191841	191942	192136	192237	192540	192641	192843	193239	193845	194443	194847	195445	195849	195950	196144	196346	196750	197348	198047	198249	198451	198653	199150	199655	200008	200109	200311	200513	200614	201515	201818	202113	202719	203418	203923	204016	205220	205725	205826	206222	206323	206727	206828	206929	207123	207426	208226	208327	209127	209228	209329	210011	210112	210415	210617	211922	212419	212823	213421	214423	214524	214726	217429	220721	227533	228434	231928	233326	238033	239944	246133	250427	250932	251833	255639	255740	257542	257845	263436	268749	274542	275645	283543	285345	285446	286650	287248	298051	299154	300719	303624	304020	304727	307127	308129	308331	310621	314225	316835	320826	321323	325129	330324	333330	341834	342129	346137	346945	349244	352132	353740	358144	360030	361234	365343	366042	371843	377451	378756	380036	381038	381543	385046	385450	386250	387959	389357	391748	392447	393247	393550	394956	395756	397154	397760	397861	401422	406836	412528	413934	414229	422632	424939	429040	432332	433839	436239	436845	445543	448347	453441	453542	454140	456346	459453	461743	463040	467351	468050	469961	479762	481042	481951	495255	499566	500222	506234	510225	510326	512835	513130	516742	519647	519950	520228	522434	525541	529953	530635	531536	541640	553344	555954	557857	558657	558960	559053	561949	562446	567759	568963	572045	573249	576255	579867	581450	583858	586460	587664	588565	590047	597869	598568	599065	609143	613538	615744	616645	617748	618952	622236	627549	627852	633847	635245	638049	645450	654552	656253	656657	660951	663755	664757	665254	668361	671855	672756	673455	675661	677766	677968	679568	680452	690152	692964	695768	698168	700634	702133	704238	705341	707749	709551	715950	723141	724446	725751	728454	731140	732243	734045	735148	742549	744553	748258	749058	753150	759869	761957	765056	765864	767464	770352	771354	773257	774663	779370	783462	784565	788674	789373	792564	800941	803240	810843	812746	814548	816653	818859	826353	826454	828862	833249	835657	841349	844961	849971	852455	856766	856968	859671	861456	865363	869472	870861	871762	871964	872562	878877	882161	886674	887373	894673	896778	896879	898176	899885	901139	901442	902242	904044	907656	908860	910241	910443	911849	912447	917255	917558	919966	922854	923755	927359	932554	933253	942658	957974	958976	959574	966975	969476	971160	983773	990366	991267	992673	992774	993675	994273	996782];
path = '/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/DTI';

for i = 2: length(flist)
    ResultFolder = [path '/' int2str(flist(i)) '/tractography'];
    resultant_folder = [ResultFolder '/Network/Probabilistic'];
    bedpostx_folder = [ResultFolder '/native_space.bedpostX'];
    if ~exist(resultant_folder , 'dir')
        mkdir(resultant_folder);
    end
    % Create seedmask
    Seedmask = '/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/HCPMMP_SUB.nii.gz';        %% change if necessary.
    Label_fileName_mask ='/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/HCPMMP_SUB_mask.nii.gz';
    
    targets_txt_fileName = [resultant_folder,'/Seed2Target.txt'];
    fid = fopen(targets_txt_fileName, 'w');
    
    Label_vector = [1:372];
    for i = 1:length(Label_vector)
        index = Label_vector(i);
        output_dir = [resultant_folder, '/Label', num2str(index,'%02.0f'), '_PDtrackNET'];
        if ~exist(output_dir, 'dir')
            mkdir(output_dir);
        end
        Label_seed_fileName{i,1} = [output_dir, '/Label', num2str(index,'%02.0f'), '_SeedMask'];
        Label_term_fileName{i,1} = [output_dir, '/Label', num2str(index,'%02.0f'), '_TermMask'];
        disp(cat(2, 'generating masks for label of ', num2str(index,'%02.0f')));
        system(cat(2, 'fslmaths ', Seedmask, ' -thr ', num2str(index), ' -uthr ', num2str(index), ' -div ', num2str(index), ' ', Label_seed_fileName{i,1}));
        system(cat(2, 'fslmaths ', Label_fileName_mask, ' -sub ', Label_seed_fileName{i,1}, ' ',Label_term_fileName{i,1}));
        
        fprintf(fid, Label_seed_fileName{i,1});
        fprintf(fid, '\n');
    end
end

%% ProbatrackX_gpu

clear; clc;

flist = [100206	100307	100408	100610	101107	102109	102311	102513	102614	102715	103111	103212	103414	103818	104012	105014	105115	105216	105620	105923	106016	106319	106521	106824	107018	108020	108222	108323	109123	110411	110613	111009	111211	111312	111413	111514	112516	112920	113215	113619	113922	114217	114419	114621	114823	115320	115724	116726	117021	117930	118225	118730	118831	118932	119025	120111	120414	120717	122317	122620	122822	123521	124220	124624	124826	125222	125424	125525	126325	126426	127226	127832	127933	128632	128935	129028	129129	130013	130114	130316	130417	130619	130720	131217	131722	131823	133019	133625	134021	134425	134728	135124	135528	135629	135932	136227	136631	136732	136833	137229	137532	138130	138231	139233	139435	139637	139839	140117	140319	141422	141826	143224	143325	143830	144125	144428	144731	144832	144933	145632	145834	146129	146432	146735	146836	146937	147030	147636	147737	148133	148840	148941	149337	149539	149741	150625	150726	150928	151223	151425	151526	151627	151728	151829	151930	152225	152427	153025	153126	153227	153429	154431	154532	154734	154835	155635	155938	156334	156435	156637	157336	157437	158035	158136	158338	158540	158843	159138	159239	159744	161731	162026	162228	162329	162733	162935	163129	163331	164030	164131	164636	165436	165638	166438	167036	167238	167440	168139	168240	168947	169040	169444	169545	169949	170631	171330	171633	172029	172130	172433	172534	173334	173435	173536	173940	174841	175136	175237	175439	175742	176037	176441	176542	177140	177241	177645	178142	178647	179346	180432	180735	180937	181232	182436	182739	185139	185341	185947	186848	187547	188145	188751	189349	189652	191033	191336	191841	191942	192136	192237	192540	192641	192843	193239	193845	194443	194847	195445	195849	195950	196144	196346	196750	197348	198047	198249	198451	198653	199150	199655	200008	200109	200311	200513	200614	201515	201818	202113	202719	203418	203923	204016	205220	205725	205826	206222	206323	206727	206828	206929	207123	207426	208226	208327	209127	209228	209329	210011	210112	210415	210617	211922	212419	212823	213421	214423	214524	214726	217429	220721	227533	228434	231928	233326	238033	239944	246133	250427	250932	251833	255639	255740	257542	257845	263436	268749	274542	275645	283543	285345	285446	286650	287248	298051	299154	300719	303624	304020	304727	307127	308129	308331	310621	314225	316835	320826	321323	325129	330324	333330	341834	342129	346137	346945	349244	352132	353740	358144	360030	361234	365343	366042	371843	377451	378756	380036	381038	381543	385046	385450	386250	387959	389357	391748	392447	393247	393550	394956	395756	397154	397760	397861	401422	406836	412528	413934	414229	422632	424939	429040	432332	433839	436239	436845	445543	448347	453441	453542	454140	456346	459453	461743	463040	467351	468050	469961	479762	481042	481951	495255	499566	500222	506234	510225	510326	512835	513130	516742	519647	519950	520228	522434	525541	529953	530635	531536	541640	553344	555954	557857	558657	558960	559053	561949	562446	567759	568963	572045	573249	576255	579867	581450	583858	586460	587664	588565	590047	597869	598568	599065	609143	613538	615744	616645	617748	618952	622236	627549	627852	633847	635245	638049	645450	654552	656253	656657	660951	663755	664757	665254	668361	671855	672756	673455	675661	677766	677968	679568	680452	690152	692964	695768	698168	700634	702133	704238	705341	707749	709551	715950	723141	724446	725751	728454	731140	732243	734045	735148	742549	744553	748258	749058	753150	759869	761957	765056	765864	767464	770352	771354	773257	774663	779370	783462	784565	788674	789373	792564	800941	803240	810843	812746	814548	816653	818859	826353	826454	828862	833249	835657	841349	844961	849971	852455	856766	856968	859671	861456	865363	869472	870861	871762	871964	872562	878877	882161	886674	887373	894673	896778	896879	898176	899885	901139	901442	902242	904044	907656	908860	910241	910443	911849	912447	917255	917558	919966	922854	923755	927359	932554	933253	942658	957974	958976	959574	966975	969476	971160	983773	990366	991267	992673	992774	993675	994273	996782];
path = '/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/DTI';


Label_vector = [1:372];
for j = 1:length(flist)
    j
    ResultFolder = [path '/' int2str(flist(j)) '/tractography'];
    resultant_folder = [ResultFolder '/Network/Probabilistic/'];
    bedpostx_folder = [ResultFolder '/native_space.bedpostX'];
    
    
    samples_basefileName = cat(2, bedpostx_folder, filesep, 'merged');
    nodif_mask_fileName = cat(2, bedpostx_folder, filesep, 'nodif_brain_mask');
    for i = 1:length(Label_vector)
        JobName = int2str(i);
        output_dir = cat(2, resultant_folder, filesep, 'Label', num2str(i,'%02.0f'), '_PDtrackNET');
        Label_seed_fileName = cat(2, output_dir, filesep, 'Label', num2str(i,'%02.0f'), '_SeedMask');
        Label_term_fileName = cat(2, output_dir, filesep, 'Label', num2str(i,'%02.0f'), '_TermMask');
        targets_txt_fileName = cat(2, resultant_folder,filesep,'Seed2Target.txt');
        
        probtrack_cmd = cat(2, 'probtrackx2_gpu --omatrix1',...
            ' -l --opd -c 0.2 -S 2000 --steplength=0.5 -P 5000',...
            ' --stop=', Label_term_fileName,...
            ' -x ', Label_seed_fileName,...
            ' --forcedir --pd --s2tastext',...
            ' --targetmasks=', targets_txt_fileName,...
            ' -s ', samples_basefileName,...
            ' -m ', nodif_mask_fileName,...
            ' --dir=', output_dir); %% user parameter
        system(probtrack_cmd);
    end
end


%% ProbatrackX_sge

clear; clc;

flist = [100206	100307	100408	100610	101107	102109	102311	102513	102614	102715	103111	103212	103414	103818	104012	105014	105115	105216	105620	105923	106016	106319	106521	106824	107018	108020	108222	108323	109123	110411	110613	111009	111211	111312	111413	111514	112516	112920	113215	113619	113922	114217	114419	114621	114823	115320	115724	116726	117021	117930	118225	118730	118831	118932	119025	120111	120414	120717	122317	122620	122822	123521	124220	124624	124826	125222	125424	125525	126325	126426	127226	127832	127933	128632	128935	129028	129129	130013	130114	130316	130417	130619	130720	131217	131722	131823	133019	133625	134021	134425	134728	135124	135528	135629	135932	136227	136631	136732	136833	137229	137532	138130	138231	139233	139435	139637	139839	140117	140319	141422	141826	143224	143325	143830	144125	144428	144731	144832	144933	145632	145834	146129	146432	146735	146836	146937	147030	147636	147737	148133	148840	148941	149337	149539	149741	150625	150726	150928	151223	151425	151526	151627	151728	151829	151930	152225	152427	153025	153126	153227	153429	154431	154532	154734	154835	155635	155938	156334	156435	156637	157336	157437	158035	158136	158338	158540	158843	159138	159239	159744	161731	162026	162228	162329	162733	162935	163129	163331	164030	164131	164636	165436	165638	166438	167036	167238	167440	168139	168240	168947	169040	169444	169545	169949	170631	171330	171633	172029	172130	172433	172534	173334	173435	173536	173940	174841	175136	175237	175439	175742	176037	176441	176542	177140	177241	177645	178142	178647	179346	180432	180735	180937	181232	182436	182739	185139	185341	185947	186848	187547	188145	188751	189349	189652	191033	191336	191841	191942	192136	192237	192540	192641	192843	193239	193845	194443	194847	195445	195849	195950	196144	196346	196750	197348	198047	198249	198451	198653	199150	199655	200008	200109	200311	200513	200614	201515	201818	202113	202719	203418	203923	204016	205220	205725	205826	206222	206323	206727	206828	206929	207123	207426	208226	208327	209127	209228	209329	210011	210112	210415	210617	211922	212419	212823	213421	214423	214524	214726	217429	220721	227533	228434	231928	233326	238033	239944	246133	250427	250932	251833	255639	255740	257542	257845	263436	268749	274542	275645	283543	285345	285446	286650	287248	298051	299154	300719	303624	304020	304727	307127	308129	308331	310621	314225	316835	320826	321323	325129	330324	333330	341834	342129	346137	346945	349244	352132	353740	358144	360030	361234	365343	366042	371843	377451	378756	380036	381038	381543	385046	385450	386250	387959	389357	391748	392447	393247	393550	394956	395756	397154	397760	397861	401422	406836	412528	413934	414229	422632	424939	429040	432332	433839	436239	436845	445543	448347	453441	453542	454140	456346	459453	461743	463040	467351	468050	469961	479762	481042	481951	495255	499566	500222	506234	510225	510326	512835	513130	516742	519647	519950	520228	522434	525541	529953	530635	531536	541640	553344	555954	557857	558657	558960	559053	561949	562446	567759	568963	572045	573249	576255	579867	581450	583858	586460	587664	588565	590047	597869	598568	599065	609143	613538	615744	616645	617748	618952	622236	627549	627852	633847	635245	638049	645450	654552	656253	656657	660951	663755	664757	665254	668361	671855	672756	673455	675661	677766	677968	679568	680452	690152	692964	695768	698168	700634	702133	704238	705341	707749	709551	715950	723141	724446	725751	728454	731140	732243	734045	735148	742549	744553	748258	749058	753150	759869	761957	765056	765864	767464	770352	771354	773257	774663	779370	783462	784565	788674	789373	792564	800941	803240	810843	812746	814548	816653	818859	826353	826454	828862	833249	835657	841349	844961	849971	852455	856766	856968	859671	861456	865363	869472	870861	871762	871964	872562	878877	882161	886674	887373	894673	896778	896879	898176	899885	901139	901442	902242	904044	907656	908860	910241	910443	911849	912447	917255	917558	919966	922854	923755	927359	932554	933253	942658	957974	958976	959574	966975	969476	971160	983773	990366	991267	992673	992774	993675	994273	996782];
path = '/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/DTI';

pause(280);
Label_vector = [1:372];
for j = 560:length(flist)
    j
    ResultFolder = [path '/' int2str(flist(j)) '/tractography'];
    resultant_folder = [ResultFolder '/Network/Probabilistic/'];
    bedpostx_folder = [ResultFolder '/native_space.bedpostX'];
    
    
    samples_basefileName = cat(2, bedpostx_folder, filesep, 'merged');
    nodif_mask_fileName = cat(2, bedpostx_folder, filesep, 'nodif_brain_mask');
    for i = 1:length(Label_vector)
        JobName = int2str(i);
        output_dir = cat(2, resultant_folder, filesep, 'Label', num2str(i,'%02.0f'), '_PDtrackNET');
        Label_seed_fileName = cat(2, output_dir, filesep, 'Label', num2str(i,'%02.0f'), '_SeedMask');
        Label_term_fileName = cat(2, output_dir, filesep, 'Label', num2str(i,'%02.0f'), '_TermMask');
        targets_txt_fileName = cat(2, resultant_folder,filesep,'Seed2Target.txt');
        
        probtrack_cmd = cat(2, 'fsl_sub -q long.q probtrackx2 --omatrix1',...
            ' -l --opd -c 0.2 -S 2000 --steplength=0.5 -P 5000',...
            ' --stop=', Label_term_fileName,...
            ' -x ', Label_seed_fileName,...
            ' --forcedir --pd --s2tastext',...
            ' --targetmasks=', targets_txt_fileName,...
            ' -s ', samples_basefileName,...
            ' -m ', nodif_mask_fileName,...
            ' --dir=', output_dir, ' && touch ', output_dir, filesep, JobName, '.done'); %% user parameter
        
        tmp = [resultant_folder '/tmp'];
        if ~exist(tmp , 'dir')
            mkdir(tmp);
        end
        cd(tmp);
        system(probtrack_cmd);
    end
    pause(280);
end


%% Create matrix
clear; clc;

flist = [100206	100307	100408	100610	101107	102109	102311	102513	102614	102715	103111	103212	103414	103818	104012	105014	105115	105216	105620	105923	106016	106319	106521	106824	107018	108020	108222	108323	109123	110411	110613	111009	111211	111312	111413	111514	112516	112920	113215	113619	113922	114217	114419	114621	114823	115320	115724	116726	117021	117930	118225	118730	118831	118932	119025	120111	120414	120717	122317	122620	122822	123521	124220	124624	124826	125222	125424	125525	126325	126426	127226	127832	127933	128632	128935	129028	129129	130013	130114	130316	130417	130619	130720	131217	131722	131823	133019	133625	134021	134425	134728	135124	135528	135629	135932	136227	136631	136732	136833	137229	137532	138130	138231	139233	139435	139637	139839	140117	140319	141422	141826	143224	143325	143830	144125	144428	144731	144832	144933	145632	145834	146129	146432	146735	146836	146937	147030	147636	147737	148133	148840	148941	149337	149539	149741	150625	150726	150928	151223	151425	151526	151627	151728	151829	151930	152225	152427	153025	153126	153227	153429	154431	154532	154734	154835	155635	155938	156334	156435	156637	157336	157437	158035	158136	158338	158540	158843	159138	159239	159744	161731	162026	162228	162329	162733	162935	163129	163331	164030	164131	164636	165436	165638	166438	167036	167238	167440	168139	168240	168947	169040	169444	169545	169949	170631	171330	171633	172029	172130	172433	172534	173334	173435	173536	173940	174841	175136	175237	175439	175742	176037	176441	176542	177140	177241	177645	178142	178647	179346	180432	180735	180937	181232	182436	182739	185139	185341	185947	186848	187547	188145	188751	189349	189652	191033	191336	191841	191942	192136	192237	192540	192641	192843	193239	193845	194443	194847	195445	195849	195950	196144	196346	196750	197348	198047	198249	198451	198653	199150	199655	200008	200109	200311	200513	200614	201515	201818	202113	202719	203418	203923	204016	205220	205725	205826	206222	206323	206727	206828	206929	207123	207426	208226	208327	209127	209228	209329	210011	210112	210415	210617	211922	212419	212823	213421	214423	214524	214726	217429	220721	227533	228434	231928	233326	238033	239944	246133	250427	250932	251833	255639	255740	257542	257845	263436	268749	274542	275645	283543	285345	285446	286650	287248	298051	299154	300719	303624	304020	304727	307127	308129	308331	310621	314225	316835	320826	321323	325129	330324	333330	341834	342129	346137	346945	349244	352132	353740	358144	360030	361234	365343	366042	371843	377451	378756	380036	381038	381543	385046	385450	386250	387959	389357	391748	392447	393247	393550	394956	395756	397154	397760	397861	401422	406836	412528	413934	414229	422632	424939	429040	432332	433839	436239	436845	445543	448347	453441	453542	454140	456346	459453	461743	463040	467351	468050	469961	479762	481042	481951	495255	499566	500222	506234	510225	510326	512835	513130	516742	519647	519950	520228	522434	525541	529953	530635	531536	541640	553344	555954	557857	558657	558960	559053	561949	562446	567759	568963	572045	573249	576255	579867	581450	583858	586460	587664	588565	590047	597869	598568	599065	609143	613538	615744	616645	617748	618952	622236	627549	627852	633847	635245	638049	645450	654552	656253	656657	660951	663755	664757	665254	668361	671855	672756	673455	675661	677766	677968	679568	680452	690152	692964	695768	698168	700634	702133	704238	705341	707749	709551	715950	723141	724446	725751	728454	731140	732243	734045	735148	742549	744553	748258	749058	753150	759869	761957	765056	765864	767464	770352	771354	773257	774663	779370	783462	784565	788674	789373	792564	800941	803240	810843	812746	814548	816653	818859	826353	826454	828862	833249	835657	841349	844961	849971	852455	856766	856968	859671	861456	865363	869472	870861	871762	871964	872562	878877	882161	886674	887373	894673	896778	896879	898176	899885	901139	901442	902242	904044	907656	908860	910241	910443	911849	912447	917255	917558	919966	922854	923755	927359	932554	933253	942658	957974	958976	959574	966975	969476	971160	983773	990366	991267	992673	992774	993675	994273	996782];
path = '/store6/mskim/project/02.ImagingGenetics/06.HCP.imaging.genetics/01.data/02.Img/DTI';


for n = 1%: length(subject_list)
    n
    ResultFolder = [path '/' int2str(flist(j)) '/tractography'];
    resultant_folder = [ResultFolder '/Network/Probabilistic/'];
    MatrixPath = [ResultFolder '/result'];
    if ~exist(MatrixPath , 'dir')
        mkdir(MatrixPath);
    end
    
    
    for i = 1 : 372 %length(Label_vector)
        Label_seed_fileCell{i} = [resultant_folder, filesep, 'Label', num2str(i,'%02.0f'), '_PDtrackNET/Label', num2str(i,'%02.0f'), '_SeedMask.nii.gz'];
        Label_fdt_fileCell{i} =  [resultant_folder, filesep, 'Label', num2str(i,'%02.0f'), '_PDtrackNET/fdt_paths.nii.gz'];
    end
    
    seed_Voxel_matrix = zeros(length(Label_seed_fileCell), length(Label_seed_fileCell));
    target_Voxel_matrix = zeros(length(Label_seed_fileCell), length(Label_seed_fileCell));
    target_meanFDT_matrix = zeros(length(Label_seed_fileCell), length(Label_seed_fileCell));
    
    for SeedNum = 1:372 %length(Label_seed_fileCell)
        SeedNum
        Label_seed_fileName = Label_seed_fileCell{SeedNum};
        disp(Label_seed_fileName);
        disp(cat(2, 'reading label of ',Label_seed_fileName));
        
        
        [~, results] = system(cat(2, 'fslstats ', Label_seed_fileName, ' -V'));
        tmp_prob = str2num(results);
        seed_Voxel_matrix(SeedNum,:) = tmp_prob(1);
        fdt_fileName = Label_fdt_fileCell{SeedNum};
        disp(fdt_fileName);
        for j = 1:length(Label_seed_fileCell)
            if j ~= SeedNum
                Label_target_fileName = Label_seed_fileCell{j};
                [~, results] = system(cat(2, 'fslstats ', fdt_fileName, ' -k ', Label_target_fileName, ' -M -V'));
                [~, Flag] = str2num(results);
                if ~Flag
                    target_meanFDT_matrix(SeedNum, j)=0;
                    target_Voxel_matrix(SeedNum, j)=0;
                else
                    tmp_prob = str2num(results);
                    target_meanFDT_matrix(SeedNum, j) = tmp_prob(1);
                    target_Voxel_matrix(SeedNum, j) = tmp_prob(2);
                end
            end
        end
    end
    
    
    ProbabilisticMatrixPath = [ResultFolder '/result/ProbabilisticMatrix.mat'];
    %     save( ProbabilisticMatrixPath, 'ProbabilisticMatrix' );
    save( ProbabilisticMatrixPath, 'seed_Voxel_matrix', 'target_Voxel_matrix', 'target_meanFDT_matrix' );
    
    %load(ProbabilisticMatrixPath);
    
    FDT2target = target_Voxel_matrix .* target_meanFDT_matrix;
    ProbabilisticMatrix = FDT2target./seed_Voxel_matrix./10000; % userparameter
    ProbabilisticMatrix(find(isnan(ProbabilisticMatrix)))=0;
    
    ProbabilisticMatrixPath = [ResultFolder '/result/Final_ProbabilisticMatrix_PD_90.mat'];
    save(ProbabilisticMatrixPath, 'ProbabilisticMatrix');
end


%% Weighted connectivity analysis















