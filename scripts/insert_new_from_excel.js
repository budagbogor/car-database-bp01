'use strict';
require('dotenv').config();
const fs = require('fs');
const path = require('path');
const pool = require('../db');

// ===== HELPERS: Generator spesifikasi per field =====
const clean = s => String(s || '').trim().replace(/\s+/g, ' ');
const isEV = ({model, segmen, catatan}) => {
  const s = `${model} ${segmen} ${catatan}`.toLowerCase();
  if (/\b(bev|listrik|electric|ev|e-tech|e-hs|e-power ev|nevo|deepal|etron)\b/.test(s)) return true;
  if (/^(aion|xpeng|vinfast|neta|lepas|aletra|icar|smart|geely|hongqi|changan|maxus|polytron|gwm|baic|leapmotor)$/i.test('')) return false;
  return false;
};
const isHybrid = ({model, catatan}) => {
  const s = `${model} ${catatan}`.toLowerCase();
  return /\b(hybrid|phev|hev|mhev|recharge|dht|e-power|ehev|plug[- ]?in)\b/.test(s);
};
const isDiesel = ({merek, model, segmen, catatan}) => {
  const s = `${merek} ${model} ${segmen} ${catatan}`.toLowerCase();
  if (/(diesel|hino|d[- ]?max|panther|traga|ranger|everest|bt-?50|navara|terra|mu-?x|hilux|fortuner|pajero sport|strada|triton|truck|pickup|box|van|cargo|commercial|bus|tronton|engkel|double cabin|4x4 diesel|cdi|crdi|d4d|d-4d|skyactiv-?d|tdi|tdci|jtd|dci|bluehdi|multijet|duratorq|ecoblue)\b/.test(s)) return true;
  if (['HINO', 'ISUZU'].includes(merek.toUpperCase()) && !/(SUV|MPV|penumpang|cross)/i.test(segmen)) return true;
  if (merek.toUpperCase() === 'DFSK') return /diesel|truck|box|cargo|pickup|angkutan/.test(s) ? true : false;
  return false;
};

// Tahun default untuk model-model baru 2026 / Excel DATA KENDARAAN LENGKAP 2026
const tahunDefault = ({merek, segmen, catatan}) => {
  const s = `${segmen} ${catatan}`.toLowerCase();
  if (/\b(giias\s*2026|kuartal\s*iv\s*2026|mei\s*2025|juni\s*2025|2025|2026|rencana\s*meluncur|belum\s*dijual)\b/.test(s) || /(CKD|dirakit|diluncurkan|meluncur|telah\s*hadir|tersedia)/.test(s)) {
    return '2024 – Sekarang (Generasi baru / EV Modern)';
  }
  if (/(lama|klasik|lawas|old\b|generasi\s*pertama|dahulu|pernah\s*dijual)/.test(s)) {
    return 'Model lama (sebelum 2020) — cek generasi';
  }
  return '2010 – Sekarang (cek generasi spesifik)';
};

const kategoriFromSegmen = (merek, segmen, catatan, model) => {
  const s = `${segmen} ${catatan} ${model}`.toLowerCase();
  // Pickup & Utility
  if (/(pick|double\s*cabin|truck|angkutan|box|cargo|tronton|engkel|mini\s*bus|microbus|panel\s*van|single\s*cab)/.test(s)) return 'Pickup / Utility / Commercial';
  if (['HINO'].includes(merek.toUpperCase())) return 'Truk Komersial / Bus';
  // SUV 7 seater besar
  if (/(suv\s*7-seat|suv\s*7\s*tempat|full.size\s*suv|large\s*suv|suv\s*premium\s*7|suv\s*mewah|mid.size\s*suv\s*7)/.test(s)) return 'SUV Premium 7-seat';
  if (/(suv\s*listrik|suv\s*ev|suv\s*coupe|suv\s*crossover|compact\s*suv|suv\s*kompak|medium\s*suv|suv\s*premium|off[\s-]?road)/.test(s)) return (/(off|premium|mewah|full\s*size|large)/.test(s)) ? 'SUV Premium' : (/kompak|compact/.test(s) ? 'SUV Compact' : 'SUV');
  if (/(suv\s*7|7.seat|xl7|erzga|rush|terios|xpander\s*cross|br[- ]v|xl6|xlv|c3\s*aircross|suv\s*7-seat)/.test(s)) return 'SUV 7-seat';
  if (/\bsuv\b/.test(s)) return 'SUV Compact / Crossover';
  // Crossover
  if (/(crossover|cross)/.test(s)) return 'Crossover';
  // MPV
  if (/(mpv|7[-\s]?penumpang|7[-\s]?seater|orang\s*7|minivan)/.test(s)) {
    if (/(premium|mewah|flagship|alphard|vellfire|voxy|esquire|staria|v[-\s]?class|vito|mifa|sedona|carnival|serena|biante)/.test(s)) return 'MPV Premium / Van';
    return /low|murah|entry|compact/.test(s) ? 'Low MPV' : 'MPV';
  }
  if (merek.toUpperCase() === 'DFSK' && /(mpv|gelora|penumpang)/.test(s)) return 'Compact MPV';
  // Hatchback / Sedan
  if (/(sedan|limousine)/i.test(s)) return (/(premium|mewah|flagship|s-class|7\s*series|a8|s90)/.test(s)) ? 'Sedan Premium Flagship' : 'Sedan';
  if (/(hatchback|city\s*car|compact\s*car|micro\s*car|quadricycle|5-door|3-door|hatch)/.test(s)) return /city|micro|lcgc|sazuka|ayla|agya|brio|karimun|march|kwid|picanto|morning/.test(s) ? 'LCGC Hatchback/MPV' : (/premium|hot\s*hatch|rs|st|gt|amg|m\s*power|cooper\s*s/ ? 'Hatchback Premium' : 'Hatchback / Sedan');
  if (/(coupe|gran\s*coupe|fastback|roadster|sports\s*car|cabrio|convertible|spyder|gti|type\s*r|amg|m4|m5|st|rs\b)/.test(s)) return 'Coupe / Gran Coupe';
  if (/(sports|coupe|roadster|mx.?5)/i.test(s)) return 'Sports Roadster';
  // Default by merek EV
  if (['AION', 'XPENG', 'NETA', 'ALETRA', 'ICAR', 'GWM', 'LEAPMOTOR', 'Lepas', 'POLYTRRON'].includes(merek)) return 'EV Hatchback / SUV';
  return /mewah|premium/.test(s) ? 'SUV Premium' : 'Hatchback / Sedan';
};

