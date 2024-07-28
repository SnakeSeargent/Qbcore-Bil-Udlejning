# 🚗 Køretøjsudlejnings NPC Script til QBCore

Velkommen til **Køretøjsudlejnings NPC Scriptet** til QBCore! Dette script giver spillere mulighed for at leje køretøjer via en NPC placeret på kortet. Du kan tilpasse NPC'ens koordinater, køretøjets spawn lokationer, lejepriser og tilgængelige køretøjer i `config.lua` filen. Derudover kan spillere få penge tilbage, når de afleverer det lejede køretøj, og mængden kan justeres i `Server/main.lua` filen.

## ✨ Funktioner

- **Køretøjsudlejning via NPC**: Lej køretøjer direkte fra en NPC på kortet.
- **Fuldstændig konfigurerbar**:
  - Ændr NPC'ens koordinater/placering.
  - Indstil køretøjets spawn koordinater.
  - Juster lejepriserne.
  - Tilpas hvilke køretøjer der er tilgængelige for leje.
- **Refunderingssystem**: Spillere kan få penge tilbage, når de afleverer det lejede køretøj. Refunderingsbeløbet kan justeres i scriptet.
- **QBCore kompatibilitet**: Bygget specifikt til QBCore, ved brug af qbcore target.

## 🔧 Konfiguration

### config.lua

- **NPC Model**: Definer NPC'ens model.
- **NPC Placering**: Indstil NPC'ens placering på kortet.
- **NPC Heading**: Angiv NPC'ens retning.
- **Tilgængelige Køretøjer**: List og ændr hvilke køretøjer der kan lejes.
- **Køretøjets Spawn Placering**: Definer hvor det lejede køretøj vil dukke op.
- **Køretøjets Heading**: Angiv køretøjets retning.
- **Lejepris**: Juster omkostningerne for at leje hvert køretøj.
- **Blip Indstillinger**: Tilpas blip-indstillingerne for kortmarkeringen.

```lua
Config = {}

Config.NPCModel = 'a_m_y_beach_01'
Config.NPCLocation = vector3(4983.50, -5144.27, 2.53)
Config.NPCHeading = 187.68

Config.Vehicles = {
    {label = 'Dune Buggy', model = 'dune'},
    {label = 'Blazer', model = 'blazer'},
    {label = 'Mesa', model = 'mesa'}
}

Config.VehicleSpawnLocation = vector3(4986.45, -5153.46, 2.45)
Config.VehicleHeading = 199.87

Config.RentalCost = 2500

-- Blip Settings
Config.Blip = {
    Sprite = 225, -- Bil ikon
    Color = 3, -- Blå farve
    Scale = 0.8,
    Label = "Køretøjsudlejning"
}



📜 Licens
Dette projekt er licenseret under MIT-licensen. Se LICENSE-filen for detaljer.
