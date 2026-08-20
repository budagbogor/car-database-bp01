'use strict';
require('dotenv').config();
const pool = require('../db');

const LOOKUP = {
  '6755': { ukuran_ban:'195 R15 LT (Hi Ace Commuter) / 205/70 R15 (High Ace Premio) / 215/70 R16 (Generasi Terbaru Diesel Turbo)', merek_ban_oem:'Bridgestone Duravis R624 / Dunlop Econodrive LT / GT Radial Maxmiler / Michelin Agilis 3', tekanan_ban:'38 PSI (ban tunggal penumpang) / 42 - 45 PSI (Blind Van / Muat Berat)' },
  '6780': { ukuran_ban:'185/70 R14 LT (Luxio Basic) / 195/70 R15 (Luxio M/T Xenia basis)', merek_ban_oem:'Dunlop SP Touring T1 / GT Radial Champiro VP1 / Bridgestone Ecopia EP150', tekanan_ban:'35 PSI (Kosong) / 38 PSI (7-penumpang + bagasi)' },
  '6784': { ukuran_ban:'175/70 R13 LT (Zebra Espass 1.3 Pickup) / 185/70 R14 (Zebra Passenger Minibus)', merek_ban_oem:'GT Radial Savero / Dunlop SP831 / Bridgestone RD-613 Steel', tekanan_ban:'38 PSI (Depan) / 40 PSI (Belakang beban)' },
  '6785': { ukuran_ban:'175 R13 LT (Zebra Hi-Jet 1.0 Pickup Flat Deck)', merek_ban_oem:'Bridgestone RD613 / Dunlop SP Light Truck / GT Radial Maxmiler LT', tekanan_ban:'42 - 45 PSI (sesuai plat plakat pintu beban sumbu)' },
  '6801': { ukuran_ban:'195/65 R15 (Stepwgn Spada Low) / 205/60 R16 (Stepwgn Modulo X / Spada Premium)', merek_ban_oem:'Bridgestone Playz PX-RV / Dunlop Le Mans V / Yokohama BluEarth RV-02', tekanan_ban:'33 PSI (Depan) / 32 PSI (Belakang 2-penumpang) / 35 PSI (Full 7 seat)' },
  '6826': { ukuran_ban:'7.00 R15 LT (Canter 110 HD) / 7.00 R16 LT (Canter 125 HD) / 7.50 R16 (Canter HD X 136 ps)', merek_ban_oem:'Bridgestone Greatec M828 / Michelin X Multi D / Dunlop SP831 Truck / Goodyear Cargo Marathon II', tekanan_ban:'70 - 80 PSI (Gandar Depan) / 80 - 95 PSI (Gandar Belakang Tunggal / Gandar Ganda Double Ban belakang)' },
  '6831': { ukuran_ban:'205/70 R15 C (Delica Diesel Pickup) / 195/80 R15 LT (Delica 4x4 Minibus)', merek_ban_oem:'Bridgestone Dueler H/T 689 / Michelin LTX Force / Dunlop Grandtrek AT5', tekanan_ban:'36 PSI (2WD) / 38 PSI (4WD Off-Road ringan)' },
  '6832': { ukuran_ban:'9.00 R20 (Fuso FM 517 HL Chassis 17 Ton) / 10.00 R20 (FM 517 HL Tronton 22 Ton)', merek_ban_oem:'Bridgestone M748 / Michelin X Works D / Goodyear Omnitrac MSS II / Dunlop SP326 Truck & Bus', tekanan_ban:'105 PSI (depan) / 110 PSI (Belakang double ban tronton — sesuai plat beban sumbu)' },
  '6849': { ukuran_ban:'205/75 R16 C (NV350 Caravan 15-seat) / 215/70 R16 (NV350 Premium MPV 10-seat)', merek_ban_oem:'Michelin Agilis 3 / Bridgestone Duravis R660 / Yokohama BluEarth Van RY55', tekanan_ban:'36 PSI (Penumpang) / 40 PSI (Blind van / muat berat barang)' },
  '6882': { ukuran_ban:'165/80 R13 LT (Carry Futura 1.0 Pickup Flat Deck / Box) / 175/70 R14 (Carry Futura Minibus angkot)', merek_ban_oem:'Dunlop SP320 / Bridgestone RD 613 Steel / GT Radial Greatec / GT Savero HT2 Ringan', tekanan_ban:'42 PSI (Depan) / 45 PSI (Belakang muat — sesuai plat plakat pintu Carry)' },
  '6910': { ukuran_ban:'215/70 R16 (H-1 Travello MPV 11-seat) / 225/60 R17 (H-1 Premium Elite / Royale MPV)', merek_ban_oem:'Bridgestone Dueler H/L 422 Ecopia / Michelin Latitude Tour HP / Hankook Dynapro HP2', tekanan_ban:'34 PSI (Depan) / 36 PSI (Belakang 11-seater penuh)' },
  '6911': { ukuran_ban:'215/70 R16 C (H-1 Diesel Blind Van) / 225/65 R16 (H-1 Diesel XG 12-seat)', merek_ban_oem:'Michelin Agilis CrossClimate / Bridgestone Duravis R660 Van / Continental VanContact Ultra', tekanan_ban:'40 PSI (Blind Van muat) / 38 PSI (Minibus 12-seat penuh)' },
  '6927': { ukuran_ban:'195/75 R15 LT (Kia Pregio 2.7 Diesel Minibus angkot) / 205/70 R15 (Pregio 16-seat Basis Travello)', merek_ban_oem:'GT Radial Savero HT2 / Dunlop Econodrive LT / Bridgestone B380 LT Steel', tekanan_ban:'38 PSI (Depan) / 40 PSI (Belakang — 16-seater + bagasi atas)' },
  '6928': { ukuran_ban:'205/75 R16 C (Pregio Diesel 2.9 CRDi Blind Van / Ambulance)', merek_ban_oem:'Michelin Agilis 3 / Bridgestone Duravis R660 LT / Continental VanContact A/S', tekanan_ban:'42 PSI (Blind Van / Ambulance beban penuh)' },
  '6931': { ukuran_ban:'205/75 R16 C (Travello 11-seat) / 215/70 R16 (Travello Executif Lounge seat)', merek_ban_oem:'Michelin LTX M/S2 / Bridgestone Dueler H/L Alenza / Hankook Dynapro HP2 RA33', tekanan_ban:'35 PSI (2+2) / 38 PSI (11-seat penuh + bagasi)' },
  '6980': { ukuran_ban:'205/75 R15 LT (Chevrolet Tavera Base 10-seat) / 215/70 R16 (Tavera Neo 3 LT Diesel 9-seat)', merek_ban_oem:'Bridgestone B381 Steel / GT Radial Savero HT2 / Dunlop Grandtrek ST30', tekanan_ban:'35 PSI (Depan) / 38 PSI (Belakang muat 10-seat + bagasi)' },
  '7117': { ukuran_ban:'215/75 R16 LT (Chery Himma / Tiggo 8 Pro platform Pickup) / 235/70 R16 (4x4 Double Cabin)', merek_ban_oem:'Chaoyang / Westlake SU318 / GT Radial Savero AT Pro / Nexen Roadian AT Pro RA8', tekanan_ban:'36 PSI (2WD 4x2) / 40 PSI (4x4 beban + towing 2500kg)' },
  '7174': { ukuran_ban:'215/65 R16 C (Ford Transit Custom 13-seat) / 235/65 R16 (Transit 350L Minibus / Box)', merek_ban_oem:'Michelin Agilis 3 / Continental VanContact Eco / Goodyear EfficientGrip Cargo / Bridgestone Duravis R660', tekanan_ban:'44 PSI (Blind van box) / 38 PSI (Penumpang 13-seat)' },
  '7175': { ukuran_ban:'185/70 R14 (Ford Spectron 12-seat Angkot Basis) / 195/70 R15 C (Spectron Blind Van / Kijang basis)', merek_ban_oem:'GT Radial Champiro VP1 / Dunlop SP Touring T1 / Bridgestone B250 LT Steel', tekanan_ban:'36 PSI (Depan) / 38 PSI (Belakang 12-seat)' },
  '7326': { ukuran_ban:'225/55 R17 C (Vito Tourer Select 9-seat) / 245/45 R19 (Vito Tourer Premium AMG Line)', merek_ban_oem:'Michelin Primacy 4+ / Continental PremiumContact 6 / Pirelli Cinturato P7 / Bridgestone Turanza T005', tekanan_ban:'38 PSI (9-seat penuh + bagasi) / 42 PSI (Vansport Muat berat)' },
  '7327': { ukuran_ban:'205/65 R16 C (Vito Select 110 CDI Base) / 225/55 R17 (Vito 116 CDI Mixto Van)', merek_ban_oem:'Continental VanContact Ultra / Michelin Agilis 3 / Goodyear EfficientGrip Cargo / Hankook Vantra LT', tekanan_ban:'44 PSI (Mixto Blind Van) / 36 PSI (Passenger Select 8-seat)' },
  '7328': { ukuran_ban:'235/65 R16 C (Sprinter 315 CDI Panel Van) / 225/75 R16 LT (Sprinter 315 CDI 16-seat Minibus)', merek_ban_oem:'Michelin Agilis 3 / Continental VanContact A/S Ultra / Goodyear Marathon Cargo / Bridgestone Duravis R410 HD', tekanan_ban:'52 PSI (Rear double-wheel 3,5t GVW) / 44 PSI (Penumpang Minibus 16-seat)' },
  '7329': { ukuran_ban:'225/75 R16 LT (Sprinter 415 CDI Chassis / Crew Cab) / 235/65 R16 C 8-Ply (Double ban belakang 4,5 ton)', merek_ban_oem:'Michelin X Multi D LT / Continental VanContact 100 / Hankook Vantra Trailer / Bridgestone Duravis M713 All Terrain', tekanan_ban:'65 PSI (Gandar depan 415) / 75 PSI (Gandar belakang double ban — sesuai plat plakat Sprinter 415 CDI 4,5t)' },
  '7345': { ukuran_ban:'275/80 R22.5 (Chassis Bus OH 1526 — Basis Mercy Medium Bus 37-seat)', merek_ban_oem:'Bridgestone U-AP 001 / Michelin X Multi Z / Goodyear Regional RHS II / Continental Conti Urban HA3', tekanan_ban:'110 PSI (depan) / 115 PSI (belakang — sesuai plat beban gandar sumbu roda 19,5 ton)' },
  '7346': { ukuran_ban:'295/80 R22.5 (OH 1626 Big Bus Pariwisata 51-seat / AKAP)', merek_ban_oem:'Michelin X Coach / Bridgestone Greatec UA / Goodyear Regional RHD II / Dunlop SP362 Coach', tekanan_ban:'115 PSI (Depan Steering Axle) / 120 PSI (Drive Axle belakang — sesuai plat beban GBK 22 ton)' },
  '7347': { ukuran_ban:'11 R22.5 (Chassis OF 1623 Basis Medium Bus 39-seat AKDP)', merek_ban_oem:'Michelin X Multi Grip / Bridgestone M748 Ecopia / Continental Conti Hybrid LD3 / Dunlop SP328 Regional', tekanan_ban:'110 PSI (Depan) / 115 PSI (Belakang beban 18 ton GVW)' },
  '7348': { ukuran_ban:'315/80 R22.5 (Mercedes O 500 RS 1836 — Flagship High Decker Bus Pariwisata 57-seat)', merek_ban_oem:'Michelin X Coach HD Z / Bridgestone Ecopia U-AP 001 / Goodyear Touring LHT II / Continental Conti Tour', tekanan_ban:'120 PSI (Gandar Depan) / 125 PSI (Gandar Tengah Drive + Gandar Belakang Tag axle — sesuai plat plakat 28 ton GVW)' },
  '7349': { ukuran_ban:'10.00 R20 (Axor 1623 Medium Truck Box) / 11 R22.5 (Axor 1623 Tronton 18T Basis)', merek_ban_oem:'Michelin X Works D / Bridgestone M840 Greatec / Continental Conti Hybrid HD3 / Goodyear Omnitrac MSS II', tekanan_ban:'105 PSI (Depan) / 110 PSI (Belakang — sesuai plat beban sumbu roda 18t GVW)' },
  '7350': { ukuran_ban:'11 R22.5 (Axor 2528 Chassis Tronton 25T) / 295/80 R22.5 (Axor 2528 Kargo Wingbox)', merek_ban_oem:'Bridgestone Greatec M828 / Michelin X Multi D / Continental Conti Hybrid LD3 / Hankook Smart Flex TH31', tekanan_ban:'115 PSI (Depan Gandar kemudi) / 120 PSI (Belakang double-ban 2 sumbu tronton)' },
  '7351': { ukuran_ban:'12.00 R20 (Axor 4028 Heavy Haul 8x4) / 315/80 R22.5 (Axor 4028 Tronton 40 Ton Tangki / Container)', merek_ban_oem:'Michelin X Works HD Z / Bridgestone M854 Greatec / Continental ContiTread HD / Goodyear Omnitrac MSD II', tekanan_ban:'125 PSI (Gandar Depan Kemudi) / 130 PSI (Semua Gandar Belakang — pastikan tekanan sesuai plat plakat sumbu roda GBK 42 ton)' },
  '7389': { ukuran_ban:'LT265/70 R17 (Gladiator Overland 4x4) / LT285/70 R17 (Rubicon 4x4 Rock-Trac 33-inch MT upgrade OEM)', merek_ban_oem:'BFGoodrich All-Terrain T/A KO2 / Falken Wildpeak AT3W / Bridgestone Dueler A/T Revo 3 / Goodyear Wrangler Duratrac', tekanan_ban:'38 PSI (Jalan raya On-road 2+2) / 28 - 32 PSI (Off-Road Permukaan Lunak pasir / Lumpur — deflasi dengan pengukur akurat)' },
  '7391': { ukuran_ban:'205/75 R15 (Jeep Comanche MJ 2WD Pickup) / 215/75 R15 (Comanche 4x4 Base Sportruck)', merek_ban_oem:'Michelin LTX M/S2 / Bridgestone Dueler H/T 689 / Cooper Discoverer H/T Plus / Goodyear Wrangler SR-A', tekanan_ban:'34 PSI (2WD) / 36 PSI (4x4 beban towing 2500lbs)' },
  '7410': { ukuran_ban:'255/60 R18 (MG Extender Grand X 2WD AT Double Cab) / 265/60 R18 (Extender 4x4 Double Cabin Diamond)', merek_ban_oem:'Michelin LTX Force / Bridgestone Dueler A/T Revo III / Yokohama Geolandar G015 / Continental CrossContact ATR', tekanan_ban:'36 PSI (2+2) / 40 PSI (Pemuat 1000kg payload penuh + Towing 3000kg)' },
  '7457': { ukuran_ban:'175/70 R13 (Proton Arena / Jumbuck 1.5 Coupe Utility Pickup 2WD)', merek_ban_oem:'GT Radial Champiro 128 / Dunlop SP Touring R1 / Bridgestone Playz / Silverstone Kruizer 1 NS800', tekanan_ban:'34 PSI (Depan) / 36 PSI (Belakang — 700kg Pickup Flat Deck muat ringan)' },
  '7528': { ukuran_ban:'235/60 R18 (VW ID. Buzz Life EV 5-seat) / 255/45 R20 (ID. Buzz Style EV People Mover 7-seat Long Wheelbase)', merek_ban_oem:'Michelin e.Primacy / Continental EcoContact 6 Q EV / Bridgestone Turanza Eco ENLITEN / Goodyear EfficientGrip Performance 2 (EV Silica)', tekanan_ban:'42 PSI (Baterai 77kWh berat + penumpang 7-seat — cek label pintu pengemudi ID Buzz LWB)' },
  '7536': { ukuran_ban:'205/65 R16 C (VW Caravelle T6.1 9-seat) / 215/65 R16 (Caravelle Highline 4Motion AWD)', merek_ban_oem:'Michelin Agilis 3 / Continental VanContact Camper / Goodyear EfficientGrip Cargo / Bridgestone Duravis R660', tekanan_ban:'38 PSI (9-seat penuh) / 44 PSI (Caravelle Blind Van muat + towing 2500kg)' },
  '7537': { ukuran_ban:'185/80 R14 (VW Combi T2 / T3 Lawas Generasi) / 195/70 R15 (Combi T4 Generasi Terakhir)', merek_ban_oem:'Michelin XZX / Continental ContiVanContact 100 / Vredestein Comtrac / Bridgestone B381 LT', tekanan_ban:'32 PSI (Depan) / 36 PSI (Belakang 9-seater Combi lawas)' },
  '7540': { ukuran_ban:'205/65 R16 C (Transporter T4 2.5 TDI Base) / 215/65 R16 C (Transporter T5 / T6 Highline Crew Van / Double Cab Pickup) / 225/55 R17 (T6.1 Highline Premium)', merek_ban_oem:'Michelin Agilis 3 / Continental VanContact Ultra / Hankook Vantra LT / Bridgestone Duravis R660 HD', tekanan_ban:'44 PSI (Box van / Pickup double cab beban 3.2t) / 38 PSI (Passenger Kombi 8-seat)' },
  '7568': { ukuran_ban:'185 R14 LT 8-PR (Wuling Formo Max Blind Van / Pickup 1.8 Ton) / 195/70 R15 C (Formo Max 12-seat Minibus Angkot)', merek_ban_oem:'GT Radial Maxmiler X / Bridgestone Duravis R624 LT / Chaoyang SL305 / Goodyear Cargo Marathon II', tekanan_ban:'48 PSI (Blind Van / Pickup 1,8 Ton beban penuh) / 40 PSI (12-seat Minibus penumpang + bagasi)' }
};

const MAIN = async () => {
  const list = Object.keys(LOOKUP);
  console.log(`🔧 Akan update spesifikasi ban untuk ${list.length} record...`);
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    let ok = 0;
    for (const id of list) {
      const s = LOOKUP[id];
      await client.query(
        `UPDATE kendaraan SET ukuran_ban=$1, merek_ban_oem=$2, tekanan_ban=$3 WHERE id=$4`,
        [s.ukuran_ban, s.merek_ban_oem, s.tekanan_ban, Number(id)]
      );
      ok++;
    }
    await client.query('COMMIT');
    console.log(`✅ ${ok} record berhasil diupdate (kelengkapan ban 100%)`);
  } catch (e) {
    await client.query('ROLLBACK');
    throw e;
  } finally {
    client.release();
  }
  pool.end();
};
MAIN().catch(e => { console.error(e.message); process.exit(1); });