// ===== GENERATE SEMUA 21 FIELD per entry =====
function buildFullRecord(e) {
  const merek = clean(e.merek);
  const model = clean(e.model);
  const segmen = clean(e.segmen);
  const catatan = clean(e.catatan);
  const M = merek.toUpperCase();
  const _ev = isEV({model, segmen, catatan});
  const _hev = isHybrid({model, catatan});
  const _ds = isDiesel({merek: M, model, segmen, catatan});
  const bahan_bakar = _ev ? 'Listrik (BEV)' : (_hev ? 'Bensin + Listrik (Hybrid HEV / PHEV)' : (_ds ? 'Diesel (Common Rail / CRDi)' : 'Bensin (MPI / VVT-i / Dual VVT / Skyactiv-G)'));
  const kategori = kategoriFromSegmen(M, segmen, catatan, model);

  // Kode mesin
  const kode_mesin = _ev ? 'Motor Listrik (BEV Permanent Magnet Synchronous) — Torsi & tenaga sesuai varian' :
    _hev ? 'Mesin Bensin + Motor Listrik (Hybrid Parallel / Series-Parallel)' :
    _ds ? 'Mesin Diesel Turbo Common Rail (CRDi / D-4D / BlueHDi / Skyactiv-D)' :
    /1\.0|998|lcgc|ayla|agya|suzuki\s*karimun|wizard|honda\s*brio|nissan\s*march|renault\s*kwid|picanto|wuling\s*binguo/i.test(`${merek} ${model}`) ? '1.0L 3 Silinder (VVT / i-VTEC / DVVT / K10B / 1KR-VE)' :
    /1\.2|1197|1200/i.test(`${model} ${segmen} ${catatan}`) ? '1.2L 4 Silinder (VVT-i / DVVT / K12M / WA-VE / HR12DE)' :
    /1\.3|1300/i.test(`${model} ${segmen} ${catatan}`) ? '1.3L 4 Silinder (K3-VE / M13A / G13B / 4A90)' :
    /1\.4|1400|multijet|crdi\s*1\.4/i.test(`${model} ${segmen} ${catatan}`) ? '1.4L 4 Silinder (K14B / G4LC / MPI / Multijet)' :
    /1\.5|hr15|k15b|m15a|l15a|l15b|2nr/i.test(`${model} ${segmen} ${catatan} ${bahan_bakar}`) && !_ds ? '1.5L 4 Silinder (2NR-VE / L15B / HR15DE / K15B / Skyactiv-G 1.5)' :
    /1\.5|1500|d4d|crdi\s*1\.5|cdi\s*1\.5/i.test(`${model} ${segmen} ${catatan}`) && _ds ? '1.5L Diesel Turbo Common Rail (1KD-FTV / CRDi / DDiS / 4JJ1)' :
    /1\.6|1600|hr16|g4fj|gamma\s*1\.6/i.test(`${model} ${segmen} ${catatan}`) ? '1.6L 4 Silinder (HR16DE / G4FD / Gamma 1.6 MPI / Prince 1.6 THP)' :
    /1\.8|1798|2zr|r18|mr18/i.test(`${model} ${segmen} ${catatan}`) ? '1.8L 4 Silinder (2ZR-FE / R18A / MR18DE / 4J18)' :
    /2\.0|2000|m20a|r20|k20|mr20|skyactiv-g\s*2\.0/i.test(`${model} ${segmen} ${catatan}`) ? '2.0L 4 Silinder (M20A-FKS / MR20DD / R20A / Skyactiv-G 2.0)' :
    /2\.4|2400|2az|k24/i.test(`${model} ${segmen} ${catatan}`) ? '2.4L 4 Silinder (2AZ-FE / K24A / J24B / Tigershark)' :
    /2\.5|2500|2kd|skyactiv-d\s*2\.2/i.test(`${model} ${segmen} ${catatan}`) && _ds ? '2.5L Diesel Turbo Common Rail (2KD-FTV / Skyactiv-D 2.2 / 4JK1-TCX / YD25)' :
    /2\.5|2500|pr25|qr25/i.test(`${model} ${segmen} ${catatan}`) ? '2.5L 4 Silinder (PR25DD / QR25DE / 2TR-FE)' :
    /3\.0|3000|v6|4jj1|zd30|4jj3|v9x/i.test(`${model} ${segmen} ${catatan}`) && _ds ? '3.0L Diesel Common Rail (4JJ3-TCX / ZD30 / V9X 3.0 V6 dCi / VM Motori)' :
    /3\.0|3000|v6|gr|fj|land\s*cruiser/i.test(`${model} ${segmen} ${catatan}`) ? '3.0L V6 (2GR-FKS / VQ35DE / 1GR-FE)' :
    /v8|5\.0|4\.6|land\s*cruiser\s*200|lexus\s*lx57|amg\s*63|m5|m8/i.test(`${model} ${segmen} ${catatan}`) ? '4.6L / 5.0L V8 (1UR-FE / 2UR-GSE / 3UR-FE / V8 Biturbo)' :
    'Bervariasi sesuai generasi & varian — cek manual / plat mesin';

  // Kapasitas CC
  const kapasitas_cc = _ev ? 'Tidak ada (Kendaraan Listrik BEV — Pakai Motor Listrik + Inverter)' :
    /1\.0|998|1000/i.test(model + ' ' + segmen) ? '998 cc (1.0L 3 silinder / 4 silinder)' :
    /1\.2|1197|1200/i.test(model + ' ' + segmen) ? '1197 cc (1.2L 4 silinder)' :
    /1\.3|1300/i.test(model + ' ' + segmen) ? '1298 - 1329 cc (1.3L 4 silinder)' :
    /1\.4|1400/i.test(model + ' ' + segmen) ? '1368 - 1396 cc (1.4L 4 silinder)' :
    /1\.5|hr15|k15b|m15a|l15/i.test(model + ' ' + segmen + ' ' + bahan_bakar) ? '1496 - 1498 cc (1.5L 4 silinder)' :
    /1\.6|gamma\s*1\.6|hr16/i.test(model + ' ' + segmen) ? '1580 - 1598 cc (1.6L 4 silinder)' :
    /1\.8|1798|2zr/i.test(model + ' ' + segmen) ? '1798 cc (1.8L 4 silinder)' :
    /2\.0|m20a|r20|mr20|skyactiv-g\s*2\.0/i.test(model + ' ' + segmen) ? '1995 - 2000 cc (2.0L 4 silinder / Boxer FA20)' :
    /2\.2|skyactiv-d|2200/i.test(model + ' ' + segmen) && _ds ? '2191 cc (2.2L Diesel Twin-turbo Skyactiv-D)' :
    /2\.4|k24|2az/i.test(model + ' ' + segmen) ? '2354 - 2494 cc (2.4 L4 / H4 Boxer)' :
    /2\.5|2kd|pr25/i.test(model + ' ' + segmen) ? '2494 cc (2.5L 4 silinder / Skyactiv-D 2200)' :
    /3\.0|4jj1|zd30|1gr/i.test(model + ' ' + segmen) ? '2982 - 3956 cc (3.0 V6 / 4.0 V6 TBC)' :
    /3\.5|vq35|2gr/i.test(model + ' ' + segmen) ? '3456 - 3498 cc (3.5L V6 — J35 / 2GR-FKS / VQ35DE)' :
    /v8|5\.0|4\.6|5700|lx\s*57|land\s*cruiser\s*200/i.test(model + ' ' + segmen) ? '4608 - 5663 cc (4.6 / 5.0 / 5.7 V8)' :
    'Cek kode mesin untuk akurasi kapasitas (liter × 1000)';

  // Tipe Transmisi & Detail
  let tipe_transmisi = _ev ? 'Single-Speed Reduction Gear (EV — 1 kecepatan)' :
    /(at|automatic|matic|a\/t|tip|steptronic|geartronic|multitronic|dct|dual\s*clutch|pdk|e-cvt|ecvt|cvt|direct\s*shift|9g-tronic)/i.test(`${segmen} ${catatan} ${model}`) ?
      (/(cvt|ecvt|e-cvt)/i.test(catatan + ' ' + model) ? 'CVT' : /(dct|pdk|dual\s*clutch)/i.test(catatan+model) ? 'DCT (Dual Clutch)' : 'AT') :
    /(manual|m\/t|5\s*speed\s*mt|6\s*speed\s*mt)/i.test(segmen + ' ' + catatan) ? 'Manual' :
    /(amt|automated|i-?amt)/i.test(segmen + ' ' + catatan) ? 'AMT' :
    (_ds && /(truck|tronton|bus|engkel)/.test(segmen)) ? 'Manual (6/10/12 percepatan)' :
    // Default: passenger cars — CVT modern untuk Jepang/Korea, AT ke Eropa/China
    ['AION','XPENG','NETA','GWM','ALETRA','ICAR','LEPAS','POLYTRON','CHANGAN','LEAPMOTOR','SMART','VINFAST','HONGQI','AION'].includes(M) ? 'Single-Speed Reduction Gear (EV 1-percepatan)' :
    ['TOYOTA','DAIHATSU','HONDA','NISSAN','MITSUBISHI','SUZUKI','MAZDA','SUBARU','HYUNDAI','KIA','MG','CHERY','WULING'].includes(M) ? 'CVT (Modern) / AT — tersedia varian Manual entry' :
    ['BMW','MERCEDES-BENZ','MERCEDES','AUDI','VW','VOLKSWAGEN','VOLVO','MINI','JEEP','PEUGEOT','CITROEN','RENAULT','OPEL','FORD','CHEVROLET'].includes(M) ? 'AT 8-speed / DCT (Entry: Manual 6-speed)' :
    'CVT / AT — varian Manual tersedia tipe dasar';

  // Detail transmisi + oli transmisi (pakai pola per brand dari migration 027)
  let detail_transmisi, oli_transmisi;
  const transMap = {
    HONDA: {MT: 'API GL-4 SAE 75W-90 / 80W-90 — Kapasitas: 1.6-2.2 L', AT: 'ATF DW-1 (Honda Genuine ATF type 3.1) — Kapasitas 7.0-8.5 L (Drain & Fill: 3.5 L)', CVT: 'Honda Genuine CVTF HCF-2 — Kapasitas: 3.8-4.5 L'},
    SUZUKI: {MT: 'API GL-4 / GL-5 SAE 75W-90 — Kapasitas 1.6-2.6 L', AT: 'ATF Dexron III / JWS 3309 (Suzuki Genuine ATF 3317) — Kapasitas 6.0-7.5 L', CVT: 'Suzuki CVT Fluid Green 1 / CVTF TC — Kapasitas: 4.5-6.0 L'},
    NISSAN: {MT: 'API GL-4 SAE 75W-90 — Kapasitas 1.8-2.6 L', AT: 'ATF Matic-S / Matic-D / Matic-K (JWS 3309 / 3314 / 3317) — Kapasitas 6.5-9.5 L', CVT: 'NS-2 CVT Fluid / NS-3 V.2 (JATCO CVT) — Kapasitas: 6.5-8.5 L'},
    TOYOTA: {MT: 'Toyota Genuine MT-1 GL-4 SAE 75W-80 — Kapasitas 1.5-2.5 L', AT: 'ATF T-IV / WS (World Standard) — Kapasitas: 6.5-8.0 L (Drain: 3.5 L)', CVT: 'TC / CVT Fluid FE / K114/K120 CVTF — Kapasitas: 6.0-6.5 L'},
    DAIHATSU: {MT: 'API GL-4 SAE 75W-80 / SAE 80 GL-4 (Toyota Genuine MT-1) — Kapasitas 1.2-1.4 L', AT: 'ATF Dexron III (T-IV) — Kapasitas 4.6-5.5 L', CVT: 'CVT Fluid FE (Toyota Genuine TC) — Kapasitas: 6.0 L'},
    MAZDA: {MT: 'API GL-4 SAE 75W-80 (Mazda Genuine M502) — Kapasitas 1.8-2.2 L', AT: 'ATF M-V / FZ (Mazda Genuine Mercon LV) — Kapasitas 7.0-8.5 L', CVT: 'Mazda CVT Fluid MV — Kapasitas: 6.0-7.0 L'},
    MITSUBISHI: {MT: 'API GL-4 SAE 75W-90 — Kapasitas 1.8-2.6 L', AT: 'ATF DiaQueen SPIII / JWS 3317 — Kapasitas: 7.0-9.0 L', CVT: 'DiaQueen CVTF-J1 / CVTF-J4 — Kapasitas: 6.0-8.0 L'},
    SUBARU: {MT: 'Subaru Genuine MT GL-5 SAE 75W-90 / Extra-S — Kapasitas 2.0-3.5 L (termasuk AWD transfer)', AT: 'Subaru ATF-HP / Dexron VI — Kapasitas: 7.5-11.0 L (Lineartronic CVT)', CVT: 'Subaru Lineartronic CVTF-II (SOA868V9270) — Kapasitas: 8.0-12.0 L'},
    HYUNDAI: {MT: 'Hyundai Genuine MT GL-4 SAE 75W-85 — Kapasitas 1.7-2.3 L', AT: 'SP-IV / Diamond ATF SP-III (M-IV) — Kapasitas 6.5-9.5 L', CVT: 'Hyundai / Kia CVTF G-050 / G-052 — Kapasitas 5.5-8.0 L'},
    KIA: {MT: 'Kia Genuine GL-4 SAE 75W-85 — Kapasitas 1.8-2.3 L', AT: 'Diamond ATF SP-IV (M-V) — Kapasitas 7.0-10.0 L', CVT: 'CVTF G-052 (Chain type) — Kapasitas: 6.5-8.0 L'},
    FORD: {MT: 'Ford Genuine MTF SAE 75W-90 — Kapasitas 1.8-2.6 L', AT: 'Mercon LV / Mercon SP / Dexron VI — Kapasitas: 7.5-11.5 L (Drain: 4L)', DCT: 'Ford Powershift / Getrag DCT Fluid — Kapasitas: 6.0-8.0 L'},
    CHEVROLET: {MT: 'GM MTF SAE 75W-85 GL-4 — Kapasitas 1.7-2.4 L', AT: 'DEXRON VI / DEXRON HP — Kapasitas 7.0-10.5 L', DCT: 'GM DCTF 1st / 2nd Gen — Kapasitas: 5.5-7.5 L'},
    BMW: {MT: 'BMW MTF-LT-1 / MTF-LT-2 / SAE 75W-80 GL-4 — Kapasitas 1.6-2.8 L', AT: 'BMW ATF 3+ / 4 / 6 (GA6L45R / GA8HP / ZF 8HP) — Kapasitas 8.0-11.0 L', DCT: 'BMW DCTF-1 / DCTF-2 (M DKG) — Kapasitas: 6.0-8.0 L', EV: 'BMW EV Gear Oil SAF-XO + Inverter Coolant (G48)'},
    'MERCEDES-BENZ': {MT: 'MB 235.10 / 235.12 MTF SAE 75W-85 GL-4 — Kapasitas 1.6-2.5 L', AT: 'MB 236.14 / 236.15 / 236.17 (722.9 7G-Tronic / 9G-Tronic 725) — Kapasitas 8.0-12.0 L', DCT: 'MB 236.21 DCTF (8G-DCT) — Kapasitas: 6.0-8.0 L'},
    MERCEDES: null, // use MERCEDES-BENZ
    AUDI: {MT: 'VW/Audi G 052 145 / G 052 512 MTF SAE 75W-80 — Kapasitas 1.7-2.4 L', AT: 'VW/Audi G 055 025 (Aisin 8AT) / G 060 165 (DL382) — Kapasitas 7.5-10.0 L', DCT: 'Audi DSG G 052 182 / DQ250/DQ380/DQ381/DQ500 — Kapasitas 5.5-7.5 L'},
    VOLKSWAGEN: {MT: 'VW G 052 145 MTF SAE 75W-80 GL-4 — Kapasitas 1.7-2.3 L', AT: 'VW ATF 1 (Aisin 8AT / 6AT) — Kapasitas 7.0-9.5 L', DCT: 'VW DSG DQ200/DQ250/DQ381/DQ500 G 052 529 / G 052 182 — Kapasitas: 5.2-7.5 L'},
    VOLVO: {MT: 'Volvo 1161401 MTF SAE 75W-80 GL-4 — Kapasitas 1.7-2.4 L', AT: 'Volvo ATF AW-1 / JWS 3324 (Aisin AW TG-81SC 8AT) / Dexron VI — Kapasitas 7.0-10.0 L', EV: 'Volvo EV Gear Oil (Single Speed) + Coolant (G48 Ready Mix)'},
    MINI: {MT: 'BMW/MINI MTF-LT-1 — Kapasitas 1.5-2.0 L', AT: 'Mini ATF 3+ (Aisin GA6F21WA 6AT) — Kapasitas 6.5-8.0 L', DCT: 'Getrag 7DCT300 F56 DCTF — Kapasitas 5.5-6.5 L'},
    RENAULT: {MT: 'Renault MTF 75W-80 TL 521 05 / TL 521 12 — Kapasitas 1.7-2.4 L', AT: 'Renault ATF DIII / ATF6 (Aisin 6AT) / Dexron VI — Kapasitas 7.0-9.5 L', CVT: 'Renault CVT Fluid ELF Matic CVT (JATCO JF015E) — Kapasitas: 6.0-7.5 L', DCT: 'Renault DCTF (6DCT450 MPS6 / 7DCT300) — Kapasitas 5.5-7.0 L'},
    PEUGEOT: {MT: 'Peugeot TL 521 05 / 75W-80 MTF — Kapasitas 1.7-2.3 L', AT: 'Total Fluide ATX / Dexron VI (Aisin EAT8 8AT) — Kapasitas 7.0-10.0 L', CVT: 'Total Matic CVT FLUIDE CVT — Kapasitas 6.5-8.0 L', DCT: 'Total DCTF / DSL-0703 6DCT250 / EAT8 — Kapasitas 5.5-7.0 L'},
    CITROEN: {MT: 'Citroen TL 521 05 75W-80 GL-4 — Kapasitas 1.7-2.3 L', AT: 'Total Fluide ATX / EAT8 Dexron VI — Kapasitas 7.0-10.0 L', DCT: 'Total DCTF 6DCT250 / EAT8 — Kapasitas 5.5-7.0 L'},
    OPEL: {MT: 'GM MTF 75W-85 GL-4 / Opel 93165 388 — Kapasitas 1.7-2.4 L', AT: 'Opel ATF DEXRON VI (Aisin 8AT / 6AT) — Kapasitas 7.0-9.5 L', CVT: 'Opel CVT Fluid (JATCO JF018E) — Kapasitas 7.0 L', DCT: 'Opel DCTF (Tremec / Aisin 8DCT) — Kapasitas 5.5-7.0 L'},
    WULING: {MT: 'Wuling MTF SAE 75W-90 GL-4 — Kapasitas 1.8-2.5 L', AT: 'CVT Fluid Jatco JF015E (CVT) / ATF Dexron VI (i-AMT) — Kapasitas: 6.5 L', AMT: 'Manual Trans Oil GL-4 + ATF aktuator (Cek buku manual)'},
    MG: {MT: 'MG MTF GL-4 SAE 75W-90 — Kapasitas 1.6-2.2 L', AT: 'Aisin ATF AW-1 (6AT) / CVT Fluid CVTF JATCO — Kapasitas 6.5-9.0 L', CVT: 'MG CVT Fluid Green 2 / JF017E JATCO — Kapasitas: 6.5-7.5 L', EV: 'SAIC / MG EV Gear Oil — Kapasitas 2.0-2.5 L (1-speed Reducer) + Inverter Coolant'},
    CHERY: {MT: 'Chery MTF SAE 75W-90 GL-4 — Kapasitas 1.8-2.6 L', AT: 'Aisin ATF AW-1 (8AT) / DEXRON VI — Kapasitas 7.0-9.0 L', CVT: 'Chery CVT 018/019 CVTF EXEED / TIGGO — Kapasitas: 6.5-8.0 L', DCT: 'Getrag 7DCT300 / Magna 7DCT300 DCTF — Kapasitas 5.5-7.0 L', EV: 'Chery EV Gear Oil — Kapasitas 2.5 L + Coolant (BEV)'},
    PROTON: {MT: 'Proton MTF SAE 75W-80 GL-4 (Petronas Tutela GI+) — Kapasitas 1.7-2.3 L', AT: 'Petronas Tutela ATF Z1 Dexron III / Aisin AW-1 (Punch CVT + 4AT) — Kapasitas 6.5-8.5 L', CVT: 'Proton CVTF (Punch VT2/VT3) Petronas Tutela — Kapasitas: 6.0-7.0 L'},
    DFSK: {MT: 'Dongfeng / DFSK MTF SAE 80W-90 GL-5 (Heavy Duty) — Kapasitas 2.0-3.0 L', AT: 'Punch CVT Fluid (DFSK Glory) — Kapasitas 6.0 L'},
    HINO: {MT: 'HINO Genuine Gear Oil GL-5 80W-90 (atau 85W-140 Extra HD) — Kapasitas 4.0-14.0 L (sesuaikan transmisi MZ / MJ / J08E)', AT: 'HINO ATF (Allison) / Dexron III — Kapasitas 8.0-20 L (sesuaikan tipe bus/truk)'},
    ISUZU: {MT: 'Isuzu Genuine MTF GL-5 80W-90 (Traga / Panther) / GL-5 85W-140 HD (NMR / NLR / Fuso 6-speed) — Kapasitas 2.0-12.0 L', AT: 'Isuzu MLL / ATF Dexron III (Panther Touring MT / Isuzu MU-X 6-speed) — Kapasitas 7.5 L'},
    DATSUN: {MT: 'API GL-4 75W-85 / Nissan MTF — Kapasitas 1.5-1.7 L', AT: 'Nissan Matic-D Dexron III / JATCO CVT (Go Panca CVT) — Kapasitas: 5.5-7.5 L'},
    LEXUS: {MT: '— (Lexus hampir tidak ada MT — lihat tipe AT)', AT: 'Toyota Genuine ATF WS / ATF Type T-IV (GS/LS 8-speed AA81E / 10-speed AWR10L65) — Kapasitas 8.0-12.0 L', CVT: 'Toyota CVTF TC / K114 / K120 — Kapasitas 6.0-6.5 L (UX200 / ES200 CVT)', Hybrid: 'Toyota ATF WS (e-CVT / PSD Power Split Device) — Kapasitas: 3.0-4.0 L (Drain + Fill)'},
    JEEP: {MT: 'Jeep MTF GL-4 SAE 75W-85 (Wrangler 6-speed NSG370) — Kapasitas 1.8-2.2 L', AT: 'Mopar ATF+4 (WA580 5AT / 850RE 8AT / 8HP75 ZF) — Kapasitas 8.5-12.5 L'},
    BYD: {MT: 'BYD MTF — Kapasitas 1.8-2.2 L (ICE jarang MT)', AT: 'BYD ATF 6DCT / DiLink e-CVT DM-i (Hybrid) — Kapasitas 6.5-8.0 L', EV: 'BYD EV Gear Oil — Kapasitas 2.0-2.5 L (Single / Dual Motor R/AWD) + Inverter Coolant (G48 Ready Mix)'},
    LANCIA: null,
    FIAT: null
  };
  transMap.MERCEDES = transMap['MERCEDES-BENZ'];

  let tKey;
  if (_ev || /Single-Speed/i.test(tipe_transmisi)) tKey = 'EV';
  else if (tipe_transmisi === 'Manual') tKey = 'MT';
  else if (tipe_transmisi === 'DCT (Dual Clutch)') tKey = 'DCT';
  else if (tipe_transmisi === 'AMT') tKey = 'AMT';
  else tKey = tipe_transmisi; // AT or CVT

  let brandTrans = transMap[M] || {
    MT: 'API GL-4 SAE 75W-90 — Kapasitas: 1.5-2.5 L',
    AT: 'ATF Dexron VI / Mercon LV — Kapasitas: 6.0-10.0 L (sesuaikan)',
    CVT: 'CVT Fluid (sesuaikan dengan pabrikan transmisi) — Kapasitas: 5.5-8.0 L',
    DCT: 'Dual Clutch Fluid (DCTF) — Kapasitas: 5.5-7.5 L',
    AMT: 'Manual Trans Oil GL-4 75W-85 + ATF aktuator — Kapasitas 2.0 L',
    EV: 'Single-Speed Gear Oil SAE 75W-85 (BEV Reducer) — Kapasitas: 2.0-3.0 L + Inverter Coolant (G48 Ready Mix atau spesifikasi pabrikan)',
    Hybrid: 'ATF WS / Dexron VI (e-CVT / Hybrid) — Kapasitas: 3.5-6.0 L (Drain Fill)'
  };

  if (!brandTrans) brandTrans = transMap['MERCEDES-BENZ']; // fallthrough
  let oilT = brandTrans[tKey] || brandTrans.AT || brandTrans.CVT;
  if (_hev && ['TOYOTA','LEXUS','HONDA','MITSUBISHI'].includes(M)) oilT = (transMap[M] && transMap[M].Hybrid) || brandTrans.CVT || oilT;
  oli_transmisi = oilT;
  detail_transmisi = `${tipe_transmisi} — ${oilT}`;

  // Viskositas oli + standar + kapasitas (per bahan bakar + merek)
  let viskositas_oli, standar_oli, kapasitas_oli;
  if (_ev) {
    viskositas_oli = 'Tidak menggunakan oli mesin (Kendaraan Listrik BEV — hanya pakai oli Reducer Gear + Coolant Inverter & Battery)';
    standar_oli = 'Tidak ada (EV) — Gear Reducer: API GL-5 SAE 75W-85, Coolant: G48 Ready Mix (G12 EVO / pabrikan spesifik)';
    kapasitas_oli = 'Tidak ada — Gear Reducer: 2.0-3.0 L (cek buku manual), Coolant: 6.0-14.0 L (tergantung ukuran baterai)';
  } else if (_ds) {
    viskositas_oli = '15W-40 CI-4 / 5W-30 ACEA C3 (Diesel Modern DPF)';
    standar_oli = `API ${/(dpf|euro\s*[456]|crde|bs6|blued|clean|skyactiv-d)/i.test(catatan+segmen) ? 'CK-4 / CJ-4 / ACEA C3' : 'CI-4 / CH-4 / ACEA B4'} / ${M === 'MAZDA' ? 'Mazda Dexelia Diesel' : M === 'TOYOTA' || M === 'DAIHATSU' || M === 'LEXUS' ? 'Toyota DK-7 / DK-5 (D-4D)' : M === 'HINO' || M === 'ISUZU' || M === 'DFSK' ? 'JASO DH-2 / DH-1 Heavy Duty' : 'OEM Diesel Spec — cek manual'}`;
    kapasitas_oli = M === 'HINO' ? '12.0 - 28.0 L (tergantung ukuran mesin truk/bus J05E/J08E/J07E — cek plat spesifikasi)' :
      M === 'ISUZU' ? (/mu-?x|d-?max|panther/i.test(model + segmen) ? '6.0 - 7.5 L (4JJ1 / 4JK1 / 4JA1L Panther)' : '8.0 - 16.0 L (Isuzu NMR/NLR/Fuso Series HD)') :
      M === 'DFSK' ? '6.5 - 10.0 L (DFSK Super Carry / Glory Diesel — cek tipe mesin)' :
      `${/(2\.0|2\.2|2\.5)/.test(model+catatan) ? '5.5 - 7.5 L' : /(3\.0|4jj1|4jk1)/.test(model+catatan) ? '6.5 - 8.0 L' : '6.0 - 8.0 L (Drain + Filter, sesuai tipe)'} (tanpa filter: -0.5 L)`;
  } else {
    // Bensin / Hybrid (passenger cars): 0W-20 modern / 0W-16 Toyota / 5W-30 lawas / 10W-40 daerah panas
    const modern = /(2010|2015|2020|baru|modern|giias|202[0-9]|baru|ckd)/i.test(catatan+tahunDefault({merek:M, segmen, catatan}));
    viskositas_oli = modern ? ((M === 'TOYOTA' || M === 'DAIHATSU' || M === 'LEXUS') ? '0W-16 API SP GF-6A / 0W-20 (opsional)' : '0W-20 API SP GF-6A') :
      /(lama|lawas|old|200[0-9]|generasi\s*pertama)/i.test(catatan + segmen) ? '10W-40 API SL / 15W-40 (daerah panas)' :
      '5W-30 API SN RC / 0W-20 API SP (dua-duanya bisa untuk iklim tropis Indo)';
    standar_oli = `${/(0w-20|0w-16)/i.test(viskositas_oli) ? 'API SP / ILSAC GF-6A' : /5w-30/i.test(viskositas_oli) ? 'API SN RC / ILSAC GF-5 / ACEA A5/B5' : 'API SL / SM / ACEA A3/B4'} — ${M === 'HONDA' ? 'HTO-06' : M === 'TOYOTA' ? 'SN-C3 / DK-7 (bensin)' : M === 'MAZDA' ? 'Skyactiv-G ULEV Dexelia' : M === 'NISSAN' ? 'Nissan SN-5' : M === 'HYUNDAI' || M === 'KIA' ? 'Hyundai / Kia Gasoline SP / LS MPC 1.5 A-5/B-5' : M === 'SUBARU' ? 'Subaru Genuine 0W-20 SN/GF-5 / FA/FB Boxer' : M === 'BMW' ? 'BMW Longlife-01 / LL-01 FE / LL-04' : M === 'MERCEDES-BENZ' || M === 'MERCEDES' ? 'MB 229.5 / 229.51 / 229.71' : M === 'AUDI' || M === 'VOLKSWAGEN' ? 'VW 502 00 / 504 00 / 508 00' : M === 'VOLVO' ? 'Volvo VCC RBS0-2AE / 95 396 387' : 'Merek Lain: ikuti spec buku manual — API SP / GF-6 adalah safe choice baru'}`;
    kapasitas_oli = /1\.0|lcgc|998/i.test(model+segmen+kode_mesin) ? '2.7 - 3.2 L (Drain + Filter) — Tanpa Filter: 2.5-3.0 L' :
      /1\.2|1\.3|1\.4/i.test(model+segmen+kode_mesin) ? '3.0 - 3.8 L (Drain + Filter) — Tanpa Filter: -0.3 L' :
      /1\.5|1\.6/i.test(model+segmen+kode_mesin) ? '3.5 - 4.3 L (Drain + Filter) — Tanpa Filter: 3.2-4.0 L' :
      /1\.8|2\.0/i.test(model+segmen+kode_mesin) ? '4.0 - 4.8 L (Drain + Filter — Subarus: 4.8L Boxer)' :
      /2\.4|2\.5/i.test(model+segmen+kode_mesin) ? '4.2 - 5.5 L (Drain + Filter) — V6: 5.8-6.3 L' :
      /3\.0|v6|2gr|vq35|1gr/i.test(model+segmen+kode_mesin) ? '6.0 - 6.8 L (V6 — 2GR / VQ35 / 1GR-FE) — Tanpa Filter: -0.4 L' :
      /v8|5\.0|4\.6|5700/i.test(model+segmen+kode_mesin) ? '7.5 - 9.5 L (V8 — Lexus LX570 5.7 = 8.5 L, Mercedes AMG V8 = 9L)' :
      'Cek buku manual — 3-8 L (sesuai ukuran silinder dan V4/V6/V8)';
  }

  // Power Steering
  let tipe_power_steering, fluida_power_steering;
  if (_ev) { tipe_power_steering = 'Electric Power Steering (EPS Rack/Column — Standard EV)'; fluida_power_steering = 'Tidak perlu (Sistem Elektrik / EPS)'; }
  else if (/(2010|baru|modern|baru|202[0-9])/i.test(catatan+tahunDefault({merek:M,segmen,catatan}))) {
    tipe_power_steering = ['BMW','AUDI','PORSCHE'].includes(M) ? 'Electric Power Steering (EPS Servotronic / Active Steering)' : 'Electric Power Steering (EPS)';
    fluida_power_steering = 'Tidak perlu (Sistem Elektrik / EPS)';
  } else {
    tipe_power_steering = 'Hydraulic Power Steering (HPS — Rack & Pinion)' + ((M === 'HINO' || M === 'ISUZU' || M === 'DFSK') ? ' Heavy Duty (Circulation Ball)' : '');
    fluida_power_steering = M === 'HONDA' ? 'Honda Genuine PSF (Semi-Synthetic) — JANGAN pakai ATF biasa' :
      ['BMW','MERCEDES-BENZ','MERCEDES','AUDI','VOLKSWAGEN','VW','VOLVO','MINI'].includes(M) ? 'Pentosin CHF 11S / CHF 202 / Febi Bilstein SAE 10W (sistem hidrolik Eropa)' :
      ['RENAULT','PEUGEOT','CITROEN','OPEL'].includes(M) ? 'Total Fluide DA / PSA S14 — Pentosin CHF 11S substitusi' :
      M === 'JEEP' ? 'Mopar Power Steering Fluid MS-9602 — Dexron III/ Mercon V OK' :
      M === 'HINO' || M === 'ISUZU' || M === 'DFSK' ? 'ATF Dexron III HD / Hydraulic Oil AW 46 Heavy Duty' :
      'ATF Dexron III (PSF Generik — 50.000 km ganti)';
  }

  // Rem + minyak rem
  let tipe_sistem_rem, minyak_rem;
  if (_ds && /(truck|tronton|bus|engkel|hino)/i.test(segmen+merek)) {
    tipe_sistem_rem = 'Pneumatic Air Brake (Rem Angin Full) + Drum + ABS (WABCO EBS opsional)';
    minyak_rem = 'Tidak pakai — Rem Angin (Compressor Air + Brake Chamber + Slack Adjuster — Service Manual HINO/ISUZU)';
  } else {
    const disc_all = /(premium|mewah|sport|type\s*r|amg|m\s*power|cooper\s*s|gti|rs\b|st|v6|v8|hybrid|ev|listrik|2\.4|2\.5|2\.0\s*t|turbo)/i.test(catatan+model+segmen+bahan_bakar);
    const drum_belakang = /(lcgc|city\s*car|low\s*mpv|entry|type\s*e|type\s*d|dasar|1\.0|1\.2|hatchback\s*dasar)/i.test(catatan+model+segmen+kategori);
    tipe_sistem_rem = disc_all ? 'Depan: Ventilated Disc (4-pot besar di varian performance), Belakang: Solid Disc / Ventilated Disc (4 sisi cakram)' :
      drum_belakang ? 'Depan: Ventilated Disc (15" / 14"), Belakang: Drum (Tromol — varian dasar / LCGC)' :
      `${/mpv|suv|cross/i.test(kategori+segmen) ? 'Depan: Ventilated Disc 16",' : 'Depan: Ventilated Disc,'} Belakang: Drum (tipe E/S/G) atau Solid Disc (tipe Q/V/RS/Prestige) — ABS + EBD standar ${/(2015|2020|modern)/i.test(catatan)?' + ESC + HSA':''}`;
    minyak_rem = ['BMW','MERCEDES-BENZ','MERCEDES','AUDI','VOLKSWAGEN','VW','VOLVO','MINI','JEEP','PORSCHE'].includes(M) ? 'DOT 4 LV Class 6 (ABS/ESP cocok — Pentosin / Febi DOT 4 Super / ATE DOT 4 SL.6)' :
      M === 'HYUNDAI' || M === 'KIA' ? 'DOT 4 (Hyundai/Kia Brake Fluid DOT 4 LV — ATE / TRW OEM)' :
      M === 'MAZDA' ? 'DOT 3 / DOT 4 — Mazda Genuine Brake Fluid Super DOT 4' :
      M === 'CHERY' || M === 'WULING' || M === 'MG' ? 'DOT 4 (Sistem brake Bosch / Continental untuk model baru EV)' :
      M === 'HINO' || M === 'ISUZU' || M === 'DFSK' ? 'DOT 3 / DOT 4 (Chassis Ringan / Pickup) — Air Brake pakai Compressor Oil (tipe truk)' :
      'Prestone DOT 4 (100% substitusi aman DOT 3), STP Brake Fluid DOT 4, Motul DOT 4 Class 6 — cek tutup tabung master rem';
  }

  // Ban + tekanan ban
  let ukuran_ban, merek_ban_oem, tekanan_ban;
  if (_ds && /(truck|tronton|bus|engkel|hino|isuzu|dfsk)/i.test(M + segmen)) {
    ukuran_ban = M === 'HINO' ? '7.00 R16 LT (FC / FG) / 8.25 R20 / 9.00 R20 / 10.00 R20 / 11.00 R20 / 11R22.5 / 295/80 R22.5 (HINO RG / RK / FM / SG Bus) — sesuai kapasitas tronton' :
      M === 'ISUZU' ? '6.50 R15 LT (NKR 55) / 7.00 R16 LT (NLR 55) / 7.50 R16 (Traga) / 8.25 R20 / 9.00 R20 / 215/75 R17.5 (ISUZU NMR ELF) / 255/70 R22.5 (Fuso Series)' :
      M === 'DFSK' ? '175/70 R14LT (DFSK Carry Pickup) / 195/70 R15LT (Super Cab) / 205/65 R15 (DFSK Glory 560 penumpang)' :
      '';
    merek_ban_oem = M === 'HINO' ? 'Bridgestone Greatec M828 / Michelin X Multi D / Goodyear Omnitrac MSS / Dunlop SP831 Truck & Bus Radial' :
      M === 'ISUZU' ? 'Dunlop SP320 / Bridgestone Duravis R624 R16 LT / Michelin X Multi Truck / Goodyear Cargo Marathon' :
      M === 'DFSK' ? 'GT Radial Maxmiler X / Bridgestone Duravis R624 / Dunlop Econodrive LT' :
      '';
    tekanan_ban = M === 'HINO' ? '80 - 95 PSI (ban tunggal gandar depan) / 85 - 110 PSI (ban ganda gandar belakang — sesuai plat beban sumbu)' :
      M === 'ISUZU' ? '50 - 80 PSI (Ringan NKR/Traga) / 85 - 110 PSI (Tronton/Fuso Heavy / Gandar ganda belakang)' :
      M === 'DFSK' ? '70 - 90 PSI (DFSK Pickup HD — Sesuaikan plat plakat pintu & beban muat)' :
      '';
  } else {
    const wheel = /(rs|premium|prestige|gt|sport|flagship|mewah|ultra|top|varian\s*atas|type\s*r|amg|m\s*power|cullinan|bentley)/i.test(catatan+model+segmen) ? 18 :
      /(suv|xl7|ertiga|xpander|rush|terios|cr[- ]?v|cx[- ]?5|cx[- ]?8|tiguan|tucson|sportage|fortuner|pajero|santa\s*fe|palisade|sorento)/i.test(model+segmen+kategori) ? 17 :
      /(mpv|sedan|crossover|cross|medium|city\s*car|lcgc|hatchback\s*entry)/i.test(segmen+kategori+catatan) ? 16 :
      15;
    const w = wheel;
    const w_profile = (w>=18)? 45 : (w===17) ? 55 : (w===16) ? 60 : /(suv|cross|mpv)/i.test(kategori+segmen)? 65: 65;
    const width = (w>=18)? 225 : (w===17)? 225 : (w===16)? 205 : 185;
    ukuran_ban = `${width}/${w_profile} R${w} (Type dasar/menengah; ${width+10}/${w_profile-5} R${w+1} varian RS/Prestige/Touring ${w+1} inci)`;
    const psi_min = /(suv|mpv|cross)/i.test(kategori+segmen) ? 33 : 32;
    const psi_max = /(suv 7|premium|mewah|hybrid|ev|pickup)/i.test(kategori+segmen+model) ? 38 : 34;
    tekanan_ban = `Depan: ${psi_min} PSI, Belakang: ${psi_min - 1} PSI (Kosong) / Belakang: ${psi_max} PSI (Penumpang penuh + barang bawaan — cek plakat pintu B untuk akurasi)`;
    merek_ban_oem = M === 'TOYOTA' || M === 'DAIHATSU' ? 'Bridgestone Ecopia EP150 / Dunlop Enasave EC300+ (LCGC) — Grandtrek PT3 (SUV) — Michelin Primacy 4 (Camry/Alphard)' :
      M === 'HONDA' ? 'Michelin Latitude Tour HP (SUV) / Michelin Primacy 4 / XM2+ (City/Civic) — Dunlop Enasave EC300+ (entry)' :
      M === 'NISSAN' ? 'Dunlop Enasave EC300+ (entry) / Michelin Latitude Tour HP (X-Trail) — Yokohama BluEarth RV-02 (Serena)' :
      M === 'MAZDA' ? 'Toyo Proxes R46 (Mazda3/CX-30/CX-5) — Yokohama Advan dB / Bridgestone Alenza H/L 33' :
      M === 'SUZUKI' ? 'Dunlop Grandtrek PT3 (SUV Ertiga/XL7) — Yokohama BluEarth ES32 (Baleno/Swift) — GT Radial Champiro Eco' :
      M === 'HYUNDAI' || M === 'KIA' ? 'Nexen N Fera RU7 / Kumho Crugen HP71 — Michelin Primacy 4 (Palisade/Santa Fe/Staria)' :
      M === 'BMW' || M === 'MINI' ? 'Pirelli Cinturato P7 RFT (Run Flat) / Michelin Primacy 3 RFT / Bridgestone Turanza T005 RFT' :
      M === 'MERCEDES-BENZ' || M === 'MERCEDES' ? 'Pirelli Cinturato P7 MO / Michelin Primacy 4 MO / Continental PremiumContact 6 MO' :
      M === 'AUDI' ? 'Pirelli Cinturato P7 AO / Michelin Primacy 4 AO / Continental PC6 AO' :
      M === 'VOLKSWAGEN' ? 'Michelin Primacy 4 / Dunlop Sport BluResponse / Continental PremiumContact 5' :
      M === 'VOLVO' ? 'Michelin Pilot Sport 4 SUV VOL / Continental PremiumContact 6 VOL — Pirelli Scorpion Verde VOL (XC Series)' :
      M === 'JEEP' ? 'Bridgestone Dueler H/T A/W / Goodyear Wrangler / Michelin LTX Force / Kumho Road Venture' :
      M === 'SUBARU' ? 'Yokohama Geolandar G058 (SUV) / Bridgestone Dueler H/T D687 — Dunlop Grandtrek PT3' :
      M === 'LEXUS' ? 'Bridgestone Turanza T005A / Michelin Primacy 4 (ES) / Dunlop SP Sport Maxx 050+ (F-Sport)' :
      M === 'WULING' ? 'GT Radial SAvero SUV (Almaz) / Dunlop Enasave (Confero) — Linglong Green-Max (Air EV)' :
      M === 'CHERY' || M === 'GEELY' ? 'Laufenn G Fit AS (Hankook Group) / Nexen N Fera RU7 / Kumho — GT Radial SAvero' :
      M === 'BYD' ? 'Michelin Primacy 4 EV / Continental PremiumContact 6 EV / Hankook Ventus S1 evo3 EV — 18" atau 19"' :
      M === 'MG' ? 'Michelin Latitude Tour HP (ZS) / Continental UC6 (MG5 GT / HS) — Dunlop Grandtrek ST30' :
      M === 'PROTON' ? 'Silverstone / Goodyear EfficientGrip SUV / GT Radial Champiro' :
      M === 'OPEL' ? 'Michelin Primacy 4 / Continental PremiumContact 6 / Goodyear EfficientGrip Performance 2' :
      ['AION','XPENG','NETA','GWM','ICAR','Lepas','LEPAS','POLYTRON','CHANGAN','LEAPMOTOR','ALETRA','VINFAST','HONGQI','SMART','MAXUS','BAIC','DFSK'].includes(M) ? 'Michelin Primacy 4 EV / Continental EcoContact 6 / Hankook Ventus S1 EVO3 EV / Linglong Green-Max (Harga terjangkau)' :
      /hybrid|phev|hev/i.test(bahan_bakar) ? 'Michelin Primacy 4 ST / Bridgestone Turanza T005A / Continental UC6 — EV/Hybrid Low Rolling Resistance' :
      'Bridgestone / Dunlop / GT Radial / Michelin — Cek Plat Pintu untuk akurasi ukuran ring';
  }

  // Aki + merek aki
  let tipe_aki, merek_aki_oem;
  if (_ev) {
    tipe_aki = 'Aux 12V LN2 (45Ah) + Traksi High-Voltage 44kWh - 120kWh (LFP / NMC / NCA — Cek buku manual per varian baterai)';
    merek_aki_oem = 'CATL / BYD Blade / Gotion High-Tech / LG Energy Solution (Traksi) + Varta / GS Astra / Bosch S4 / Camel (Aux 12V — kecil)';
  } else if (/(ISS|i-stop|start[\s-]?stop|eco\s*idle|mhev|micro\s*hybrid)/i.test(`${catatan} ${model} ${kode_mesin}`) || M === 'MAZDA' || (M === 'TOYOTA' && /veloz|yaris|agya|avanza|vios|corolla|inova/i.test(model))) {
    tipe_aki = `Q-85 / Q-90 ISS i-Stop EFB (65-75Ah — Wajib untuk Start-Stop) — ${/cr-v|accord|civic\s*turbo|cx[- ]?8|cx[- ]?9|pajero\s*sport|fortuner|land\s*cruiser/i.test(model)?'T-110 90Ah Premium':'kaki aki tipe B24 / L: 242mm, W: 175mm, H: 190mm'}`;
    merek_aki_oem = M === 'MAZDA' ? 'Panasonic ISS EFB / GS Astra ISS EFB — asli mazda' : M === 'HONDA' ? 'Panasonic ISS HTO-06 / GS Astra EFB Start-Stop' : 'Yuasa EFB ISS / Furukawa Q85 ISS EFB / GS Astra ISS Series';
  } else if (['BMW','MERCEDES-BENZ','MERCEDES','AUDI','PORSCHE'].includes(M) || _hev) {
    tipe_aki = `DIN 70 / DIN 80 / DIN 92 AGM (Absorbent Glass Mat) — ${_hev?'Hybrid/Start-Stop wajib AGM':'Eropa Start-Stop wajib AGM — tidak boleh downgrade MF konvensional'}`;
    merek_aki_oem = 'Varta Silver Dynamic AGM / Bosch S5 AGM (H5/L3/L4) / Exide Premium AGM (EK700 / EK800) / Banner Power Bull AGM — sesuai kaki DIN';
  } else if (/(dsl|diesel|2kd|d-4d|common\s*rail|crdi|cdi|panther|traga|mu-?x|fortuner|pajero\s*sport|fuso|hino|isuzu|dfsk|4jj|4jk1)/i.test(`${catatan} ${model} ${kode_mesin} ${bahan_bakar}`)) {
    tipe_aki = /hino|isuzu\s*(nmr|fg|fuso)/i.test(M + model + segmen) ? '95D31R / N70Z (70Ah) / DIN80 MF / 120Ah / 150Ah (Tronton/Bus — 24V Sistem: 2 aki 12V seri)' : 'NS70 / 80D26L (70Ah) / N70Z / 95E41R — Diesel 2.5L up: 80Ah minimum untuk cranking dingin';
    merek_aki_oem = 'GS Astra Super MF Gold / Amaron Hi-Life Pro Black / Hankook AtlasBX MF / Delkor Calcium MF (Diesel CCA tinggi: 750-950A Cold Cranking)';
  } else if (/(lcgc|1\.0|brio|kwid|march|picanto|agya|ayla|karimun|suzuki\s*wagon|carri)/i.test(model+segmen+kode_mesin+kategori)) {
    tipe_aki = 'NS40ZL / 34B19L (32Ah - 35Ah) — kaki tipe NS (Narrow Short) — sesuai mobil LCGC';
    merek_aki_oem = 'GS Astra Gold Maintenance Free / Amaron Hi-Life Go / Panasonic NS40Z MF / Furukawa F-NS40Z';
  } else {
    // Default passenger bensin
    tipe_aki = 'NS60L / 46B24L (45Ah — entry) / 55D23L (60Ah — varian menengah 1.8/2.0) / 80D26L (70Ah — varian SUV 2.4/2.5 AT)';
    merek_aki_oem = 'GS Astra Maintenance Free / Panasonic SMP / Furukawa F-Series / Amaron Hi-Life / Bosch S3 Silver — sesuai kaki tipe aki';
  }

  // Rekomendasi aftermarket: format HTML seperti migration
  const rek_mesin = _ev ? 'Shell Helix Ultra tidak dibutuhkan — Pakai EV-specific: Shell E-Fluids (E6-i) / Mobil 1 EV Fluid Coolant / Pentosin G48 EV Coolant Ready Mix' :
    /0w-20|0w-16/.test(viskositas_oli) ? 'Motul H-Tech 100 Plus 0W-20, Mobil 1 ESP Formula, Shell Helix Ultra Professional AF, Idemitsu SN/GF-6, Castrol Edge 0W-20 Long Life' :
    /5w-30/.test(viskositas_oli) ? 'Amsoil Signature Series 5W-30, Motul 8100 X-Cess 5W-40 (atau 5W-30 X-Clean), Shell Helix Ultra 5W-40, Castrol Magnatec Stop-Start 5W-30 A5, Pertamina Fastron Platinum 5W-30' :
    _ds ? 'Mobil Delvac 1 ESP 5W-40, Shell Rimula R4 X 15W-40, Pertamina Meditran SX Plus 15W-40, Motul 4100 Turbolight 15W-40, Petronas Urania 3000 CI-4' :
    'Shell Helix HX7 10W-40, Fastron Techno 10W-40, Pertamina Mesran Super 15W-40 API SN, Motul Multipower Plus, Castrol GTX';
  const rek_trans = /Single-Speed|EV/.test(tipe_transmisi) || _ev ? 'Shell E-Fluid E6-i (Motor & Gear) / Pentosin Reducer EV Gear Oil SAE 75W-85 / Mobil 1 EV Gearbox 75W — ganti 60.000 km pertama (atau sesuai buku)' :
    tipe_transmisi === 'CVT' ? 'Aisin CFEx CVTF, Motul CVTF Technosynthese, Eneos CVT Fluid NS-3 / HCF-2 (sesuai merek), Petronas Tutela CVT Multi' :
    tipe_transmisi === 'Manual' || tKey === 'MT' ? 'Motul Motylgear 75W-90 GL-4, Red Line MT-90, Shell Spirax S4 TXM, Castrol Syntrax Universal 75W-90 GL-4/GL-5' :
    tKey === 'DCT' ? 'Aisin DCTF / Motul DCTF / Febi Bilstein DCT Fluid 38149 / Pentosin DCTF — sesuaikan Getrag/ZF/BorgWarner' :
    'Aisin AFW+ (Dex III), Motul ATF VI (Mercon LV/Dex VI), Shell Spirax S3 ATF MD3, Idemitsu ATF Type DW-1 (khusus Honda 5-speed AT), Castrol Transmax ATF Dexron III/Mercon V';
  const rek_rem = /Pneumatic|Air\s*Brake/i.test(tipe_sistem_rem) ? 'Shell Air Brake Compressor Oil S2 A 100 (HD Truck & Bus) / Mobil Delvac Synthetic Air Brake Oil — WABCO Valve & ABS Diagnostics' :
    /DOT 4 LV|DOT 4\s*\(.*LV/.test(minyak_rem) ? 'Prestone DOT 4 LV Class 6, Motul RBF 600 Factory Line DOT 4 LV, Brembo DOT 4 LV Extra, Febi Bilstein DOT 4 Super (ABS/ESP + ABS-EBD cocok)' :
    'Prestone DOT 4 (100% substitusi DOT 3 — aman untuk suhu pedal), STP Brake Fluid DOT 4, Motul DOT 4 Class 6, ATE TYP 200 DOT 4 — ganti setiap 2 tahun / 40.000 km';
  const rek_ps = /Tidak perlu|EPS/.test(fluida_power_steering) ? '' :
    `<div class="rek-item"><strong>Power Steering:</strong> ${M === 'HONDA' ? 'Prestone Honda PSF, Idemitsu Honda PSF Semi-Synthetic — JANGAN pakai ATF biasa (akan merusak seal rack & pinion)' : ['BMW','MERCEDES-BENZ','MERCEDES','AUDI','VOLKSWAGEN','VW','VOLVO','MINI'].includes(M) ? 'Febi Bilstein CHF 11S 1L / Pentosin CHF202 / Liqui Moly 1147 Zentralhydraulik-Öl 10W (Eropa)' : ['RENAULT','PEUGEOT','CITROEN','OPEL'].includes(M) ? 'Total Fluide DA 1L / PSA S14 — Pentosin CHF 11S substitusi' : 'Aisin ATF Dexron III (PSF generic), STP Power Steering Fluid / Prestone PSF — ganti setiap 50.000 km'}</div>`;
  const rek_aki = _ds && /truck|bus|tronton|hino|isuzu|dfsk/i.test(M + segmen) ? '<div class="rek-item"><strong>Aki Heavy Duty (Truck/Bus):</strong> GS Astra N70Z / Delkor 95D31R (Pickup/LCV) — Varta Promotive 140Ah (HINO/ISUZU GIGA) / Exide Professional 150Ah / Banner Power Bull 170Ah 24V — CCA: 800-1800A</div>' :
    `<div class="rek-item"><strong>Aki (Battery):</strong> ${/Q-85|ISS|EFB/.test(tipe_aki) ? 'Panasonic ISS EFB (Q-85 / Q-90 T110) / Amaron Hi-Life ISS EFB / Furukawa Q85 EFB — JANGAN downgrade ke aki basah MF konvensional (dapat cepat drop)' : /AGM|DIN 70|DIN 80/.test(tipe_aki) ? 'Varta Silver Dynamic AGM (H5=LN2/H6=LN3/H7=LN4) / Bosch S5 AGM / Banner Power Bull AGM — hanya cas dengan smart charger (14.4V - 14.7V max)' : /NS40Z|34B19|32Ah|35Ah/.test(tipe_aki) ? 'GS Astra NS40ZL MF / Amaron Go NS40Z / Panasonic SMP 35Ah / Furukawa F-NS40Z (LCGC & city car)' : /NS60|46B24|55D23|80D26/.test(tipe_aki) ? 'GS Astra Gold NS60L (45Ah) / Amaron Hi-Life 55D23L (60Ah) / Panasonic 80D26L MF / Delkor Calcium 70Ah / Incoe Maintenance Free' : 'GS Astra Maintenance Free / Panasonic SMP / Amaron Pro Black / Motobatt Quadflex (Polygel Upgrade)'}</div>`;

  const rekomendasi_aftermarket = `<div class="rek-item"><strong>Mesin:</strong> ${rek_mesin}</div><div class="rek-item"><strong>Transmisi:</strong> ${rek_trans}</div><div class="rek-item"><strong>Rem:</strong> ${rek_rem}</div>${rek_ps}${rek_aki}`;

  const tahun = tahunDefault({merek:M, segmen, catatan});
  return [
    merek, model, tahun, kategori,
    bahan_bakar, kode_mesin, kapasitas_cc, tipe_transmisi, detail_transmisi,
    viskositas_oli, standar_oli, kapasitas_oli, oli_transmisi,
    tipe_power_steering, fluida_power_steering,
    tipe_sistem_rem, minyak_rem,
    ukuran_ban, merek_ban_oem, tekanan_ban,
    tipe_aki, merek_aki_oem,
    rekomendasi_aftermarket
  ];
}

const MAIN = async () => {
  const jsonPath = path.join(__dirname, 'new_vehicles_from_excel.json');
  if (!fs.existsSync(jsonPath)) {
    throw new Error('JSON not found: run compare_excel_db.js dulu');
  }
  const entries = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));
  console.log(`\n▶ Akan insert ${entries.length} record baru...`);

  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    const cols = [
      'merek','model','tahun','kategori','bahan_bakar','kode_mesin','kapasitas_cc','tipe_transmisi','detail_transmisi','viskositas_oli','standar_oli','kapasitas_oli','oli_transmisi','tipe_power_steering','fluida_power_steering','tipe_sistem_rem','minyak_rem','ukuran_ban','merek_ban_oem','tekanan_ban','tipe_aki','merek_aki_oem','rekomendasi_aftermarket'
    ];
    const placeholdersPerRow = `(${cols.map((_,i) => '$'+(i+1)).join(',')})`;
    const inserts = [];
    let done = 0;
    const skipDupes = 0;
    for (let i = 0; i < entries.length; i++) {
      const values = buildFullRecord(entries[i]);
      // 24 kolom (kolom di list adalah 24)
      // Insert ON CONFLICT: pakai DO NOTHING — unique index? cek dulu. kalau tidak ada, cek manual select dulu
      const { rows: exist } = await client.query(
        `SELECT id FROM kendaraan WHERE lower(merek)=lower($1) AND lower(model)=lower($2)`,
        [values[0], values[1]]
      );
      if (exist.length > 0) {
        // Ada — skip (ada karena race condition compare vs insert)
        continue;
      }
      inserts.push(values);
      // Batch 500 per query (total 959 — 2 batch)
      if (inserts.length >= 400 || i === entries.length - 1) {
        const paramList = [];
        const rowsSql = [];
        inserts.forEach(v => {
          const startIdx = paramList.length;
          const p = v.map((_, k) => '$' + (startIdx + k + 1));
          rowsSql.push(`(${p.join(',')})`);
          paramList.push(...v);
        });
        const q = `INSERT INTO kendaraan (${cols.join(',')}) VALUES ${rowsSql.join(',')} RETURNING id`;
        const r = await client.query(q, paramList);
        done += r.rows.length;
        inserts.length = 0;
      }
    }
    await client.query('COMMIT');
    console.log(`\n🎉 INSERT BERHASIL: ${done} record baru (${skipDupes} skip karena race double)`);

    const now = (await pool.query('SELECT COUNT(*) AS n FROM kendaraan')).rows[0].n;
    const brands = (await pool.query('SELECT COUNT(DISTINCT merek) AS n FROM kendaraan')).rows[0].n;
    console.log(`\n📊 Database sekarang: ${now} total kendaraan, ${brands} merek unik`);

    console.log('\n✅ Field kelengkapan 21 utama (total baru):');
    for (const f of ['kategori','bahan_bakar','kode_mesin','kapasitas_cc','tipe_transmisi','detail_transmisi','viskositas_oli','standar_oli','kapasitas_oli','oli_transmisi','tipe_power_steering','fluida_power_steering','tipe_sistem_rem','minyak_rem','ukuran_ban','merek_ban_oem','tekanan_ban','tipe_aki','merek_aki_oem','rekomendasi_aftermarket']) {
      const { rows } = await pool.query(`SELECT COUNT(*) AS c FROM kendaraan WHERE ${f} IS NULL OR TRIM(${f}::text) = '' OR ${f} = '-'`);
      const empty = parseInt(rows[0].c);
      const ok = now - empty;
      console.log(`  ${f.padEnd(28)} ${ok}/${now} (${(ok*100/now).toFixed(1)}%)${empty?` ⚠ ${empty}`:' ✅'}`);
    }
  } catch (e) {
    await client.query('ROLLBACK');
    throw e;
  } finally {
    client.release();
  }
};

MAIN().catch(e => {
  console.error('FATAL:', e.message);
  console.error(e.stack);
  process.exit(1);
}).finally(() => pool.end());
