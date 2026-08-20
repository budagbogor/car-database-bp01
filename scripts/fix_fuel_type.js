require('dotenv').config({ path: require('path').join(__dirname, '..', '.env') });
const p = require('../db');

// Keyword list mobil yang PASTI DIESEL di Indonesia (hanya model diesel yang benar)
const BENAR_DIESEL_PATTERNS = [
  /fortuner.*vr?z/i, /fortuner.*diesel/i,
  /innova.*diesel/i, /innova.*reborn.*diesel/i, /innova.*venturer.*diesel/i, /innova.*q.*diesel/i,
  /hilux.*(double|single|extra)?\s*cab/i, /hilux.*vigo/i, /hilux.*rocco/i, /hilux.*gr/i, /hilux.*diesel/i,
  /pajero.*sport/i, /pajero.*(dakar|exceed|glx|exceed)/i, /pajero diesel/i, /triton/i,
  /ranger.*(wildtrak|xlt|xl|fx4|raptor)/i, /ranger.*diesel/i, /everest/i,
  /navara.*(pro[- ]?4x|vl|el|calibre|ve|n[- ]?warra)/i, /navara.*diesel/i, /np300/i, /d[- ]?max/i,
  /strada.*(gls|gt|exceed|athlete)/i, /strada.*diesel/i, /triton /i, /l200/i,
  /colorado.*(high|z71|ltr|lt)/i, /colorado.*diesel/i, /trailblazer/i,
  /koleos/i, /captiva.*diesel/i, /orlando.*diesel/i,
  /sportage.*diesel/i, /sorento.*diesel/i, /santa[ -]?fe.*diesel/i, /grand[ -]?carnival.*diesel/i, /sedona/i, /carnival/i,
  /pregio/i, /bongo/i,
  /terrano/i, /pathfinder/i, /navara/i, /patrol/i, /elgrand/i, /terrano/i,
  /x[- ]?trail.*diesel/i, /qashqai.*diesel/i, /juke.*diesel/i, /serena.*diesel/i,
  /grand[ -]?vitara.*diesel/i, /escudo.*diesel/i,
  /kuda.*diesel/i, /serena.*diesel/i,
  /spin.*diesel/i, /tavera/i,
  /frontera/i, /monterey/i, /trooper/i, /blazer.*diesel/i,
  /panther/i, /kijang.*diesel/i, /kristar.*diesel/i, /escolta.*diesel/i, /venture.*diesel/i, /unser.*diesel/i, /ranch /i,
  /[^\w]reborn[^\w]/i, /[^\w]vr[sz][^\w]/i, /[^\w]dakar[^\w]/i,
  /land cruiser/i, /prado/i, /fj cruiser/i, /coaster/i,
  /defender/i, /discovery/i, /range rover/i, /evoque/i, /velar/i,
  /gl[ ]?class/i, /ml[ -]?class/i, /gle/i, /gls/i, /g wagon/i, /g[- ]?class/i, /sprinter/i, /vito/i, /v class/i,
  /x5/i, /x6/i, /x7/i, /bmw.*320d/i, /bmw.*520d/i, /bmw.*x3.*(20d|30d)/i, /bmw.*x5.*(25d|30d|35d|40d)/i,
  /cayenne.*diesel/i, /macan.*diesel/i, /touareg.*diesel/i, /amarok/i, /tigua[nl].*diesel/i, /phaeton/i, /transporter/i, /crafter/i,
  /ducato/i, /daily/i, /sprinter/i, /master/i, /movano/i, /vivaro/i, /trafic/i,
  /orlando/i, /captiva/i,
  /jeep.*wrangler/i, /jeep.*cherokee.*diesel/i, /grand cherokee.*(crd|diesel)/i, /wrangler.*crd/i,
  /santa cruz/i,
  /mg.*extender/i, /mg.*gloster/i,
  /maxus.*(g10|t60|v80|v90|d60|d90)/i, /ldv.*(v80|t60)/i, /gwm.*(poer|cannon|wey|tank)/i, /haval.*(h5|h6|h9|jolion).*diesel/i,
  /d[- ]?max/i, /colorado.*(ltr|2.8|2.5|duramax)/i,
  /toyota.*(hilux|fortuner|land cruiser|coaster|dyna|kijang innova.*diesel)/i,
  /daihatsu.*(delta|gran max pick up diesel)/i,
  /suzuki.*(apv pick up diesel|futura pick up diesel|megacarry diesel)/i,
  /carry.*diesel/i, /mega carry.*diesel/i, /gran[ -]?max.*diesel/i, /luxio.*diesel/i,
  /nissan.*(terra|urvan|elgrand|patrol|navara)/i,
  /isuzu.*(trooper|panther|mux|mu[ -]x|d[ -]?max|elf|nhr|nkr|forward|giga)/i,
  /hino.*(dutro|500|700|ranger|profia|s'elega)/i,
  /mitsu.*(canter|fuso|colt diesel|l300.*diesel|kuda.*diesel)/i, /colt diesel/i, /l300.*diesel/i,
  /kia.*(sedona|carnival|grand carnival|sorento.*diesel|sportage.*diesel|k2500|bongo frontier|pregio|frontier)/i,
  /hyundai.*(h-1|h1|h-100|starex|porter|trajet.*diesel|santa fe.*diesel|grand starex.*diesel|terracan|tucson.*diesel)/i, /starex/i,
  /ssangyong/i, /kyron/i, /rexton/i, /stavic/i, /tivoli.*xvl/i, /actyon/i, /korando/i,
  /ford.*(cargo|super duty|f[ -]?250|f[ -]?350|ranger.*diesel|everest.*diesel)/i,
  /chevrolet.*(colorado.*diesel|trailblazer|captiva.*diesel|spin.*diesel)/i,
  /tavera/i, /enjoy.*diesel/i, /neo.*diesel/i,
  /dfsk.*(c31|c32|c35|k01|k05).*diesel/i,
  /datsun.*(cross|go.*plus)?.*(tdi|dci|cdti|crdi|diesel)/i,
  // Special pattern: kode mesin diesel: 1GD, 2GD, 2KD, 1KD, 2TR? bukan 2TR bensin, 2L, 3L, 5L, WL, WLT, 4JJ1, 4JK1, R2, RF, VJT, OM642, CRDi, dCi, CDTi, DDiS, i-DTEC, TDI, D4D, D-4D
];

// Kode mesin yang PASTI DIESEL
const BENAR_DIESEL_KODE_MESIN = [
  /\b(1GD|2GD|1KD|2KD|5L|3L|2L|2LT|WL|WLT|WLE|4JJ1|4JK1|R2|RFS|RF|J2|A2|D4CB|D4HA|D4HB|CRDi|i-DTEC|dCi|CDTi|D-CAT|DDiS|i-DE4|TD[Ii]|BlueTec|BlueHDi|e-HDI|HDi|Turbodiesel|Turbo.?Diesel|OM6\d{2}|EA288|CR\d{2,3}|Duratorq|Power.?Stroke|VGT|VNT|DW10|DW12|RFN|RLF|ZD30|ZD25|QD32)\b/i,
  /\b1GD-FTV\b/, /\b2GD-FTV\b/, /\b1KD-FTV\b/, /\b2KD-FTV\b/, /\b5L-E\b/, /\b3L\b/, /\b4JJ1-TC/, /\b4JK1-TC/, /\bCommon[- ]?Rail\b/, /\bDirect Injection Diesel\b/
];

const BENAR_DIESEL_KATEGORI = /LCGC.*?Diesel|SUV.*?Diesel|Pick[- ]?up.*?Diesel|Minibus.*?Diesel|MPV.*?Diesel|LCV.*?Diesel|Double Cabin|Truk/i;

// Kode mesin yang PASTI BENSIN
const PASTI_BENSIN_KODE_MESIN = [
  /\b(1KR|2NR|3NR|4NR|1NR|WA-VE|K10B|K12M|K14C|K15B|K10C|K12N|R15B|R18A|R20A|L15A|L15B|L13A|L13B|L12A|K20A|K24A|K24W|K20C|B16A|B16B|B18C|F20C|K3-VE|K3-VET|2ZZ-GE|1ZZ-FE|3ZZ-FE|1NZ-FE|2NZ-FE|3ZR-FE|2ZR-FE|1ZR-FE|3SZ-VE|2SZ-FE|M15A|M16A|M13A|K12B|K14B|K10A|G16B|G13B|F10A|F6A|M10A|G4LA|G4LC|G4LD|G4FJ|G4KD|G4KE|G4KH|Dual VVT|i-VTEC|VTEC|VVT-i|VVTL-i|Skyactiv-G|SKYACTIV-G|MPI|MPFi|EFI|SFi|Twin Cam|DOHC|SOHC|16V|12V|8V|VVT|DVVT|CVTC|VTC|PFI|GDI|T-GDi|TGDi|SI Drive|D-4S|D4S|Bensin|Multiair|Valvematic|VCM|FSI|TFSI|TSI|Duratec|Ecoboost|Skyactiv-X)\b/i
];

// Model yang PASTI BENSIN di Indonesia (hanya bensin, tidak ada varian diesel)
const PASTI_BENSIN_MODEL = [
  /agya/i, /ayla/i, /brio/i, /calya/i, /sigra/i, /mobilio/i, /jazz/i, /civic[^ ]*?(?!.*\bdiesel\b.*)/i,
  /city/i, /yaris/i, /vios/i, /avanza[^ ]*?(?!.*\bdiesel\b.*)/i, /veloz[^ ]*?(?!.*\bdiesel\b.*)/i, /xenia[^ ]*?(?!.*\bdiesel\b.*)/i,
  /xpander[^ ]*?(?!.*\bdiesel\b.*)/i, /xpander cross/i, /ertiga[^ ]*?(?!.*\bdiesel\b.*)/i,
  /baleno/i, /swift/i, /ignis/i, /karimun/i, /wigo/i,
  /brv/i, /wrv/i, /raize/i, /rocky/i, /stargazer[^ ]*?(?!.*\bdiesel\b.*)/i, /livina/i,
  /sirion/i, /aile/i, /sienta/i,
  /suzuki carry[^ ]*?(?!.*\bdiesel\b.*)/i, /carry[^ ]*?(?!.*\bdiesel\b.*)/i, /futura[^ ]*?(?!.*\bdiesel\b.*)/i,
  /sirion/i, /luxio[^ ]*?(?!.*\bdiesel\b.*)/i, /mighty max/i, /l300[^ ]*?(?!.*\bdiesel\b.*)/i,
  /rush[^ ]*?(?!.*\bdiesel\b.*)/i, /terios[^ ]*?(?!.*\bdiesel\b.*)/i,
  /copen/i, /civic type r/i, /mazda 2[^ ]*?(?!.*\bdiesel\b.*)/i, /mazda 3[^ ]*?(?!.*\bdiesel\b.*)/i, /mazda 6[^ ]*?(?!.*\bdiesel\b.*)/i,
  /mx-?5/i, /cx-3[^ ]*?(?!.*\bdiesel\b.*)/i, /cx-30[^ ]*?(?!.*\bdiesel\b.*)/i,
  /cooper/i, /mini cooper/i, /countryman[^ ]*?(?!.*\bdiesel\b.*)/i, /clubman[^ ]*?(?!.*\bdiesel\b.*)/i,
  /golf[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*|.*crdi.*)/i, /polo[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*)/i, /vento[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*)/i,
  /almera/i, /grand livina/i, /serena hybrid/i, /note/i, /leaf/i,
  /audi a3[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*)/i, /audi a4[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*)/i, /audi a1[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*)/i, /a3 sedan[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*)/i,
  /tiguan[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*)/i, /t-roc[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*)/i, /taos[^ ]*?(?!.*\bdiesel\b.*)/i, /jetta[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*)/i, /passat[^ ]*?(?!.*\bdiesel\b.*|.*tdi.*)/i,
  /qashqai[^ ]*?(?!.*\bdiesel\b.*|.*dci.*)/i, /juke[^ ]*?(?!.*\bdiesel\b.*|.*dci.*)/i, /x-trail[^ ]*?(?!.*\bdiesel\b.*|.*dci.*)/i, /livina/i,
  /colt t120ss/i, /colt l300[^ ]*?(?!.*\bdiesel\b.*)/i, /grand new carry[^ ]*?(?!.*\bdiesel\b.*)/i, /new carry[^ ]*?(?!.*\bdiesel\b.*)/i,
  /gran max[^ ]*?(?!.*\bdiesel\b.*)/i, /granmax[^ ]*?(?!.*\bdiesel\b.*)/i, /apv[^ ]*?(?!.*\bdiesel\b.*)/i,
  /alto[^ ]*?(?!.*\bdiesel\b.*)/i, /karimun wagon/i, /celerio/i, /spresso[^ ]*?(?!.*\bdiesel\b.*)/i,
  /mg zs[^ ]*?(?!.*\bdiesel\b.*)/i, /mg 5[^ ]*?(?!.*\bdiesel\b.*)/i, /mg gt/i, /mg zs ev/i,
  /wrv[^ ]*?(?!.*\bdiesel\b.*)/i, /vektor/i, /vektor 1.5/i, /creta[^ ]*?(?!.*\bdiesel\b.*|.*crdi.*)/i, /stargazer x/i, /stargazer prime/i,
  /cr-v[^ ]*?(?!.*\bdiesel\b.*|.*2\.2.*)/i, /crv[^ ]*?(?!.*\bdiesel\b.*|.*2\.2.*)/i, /honda crv[^ ]*?(?!.*\bdiesel\b.*|.*2\.2.*)/i,
  /honda hrv[^ ]*?(?!.*\bdiesel\b.*|.*1\.6.*)/i, /hrv[^ ]*?(?!.*\bdiesel\b.*|.*1\.6.*)/i, /honda brv/i,
  /accord[^ ]*?(?!.*\bdiesel\b.*|.*2\.2.*|.*i-dtec.*)/i, /odyssey[^ ]*?(?!.*\bdiesel\b.*)/i, /honda insight/i,
  /ioniq[^ ]*?(?!.*\bdiesel\b.*)/i, /ioniq 5/i, /kona[^ ]*?(?!.*\bdiesel\b.*)/i, /kona electric/i, /tucson[^ ]*?(?!.*\bdiesel\b.*|.*crdi.*)/i, /santa cruz/i,
  /venza/i, /camry[^ ]*?(?!.*\bdiesel\b.*)/i, /corolla altis/i, /corolla cross[^ ]*?(?!.*\bdiesel\b.*)/i, /corolla hatchback/i,
  /yaris cross/i, /yaris hev/i, /yaris gr/i, /sienta type q/i, /c-hr[^ ]*?(?!.*\bdiesel\b.*)/i, /chr[^ ]*?(?!.*\bdiesel\b.*)/i,
  /kijang lgx/i, /kijang sx/i, /kijang super/i, /kijang grand extra[^ ]*?(?!.*\bdiesel\b.*)/i,
  /civic fd/i, /civic fb/i, /civic fc/i, /civic fe/i, /civic turbo/i, /civic hatchback/i, /civic type r/i,
  /city hatchback/i, /city sedan/i, /mobilio e/i, /mobilio rs/i, /jazz gk5/i, /jazz ge8/i, /jazz gd/i, /jazz rs/i,
  /kia picanto/i, /kia rio[^ ]*?(?!.*\bdiesel\b.*)/i, /kia cerato/i, /kia forte/i,
  /hyundai i10/i, /grand i10/i, /i20[^ ]*?(?!.*\bdiesel\b.*|.*crdi.*)/i, /hyundai getz/i, /hyundai accent/i,
  /aura/i, /amaze[^ ]*?(?!.*\bdiesel\b.*)/i, /city zx/i, /wrv v/i,
  /vitara[^ ]*?(?!.*\bdiesel\b.*|.*ddis.*)/i, /s cross[^ ]*?(?!.*\bdiesel\b.*)/i, /scross[^ ]*?(?!.*\bdiesel\b.*)/i, /grand vitara[^ ]*?(?!.*\bdiesel\b.*)/i, /across[^ ]*?(?!.*\bdiesel\b.*)/i,
  /suzuki every/i,
  /dfsk glory 560/i, /dfsk glory 580[^ ]*?(?!.*\bdiesel\b.*)/i, /glory i-auto/i,
  /hino dutro[^ ]*?(?!.*\bdiesel\b.*)/i, // sebenarnya diesel, tapi ini varian bensin langka — skip; pattern ini nanti tidak ke-fix, tidak masalah
  /datsun go/i, /datsun go\+/i, /datsun cross/i, /datsun mi do/i, /datsun on do/i,
  /suzuki splash/i, /suzuki x-over/i, /suzuki kizashi/i,
  /subaru brz/i, /toyota gt86/i, /toyota 86/i, /mazda mx5/i, /ford mustang/i, /camaro/i, /challenger/i, /charger/i,
  /aion/i, /aletra/i, /byd/i, /wuling/i, /confero/i, /cortez[^ ]*?(?!.*\bdiesel\b.*)/i, /formo/i, /baic/i, /changhe/i, /chang'an/i, /changhe beidouxing/i,
  /honda freed/i, /honda fit/i, /honda airwave/i, /honda insight/i,
  /geely coolray/i, /geely okavango/i, /geely azkarra/i, /proton x70[^ ]*?(?!.*\bdiesel\b.*)/i, /proton x50[^ ]*?(?!.*\bdiesel\b.*)/i,
  /proton persona/i, /proton saga/i, /proton iriz/i, /proton exora[^ ]*?(?!.*\bdiesel\b.*)/i,
  /nissan almera/i, /nissan grand livina/i, /nissan x-trail[^ ]*?(?!.*\bdiesel\b.*)/i, /nissan juke[^ ]*?(?!.*\bdiesel\b.*)/i,
  /nissan qashqai[^ ]*?(?!.*\bdiesel\b.*)/i, /nissan sylphy/i, /nissan teana[^ ]*?(?!.*\bdiesel\b.*)/i, /nissan skyline/i, /nissan fairlady/i,
  /nissan leaf/i,
  /vinfast fadil/i, /vinfast lux a 2.0/i, /vinfast lux sa 2.0/i, /vinfast president/i,
  /xpeng/i, /gwm ora/i, /ora 03/i, /ora good cat/i, /haval jolion[^ ]*?(?!.*\bdiesel\b.*)/i, /haval h6[^ ]*?(?!.*\bdiesel\b.*)/i, /haval h6 gt/i,
  /mitsu lancer ex/i, /lancer evolution/i, /outlander sport[^ ]*?(?!.*\bdiesel\b.*)/i, /asx[^ ]*?(?!.*\bdiesel\b.*)/i, /attrage/i, /mirage/i, /mitsu space star/i, /grandis[^ ]*?(?!.*\bdiesel\b.*)/i, /colt plus/i, /mitsu colt/i,
  /peugeot 208[^ ]*?(?!.*\bdiesel\b.*|.*hdi.*)/i, /peugeot 2008[^ ]*?(?!.*\bdiesel\b.*|.*hdi.*)/i, /peugeot 3008[^ ]*?(?!.*\bdiesel\b.*|.*hdi.*)/i, /peugeot 308[^ ]*?(?!.*\bdiesel\b.*|.*hdi.*)/i, /peugeot 508[^ ]*?(?!.*\bdiesel\b.*|.*hdi.*)/i, /peugeot 5008[^ ]*?(?!.*\bdiesel\b.*|.*hdi.*)/i,
  /renault captur[^ ]*?(?!.*\bdiesel\b.*|.*dci.*)/i, /renault kadjar[^ ]*?(?!.*\bdiesel\b.*|.*dci.*)/i, /renault koleos[^ ]*?(?!.*\bdiesel\b.*|.*dci.*)/i, /renault clio[^ ]*?(?!.*\bdiesel\b.*|.*dci.*)/i,
  /smart fortwo/i, /smart forfour/i, /smart electric/i,
  /opel corsa[^ ]*?(?!.*\bdiesel\b.*|.*cdti.*)/i, /opel astra[^ ]*?(?!.*\bdiesel\b.*|.*cdti.*)/i, /opel mokka[^ ]*?(?!.*\bdiesel\b.*|.*cdti.*)/i, /chevrolet trax[^ ]*?(?!.*\bdiesel\b.*)/i, /aveo[^ ]*?(?!.*\bdiesel\b.*)/i, /chevrolet cruze[^ ]*?(?!.*\bdiesel\b.*|.*vcdi.*)/i, /spark/i, /beat/i, /trax[^ ]*?(?!.*\bdiesel\b.*)/i,
  /alfa romeo mito/i, /alfa giulietta[^ ]*?(?!.*\bdiesel\b.*|.*jtdm.*)/i, /fiat 500[^ ]*?(?!.*\bdiesel\b.*|.*multijet.*)/i, /fiat punto[^ ]*?(?!.*\bdiesel\b.*|.*multijet.*)/i, /abarth/i,
  /ford focus[^ ]*?(?!.*\bdiesel\b.*)/i, /ford fiesta[^ ]*?(?!.*\bdiesel\b.*)/i, /ford ecosport[^ ]*?(?!.*\bdiesel\b.*)/i, /ford ka/i, /ford escape[^ ]*?(?!.*\bdiesel\b.*)/i, /ford kuga[^ ]*?(?!.*\bdiesel\b.*)/i, /ford edge[^ ]*?(?!.*\bdiesel\b.*)/i, /ford territory[^ ]*?(?!.*\bdiesel\b.*)/i,
  /gac trumpchi/i, /gwm\/haval/i, /mg hector[^ ]*?(?!.*\bdiesel\b.*)/i, /mg astor[^ ]*?(?!.*\bdiesel\b.*)/i, /mg zs ev/i
];

const BENSIN_STANDARD_DESCRIPTOR = 'Bensin (MPI / VVT-i / Dual VVT / Skyactiv-G / i-VTEC / VVT / DVVT)';
const BENSIN_SHORT = 'bensin';
const DIESEL_STANDARD_DESCRIPTOR = 'Diesel (CRDi / Common Rail / DDiS / dCi / CDTi / Turbo Diesel / Direct Injection)';
const DIESEL_SHORT = 'diesel';

(async () => {
  const client = await p.connect();
  try {
    await client.query('BEGIN');

    // Ambil SEMUA data
    const { rows: all } = await client.query(`SELECT id, merek, model, tahun, kode_mesin, kategori, bahan_bakar FROM kendaraan ORDER BY id`);
    console.log('Total record:', all.length);

    function isBenarDiesel(r) {
      const modelKat = `${r.merek} ${r.model} ${r.kategori||''} ${r.kode_mesin||''}`;
      for (const rx of BENAR_DIESEL_KODE_MESIN) if (rx.test(modelKat)) return true;
      for (const rx of BENAR_DIESEL_PATTERNS) if (rx.test(modelKat)) return true;
      if (BENAR_DIESEL_KATEGORI.test(r.kategori || '')) return true;
      return false;
    }
    function isPastiBensin(r) {
      const modelKat = `${r.merek} ${r.model}`;
      for (const rx of PASTI_BENSIN_MODEL) if (rx.test(modelKat)) return true;
      const km = r.kode_mesin || '';
      for (const rx of PASTI_BENSIN_KODE_MESIN) if (rx.test(km)) return true;
      return false;
    }

    let fixBensin = 0, fixDiesel = 0, fixBoth = 0, skipBensinShort = 0, skipDieselBenar = 0, skipSudahBenarDescriptor = 0, skipNull = 0, unknown = 0;
    const unknownIds = [];

    for (const r of all) {
      const fuel = (r.bahan_bakar || '').trim();

      // Case 1: fuel sudah full descriptor benar → skip
      if (fuel.includes('Bensin (') || fuel.includes('Diesel (') || fuel.includes('Hybrid') || fuel.includes('Listrik') || fuel.includes('HEV') || fuel.includes('PHEV') || fuel.includes('BEV') || fuel.includes('Bensin + Listrik') || fuel === 'hybrid' || fuel === 'listrik' || fuel === 'Bensin' || fuel === 'Diesel') {
        skipSudahBenarDescriptor++;
        continue;
      }
      // Case 2: fuel null / kosong → unknown, set ke bensin jika modelnya pasti bensin
      if (!fuel) {
        if (isPastiBensin(r)) {
          await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [BENSIN_STANDARD_DESCRIPTOR, r.id]);
          fixBensin++;
        } else { unknownIds.push({...r, reason:'bahan_bakar NULL'}); unknown++; }
        skipNull++;
        continue;
      }
      // Case 3: fuel = exact lowercase 'bensin' → upgrade ke standard descriptor (dan cek apakah modelnya diesel? harusnya tidak)
      if (fuel === BENSIN_SHORT) {
        if (isBenarDiesel(r) && !isPastiBensin(r)) {
          await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [DIESEL_STANDARD_DESCRIPTOR, r.id]);
          fixDiesel++;
        } else {
          await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [BENSIN_STANDARD_DESCRIPTOR, r.id]);
          skipBensinShort++;
        }
        continue;
      }
      // Case 4: fuel = exact lowercase 'diesel' → SANGAT MUNGKIN SALAH (data kotor). Cek model:
      if (fuel === DIESEL_SHORT) {
        const pastiBensin = isPastiBensin(r);
        const benarDiesel = isBenarDiesel(r);

        if (pastiBensin && benarDiesel) {
          // Conflict: misal Innova bensin vs diesel tag diesel → pilih INNOVA yang benar diesel tergantung tahun / kode mesin.
          // Default: tag ke descriptor diesel standard tapi log.
          console.log('  CONFLICT id='+r.id+' '+r.merek+' '+r.model+' km='+r.kode_mesin+' → anggap DIESEL (karena match diesel pattern)');
          await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [DIESEL_STANDARD_DESCRIPTOR, r.id]);
          fixBoth++;
        } else if (benarDiesel) {
          await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [DIESEL_STANDARD_DESCRIPTOR, r.id]);
          skipDieselBenar++;
        } else if (pastiBensin) {
          // ✅ Fix yang paling penting: ini data kotor! Ubah dari 'diesel' → BENSIN descriptor.
          await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [BENSIN_STANDARD_DESCRIPTOR, r.id]);
          console.log(`  ✅ FIX-SALAH-DIESEL → BENSIN id=${r.id} ${r.merek} ${r.model} km=${r.kode_mesin||'?'}`);
          fixBensin++;
        } else {
          // Tidak diketahui. Default anggap BENSIN kecuali katakan 'Pick up Diesel / Truk' di kategori.
          const tampakDiesel = /diesel|crdi|common[- ]?rail|dci|cdti|tdi|ddis|duratorq|bluetec|hdi|multijet|ecotec dti|i-dtec|bluehdi|d-4d|d4d|kijang innova|reborn|vr[sz]|dakar|hilux|pajero|triton|fortuner|everest|ranger|navara|d-max|strada|colorado|elgrand|land cruiser|patrol|coaster|panther|kuda|serena|bongo|pregio|starex|h-1|h100|porter|trajet|frontier|isuzu panther|elf|dutro|canter|fuso|colt diesel|l300 diesel|mega carry diesel|carry diesel|tavera|ssangyong|actyon|kyron|rexton|stavic|terracan|trailblazer|captiva diesel|orlando diesel|santa fe.*?diesel|sorento.*?diesel|carnival|sedona|k2500|daihatsu delta|luxio diesel|futura diesel/i
            .test(`${r.merek} ${r.model} ${r.kategori||''} ${r.kode_mesin||''}`);
          if (tampakDiesel) {
            await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [DIESEL_STANDARD_DESCRIPTOR, r.id]);
            skipDieselBenar++;
          } else {
            // Fallback: anggap BENSIN (aman, kebanyakan mobil di ID bensin)
            console.log(`  ⚠️  UNKNOWN → default BENSIN id=${r.id} ${r.merek} ${r.model} km=${r.kode_mesin||'?'} fuel=${fuel}`);
            await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [BENSIN_STANDARD_DESCRIPTOR, r.id]);
            unknownIds.push({...r, reason:'unknown, defaulted to bensin'});
            unknown++;
            fixBensin++;
          }
        }
        continue;
      }
      // Lain-lain: tidak diketahui formatnya → default ke BENSIN jika kelihatan bensin, else diesel.
      const lower = fuel.toLowerCase();
      if (/bensin|pertamax|pertalite|premium|gasoline|petrol|mpi|vvt|skyactiv|i-vtec|vvt-i|mivec|dual vvt/i.test(lower)) {
        await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [BENSIN_STANDARD_DESCRIPTOR, r.id]);
        fixBensin++;
      } else if (/diesel|solar|pertamina dex|biosolar|crdi|common[- ]?rail|dci|cdti|tdi|ddis|duratorq|bluetec|hdi|multijet|d-4d|d4d/i.test(lower)) {
        await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [DIESEL_STANDARD_DESCRIPTOR, r.id]);
        fixDiesel++;
      } else if (/hybrid|hev|phev|plug.in/i.test(lower)) {
        // Sudah di skip sebelumnya, tapi fallback jika lowercase exact
        skipSudahBenarDescriptor++;
      } else if (/listrik|bev|electric|ev$/i.test(lower)) {
        skipSudahBenarDescriptor++;
      } else {
        console.log(`  ⚠️  UNKNOWN fuel format id=${r.id} ${r.merek} ${r.model} fuel=${JSON.stringify(fuel)} → default BENSIN`);
        await client.query(`UPDATE kendaraan SET bahan_bakar=$1 WHERE id=$2`, [BENSIN_STANDARD_DESCRIPTOR, r.id]);
        unknown++;
        fixBensin++;
      }
    }

    await client.query('COMMIT');

    console.log('\n═══════ RINGKASAN FIX ═══════');
    console.log('  Skip: fuel sudah full descriptor (benar):', skipSudahBenarDescriptor);
    console.log('  Skip: fuel="bensin" exact → upgrade ke standard descriptor (benar BENSIN):', skipBensinShort);
    console.log('  Skip: fuel="diesel" → model memang BENAR diesel:', skipDieselBenar);
    console.log('  Skip NULL total:', skipNull);
    console.log('  FIX ✅ fuel="diesel" SALAH → set ke BENSIN (Agya/Ayla/Brio/Jazz dst):', fixBensin);
    console.log('  FIX ✅ fuel yang semula "bensin" ternyata DIESEL (Fortuner/Hilux dll → diesel):', fixDiesel);
    console.log('  CONFLICT (match 2 pattern):', fixBoth);
    console.log('  UNKNOWN (fallback ke BENSIN):', unknown);
    if (unknownIds.length) console.log('\nTop 10 unknowns:', unknownIds.slice(0,10).map(r=>`id=${r.id} ${r.merek} ${r.model} (${r.reason})`));

    // Final summary post-fix
    const final = await p.query(`
      SELECT bahan_bakar, COUNT(*) n FROM kendaraan GROUP BY bahan_bakar ORDER BY n DESC
    `);
    console.log('\nDistinct bahan_bakar final:');
    final.rows.forEach(r => console.log(' ', String(r.n).padStart(5), JSON.stringify(r.bahan_bakar)));

  } catch (e) {
    await client.query('ROLLBACK');
    console.error('ROLLBACK. ERR:', e.message, e.stack);
    process.exit(1);
  } finally {
    client.release();
    p.end();
  }
})();
