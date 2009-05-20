use strict;
use warnings;
use Text::Phonetic::VideoGame;
use Test::More;
use List::MoreUtils qw( uniq );

my @tests = (
    [
        q{Ninja Gaiden 3},
        q{Ninja Gaiden III},
        q{Ninja Gaiden III Ancient Ship of Doom},
    ],
    [
        q{Hot Wheels World Race},
        q{Hotwheels world race},
    ],
    [
        q{Clay Fighter Tournament Edition},
        q{clayfighter tournament},
    ],
    [
        q{Clay Fighter},
        q{ClayFighter},
    ],
    [
        q{Allstar Baseball 2001},
        q{all star baseball 2001},
        q{all-star baseball '01},
        q{all-star baseball 01},
        q{all-star baseball 2001},
        q{allstar baseball '01},
        q{allstar baseball 01},
    ],
    [
        q{Backyard Football 09},
        q{Backyard Football 2009},
    ],
    [
        q{Baldur's Gate Dark Alliance 2},
        q{dark alliance 2},
    ],
    [
        q{Madden 06},
        q{Madden 2006},
        q{madden '06},
        q{madden nfl 06},
        q{madden nfl 2006},
    ],
    [
        q{Panic on Funkotron},
        q{ToeJam and Earl in Panic on Funkotron},
    ],
    [
        q{Pirates of the Caribbean At World's End},
        q{Pirates of the Caribbean: At World's End},
        q{Pirates of the Caribbean: At Worlds End},
    ],
    [
        q{Brothers in Arms Road to Hill},
        q{Brothers in Arms Road to Hill 30},
        q{Brothers in Arms: Road to Hill 30},
    ],
    [
        q{Bart's Nightmare},
        q{Barts Nightmare},
        q{The Simpsons Bart's Nightmare},
    ],
    [
        q{The Hulk},
        q{hulk},
    ],
    [
        q{Diddy Kong Racing DS},
        q{diddy kong ds},
    ],
    [
        q{Magna Carta Tears of Blood},
        q{magna carta},
    ],
    [
        q{Castlevania Dawn of Sorrow},
        q{castlevania: dawn of sorrow},
        q{dawn of sorrow},
    ],
    [
        q{Metroid Prime 3},
        q{Metroid Prime 3 Corruption},
    ],
    [
        q{Rugrats Scavenger Hunt},
        q{scavenger hunt},
    ],
    [
        q{Chip & Dale 2},
        q{Chip and Dale Rescue Rangers 2},
    ],
    [
        q{Mario Kart DS},
        q{mariokart ds},
    ],
    [
        q{Spiderman Battle for New York},
        q{spider-man battle},
        q{spiderman battle},
    ],
    [
        q{Wii Fit},
        q{wiifit},
    ],
    [
        q{'new' super mario},
        q{New Super Mario Bros},
        q{New Super Mario Brothers},
        q{new super mario},
        q{super mario ds},
    ],
    [
        q{Wario World},
        q{warioworld},
    ],
    [
        q{Waverace Blue Storm},
        q{wave race blue storm},
        q{waverace - blue},
    ],
    [
        q{Journey to Jaburo},
        q{Mobile Suit Gundam Journey to Jaburo},
    ],
    [
        q{Sega Smash Pack},
        q{Sega Smashpack},
    ],
    [
        q{Star Wars Flight of Falcon},
        q{flight of the falcon},
    ],
    [
        q{Mega Man X6},
        q{Megaman X6},
    ],
    [
        q{Final Fantasy VII},
        q{final fantasy 7},
    ],
    [
        q{New York Times Crosswords},
        q{ny times crossword},
    ],
    [
        q{Fzero GX F Zero},
        q{f zero gx},
        q{f-zero gx},
        q{fzero gx},
        q{zero gx},
    ],
    [
        q{Trauma Center Under the Knife},
        q{Under the Knife },
    ],
    [
        q{Blinx Time Sweeper},
        q{blinx the time sweeper},
        q{blinx: time sweeper},
    ],
    [
        q{Dungeons and Dragons Warriors of the Eternal Sun},
        q{Warriors of the Eternal Sun },
    ],
    [
        q{King's Field},
        q{kings field},
    ],
    [
        q{Mr. Driller 2},
        q{mr driller 2},
    ],
    [
        q{Starfox Adventures},
        q{star fox adventures},
    ],
    [
        q{Starfox 64},
        q{star fox 64},
    ],
    [
        q{Pacman World 2},
        q{pac man world 2},
        q{pac-man world 2},
    ],
    [
        q{WWE Wrestlemania XIX 19},
        q{Wrestlemania 19},
        q{Wrestlemania xix},
    ],
    [
        q{McDonald Treasure Adventure},
        q{McDonald's Treasure Adventure},
        q{McDonald's Treasureland Adventure},
        q{McDonalds Treasure Adventure},
    ],
    [
        q{Medal of Honor - Infiltrator},
        q{Medal of Honor Infiltrator},
        q{Medal of Honor: Infiltrator },
    ],
    [
        q{Final Fantasy 1 and 2 Dawn of Souls},
        q{dawn of souls},
        q{final fantasy 1 & 2},
        q{final fantasy 1 and 2},
        q{final fantasy I & II},
        q{final fantasy I and II},
    ],
    [
        q{Suikoden 3},
        q{suikoden iii},
    ],
    [
        q{Tiger Woods 2004},
        q{pga 2004},
        q{tiger woods golf 2004},
        q{tiger woods pga 2004},
        q{tigerwoods 2004},
    ],
    [
        q{Lord of the Rings - Two Towers},
        q{Lord of the Rings Two Towers},
        q{Lord of the Rings the Two Towers},
        q{Lord of the Rings: The Two Towers},
        q{Lord of the Rings: Two Towers},
        q{two towers},
    ],
    [
        q{Tom and Jerry},
        q{tom & jerry},
    ],
    [
        q{Elmo's Number Journey},
        q{number journey},
    ],
    [
        q{Bassmasters 2000},
        q{bass master},
        q{bassmaster},
        q{bassmasters},
    ],
    [
        q{Toy Story 2},
        q{toystory 2},
    ],
    [
        q{FF Anthology},
        q{Final Fantasy Anthology},
    ],
    [
        q{Black Nintendo DS Lite},
        q{black ds lite},
    ],
    [
        q{Dragon Ball Z Taiketsu},
        q{Taiketsu},
    ],
    [
        q{Milo's Bowling},
        q{astro bowling},
        q{astro lanes},
    ],
    [
        q{Comix Zone},
        q{comic zone},
    ],
    [
        q{Eve of Destruction},
        q{Test Drive Eve of Destruction},
    ],
    [
        q{Bruce Lee Quest of the Dragon},
        q{quest of the dragon},
    ],
    [
        q{Tiger Woods 2003},
        q{pga 2003},
        q{tiger woods pga 2003},
        q{tigerwoods 2003},
    ],
    [
        q{Aladdin},
        q{aladin},
        q{alladin},
        q{disney aladdin},
        q{disney's alladdin},
    ],
    [
        q{SSX Tricky},
        q{ssx-tricky},
    ],
    [
        q{Chain of Memories},
        q{Kingdom Hearts Chain of Memories},
        q{kingdom hearts: chain of memories},
    ],
    [
        q{Castlevania Circle of the Moon},
        q{circle of the moon},
    ],
    [
        q{Tiger Woods 2006},
        q{tiger woods 06},
        q{tiger woods pga 2006},
        q{tiger woods pga tour 06},
        q{tiger woods pga tour 2006},
    ],
    [
        q{Red Card Soccer 2003},
        q{red card 2003},
    ],
    [
        q{Mario's Early Years Fun with Letters},
        q{fun with letters},
    ],
    [
        q{Mortal Combat 2},
        q{Mortal Combat II},
        q{Mortal Kombat 2},
        q{Mortal Kombat II},
    ],
    [
        q{Zelda 4 Game Collection},
        q{Zelda Collector Edition},
        q{Zelda Collectors Edition},
        q{zelda collection},
        q{zelda collector's edition},
        q{zelda four game collection},
    ],
    [
        q{MechAssault},
        q{mech assault},
    ],
    [
        q{Goblet of Fire},
        q{Harry Potter Goblet of Fire},
    ],
    [
        q{Yoshi's Story},
        q{yoshi story},
        q{yoshies story},
        q{yoshis story},
    ],
    [
        q{Riviera The Promised Land},
        q{riviera},
    ],
    [
        q{Grand Theft Auto Vice City},
        q{gta vice city},
        q{vice city},
    ],
    [
        q{Samurai Jack Shadow of Aku},
        q{Shadow of Aku},
    ],
    [
        q{Dance Dance Revolution Ultramix 3},
        q{Ultra mix 3},
        q{Ultramix 3},
    ],
    [
        q{Kameo},
        q{Kameo Elements of Power},
    ],
    [
        q{Clash of Super Heroes},
        q{Marvel vs. Capcom Clash of Super Heroes},
    ],
    [
        q{Kirby Crystal Shards},
        q{crystal shard},
        q{kirby},
    ],
    [
        q{Quad Desert Fury},
        q{quad desert},
    ],
    [
        q{Phantom Hourglass},
        q{Zelda Phantom Hourglass},
        q{zelda: Phantom Hourglass},
    ],
    [
        q{NBA Street V3},
        q{NBA Street Vol 3},
    ],
    [
        q{Gauntlet Dark Legacy},
        q{dark legacy},
        q{gauntlet dark},
    ],
    [
        q{Hot Wheels Stunt Track Driver},
        q{Hotwheels stunt track driver},
    ],
    [
        q{Star Wars Starfighter},
        q{starfighter},
    ],
    [
        q{Final Fantasy III},
        q{final fantasy 3},
    ],
    [
        q{Ball Banana Blitz},
        q{Super Monkey Ball Banana Blitz},
    ],
    [
        q{Banjo-Kazooie},
        q{banjo kazooie},
        q{kazoie},
        q{kazooie},
    ],
    [
        q{SUPER BATTLE TANK 2},
        q{Super Battletank 2},
    ],
    [
        q{Abe's Oddysee },
        q{Oddworld Abes Oddysee},
    ],
    [
        q{Halo 3 LE},
        q{Halo 3 Limited},
        q{Halo 3 Limited Edition},
    ],
    [
        q{Castlevania 2 Belmont},
        q{Castlevania II Belmont},
        q{Castlevania II Belmont's Revenge},
    ],
    [
        q{Waialae Country Club},
        q{waialae},
    ],
    [
        q{Kirby Air Ride},
        q{Kirby Airride},
    ],
    [
        q{F-1 Grand Prix},
        q{grand prix},
    ],
    [
        q{Aztec Adventure},
        q{Speedy Gonzales Aztec Adventure},
    ],
    [
        q{Masters of Teras Kasi},
        q{Star Wars Masters of Teras Kasi},
        q{star wars masters},
    ],
    [
        q{Grand Theft Auto San Andreas},
        q{SanAndreas},
        q{gta 5},
        q{san andreas},
    ],
    [
        q{Genji Dawn of the Samurai},
        q{genji},
    ],
    [
        q{Guitar Hero 3},
        q{Guitar Hero III Legends of Rock},
        q{Guitar Hero iii},
    ],
    [
        q{102 Dalmatians},
        q{102 Dalmatians Puppies to the Rescue},
    ],
    [
        q{Inuyasha Secret of the Cursed Mask},
        q{Secret of the Cursed Mask},
    ],
    [
        q{Genesis game console},
        q{Genesis game system},
        q{Genesis video game console},
        q{Genesis video game system},
        q{Sega Genesis 1 System},
        q{Sega Genesis 1 console},
        q{Sega Genesis Console},
        q{genesis console},
        q{genesis system},
    ],
    [
        q{Burger Time Deluxe},
        q{BurgerTime Deluxe},
    ],
    [
        q{Clubhouse Games},
        q{club house games},
    ],
    [
        q{6-PAK},
        q{6-pack},
        q{Genesis 6-Pak},
        q{sega 6 pack},
    ],
    [
        q{Los Gatos Bandidos},
        q{Speedy Gonzales Los Gatos Bandidos},
    ],
    [
        q{Dance Dance Revolution Max 2},
        q{ddr max 2},
        q{ddrm 2},
    ],
    [
        q{Grand Theft Auto Collector's},
        q{Grand Theft Auto Collectors},
        q{Grand Theft Auto Collectors Edition},
    ],
    [
        q{Blitz 2001 Football},
        q{blitz '01},
        q{blitz 01},
        q{blitz 2001},
    ],
    [
        q{Pokemon Leaf Green},
        q{Pokemon LeafGreen Version},
    ],
    [
        q{Tom and Jerry In House Trap},
        q{tom & jerry in house trap},
    ],
    [
        q{Scooby Doo The Movie},
        q{Scooby-Doo The Movie},
    ],
    [
        q{Spiderman},
        q{spider man},
        q{spider-man},
    ],
    [
        q{Tomb Raider 3},
        q{Tomb Raider III},
    ],
    [
        q{Eternal Duelist Soul},
        q{Yu-Gi-Oh Eternal Duelist Soul},
    ],
    [
        q{Final Fantasy VI Advance},
        q{final fantasy 6},
        q{final fantasy vi},
    ],
    [
        q{Mario and Luigi Superstar Saga},
        q{Superstar Saga},
        q{super saga},
    ],
    [
        q{Half-Life 2},
        q{half life 2},
    ],
    [
        q{Mr. Do!},
        q{mr do},
        q{mr. do},
    ],
    [
        q{Ninja Gaiden 2},
        q{Ninja Gaiden II},
        q{Ninja Gaiden II The Dark Sword of Chaos},
    ],
    [
        q{Lord of the Rings - Third Age},
        q{Lord of the Rings Third Age},
        q{Lord of the Rings: The Third Age},
        q{Lord of the Rings: Third Age},
        q{Third Age},
    ],
    [
        q{Project Gotham Racing},
        q{gotham racing},
        q{gothom racing},
        q{project gotham},
        q{project gothem racing},
    ],
    [
        q{Tamagotchi 2},
        q{Tamagotchi Connection Corner Shop 2},
        q{tamagotchi corner 2},
    ],
    [
        q{Power Rangers Lightspeed Rescue},
        q{ligh speed rescue},
        q{lightspeed rescue},
    ],
    [
        q{BrainDead 13},
        q{brain dead 13},
    ],
    [
        q{Break Thru},
        q{BreakThru},
    ],
    [
        q{Amped Snowboarding 2},
        q{amped 2},
        q{amped ii},
    ],
    [
        q{LEGEND OF THE SEVEN STARS},
        q{Super Mario RPG},
        q{mario rpg},
    ],
    [
        q{Breath of Fire IV},
        q{breath of fire 4},
        q{breathe of fire 4},
        q{breathe of fire iv},
    ],
    [
        q{Cruis'n USA},
        q{Cruisn' USA},
        q{cruisin usa},
        q{cruisn usa},
        q{crusin u.s.a.},
        q{crusin usa},
    ],
    [
        q{Nightfire},
        q{night fire},
    ],
    [
        q{Star Wars Bounty Hunter},
        q{Star Wars: Bounty Hunter},
        q{bounty hunter},
    ],
    [
        q{PS2 game system},
        q{Playstation 2 System},
        q{playstation 2 console},
        q{playstation 2 unit},
        q{playstation2 console},
        q{playstation2 system},
        q{ps2 console},
        q{ps2 system},
        q{ps2 unit},
    ],
    [
        q{Airborne Commando},
        q{Spec Ops Airborne Commando},
    ],
    [
        q{Time Shift},
        q{TimeShift},
    ],
    [
        q{Ratchet Deadlock},
        q{Ratchet Deadlocked},
        q{Ratchet: Deadlock},
        q{ratchet: deadlocked},
    ],
    [
        q{Disney Sport Snowboarding },
        q{Disney Sports Snowboarding},
        q{Disney's Sports Snowboarding },
    ],
    [
        q{Return to Castle Wolfenstein},
        q{wolfenstein},
        q{wolfenstien},
    ],
    [
        q{Final Fantasy Mystic Quest},
        q{Final Fantasy: Mystic Quest },
        q{Mystic Quest},
    ],
    [
        q{Tetris & Dr Mario},
        q{Tetris & Dr. Mario},
        q{Tetris and Dr Mario },
        q{Tetris and Dr. Mario},
    ],
    [
        q{Dance Dance Revolution Ultramix 2},
        q{Ultra mix 2},
        q{Ultramix 2},
        q{ddr ultramix 2},
    ],
    [
        q{Scarface the World is Yours},
        q{scarface},
    ],
    [
        q{Civil War The Game Great Battles},
        q{History Channel Civil War The Game Great Battles},
    ],
    [
        q{Gauntlet Seven Sorrows},
        q{seven sorrows},
    ],
    [
        q{Asteroids Hyper},
        q{asteroids 64},
    ],
    [
        q{Madden 2007},
        q{madden '07},
        q{madden 07},
        q{madden nfl 07},
        q{madden nfl 2007},
    ],
    [
        q{WWF Smackdown Know Your Role},
        q{know your role},
    ],
    [
        q{ATV Offroad Fury},
        q{atv off road},
        q{offroad fury},
    ],
    [
        q{Half-Life},
        q{half life},
    ],
    [
        q{Harry Potter Prisoner of Azkaban},
        q{Prisoner of Askaban},
        q{Prisoner of Azkaban},
    ],
    [
        q{Bomberman Hero},
        q{bomber man hero},
    ],
    [
        q{Mario Kart Wii},
        q{mariokart wii},
        q{mariokartwii},
        q{wii mario kart},
    ],
    [
        q{Rocket Power Team Rocket Rescue},
        q{Team Rocket Rescue},
    ],
    [
        q{Fantastic 4},
        q{Fantastic Four},
    ],
    [
        q{WWE Smackdown Here Comes the Pain},
        q{here comes the pain},
    ],
    [
        q{NES System},
        q{NES game console},
        q{Nintendo Entertainment System},
        q{Nintendo NES Console},
        q{Original Nintendo NES System},
        q{Original Nintendo System},
        q{classic nes system},
        q{classic nintendo system},
        q{nes console},
        q{nes game system},
        q{nintendo game console},
        q{nintendo game system},
    ],
    [
        q{Donkey Kong Country 2},
        q{Donkey Kong Kountry 2},
    ],
    [
        q{Super Mario Bros & Duck Hunt & World Class Track Meet},
        q{Super Mario Bros Duck Hunt World Class Track Meet},
        q{Super Mario Bros and Duck Hunt and World Class Track Meet},
    ],
    [
        q{Teenage Mutant Ninja Turtles III The Manhattan Project},
        q{Teenage Mutant Ninja Turtles III manhattan project},
        q{Teenage Mutant Ninja Turtles manhattan},
    ],
    [
        q{Unreal Championship 2},
        q{unreal 2},
    ],
    [
        q{Final Fantasy Crystal Chronicles},
        q{crystal chronicles},
    ],
    [
        q{Blitz the League},
        q{Blitz: The League},
    ],
    [
        q{Roger Rabbit},
        q{Who Framed Roger Rabbit},
    ],
    [
        q{Brothers in Arms Earned in Blood},
        q{Brothers in Arms: Earned in Blood},
    ],
    [
        q{Roller Coaster Tycoon},
        q{Rollercoaster Tycoon},
    ],
    [
        q{Extreme G 3 XG3},
        q{xg3},
    ],
    [
        q{Super Cross 2000},
        q{super cross '00},
        q{super cross 00},
        q{supercross '00},
        q{supercross 00},
        q{supercross 2000},
    ],
    [
        q{King of Fighters EX NeoBlood},
        q{neoblood},
    ],
    [
        q{Budokai Tenkaichi 3},
        q{Dragon Ball Z Budokai Tenkaichi 3},
        q{Tenkaichi 3},
    ],
    [
        q{Jedi Knight Academy },
        q{Star Wars Jedi Knight Academy},
    ],
    [
        q{Super Smash Brawl},
        q{Super Smash Bros Brawl},
        q{Super Smash Bros. Brawl},
        q{Super Smash Brothers Brawl},
        q{SuperSmash Bros Brawl},
    ],
    [
        q{Tiger Woods 2007},
        q{tiger woods 07},
        q{tiger woods pga 2007},
        q{tiger woods pga tour 07},
        q{tiger woods pga tour 2007},
    ],
    [
        q{DDS 2},
        q{Digital Devil Saga 2},
    ],
    [
        q{Harvest Moon - Save the Homeland},
        q{Harvest Moon Save the Homeland},
        q{Harvest Moon: Save the Homeland},
    ],
    [
        q{Project Snowblind},
        q{project snow blind},
    ],
    [
        q{Star Wars Rebel Strike},
        q{rebel strike},
    ],
    [
        q{Hot Wheels Stunt Track Challenge},
        q{Hotwheels stunt track challenge},
    ],
    [
        q{San Francisco Rush},
        q{rush extreme racing},
    ],
    [
        q{Def Jam Fight for New York},
        q{Fight for New York},
        q{fight for ny},
    ],
    [
        q{Astro Boy Omega Factor},
        q{astroboy omega factor},
    ],
    [
        q{Ms Pac Man},
        q{Ms. Pac Man},
        q{Ms. Pacman},
        q{ms pac-man},
        q{ms pacman},
        q{ms. pac-man},
    ],
    [
        q{Magical Starsign},
        q{magical star sign},
    ],
    [
        q{Earthbound},
        q{earth bound},
    ],
    [
        q{.hack Mutation},
        q{Mutation},
        q{dot hack mutation},
    ],
    [
        q{Diddy Kong Racing},
        q{diddy kong},
    ],
    [
        q{World Cup 98},
        q{world cup '98},
        q{world cup 1998},
    ],
    [
        q{Mario's Early Years Fun With Numbers},
        q{fun with numbers},
    ],
    [
        q{Pacman World 3},
        q{pac man world 3},
        q{pac-man world 3},
    ],
    [
        q{Fear Effect 2},
        q{Fear Effect 2 Retro Helix},
        q{Fear Effect ii},
    ],
    [
        q{Torino 2006},
        q{torino 06},
    ],
    [
        q{Kane & Lynch},
        q{Kane and Lynch},
        q{Kane and Lynch Dead Men},
    ],
    [
        q{Turok Evolution},
        q{turok: evolution},
    ],
    [
        q{Marvel Ultimate Alliance},
        q{Ultimate Alliance},
    ],
    [
        q{JoJo Bizarre Adventure},
        q{Jojo's Bizarre Adventure},
    ],
    [
        q{Metal Gear Solid 2},
        q{metal gear 2},
    ],
    [
        q{Star Wars Battlefront},
        q{Star wars Battle front},
        q{battlefront},
        q{star wars: battlefront},
    ],
    [
        q{CSI Miami Nights},
        q{Miami Nights},
    ],
    [
        q{Mega Man},
        q{megaman},
    ],
    [
        q{Contra 4},
        q{contra iv},
    ],
    [
        q{Master of Disguise},
        q{Wario Master of Disguise},
    ],
    [
        q{Sports Illustrated For Kids Baseball},
        q{Sports Illustrated baseball},
    ],
    [
        q{DinoThunder},
        q{Power Rangers Dino Thunder},
        q{dino thunder},
    ],
    [
        q{Ape Escape 2},
        q{ape escape ii},
    ],
    [
        q{FIFA 2002 Soccer},
        q{fifa soccer 2002},
    ],
    [
        q{Need for Speed Pro Street},
        q{Need for Speed Prostreet},
        q{Need for Speed: Prostreet },
    ],
    [
        q{Gex 3: Deep Cover Gecko},
        q{deep cover},
        q{gex 3},
    ],
    [
        q{Xbox System},
        q{x box console},
        q{x box system},
        q{x box unit},
        q{xbox console},
        q{xbox game console},
        q{xbox game system},
        q{xbox unit},
    ],
    [
        q{Conker Live and Reloaded},
        q{conker live},
        q{conker: live},
    ],
    [
        q{Dance Dance Revolution Mario Mix},
        q{ddr mario mix},
    ],
    [
        q{Super Mario Advance},
        q{mario advance},
    ],
    [
        q{Medabots AX Metabee Version},
        q{Metabee},
    ],
    [
        q{FIFA 2008},
        q{fifa 08},
    ],
    [
        q{Yoshi's Island DS},
        q{yoshis island ds},
    ],
    [
        q{Agent Under Fire},
        q{agent underfire},
    ],
    [
        q{Crash Nitro Cart},
        q{crash nitro kart},
        q{crash nitro-cart},
        q{crash nitro-kart},
    ],
    [
        q{Automobili},
        q{Automobili Lamborghini},
        q{Automobili Lambourghini},
    ],
    [
        q{Coral Pink Nintendo DS Lite},
        q{pink ds lite},
    ],
    [
        q{Buffy Vampire Slayer},
        q{buffy},
    ],
    [
        q{Stuntman},
        q{stunt man},
    ],
    [
        q{Jet Force Gemini},
        q{jet force},
    ],
    [
        q{Bart vs the Juggernauts },
        q{Bart vs. the Juggernauts},
    ],
    [
        q{Nintendo 64 system},
        q{n64 console},
        q{n64 unit},
        q{nintendo 64},
        q{nintendo 64 console},
        q{nintendo 64 unit},
    ],
    [
        q{Castlevania 2 Simon's Quest},
        q{Castlevania 2 Simons Quest},
        q{Castlevania II Simon's Quest},
        q{Simons Quest},
        q{castlevania 2},
        q{castlevania II},
        q{simon's quest},
    ],
    [
        q{Virtual-On},
        q{Virtual-On Oratorio Tangram},
    ],
    [
        q{Fuzion Frenzy},
        q{fusion frenzy},
    ],
    [
        q{Castlevania Curse of Darkness},
        q{Castlevania Curse of the Darkness},
        q{Curse of the Darkness},
    ],
    [
        q{Cybeast Falzar},
        q{Mega Man Battle Network 6 Cybeast Falzar},
    ],
    [
        q{Explorers of Time},
        q{Pokemon Mystery Dungeon Explorers of Time},
    ],
    [
        q{Super Empire Strikes Back},
        q{Super Star Wars Empire Strikes Back},
    ],
    [
        q{King of Fighters EX2 Howling Blood},
        q{howling blood},
    ],
    [
        q{Sacred Cards},
        q{Yu-Gi-Oh Sacred Cards},
    ],
    [
        q{Jurassic Park III Island Attack},
        q{Jurassic Park Island Attack},
    ],
    [
        q{Mario Kart 64},
        q{mario cart},
        q{mario kart},
        q{mariokart 64},
        q{mariokart64},
    ],
    [
        q{The Great Beanstalk},
        q{Tiny Toon Adventures The Great Beanstalk},
    ],
    [
        q{Civil War A Nation Divided},
        q{History Channel Civil War A Nation Divided},
    ],
    [
        q{NINTENDO DS GAME SYSTEM},
        q{Platinum DS System},
        q{blue ds},
        q{ds system},
        q{nintendo ds system},
        q{platinum ds},
        q{red ds},
        q{silver ds},
    ],
    [
        q{Elder Scrolls 4 Oblivion},
        q{Elder Scrolls 4: Oblivion},
        q{Elder Scrolls IV Oblivion},
        q{Elder Scrolls IV: Oblivion},
    ],
    [
        q{Mario's Early Years Preschool Fun},
        q{preschool fun},
    ],
    [
        q{Rocket Power Dream Scheme},
        q{dream scheme},
    ],
    [
        q{Forbidden Memories},
        q{Yu-Gi-Oh Forbidden Memories},
    ],
    [
        q{Zelda Four Swords Adventure},
        q{four swords},
    ],
    [
        q{Sly 3},
        q{Sly 3 Honor Among Thieves},
        q{Sly3},
    ],
    [
        q{Chip & Dale},
        q{Chip and Dale Rescue Rangers},
    ],
    [
        q{Michael Jackson Moonwalker},
        q{Michael Jackson's Moonwalker},
        q{moonwalker},
    ],
    [
        q{Mortal Kombat Deadly Alliance},
        q{deadly alliance},
    ],
    [
        q{Shadow Gate},
        q{Shadowgate},
    ],
    [
        q{Charlie and the Chocolate Factory},
        q{chocolate factory},
    ],
    [
        q{Battle Arena Toshinden 2},
        q{Toshinden 2},
    ],
    [
        q{Brain Age},
        q{Brainage},
    ],
    [
        q{Blitz 2003 Football},
        q{blitz 2003},
    ],
    [
        q{Midnight Club 3 Dub Edition},
        q{midnight club 3},
    ],
    [
        q{FIFA 64 Soccer},
        q{fifa 64},
        q{fifa soccer 64},
    ],
    [
        q{Elmo's Letter Adventure},
        q{letter adventure},
    ],
    [
        q{Hot Wheels Velocity X},
        q{Hotwheels Velocity X},
    ],
    [
        q{Fighters Destiny 2},
        q{fighter's destiny 2},
    ],
    [
        q{After Burner II},
        q{After burner 2},
        q{Afterburner 2},
        q{Afterburner ii},
    ],
    [
        q{Ed Edd N Eddy Jawbreakers},
        q{eddy jawbreakers},
        q{eddy: jawbreakers},
    ],
    [
        q{Battle for the pacific},
        q{History Channel Battle For the Pacific},
    ],
    [
        q{Elder Scrolls 3 III Morrowind},
        q{elder scrolls 3},
        q{morrowind},
    ],
    [
        q{Munch's Oddysee},
        q{Munch's Odysee },
        q{Oddworld Munch's Oddysee},
    ],
    [
        q{Need for Speed Porsche Unleashed},
        q{Need for Speed: Porsche Unleashed},
    ],
    [
        q{Wario Ware Mega Microgames},
        q{wario ware},
        q{warioware},
    ],
    [
        q{Attack of the Twonkies},
        q{Jimmy Neutron Attack of the Twonkies},
    ],
    [
        q{Inuyasha Secret of the Divine Jewel},
        q{Secret of the Divine Jewel},
    ],
    [
        q{Leisure Suit Larry Magna C** Laude},
        q{leisure suit larry},
        q{leisure suit larry magna},
        q{magna cum laude},
    ],
    [
        q{Star Wars Shadow of Empire},
        q{shadow of empire},
        q{shadow of the empire},
        q{shadows of the empire},
    ],
    [
        q{Marvel Super Heroes in War of the Gems},
        q{war of the gems},
    ],
    [
        q{The Sims 2 Apartment Pets},
        q{sims 2 apartment},
    ],
    [
        q{Final Fantasy XII Collector's Edition},
        q{final fantasy 12 collector},
    ],
    [
        q{Family Game Night},
        q{Family Party 30 Great Games},
    ],
    [
        q{Hot Wheels Beat That},
        q{Hotwheels bear that},
    ],
    [
        q{Rampage 2 Universal Tour},
        q{universal tour},
    ],
    [
        q{Super Mario Sunshine},
        q{mario sunshine},
    ],
    [
        q{Ty the Tasmanian Tiger 2 Bush Rescue},
        q{ty 2},
        q{ty: tasmanian tiger 2},
    ],
    [
        q{NBA Hangtime},
        q{hang time},
        q{hangtime},
    ],
    [
        q{Blue Moon},
        q{Mega Man Battle Network 4},
        q{Mega Man Battle Network 4 Blue Moon},
    ],
    [
        q{Teenage Mutant Ninja Turtles 2 Back from the Sewers},
        q{Teenage Mutant Ninja Turtles Back from the Sewers},
        q{Teenage Mutant Ninja Turtles II Back from the Sewers},
    ],
    [
        q{ATV Quad Power Racing 2},
        q{atv 2 quad},
    ],
    [
        q{NASCAR 2007},
        q{nascar 07},
    ],
    [
        q{The Ren and Stimpy Show Fire Dogs},
        q{ren & stimpy Fire Dogs},
        q{ren and stimpy Fire Dogs},
    ],
    [
        q{White Nintendo DS Lite},
        q{ds lite console},
        q{ds lite system},
        q{nintendo ds lite},
        q{white ds lite},
    ],
    [
        q{Phoenix Wright Trials and Tribulations},
        q{Trials & Tribulations},
        q{Trials and Tribulations},
    ],
    [
        q{SOCOM US Navy Seals},
        q{socom},
    ],
    [
        q{Boktai 2 Solar Boy Django},
        q{boktai 2},
    ],
    [
        q{Black GameCube System},
        q{black console},
        q{black gamecube},
        q{black system},
        q{game cube console},
        q{game cube system},
        q{gamecube black},
        q{gamecube console},
        q{gamecube indigo},
        q{gamecube platinum},
        q{gamecube system},
        q{gamecube unit},
        q{indigo gamecube},
        q{jet gamecube},
        q{jet system},
        q{jet unit},
        q{platinum gamecube},
        q{purple gamecube},
    ],
    [
        q{Metriod Fusion},
        q{Metroid Fusion},
    ],
    [
        q{NEED FOR SPEED UNDER GROUND},
        q{Need for Speed - Underground },
        q{Need for Speed Underground},
        q{need for speed: underground},
    ],
    [
        q{Jak 3},
        q{jak iii},
        q{jax 3},
    ],
    [
        q{Sonic Classics 3 In 1},
        q{sonic classics},
    ],
    [
        q{Mary-Kate and Ashley Magical Mystery Mall},
        q{mystery mall},
    ],
    [
        q{The Urbz Sims in the City},
        q{urbz},
    ],
    [
        q{Soduku Fever},
        q{Sudoku Fever},
    ],
    [
        q{Commandos 2 Men of Courage},
        q{commandos 2},
    ],
    [
        q{Hitman Contracts},
        q{Hitman: Contracts },
    ],
    [
        q{Cel Damage},
        q{cell damage},
    ],
    [
        q{Crash Bandicoot Wrath Cortex},
        q{wrath of cortex},
        q{wrath of the cortex},
    ],
    [
        q{P.N. 03},
        q{p.n.03},
    ],
    [
        q{Resident Evil Zero},
        q{resident evil 0},
        q{resident evil: zero},
    ],
    [
        q{Simpsons Road Rage},
        q{road rage},
    ],
    [
        q{Cruis'n Velocity},
        q{Cruisn Velocity},
        q{Cruisn' Velocity},
    ],
    [
        q{Battle for Bikini Bottom},
        q{Sponge Bob Square Pants Bikini Bottom},
        q{Sponge Bob SquarePants bikini},
        q{SpongeBob Square Pants bikini},
        q{SpongeBob SquarePants bikini},
    ],
    [
        q{Excitebike},
        q{excite bike},
    ],
    [
        q{Jeremy McGrath Supercross},
        q{jeremy mcgrath},
        q{mcgrath},
    ],
    [
        q{Season Flame},
        q{Season of Flame},
        q{Spyro Season of Flame},
    ],
    [
        q{Punch-Out},
        q{punch out},
        q{punchout},
    ],
    [
        q{Duke Nukem Zero Hour},
        q{zero hour},
    ],
    [
        q{Crush Course},
        q{Mary-Kate and Ashley Crush Course},
    ],
    [
        q{MechAssault 2 Lone Wolf},
        q{mechassault 2},
    ],
    [
        q{Dead or Alive Beach Volleyball},
        q{Xtreme Beach Volleyball},
        q{dead or alive extreme},
        q{doa beach volleyball},
        q{doa volleyball},
    ],
    [
        q{Azurik Rise of Perathia},
        q{azurick},
        q{azurik},
    ],
    [
        q{2nd Runner},
        q{Zone of Enders 2nd Runner},
        q{zoe 2},
    ],
    [
        q{Spyro the Dragon},
        q{spyro: the dragon},
    ],
    [
        q{Ghosts 'n Goblins},
        q{Ghosts n' goblins},
    ],
    [
        q{House of the Dead 3},
        q{house of dead 3},
        q{house of the dead iii},
    ],
    [
        q{CSI Dark Motives},
        q{Dark Motives},
    ],
    [
        q{Double Dragon V The Shadow Falls},
        q{double dragon 5},
        q{double dragon v},
    ],
    [
        q{Dragon Ball Z Budokai 3},
        q{Z Budokai 3},
    ],
    [
        q{Amped Snowboarding},
        q{amped},
    ],
    [
        q{Foresaken 64},
        q{forsaken 64},
    ],
    [
        q{Call of Duty World at War},
        q{World at War},
    ],
    [
        q{Little Nemo The Dream Master},
        q{little nemo},
    ],
    [
        q{Shell Shock 67},
        q{Shell Shock Nam '67},
        q{shell shock nam},
        q{shell shock vietnam},
        q{shellshock nam},
        q{shellshock vietnam},
    ],
    [
        q{Day of Reckoning},
        q{WWE Day of Reckoning},
    ],
    [
        q{Mary Kate and Ashley Sweet 16},
        q{Sweet 16},
    ],
    [
        q{New Droid Army},
        q{Star Wars II New Droid Army},
    ],
    [
        q{Mega Man Battle Network 4 Red Sun},
        q{Red Sun},
    ],
    [
        q{Sword of Vermilion},
        q{Sword of Vermillion},
    ],
    [
        q{Final Fantasy Tactics},
        q{ff tactics},
    ],
    [
        q{EARTH WORM JIM 2},
        q{Earthworm Jim 2},
    ],
    [
        q{Final Fantasy Fables Chocobo Tales},
        q{chocobo tales},
    ],
    [
        q{Barbie Horse Adventures Blue Ribbon Race},
        q{blue ribbon race},
    ],
    [
        q{Pac-In-Time},
        q{pac in time},
    ],
    [
        q{Battle Arena Toshinden 3},
        q{Toshinden 3},
    ],
    [
        q{Monsters Inc Scream Team},
        q{Monsters Inc. Scream Team},
        q{Monsters, Inc Scream Team},
        q{Monsters, Inc. Scream Team},
    ],
    [
        q{A Bug's Life},
        q{Bug's Life},
        q{bugs life},
    ],
    [
        q{Final Fantasy II},
        q{final fantasy 2},
    ],
    [
        q{A Hero's Tail},
        q{A Hero's Tale},
        q{Spyro A Heros Tail},
        q{Spyro a Hero's Tail},
        q{Spyro: Hero's Tail},
        q{hero's tale},
        q{heros tale},
    ],
    [
        q{Motocross Maniacs Advance},
        q{Motorcross Maniacs},
    ],
    [
        q{Zack & Wiki},
        q{Zack and Wiki},
        q{Zack and Wiki Quest for Barbaros Treasure},
    ],
    [
        q{Hitman Blood Money},
        q{Hitman: Blood Money},
    ],
    [
        q{TMNT Tournament},
        q{Teenage Mutant Ninja Turtles Tournament Fighters},
    ],
    [
        q{Swords and Serpents},
        q{swords & serpents},
    ],
    [
        q{Street Fighter 2 Special},
        q{Street Fighter II Special},
        q{Street Fighter II Special Champion Edition},
    ],
    [
        q{Castlevania Lament of Innocence},
        q{lament of innocence},
    ],
    [
        q{Star Wars Obi Wan},
        q{Star Wars Obi-Wan},
        q{obi-wan},
        q{obiwan},
    ],
    [
        q{FIFA 2005},
        q{fifa 05},
        q{fifa soccer 2005},
    ],
    [
        q{Smart Ball},
        q{smartball},
    ],
    [
        q{NEED FOR SPEED UNDER GROUND 2},
        q{Need for Speed - Underground 2},
        q{Need for Speed Underground 2},
        q{Need for Speed Underground ii},
        q{need for speed: underground 2},
        q{speed underground 2},
    ],
    [
        q{Splinter Cell Double Agent},
        q{Splinter Cell: Double Agent},
    ],
    [
        q{X-men Legends 2},
        q{xmen legends 2},
    ],
    [
        q{Pandora Tomorrow},
        q{Splinter Cell Pandora Tomorrow},
    ],
    [
        q{Jak and Daxter},
        q{jax and daxter},
    ],
    [
        q{Moto GP},
        q{motogp},
    ],
    [
        q{Monsters Inc},
        q{Monsters, Inc},
    ],
    [
        q{Alien vs Predator Extinction},
        q{Alien vs. Predator Extinction},
        q{Aliens vs Predator Extinction},
        q{Aliens vs. Predator Extinction},
    ],
    [
        q{SUPER BATTLE TANK},
        q{Super Battletank},
    ],
    [
        q{Indiana Jones Infernal Machine},
        q{indiana jones},
    ],
    [
        q{FIFA World Cup 2006 Germany},
        q{world cup 2006},
    ],
    [
        q{Rampage Total Destruction},
        q{total destruction},
    ],
    [
        q{Vampire Night w/ Gun},
        q{vampire night},
    ],
    [
        q{Ty the Tasmanian Tiger 3},
        q{ty 3},
        q{ty: tasmanian tiger 3},
    ],
    [
        q{X-men Legends},
        q{xmen legends},
    ],
    [
        q{Kingdom Hearts 2},
        q{KingdomHearts 2},
        q{kingdom hearts ii},
    ],
    [
        q{Fzero GP Legend},
        q{f zero gp},
        q{f-zero gp},
        q{fzero gp},
    ],
    [
        q{Red Steel},
        q{Redsteel},
    ],
    [
        q{Star Wars Super Bombad Racing},
        q{Super Bombad Racing},
    ],
    [
        q{Revenge of the Sith},
        q{Star Wars Revenge of the Sith},
        q{star wars episode iii},
    ],
    [
        q{Evil Dead Fistful of Broomstick},
        q{evil dead},
    ],
    [
        q{Pacman Fever},
        q{pac-man fever},
    ],
    [
        q{Mayan Adventure},
        q{Pitfall The Mayan Adventure},
        q{The Mayan Adventure},
    ],
    [
        q{Tomb Raider Last Revelation},
        q{Tomb Raider The Last Revelation },
    ],
    [
        q{.hack Quarantine},
        q{Quarantine},
        q{dot hack quarantine},
    ],
    [
        q{American Sk8land},
        q{Tony Hawk American Skateland},
        q{american skateland},
    ],
    [
        q{Phoenix Wright - Ace Attorney},
        q{Phoenix Wright Ace Attorney},
        q{Phoenix Wright: Ace Attorney},
    ],
    [
        q{Super Mario Bros 2},
        q{super mario 2},
        q{super mario bros. 2},
        q{super mario brothers 2},
    ],
    [
        q{Pokemon Fire Red},
        q{pokemon firered},
    ],
    [
        q{Scooby Doo Monsters Unleashed},
        q{Scooby-Doo Monsters Unleashed},
    ],
    [
        q{Condemned 2},
        q{Condemned 2 Bloodshot},
    ],
    [
        q{Radioactive Man},
        q{Simpsons Bartman Meets Radioactive Man},
    ],
    [
        q{Saint's Row 2},
        q{Saints Row 2},
    ],
    [
        q{Mystery Dungeon Blue},
        q{Pokemon Mystery Dungeon Blue},
    ],
    [
        q{Final Fantasy 8},
        q{final fantasy viii},
    ],
    [
        q{Starsky & Hutch},
        q{Starsky and Hutch},
    ],
    [
        q{Jurassic Park DNA Factor},
        q{Jurassic Park III DNA Factor},
    ],
    [
        q{Star Tropics},
        q{startropics},
    ],
    [
        q{Boom Bots},
        q{Boombots},
    ],
    [
        q{ATV Offroad Fury 2},
        q{offroad fury 2},
    ],
    [
        q{Alex Kidd},
        q{Alex Kidd in the Enchanted Castle},
    ],
    [
        q{Bart vs the Space Mutants},
        q{Bart vs. the Space Mutants},
    ],
    [
        q{From Russia With Love},
        q{russia with love},
    ],
    [
        q{Silent Hill Homecoming},
        q{Silent Hill: Homecoming},
    ],
    [
        q{Dance Dance Revolution ULTRAMIX 4},
        q{Ultra mix 4},
        q{Ultramix 4},
    ],
    [
        q{Killer Instinct Gold},
        q{killer instinct 64},
    ],
    [
        q{Monkey Ball Jr},
        q{Super Monkey Ball Jr},
        q{Super Monkey Ball Jr.},
    ],
    [
        q{Tiger Woods 2005},
        q{Tiger Woods PGA Tour 2005},
        q{tiger woods 05},
        q{tiger woods pga 2005},
        q{tiger woods pga tour 05},
    ],
    [
        q{Rocket Power Zero Gravity Zone},
        q{Zero Gravity Zone},
    ],
    [
        q{Ghosts to Glory},
        q{Maximo Ghosts to Glory},
    ],
    [
        q{Ace Combat 5 Unsung War},
        q{ace combat 5},
        q{ace kombat 5},
    ],
    [
        q{Terminator Rise of the Machines},
        q{terminator 3},
    ],
    [
        q{Quake 64},
        q{quake},
    ],
    [
        q{Spyro Ripto's Rage},
        q{ripto's rage},
        q{spyro 2 ripto's rage},
    ],
    [
        q{Final Fantasy X 10},
        q{final fantasy 10},
        q{final fantasy X},
    ],
    [
        q{Genghis Khan II Clan of the Gray Wolf},
        q{Genghis Khan ii},
        q{clan of gray wolf},
        q{genghis khan 2},
    ],
    [
        q{GTA 4},
        q{Grand Theft Auto 4},
        q{Grand Theft Auto IV},
    ],
    [
        q{Assasins Creed},
        q{Assassin's Creed},
        q{Assassins Creed},
    ],
    [
        q{Crash of the Titans},
        q{Crash: of the Titans},
    ],
    [
        q{FF Chronicles},
        q{Final Fantasy Chronicles},
    ],
    [
        q{Super Smash TV},
        q{super smash T.V.},
    ],
    [
        q{Star Trek Deep Space Nine},
        q{Star Trek Deep Space Nine Crossroads of Time},
    ],
    [
        q{Rugrats Go Wild},
        q{rugrats gone wild},
    ],
    [
        q{1080},
        q{1080 Snowboarding},
    ],
    [
        q{Thunderstrike Operation Phoenix},
        q{thunder strike},
        q{thunderstrike},
    ],
    [
        q{Hot Wheels All Out},
        q{Hotwheels all out},
    ],
    [
        q{FIFA 2007},
        q{fifa '07},
        q{fifa 07},
    ],
    [
        q{Mortal Combat 3},
        q{Mortal Combat III},
        q{Mortal Kombat 3},
        q{Mortal Kombat III},
    ],
    [
        q{Cabelas Outdoor Adventure},
        q{outdoor adventure},
    ],
    [
        q{Halo 2},
        q{halo2},
    ],
    [
        q{Chaos Theory},
        q{Splinter Cell Chaos Theory},
    ],
    [
        q{Teenage Mutant Ninja Turtles 3 radical rescue},
        q{Teenage Mutant Ninja Turtles III Radical Rescue},
        q{Teenage Mutant Ninja Turtles radical rescue},
    ],
    [
        q{Dead or Alive 2},
        q{doa 2},
        q{doa2},
    ],
    [
        q{Baldur's Gate Dark Alliance},
        q{baldur's gate},
        q{baldurs gate},
        q{dark alliance},
    ],
    [
        q{Eye Toy Groove},
        q{eyetoy groove},
    ],
    [
        q{The Goonies 2},
        q{goonies 2},
        q{goonies II},
    ],
    [
        q{Enter the Dragonfly},
        q{Spyro Enter the Dragonfly},
        q{spyro: Enter the Dragonfly},
    ],
    [
        q{Dead Rising},
        q{Deadrising},
    ],
    [
        q{NCAA Football 2007},
        q{ncaa football 07},
    ],
    [
        q{The Ren and Stimpy Show Time Warp},
        q{ren & stimpy Time Warp},
        q{ren and stimpy Time Warp},
    ],
    [
        q{Pirates if the Caribbean},
        q{Pirates of the Caribbean},
    ],
    [
        q{Dragon Ball Z Budokai},
        q{Z Budokai},
    ],
    [
        q{Sphinx and the Cursed Mummy},
        q{sphinx},
    ],
    [
        q{March of the Black Queen},
        q{Ogre Battle The March of the Black Queen},
    ],
    [
        q{Guitar Hero 2},
        q{Guitar Hero II},
    ],
    [
        q{Tom and Jerry War of Whiskers},
        q{war of whiskers},
    ],
    [
        q{Contra Advance Alien Wars},
        q{contra advance},
        q{contra advanced},
    ],
    [
        q{Sponge Bob Square Pants Volume 2},
        q{Sponge Bob SquarePants Volume 2},
        q{SpongeBob Square Pants Volume 2},
        q{SpongeBob SquarePants Volume 2},
    ],
    [
        q{Tony Hawk Underground},
        q{Tony Hawks Underground},
        q{tony hawk's underground},
    ],
    [
        q{Earth worm Jim },
        q{Earthworm Jim},
    ],
    [
        q{Army Men Air Combat},
        q{army men - air combat},
        q{army men: air combat},
    ],
    [
        q{T2 The Arcade Game},
        q{t2 arcade game},
    ],
    [
        q{Princess Tomato},
        q{Princess Tomato in the Salad Kingdom},
    ],
    [
        q{Sponge Bob Square Pants Yellow Avenger},
        q{Sponge Bob SquarePants yellow avenger},
        q{SpongeBob Square Pants yellow avenger},
        q{SpongeBob SquarePants yellow},
        q{SpongeBob SquarePants yellow avenger},
    ],
    [
        q{Brigandine The Legend of Forsena},
        q{Legend of Forsena},
    ],
    [
        q{PGR 3},
        q{Project Gotham Racing 3},
    ],
    [
        q{Conflict Desert Storm 2},
        q{Conflict Desert Storm II},
        q{conflict 2},
        q{desert storm 2},
        q{desert storm ii},
    ],
    [
        q{Far Cry Instincts},
        q{farcry instincts},
    ],
    [
        q{TRIBES Aerial Assault},
        q{tribes},
    ],
    [
        q{South Park},
        q{southpark},
    ],
    [
        q{Tony Hawk Project 8},
        q{tony hawk's project 8},
        q{tony hawks project 8},
    ],
    [
        q{Aerofighters Assault},
        q{aero fighters assault},
    ],
    [
        q{Covert Assault},
        q{Spec Ops Covert Assault},
    ],
    [
        q{NBA Showtime},
        q{nba on nbc},
        q{showtime},
    ],
    [
        q{MVP NCAA Baseball 2006},
        q{mvp baseball 06},
    ],
    [
        q{Ty the Tasmanian Tiger},
        q{Ty: tasmanian tiger},
        q{tasmanian tiger},
    ],
    [
        q{Harry Potter - Quidditch},
        q{Harry Potter Quidditch World Cup},
        q{Harry Potter: Quidditch},
        q{Quiddich World Cup},
        q{Quidditch World Cup},
        q{Quiddittch},
    ],
    [
        q{Adventures of Bayou Billy},
        q{Bayou Billy},
    ],
    [
        q{NBA Live 2006},
        q{nba live 06},
    ],
    [
        q{Zelda 2 II Adventures of Link},
        q{zelda 2},
        q{zelda ii},
    ],
    [
        q{Need for Speed 2 - Hot Pursuit},
        q{Need for Speed 2 Hot Pursuit},
        q{hot pursuit 2},
        q{need for speed: hot pursuit 2},
    ],
    [
        q{MLB 2006},
        q{mlb 06},
    ],
    [
        q{WWF Smackdown},
        q{just bring it},
        q{wwe smackdown},
    ],
    [
        q{Mario Hoops 3 on 3},
        q{mario hoops},
    ],
    [
        q{Lost Expeditions},
        q{Pitfall Lost Expeditions},
        q{Pitfall: Lost Expeditions},
    ],
    [
        q{Lego Star Wars Complete Saga},
        q{Wars Complete Saga },
        q{Wars The Complete Saga },
    ],
    [
        q{Pokemon Stadium},
        q{pokeman stadium},
    ],
    [
        q{Kingdom Hearts},
        q{KingdomHearts},
    ],
    [
        q{Call of Duty 2 Big Red One},
        q{big red one},
        q{call of duty 2},
    ],
    [
        q{Mario and Luigi Partners in Time},
        q{Partners in Time},
    ],
    [
        q{Looney Toons Sheep Raider},
        q{sheep raider},
    ],
    [
        q{Batman Rise of Sin Tzu},
        q{sin tzu},
    ],
    [
        q{The Sims 2 Pets},
        q{sims 2 pets},
    ],
    [
        q{WWE Smackdown Shut Your Mouth},
        q{shut your mouth},
    ],
    [
        q{Allstar Baseball 2003},
        q{all star baseball 2003},
        q{all-star baseball 2003},
    ],
    [
        q{Super Punch Out},
        q{super punch-out},
        q{super punchout},
    ],
    [
        q{Cybeast Gregar},
        q{Mega Man Battle Network 6 Cybeast Gregar},
    ],
    [
        q{Star Wars Phantom Menace},
        q{phantom menace},
    ],
    [
        q{Golden Sun The Lost Age},
        q{golden sun lost age},
        q{golden sun: lost age},
        q{golden sun: the lost age},
    ],
    [
        q{NASCAR 2000},
        q{nascar '00},
        q{nascar 00},
    ],
    [
        q{Resident Evil Code Veronica X},
        q{resident evil code},
        q{resident evil: code veronica x},
    ],
    [
        q{Looney Tunes Back in Action},
        q{back in action},
    ],
    [
        q{ESPN 2K5 Football},
        q{ESPN Football 2005},
        q{nfl 2k5},
    ],
    [
        q{Gates to Another World},
        q{Might and Magic Gates to Another World},
    ],
    [
        q{Legacy of Kain Soul Reaver 2},
        q{soul reaver 2},
    ],
    [
        q{Warioware Twisted},
        q{wario ware twisted},
    ],
    [
        q{Soul Calibur 3},
        q{soul calibur iii},
        q{soulcalibur 3},
        q{soulcalibur iii},
    ],
    [
        q{Xbox 360 Arcade},
        q{xbox360 arcade},
    ],
    [
        q{Tony Hawk 2},
        q{pro skater 2},
        q{tony hawk pro skater 2},
        q{tony hawks pro skater 2},
    ],
    [
        q{Medal of Honor - Underground},
        q{Medal of Honor Underground},
        q{Medal of Honor: Underground},
    ],
    [
        q{Psi-Ops Mindgate Conspiracy},
        q{psi-ops},
    ],
    [
        q{Star Wars Rogue Squadron},
        q{rogue},
        q{rogue squadron},
        q{rouge},
        q{squadron},
    ],
    [
        q{Resident Evil The Umbrella Chronicles},
        q{Resident Evil Umbrella Chronicles},
        q{Resident Evil: Umbrella Chronicles},
    ],
    [
        q{Mega Man X5},
        q{Megaman X5},
    ],
    [
        q{SimCity 2000},
        q{sim city 2000},
    ],
    [
        q{R.C. Pro-Am},
        q{R.C. ProAm},
        q{RC Pro AM},
        q{RC Pro-AM},
        q{RC ProAM},
    ],
    [
        q{Myst 3 Exile},
        q{myst iii},
    ],
    [
        q{Burnout 3 Take Down},
        q{burnout 3},
    ],
    [
        q{Civilization 2},
        q{Civilization II},
    ],
    [
        q{Fzero X},
        q{f zero x},
        q{f-zero x},
    ],
    [
        q{Mario & Sonic at the Olympic},
        q{Mario & Sonic olympic},
        q{Mario and Sonic Olympic Games},
        q{Mario and Sonic olympic},
        q{mario & sonic olympics},
    ],
    [
        q{Harvest Moon A Wonderful Life},
        q{harvest moon - wonderful life},
        q{harvest moon wonderful life},
        q{harvest moon: a wonderful life},
        q{harvest moon: wonderful life},
    ],
    [
        q{Namco Museum  4},
        q{Namco Museum Volume 4},
    ],
    [
        q{Spartan Total Warrior},
        q{spartan - total warrior},
        q{spartan: total warrior},
    ],
    [
        q{Mickey Mouse Magic Mirror},
        q{magic mirror},
    ],
    [
        q{Zelda Wind Waker},
        q{wind waker},
        q{wind walker},
        q{windwaker},
        q{windwalker},
        q{zelda windwaker},
    ],
    [
        q{Harvest Moon More Friends},
        q{Harvest Moon More Friends of Mineral Town},
        q{Harvest Moon: More Friends},
        q{Harvest Moon: More Friends of Mineral Town },
    ],
    [
        q{Norse by Norsewest},
        q{Norse by Norsewest The Return of The Lost Vikings},
        q{Norse by Northwest},
    ],
    [
        q{Mega Man Zero 2},
        q{megaman zero 2},
    ],
    [
        q{Mystery Dungeon Red},
        q{Pokemon Mystery Dungeon Red},
    ],
    [
        q{Cruis'n Exotica},
        q{Cruisn' Exotica},
        q{cruisn exotica},
        q{crusin exotica},
        q{exotica},
    ],
    [
        q{Xena Warrior Princess},
        q{xena},
    ],
    [
        q{Grand Theft Auto Liberty City Stories},
        q{liberty city stories},
    ],
    [
        q{Mario Kart Super Circuit},
        q{mario cart super circuit},
        q{mario cart: super circuit},
        q{mario kart - super circuit},
        q{mario kart super cir},
        q{mario kart: super circuit},
    ],
    [
        q{Burnout 2 Point of Impact},
        q{burnout 2},
    ],
    [
        q{Disney Sport Skateboarding },
        q{Disney Sports Skateboarding},
        q{disney skateboarding},
        q{disney's skateboarding},
    ],
    [
        q{Buster Busts Loose},
        q{Tiny Toon Adventures Buster Busts Loose},
    ],
    [
        q{Tak 2 The Staff of Dreams},
        q{tak 2},
    ],
    [
        q{F-zero},
        q{f zero},
        q{fzero},
    ],
    [
        q{Saint's Row},
        q{Saints Row},
    ],
    [
        q{Breath of Fire 3},
        q{breath of fire iii},
        q{breathe of fire 3},
        q{breathe of fire iii},
    ],
    [
        q{King's Quest V},
        q{Kings Quest V},
    ],
    [
        q{Ratchet and Clank Going Commando},
        q{going commando},
    ],
    [
        q{Blitz 2002 Football},
        q{blitz 2002},
    ],
    [
        q{Cruis'n World},
        q{cruisin world},
        q{cruisn world},
        q{cruisn' world},
        q{crusin world},
    ],
    [
        q{Battletanks},
        q{Battletanx},
        q{battle tanks},
        q{battle tanx},
    ],
    [
        q{Excitebike 64},
        q{excite bike 64},
    ],
    [
        q{Star Wars Rogue Leader},
        q{rouge leader},
    ],
    [
        q{NCAA Football 09},
        q{NCAA Football 2009},
    ],
    [
        q{Ar Tonelico 2},
        q{Ar Tonelico 2 Melody of MetaFalica},
        q{Melody of MetaFalica},
    ],
    [
        q{Lab and Friends },
        q{Nintendogs Lab and Friends},
        q{nintendogs lab},
    ],
    [
        q{Rise of the Underminer},
        q{The Incredibles Rise of the Underminer},
    ],
    [
        q{EA Smarty Pants},
        q{smarty pants},
    ],
    [
        q{Bass Hunters},
        q{bass hunter},
    ],
    [
        q{Star Wars Clone Wars},
        q{clone wars},
    ],
    [
        q{Zelda Ocarina of Time Master Quest},
        q{master quest},
        q{ocarina + master},
        q{ocarina of time/master quest},
    ],
    [
        q{Wolverine's revenge},
        q{Wolverines revenge},
        q{X-men Wolverines Revenge},
        q{x-men wolverine},
        q{xmen wolverine},
    ],
    [
        q{NBA Jam 2000},
        q{nba jam '00},
        q{nba jam 00},
    ],
    [
        q{Real Time Conflict Shogun Empire},
        q{Shogun Empire},
    ],
    [
        q{New AliasWrestlemania Arcade Gam},
        q{WWF Wrestlemania The Arcade Game},
    ],
    [
        q{Pilot Wings},
        q{pilotwings},
    ],
    [
        q{Gun Metal GunMetal},
        q{gun metal},
        q{gunmetal},
    ],
    [
        q{Alundra 2},
        q{alundra ii},
    ],
    [
        q{Chronicles of Narnia},
        q{Chronicles of Narnia Lion Witch and the Wardrobe},
        q{lion witch},
    ],
    [
        q{MX vs. ATV Unleashed},
        q{mx vs atv unleashed},
    ],
    [
        q{Super Star Wars Return of the Jedi},
        q{super Return of the Jedi },
    ],
    [
        q{King Kong the Movie},
        q{king kong},
    ],
    [
        q{Spec Ops Stealth Patrol},
        q{Stealth Patrol },
    ],
    [
        q{Boktai Sun in Your Hands},
        q{boktai},
    ],
    [
        q{Triple Play 2000},
        q{triple play},
        q{triple play '00},
        q{triple play 00},
        q{tripple play 2000},
    ],
    [
        q{Prince of Persia Warrior Within},
        q{Prince of Persia the Warrior Within},
        q{Prince of Persia: Warrior Within},
        q{Warrior Within},
    ],
    [
        q{Mike Tyson's Punch Out},
        q{Mike Tyson's Punch-Out},
        q{Mike Tysons Punch Out},
        q{Mike Tysons Punch-Out},
        q{mike tyson punch out},
        q{mike tyson punch-out},
        q{mike tyson punchout},
    ],
    [
        q{The Typing of the Dead},
        q{Typing of the Dead},
    ],
    [
        q{R-Type III The Third Lightning},
        q{r-type 3},
        q{r-type iii},
        q{rtype 3},
        q{rtype iii},
    ],
    [
        q{A Boy and His Blob},
        q{A Boy and His Blob Trouble on Blobolonia},
        q{Boy and His Blob},
    ],
    [
        q{Mat Hoffman Pro BMX 2},
        q{matt hoffman},
    ],
    [
        q{FIFA 98 Soccer},
        q{fifa '98},
        q{fifa 1998},
        q{fifa 98},
        q{fifa soccer 98},
    ],
    [
        q{Blade 2 II},
        q{blade 2},
        q{blade ii},
    ],
    [
        q{Disney Sport Soccer },
        q{Disney Sports Soccer},
        q{Disney's Sports Soccer },
    ],
    [
        q{NASCAR 2005},
        q{NASCAR Chase for the Cup 2005},
    ],
    [
        q{Adventures of Dr Franken},
        q{Adventures of Dr. Franken },
    ],
    [
        q{Mario Kart Double Dash},
        q{double dash},
        q{mario cart double dash},
        q{mario kart - double dash},
        q{mario kart dd},
        q{mario kart: double dash},
        q{mariocart double dash},
        q{mariokart double dash},
    ],
    [
        q{Need for Speed 3 Hot Pursuit},
        q{hot pursuit 3},
        q{iii hot pursuit},
    ],
    [
        q{Namco Museum  3},
        q{Namco Museum Volume 2},
    ],
    [
        q{Da Vinci Code},
        q{DaVinci Code},
    ],
    [
        q{Wario Ware Mega Party Games},
        q{wario ware mega},
        q{warioware mega},
    ],
    [
        q{Bomberman Second Attack},
        q{bomber man second attack},
        q{second attack},
    ],
    [
        q{Soduku Gridmaster},
        q{Sudoku Gridmaster},
    ],
    [
        q{Sega Dreamcast Console},
        q{dreamcast console},
        q{dreamcast game console},
        q{dreamcast game system},
        q{dreamcast system},
        q{dreamcast video game console},
        q{dreamcast video game system},
    ],
    [
        q{NASCAR 99},
        q{nascar '99},
        q{nascar 1999},
        q{nascar99},
    ],
    [
        q{Paper Mario ( The Thousand},
        q{Paper Mario The Thousand},
        q{Paper Mario Thousand Year Door},
        q{paper mario - and thousand year door},
        q{paper mario - thousand year door},
        q{paper mario and the thousand year door},
        q{paper mario and thousand year door},
        q{paper mario: and the thousand},
        q{paper mario: the thousand},
        q{paper mario: thousand year},
    ],
    [
        q{Rhapsody A Musical Adventure},
        q{rhapsody},
    ],
    [
        q{Capcom Classic Collection},
        q{Capcom Classics Collection },
    ],
    [
        q{Medabots AX Rokusho Version},
        q{Rokusho},
    ],
    [
        q{Scooby Doo Creep Capers},
        q{Scooby-Doo Creep Capers},
        q{creep capers},
    ],
    [
        q{Madden 09},
        q{Madden 2009},
    ],
    [
        q{The Sims 2},
        q{sims 2},
    ],
    [
        q{SUPER BATTLE TANK war},
        q{Super Battletank War in the Gulf},
        q{super battletank war},
    ],
    [
        q{Vigilante 8},
        q{vigilante8},
    ],
    [
        q{Arcade's Greatest Hits Atari Collection 2},
        q{Atari Collection 2},
    ],
    [
        q{Animal Crossing Wild World},
        q{animal crossing: wild world},
    ],
    [
        q{NBA Street Basketball},
        q{nba street},
    ],
    [
        q{Final Fantasy IV},
        q{final fantasy 4},
    ],
    [
        q{SOCOM II US Navy Seals},
        q{socom 2},
        q{socom ii},
    ],
    [
        q{Beast Wars},
        q{Transmetal},
    ],
    [
        q{A link to the past},
        q{Zelda Link to the Past},
        q{link to past},
        q{zelda link to the},
    ],
    [
        q{Assassin's Creed Limited Edition},
        q{Assassins Creed Limited Edition},
    ],
    [
        q{Day of Reckoning 2},
        q{WWE Day of Reckoning 2},
    ],
    [
        q{Super Mario All-Star},
        q{Super Mario Allstars},
        q{super mario all stars},
        q{super mario all-stars},
        q{super mario allstar},
    ],
    [
        q{Lost World Jurassic Park},
        q{lost world},
    ],
    [
        q{Twisted Metal 4},
        q{Twisted Metal IV},
    ],
    [
        q{Madden 2008},
        q{madden '08},
        q{madden 08},
        q{madden nfl 08},
        q{madden nfl 2008},
    ],
    [
        q{Harvest Moon Another Wonderful Life},
        q{harvest moon - another wonderful life},
        q{harvest moon: another wonderful life},
    ],
    [
        q{Doom 2},
        q{Doom II},
    ],
    [
        q{Warioware Touched},
        q{wario ware touched},
    ],
    [
        q{Duck Tails},
        q{Duck Tales},
    ],
    [
        q{Bust-A-Move 3000},
        q{bust a move 3000},
        q{bustamove 3000},
    ],
    [
        q{The X-Files},
        q{X-Files The Game},
    ],
    [
        q{Lion King},
        q{The Lion King},
    ],
    [
        q{Luigi's Mansion},
        q{Luigi’s Mansion},
        q{luigi mansion},
        q{luigis mansion},
    ],
    [
        q{Castlevania Legacy},
        q{castlevania: legacy},
    ],
    [
        q{50 Cent Bulletproof},
        q{50 cent},
    ],
    [
        q{EVO the Search for Eden},
        q{search for eden},
    ],
    [
        q{Turok 3},
        q{shadows of oblivion},
    ],
    [
        q{Disney Sport Football },
        q{Disney Sports Football},
        q{Disney's Sports Football },
    ],
    [
        q{Moto GP 2},
        q{motogp 2},
    ],
    [
        q{Cabela's Deer Hunt 2004},
        q{deer hunt 2004},
    ],
    [
        q{Tony Hawk 3},
        q{tony hawk pro skater 3},
        q{tony hawk's pro skater 3},
        q{tony hawks pro skater 3},
    ],
    [
        q{7 Trials to Glory},
        q{Yu-Gi-Oh 7 Trials to Glory},
    ],
    [
        q{Tokyo Xtreme Racer Zero},
        q{tokyo extreme},
        q{tokyo xtreme},
    ],
    [
        q{Tao Feng Fist of the Lotus},
        q{tao feng},
    ],
    [
        q{Batman Vengance},
        q{Batman Vengeance},
    ],
    [
        q{Scooby Doo Cyber Chase},
        q{Scooby Doo and the Cyber Chase},
        q{scooby-doo and the cyber chase},
        q{scooby-doo cyber chase},
    ],
    [
        q{Mortal Kombat Shaolin Monks},
        q{Mortal Kombat: Shaolin Monks},
    ],
    [
        q{Phoenix Wright Justice for All},
        q{justice for all},
    ],
    [
        q{Ecco The Tides of Time},
        q{tide of time},
        q{tides of time},
    ],
    [
        q{Army Men 2},
        q{sarge's heros 2},
        q{sarges heros 2},
    ],
    [
        q{Rugrats in Paris},
        q{rugrats paris},
    ],
    [
        q{Wii Play with Wii Remote},
        q{wii play},
        q{wiiplay},
    ],
    [
        q{World Championship 2004},
        q{World Championship Tournament 2004},
        q{Yu-Gi-Oh World Championship Tournament 2004},
    ],
    [
        q{Sponge Bob Square Pants Legend of the Lost Spatula},
        q{Sponge Bob SquarePants legend},
        q{Sponge Bob SquarePants lost},
        q{SpongeBob Square Pants legend},
        q{SpongeBob Square Pants lost},
        q{SpongeBob SquarePants legend},
        q{SpongeBob SquarePants lost},
    ],
    [
        q{Wrestlemania 2000},
        q{wrestle mania},
        q{wrestle mania 2000},
        q{wrestlemania},
        q{wrestlemania 00},
    ],
    [
        q{Rebel Assault 2 },
        q{Rebel Assault II},
        q{Star Wars Rebel Assault 2},
    ],
    [
        q{ISS 64 Soccer},
        q{international superstar soccer},
        q{iss 64},
    ],
    [
        q{Super Mario Bros 3},
        q{super mario 3},
        q{super mario bros. 3},
        q{super mario brothers 3},
    ],
    [
        q{Pacman Collection},
        q{pac man collection},
        q{pac-man collection},
    ],
    [
        q{SNES System},
        q{SNES console},
        q{SUPER NINTENDO ENTERTAINMENT SYSTEM},
        q{Super Nintendo NES game system},
        q{Super Nintendo System},
        q{snes game system},
        q{super nintendo console},
        q{super nintendo game console},
        q{super nintendo game system},
        q{super nintendo snes},
    ],
    [
        q{Madden 2005},
        q{madden 05},
        q{madden nfl 05},
        q{madden nfl 2005},
    ],
    [
        q{Moto GP 07},
        q{moto gp 2007},
        q{motogp 07},
    ],
    [
        q{Billy Hatcher and The Giant Egg},
        q{billy hatcher},
    ],
    [
        q{Pac-Attack},
        q{pac attack},
        q{pacattack},
    ],
    [
        q{Cabela's Dangerous Hunts},
        q{dangerous hunts},
    ],
    [
        q{Atelier Iris 3},
        q{Atelier Iris 3 Grand Phantasm},
    ],
    [
        q{The Ren and Stimpy Show Buckeroos},
        q{ren & stimpy Buckeroos},
        q{ren and stimpy Buckeroos},
    ],
    [
        q{True Crimes Streets of LA},
        q{streets of L.A.},
        q{streets of la},
    ],
    [
        q{Quake 2},
        q{quake ii},
        q{quake2},
    ],
    [
        q{Jak II},
        q{jak 2},
        q{jax 2},
    ],
    [
        q{Ratchet and Clank},
        q{ratchet & clank},
    ],
    [
        q{Ratchet and Clank Up Your Arsenal},
        q{up your arsenal},
    ],
    [
        q{Namco Museum  5},
        q{Namco Museum Volume 5},
    ],
    [
        q{Metal Gear Solid 3 Snake Eater},
        q{metal gear solid 3},
    ],
    [
        q{Beavis and Butt-Head},
        q{beavis & butt-head},
        q{beavis & butthead},
        q{beavis and butthead},
    ],
    [
        q{Star Trek Tactical Assault},
        q{tactical assault},
    ],
    [
        q{Blastcorps},
        q{blast corp},
        q{blast corps},
        q{blastcorp},
    ],
    [
        q{SSX 3},
        q{ssx3},
    ],
    [
        q{Kirby's Dream Land 2},
        q{kirby dream land 2},
        q{kirby dreamland 2},
        q{kirby's dreamland 2},
    ],
    [
        q{Zelda Minish Cap},
        q{minish cap},
    ],
    [
        q{Attack of the Clones},
        q{Star Wars Attack of the Clones},
    ],
    [
        q{Final Fantasy XII},
        q{final fantasy 12},
    ],
    [
        q{Capsule Monster Coliseum},
        q{Yu-Gi-Oh Capsule Monster Coliseum},
    ],
    [
        q{Sopranos Road to Respect},
        q{The Sopranos},
    ],
    [
        q{Call of Duty 4 Modern Warfare},
        q{call of duty 4},
    ],
    [
        q{Lunar 2 Eternal Blue Complete},
        q{lunar 2},
    ],
    [
        q{Dr. Mario},
        q{dr mario},
    ],
    [
        q{Mario vs Donkey Kong 2 March of Minis},
        q{march of minis},
        q{mario vs donkey kong 2},
        q{mario vs. donkey kong 2},
    ],
    [
        q{Need for Speed - Carbon},
        q{Need for Speed Carbon},
        q{need for speed: carbon},
    ],
    [
        q{Disney Sport Motocross },
        q{Disney Sports Motocross},
        q{Disney's Sports Motocross },
    ],
    [
        q{Pokemon Stadium 2},
        q{pokeman stadium 2},
    ],
    [
        q{Super Smash Bros.},
        q{smash brothers},
        q{super smash},
    ],
    [
        q{Twisted Metal 2},
        q{Twisted Metal II},
    ],
    [
        q{Firefighter F.D.},
        q{Firefighter FD 18},
        q{firefighter fd},
    ],
    [
        q{Sonic Hedgehog 3},
        q{Sonic the Hedgehog 3},
        q{sonic 3},
    ],
    [
        q{Silent Hill Origins},
        q{Silent Hill: Origins },
    ],
    [
        q{1943},
        q{1943 the Battle of Midway},
    ],
    [
        q{Hit and Run},
        q{Simpsons Hit and Run},
        q{hit & run},
        q{simpson's hit},
        q{simpsons hit},
    ],
    [
        q{Guilty Gear X Advance Edition},
        q{guilty gear x advance},
    ],
    [
        q{Xbox 360 System Premium 20GB},
        q{xbox 360 premium},
        q{xbox360 premium},
    ],
    [
        q{Lufia and The Fortress of Doom},
        q{fortress of doom},
        q{lufia fortress of doom},
        q{lufia: fortress of doom},
    ],
    [
        q{Jungle Book},
        q{The Jungle Book},
    ],
    [
        q{Terminator 2 Judgement Day},
        q{t2 judgement day},
    ],
    [
        q{World Is Not Enough},
        q{not enough},
    ],
    [
        q{Pirates of the Caribbean Dead Mans Chest},
        q{Pirates of the Caribbean: Dead Mans Chest},
    ],
    [
        q{Turok Rage Wars},
        q{rage wars},
        q{turok: rage wars},
    ],
    [
        q{TRON 20 Killer App},
        q{Tron 2.0},
    ],
    [
        q{Super Mario 64},
        q{mario 64},
        q{mario64},
        q{supermario64},
    ],
    [
        q{FIFA 99 Soccer},
        q{fifa '99},
        q{fifa 1999},
        q{fifa 99},
        q{fifa soccer 99},
    ],
    [
        q{Mr. Driller},
        q{mr driller},
    ],
    [
        q{FIFA 2004},
        q{fifa 04},
        q{fifa soccer 2004},
    ],
    [
        q{Medal of Honor - Frontline},
        q{Medal of Honor Frontline},
        q{medal of honor (frontline)},
        q{medal of honor: frontline},
    ],
    [
        q{Ninja Gaden},
        q{Ninja Gaiden},
    ],
    [
        q{Final Fantasy 9},
        q{final fantasy ix},
    ],
    [
        q{SimEarth the Living Planet},
        q{sim earth},
        q{simearth},
    ],
    [
        q{Civil War Secret Missions},
        q{History Channel Civil War Secret Missions},
    ],
    [
        q{Sonic & Knuckles},
        q{Sonic and Knuckles},
    ],
    [
        q{Waverace},
        q{wave race 64},
    ],
    [
        q{Tiny Toon Adventures Wacky Sports Challenge},
        q{Wacky Sports Challenge},
    ],
    [
        q{Metroid Prime 2 Echoes},
        q{metroid prime 2},
    ],
    [
        q{NHL 2006},
        q{nhl 06},
    ],
    [
        q{WWF No Mercy},
        q{no mercy},
    ],
    [
        q{Dragon Ball Z Budokai 2},
        q{Z Budokai 2},
    ],
    [
        q{CASTLEVANIA 4},
        q{CASTLEVANIA IV},
        q{Super Castlevania IV},
        q{super castlevania 4},
    ],
    [
        q{Nintendo Wii with Wii Sports},
        q{wii console},
        q{wii game console},
        q{wii game system},
        q{wii system},
    ],
    [
        q{Ace Combat 3 Electrosphere},
        q{ace combat 3},
    ],
    [
        q{Tenchu 3 Wrath of Heaven},
        q{tenchu 3},
        q{wrath of heaven},
    ],
    [
        q{Castlevania Portrait of Ruin},
        q{portrait of ruin},
    ],
    [
        q{Clay Fighter Sculptors Cut},
        q{clayfighter sculptors cut},
    ],
    [
        q{Hamsterviel Havoc},
        q{Lilo and Stitch 2 Hamsterviel Havoc},
        q{lilo and stich 2},
    ],
    [
        q{Halo 3},
        q{Halo3},
    ],
    [
        q{Super Smash Bros. Melee},
        q{bros. melee},
        q{brothers melee},
        q{super smash bros melee},
        q{super smash brothers melee},
    ],
    [
        q{Mega Man Zero 3},
        q{megaman zero 3},
    ],
    [
        q{Ready 2 Rumble Round 2},
        q{round 2},
    ],
    [
        q{Sponge Bob Square Pants Lights Camera Pants},
        q{Sponge Bob SquarePants lights},
        q{SpongeBob Square Pants lights},
        q{SpongeBob SquarePants lights},
    ],
    [
        q{.hack Outbreak},
        q{dot hack outbreak},
    ],
    [
        q{Wallace and Gromit Project Zoo},
        q{project zoo},
    ],
    [
        q{FIFA 06},
        q{FIFA 2006},
        q{fifa soccer 2006},
    ],
    [
        q{The Matrix Path of Neo},
        q{matrix path of neo},
        q{matrix: path of neo},
    ],
    [
        q{Amulet Of Time},
        q{Samurai Jack The Amulet Of Time},
    ],
    [
        q{ISS 98 Soccer},
        q{international superstar soccer '98},
        q{international superstar soccer 1998},
        q{international superstar soccer 98},
        q{iss '98},
        q{iss 1998},
        q{iss 98},
    ],
    [
        q{Marvel Nemesis},
        q{Marvel Nemesis Rise of the Imperfects},
    ],
    [
        q{Advance Wars DS},
        q{advance wars dual strike},
        q{advance wars: dual strike},
        q{dual strike},
    ],
    [
        q{WWE Wrestlemania X8},
        q{Wrestlemania 18},
        q{wrestlemania x8},
    ],
    [
        q{Simpsons Night of the Living Treehouse of Horror},
        q{Treehouse of Horror},
    ],
    [
        q{Lord of the Rings Return of King},
        q{Lord of the Rings: The Return of the King},
        q{lord of the rings - return},
        q{lord of the rings the return},
        q{lord of the rings: return},
        q{return of king},
        q{return of the king},
    ],
    [
        q{Mega Man Zero},
        q{megaman zero},
    ],
    [
        q{Metal Gear Solid Twin Snakes},
        q{twin snakes},
    ],
    [
        q{Turok 2 Seeds of Evil},
        q{turok 2},
        q{turok seeds of evil},
        q{turok: 2},
        q{turok: seeds of evil},
    ],
    [
        q{Bart Meets Radioactive Man},
        q{Bartman meets Radioactive Man},
    ],
    [
        q{MRC Multi Racing Championship},
        q{mrc},
    ],
    [
        q{Yoshi's Island Super Mario 3},
        q{mario advance 3},
        q{yoshi's island},
        q{yoshis island},
    ],
    [
        q{Boogerman},
        q{Boogerman A Pick and Flick Adventure},
    ],
    [
        q{Joe and Mac},
        q{joe & mac},
    ],
    [
        q{Lego Star Wars 2 Original Trilogy},
        q{Wars The Original Trilogy },
        q{lego star wars 2},
        q{lego star wars ii},
    ],
    [
        q{Super Mario Bros & Duck Hunt},
        q{Super Mario Bros and Duck Hunt},
        q{Super Mario Bros. & Duck Hunt},
        q{Super Mario Bros.and Duck Hunt},
    ],
    [
        q{Crash Twinsanity},
        q{Crash: Twin Sanity},
        q{Crash: Twinsanity},
        q{twin sanity},
        q{twinsanity},
    ],
    [
        q{Harvest Moon - Magical Melody},
        q{Harvest Moon Magical Melody},
        q{Harvest Moon: Magical Melody},
    ],
    [
        q{Xenosaga 2},
        q{xenosaga ii},
    ],
    [
        q{Explorers of Darkness},
        q{Pokemon Mystery Dungeon Explorers of Darkness},
    ],
    [
        q{Sponge Bob Square Pants The Movie},
        q{Sponge Bob SquarePants movie},
        q{SpongeBob Square Pants movie},
        q{SpongeBob SquarePants movie},
        q{square pants movie},
        q{square pants the movie},
        q{squarepants movie},
        q{squarepants the movie},
    ],
    [
        q{Pac-Man 2 The New Adventures},
        q{pac-man 2},
        q{pacman 2},
    ],
    [
        q{Vigilante 8 2nd Offense},
        q{vigilante 8 2},
        q{vigilante 8 2nd},
        q{vigilante 8 second offense},
    ],
    [
        q{Sports Illustrated For Kids Football},
        q{Sports Illustrated football},
    ],
    [
        q{Lego Indiana Jones},
        q{Lego Indiana Jones The Original Adventures},
    ],
    [
        q{Castlevania Symphony of the Night},
        q{symphony of the night},
    ],
    [
        q{Star Wars Jedi Outcast},
        q{jedi outcast},
    ],
    [
        q{Sonic the Hedgehog},
        q{sonic 1},
    ],
    [
        q{.hack Infection},
        q{dot hack infection},
    ],
    [
        q{Moto GP 3},
        q{motogp 3},
    ],
    [
        q{Batman Dark Tomorrow},
        q{dark tomorrow},
    ],
    [
        q{Sponge Bob Square Pants Super Sponge},
        q{Sponge Bob SquarePants super},
        q{SpongeBob Square Pants super},
        q{SpongeBob SquarePants super},
        q{super sponge},
    ],
    [
        q{Gex 64},
        q{enter the gecko},
    ],
    [
        q{Tony Hawk American Wasteland},
        q{tony hawk's american wasteland},
        q{tony hawks american wasteland},
    ],
    [
        q{Cabela's Deer Hunt 2005},
        q{deer hunt 2005},
    ],
    [
        q{Godzilla Melee},
        q{destory all monsters},
        q{godzilla destroy},
    ],
    [
        q{Battlefield 2},
        q{Battlefield 2 Modern Combat},
    ],
    [
        q{Scooby Doo Night},
        q{Scooby Doo Night of 100 Frights},
        q{Scooby-Doo Night},
        q{night of 100},
    ],
    [
        q{Bookworm},
        q{book worm},
    ],
    [
        q{Spiderman Maximum Carnage},
        q{spider-man maximum carnage},
    ],
    [
        q{Mobile Suit Gundam Zeonic Front},
        q{zeonic front},
    ],
    [
        q{Xbox 360 System Elite 120GB},
        q{xbox 360 elite},
        q{xbox360 elite},
    ],
    [
        q{Call of Duty Finest Hour},
        q{finest hour},
    ],
    [
        q{Clayfighters 63 1/3},
        q{clayfighter 63},
        q{clayfighter 63 1/3},
    ],
    [
        q{Tony Hawk 4},
        q{tony hawk pro skater 4},
        q{tony hawk's pro skater 4},
        q{tony hawks pro skater 4},
    ],
    [
        q{Pokemon Puzzle League},
        q{Puzzle League},
    ],
    [
        q{Harvest Moon Friends Mineral Town},
        q{harvest moon - friends of mineral town},
        q{harvest moon friends},
        q{harvest moon: friends of mineral town},
    ],
    [
        q{Arcade's Greatest Hits Atari Collection 1},
        q{Atari Collection 1},
    ],
    [
        q{Crash Team Racing},
        q{Crash Team Racing CTR},
    ],
    [
        q{Bugs Bunny and Taz Time Busters},
        q{taz time busters},
    ],
    [
        q{Twisted Metal Black},
        q{Twisted Metal: Black},
    ],
    [
        q{Battle for Arrakis},
        q{Dune The Battle for Arrakis},
    ],
    [
        q{Disney's PK Out of the Shadows},
        q{PK Out of the Shadows },
    ],
    [
        q{TMNT Turtles in Time},
        q{Teenage Mutant Ninja Turtles IV Turtles in Time},
        q{turtles in time},
        q{turtles iv},
    ],
    [
        q{Tony Hawk Underground 2},
        q{Tony Hawk's Underground 2},
        q{Tony Hawks Underground 2},
    ],
    [
        q{FIFA 2003},
        q{fifa soccer 2003},
    ],
    [
        q{Jimmy Neutron Jet Fusion},
        q{jet fusion},
    ],
    [
        q{Smuggler's Run},
        q{smugglers run},
    ],
    [
        q{Jedi Power Battles},
        q{Star Wars Jedi Power Battles},
    ],
    [
        q{Need for Speed - Most Wanted},
        q{Need for Speed Most Wanted},
        q{need for speed: most wanted},
    ],
    [
        q{Sponge Bob Square Pants Atlantis Squarepants},
        q{Sponge Bob SquarePants atlantis},
        q{SpongeBob Square Pants atlantis},
        q{SpongeBob SquarePants atlantis},
    ],
    [
        q{Barbie Horse Adventures Wild Horse Rescue},
        q{wild horse rescue},
    ],
    [
        q{Are You Smarter},
        q{Are You Smarter Than a 5th Grader?},
        q{Smarter Than a 5th Grader},
    ],
    [
        q{Greg Hastings Tournament Paintball Maxed},
        q{PAINTBALL MAX'D},
        q{paintball maxed},
    ],
    [
        q{Capcom's Soccer Shootout},
        q{soccer shootout},
    ],
    [
        q{Sonic Adventure 2 Battle},
        q{Sonic Adventure Battle 2},
        q{sonic 2 battle},
    ],
    [
        q{The Sims Bustin Out},
        q{The Sims Bustin' Out},
    ],
    [
        q{Enter the Matrix},
        q{enter matrix},
    ],
    [
        q{NBA Live 2007},
        q{nba live 07},
    ],
    [
        q{Crash Bandicoot - warped},
        q{Crash Bandicoot Warped},
        q{Crash Bandicoot: warped},
    ],
    [
        q{Tamagotchi Connection Corner Shop},
        q{tamagotchi connection},
        q{tamagotchi corner},
    ],
    [
        q{Fighters Destiny},
        q{fighter's destiny},
    ],
    [
        q{Abe's Exoddus},
        q{Oddworld Abes Exoddus},
    ],
    [
        q{Jedi Power Battles},
        q{Star Wars Episode I Jedi Power Battles},
    ],
    [
        q{Condemned},
        q{Condemned Criminal Origins},
    ],
    [
        q{Rush 2},
        q{rush2},
        q{san francisco rush 2},
    ],
    [
        q{Alien vs Predator},
        q{Alien vs. Predator},
    ],
    [
        q{Budokai Tenkaichi 2},
        q{Dragon Ball Z Budokai Tenkaichi 2},
        q{Tenkaichi 2},
    ],
    [
        q{Time Splitters Future Perfect},
        q{Time Splitters: Future Perfect},
        q{TimeSplitters: Future Perfect},
        q{timesplitters future perfect},
    ],
    [
        q{Super Mario Advance 2},
        q{Super Mario World Advance 2},
        q{Super Mario world Super Mario Advance 2},
        q{Super Mario world: Super Mario Advance 2},
        q{mario advance 2},
        q{super mario world 2},
    ],
    [
        q{Mortal Kombat Deception},
        q{Mortal Kombat: Deception},
        q{mortal combat deception},
    ],
    [
        q{Gran Turismo 3},
        q{grand turismo 3},
    ],
    [
        q{Battle front ii},
        q{Battlefront 2},
        q{Battlefront II},
        q{Battlefront ii},
        q{Star Wars Battlefront 2},
        q{battle front 2},
    ],
    [
        q{Street Fighter 2 turbo},
        q{Street Fighter II Turbo},
    ],
    [
        q{Legend of the black Kat},
        q{Pirates Legend of Black Kat},
        q{legend of black kat},
    ],
    [
        q{Trauma Center Under the Knife 2},
        q{Under the Knife 2},
    ],
    [
        q{Ed Edd N Eddy Mis-Edventures},
        q{eddy mis-adventures},
        q{eddy mis-edventures},
        q{eddy misadventures},
        q{eddy misedventures},
    ],
    [
        q{NASCAR Thunder 02},
        q{NASCAR Thunder 2002},
    ],
    [
        q{Spyro Orange The Cortex Conspiracy},
        q{spyro orange},
    ],
    [
        q{The Bee Movie Game},
        q{bee movie},
    ],
    [
        q{Dance Dance Revolution Ultramix},
        q{ddr ultramix},
        q{ddru},
    ],
    [
        q{CSI Hard Evidence},
        q{Hard Evidence },
    ],
    [
        q{Metroid Prime},
        q{metroid: prime},
        q{metroidprime},
    ],
    [
        q{Pitfall Beyond the Jungle},
        q{Pitfall: Beyond the Jungle},
    ],
    [
        q{Dance Dance Revolution Max},
        q{ddr max},
        q{ddrmax},
    ],
    [
        q{Contra Shattered Soldier},
        q{shattered soldier},
    ],
    [
        q{Next Dimension},
        q{X-men Next Dimension},
    ],
    [
        q{Lufia and The Rise of Sinistrals},
        q{Rise of Sinistrals},
        q{lufia rise of sinistrals},
        q{lufia: Rise of Sinistrals},
    ],
    [
        q{Ar tonelico},
        q{Ar tonelico Melody of Elemia},
        q{Melody of Elemia },
    ],
    [
        q{Halo 3 Legendary},
        q{Halo 3 Legendary Edition},
        q{Halo 3: Legendary},
    ],
    [
        q{Prince of Persia Two Thrones},
        q{Prince of Persia the Two Thrones},
        q{Prince of Persia: Two Thrones},
        q{two thrones},
    ],
    [
        q{Destiny Board Traveler},
        q{Yu-Gi-Oh Destiny Board Traveler},
    ],
    [
        q{DDS},
        q{Digital Devil Saga},
    ],
    [
        q{King's Field 2},
        q{King's Field II},
        q{Kings Field 2},
    ],
    [
        q{18 Wheeler American Pro Trucker},
        q{18 wheeler},
        q{Eighteen Wheeler},
    ],
    [
        q{Rainbow Six},
        q{rainbow 6},
    ],
    [
        q{Zelda Majora's Mask},
        q{legend of zelda majora},
        q{legend of zelda: majora},
        q{majora},
        q{majora's mask},
        q{majoras mask},
        q{zelda: majora's},
    ],
    [
        q{Breath of Fire Dragon Quarter},
        q{breath of fire v},
    ],
    [
        q{Falsebound Kingdom},
        q{Yu-Gi-oh Falsebound Kingdom},
    ],
    [
        q{Wreckless},
        q{Wreckless Yakuza Missions},
        q{yakusa missions},
    ],
    [
        q{Mario Golf Toadstool Tour},
        q{toadstool tour},
    ],
    [
        q{Bust-A-Move 99},
        q{bust a move 99},
        q{bust-a-move 1999},
        q{bustamove 99},
    ],
    [
        q{Harry Potter Sorcerers Stone},
        q{Sorcerer Stone},
        q{Sorcerer's Stone},
        q{Sorcerers Stone},
    ],
    [
        q{Splashdown Rides Gone Wild},
        q{splashdown - rides gone wild},
        q{splashdown: rides gone wild},
    ],
    [
        q{Gran Turismo 4},
        q{grand turismo 4},
    ],
    [
        q{Season Ice},
        q{Season of Ice},
        q{Spyro Season of Ice},
    ],
    [
        q{Rayman 2},
        q{raymen 2},
    ],
    [
        q{Amazing Spider man },
        q{Amazing Spider-man },
        q{Amazing Spiderman},
    ],
    [
        q{Goldeneye},
        q{golden eye},
    ],
    [
        q{Medal of Honor - European Assault},
        q{Medal of Honor European Assault},
        q{Medal of Honor: European Assault },
    ],
    [
        q{Twilight Princess},
        q{Zelda Twilight Princess},
    ],
    [
        q{NASCAR 2006 Total Team Control},
        q{nascar 06},
        q{nascar 2006},
    ],
    [
        q{Gradius 3},
        q{gradius iii},
    ],
    [
        q{Power puff girls},
        q{Powerpuff Girls},
    ],
    [
        q{Amazing Spider man 2},
        q{Amazing Spider-man 2},
        q{Amazing Spiderman 2},
    ],
    [
        q{True Crimes New York City},
        q{True Crimes new york},
        q{true crime NY},
        q{true crime new york},
        q{true crime: new york},
        q{true crimes: new york},
    ],
    [
        q{Black Gameboy Advance SP},
        q{Game Boy Advance SP},
        q{Game Boy Advanced SP},
        q{Game Boy Avance SP},
        q{gameboy advance sp},
        q{gameboy advanced sp},
        q{gba sp},
    ],
    [
        q{Sponge Bob Square Pants Volume 1},
        q{Sponge Bob SquarePants volume 1},
        q{SpongeBob Square Pants volume 1},
        q{SpongeBob SquarePants volume 1},
    ],
    [
        q{Feudal Combat},
        q{Inuyasha Feudal Combat},
    ],
    [
        q{Dungeons and Dragons Eye of the Beholder},
        q{Eye of the Beholder },
    ],
    [
        q{Sponge Bob Square Pants Creature from Krusty Krab},
        q{Sponge Bob SquarePants creature},
        q{SpongeBob Square Pants creature},
        q{SpongeBob SquarePants creature},
    ],
    [
        q{Sly 2 Band of Thieves},
        q{sly 2},
    ],
    [
        q{Tiger Woods PGA Tour 08},
        q{tiger woods 08},
        q{tiger woods 2008},
        q{tiger woods pga 2008},
    ],
    [
        q{Hot Wheels Burnin Rubber},
        q{Hotwheels burning},
    ],
    [
        q{NASCAR Thunder 03},
        q{NASCAR Thunder 2003},
    ],
    [
        q{Diner Dash Sizzle and Serve},
        q{diner dash},
    ],
    [
        q{World Wide Edition},
        q{Yu-Gi-Oh World Wide Edition},
    ],
    [
        q{Bart and the Beanstalk},
        q{Simpsons Bart and the Beanstalk},
    ],
    [
        q{Harry Potter Chamber of Secrets},
        q{chamber of secrets},
    ],
    [
        q{Joe and Mac 2 Lost in the Tropics},
        q{joe & mac 2},
        q{joe and mac 2},
    ],
    [
        q{Bust-A-Move 2},
        q{bust a move 2},
        q{bustamove 2},
    ],
    [
        q{Command & Conquer},
        q{Command and Conquer},
    ],
    [
        q{MC Dance Groovz w/ Dance Pad},
        q{dance groovz},
    ],
    [
        q{Shrek Superslam},
        q{shrek super slam},
    ],
    [
        q{Wario Land 4},
        q{warioland 4},
    ],
    [
        q{CSI Crime Scene Investigation},
        q{CSI: Crime Scene Investigation },
        q{Crime Scene Investigation},
    ],
    [
        q{Dragon Ball Z Legacy of Goku},
        q{Legacy of Goku},
    ],
    [
        q{Mega Man X4},
        q{Megaman X4},
    ],
    [
        q{Allstar Baseball 2004},
        q{all star baseball 2004},
        q{all-star baseball 2004},
    ],
    [
        q{Crash Bandicoot 2},
        q{Crash Bandicoot 2 Cortex Strikes Back},
        q{crash bandicoot cortex},
        q{crash bandicoot: 2},
        q{crash bandicoot: cortex },
    ],
    [
        q{Twisted Metal 3},
        q{Twisted Metal III},
    ],
    [
        q{F.E.A.R},
        q{FEAR},
    ],
    [
        q{Dungeon Dice Monsters},
        q{Yu-Gi-Oh Dungeon Dice Monsters},
    ],
    [
        q{XG2 Extreme-G 2},
        q{xg2},
    ],
    [
        q{Dachshund},
        q{Dachshund and Friends },
        q{Nintendogs Dachshund and Friends},
    ],
    [
        q{ANIMAL CROSSINGS CITY FOLK},
        q{Animal Crossing City Folk},
    ],
    [
        q{Feel The Magic},
        q{Feel the Magic XY XX},
    ],
    [
        q{Duelists of the Roses},
        q{Yu-Gi-Oh Duelists of the Roses},
    ],
    [
        q{America's Army Rise of a Soldier},
        q{Rise of a Soldier},
    ],
    [
        q{Teenage Mutant Ninja Turtles II},
        q{Teenage Mutant Ninja Turtles II the Arcade Game},
        q{Teenage Mutant Ninja Turtles arcade game},
        q{tmnt arcade game},
        q{tmnt ii arcade game},
    ],
    [
        q{Sonic Mega Collection},
        q{mega collection},
    ],
    [
        q{Dalmatian},
        q{Dalmatian and Friends },
        q{Nintendogs Dalmatian and Friends},
    ],
    [
        q{Ace Combat 4},
        q{ace combat 04},
        q{ace kombat 4},
    ],
    [
        q{Grim Adventures},
        q{Grim Adventures of Billy & Mandy},
    ],
    [
        q{Winback Covert Operations},
        q{winback},
    ],
    [
        q{Battletanx Global Assault},
        q{battle tank global assault},
        q{battle tanx global assault},
        q{battletanx: global},
    ],
    [
        q{Fire Emblem Sacred Stones},
        q{fire emblem - sacred stones},
        q{fire emblem sacred},
        q{fire emblem: sacred stones},
    ],
    [
        q{MLS ExtraTime 2002},
        q{extra time 2002},
        q{extratime 2002},
    ],
    [
        q{Mace Dark Age},
        q{Mace: The Dark Age},
    ],
    [
        q{Donkey Kong Country 3},
        q{Donkey Kong Kountry 3},
    ],
    [
        q{Bomberman 64},
        q{bomber man},
        q{bomber man 64},
    ],
    [
        q{StarFox},
        q{star fox},
    ],
    [
        q{FIFA World Cup 2002},
        q{world cup 2002},
    ],
    [
        q{Lord of the Rings Fellowship},
        q{Lord of the Rings: The Fellowship},
        q{fellowship},
        q{lord of the rings - fellowship},
        q{lord of the rings the fellowship},
        q{lord of the rings: fellowship},
    ],
    [
        q{Conker's Bad Fur Day},
        q{bad fur day},
        q{conker},
    ],
    [
        q{Pacman World},
        q{pac-man world},
    ],
    [
        q{Backyard Wrestling 2},
        q{Backyard Wrestling ii},
    ],
    [
        q{Kororinpa Marble Mania},
        q{Marble Mania},
    ],
    [
        q{Street Fighter 2},
        q{Street Fighter II},
    ],
    [
        q{A Series of Unfortunate Events},
        q{Lemony Snicket's A Series of Unfortunate Events},
        q{unfortunate events},
    ],
    [
        q{Donkey Kong Country},
        q{Donkey Kong Kountry},
    ],
    [
        q{Feudal Fairy Tale },
        q{Inuyasha A Feudal Fairy Tale},
    ],
    [
        q{Defender of the Future },
        q{Ecco the Dolphin Defender of the Future},
    ],
    [
        q{Buffy Vampire Slayer Chaos Bleeds},
        q{chaos bleeds},
    ],
    [
        q{SOCOM III US Navy Seals},
        q{socom 3},
        q{socom iii},
    ],
    [
        q{NBA Street Vol 2},
        q{nba street 2},
        q{nba street vol. 2},
    ],
    [
        q{Castlevania Aria of Sorrow},
        q{aria of sorrow},
    ],
    [
        q{Final Fantasy V Advance},
        q{final fantasy 5},
        q{final fantasy v},
    ],
    [
        q{The Getaway},
        q{getaway},
    ],
    [
        q{A.S.P. Air Strike Patrol},
        q{Air Strike Patroll},
    ],
    [
        q{Dragon Ball Z Sagas},
        q{Z sagas},
    ],
    [
        q{Battletoads and Double Dragon},
        q{Battletoads/Double Dragon },
    ],
    [
        q{Midnight Club Street Racing},
        q{midnight club},
    ],
    [
        q{Spiderman Mysterio's Menace},
        q{spider-man mysterio},
    ],
    [
        q{Need for Speed High Stakes},
        q{need for speed: high stakes},
    ],
    [
        q{Rocket Robot on Wheel},
        q{robot on wheel},
        q{robot on wheels},
    ],
    [
        q{Jurassic Park III Park Builder},
        q{Jurrasic Park Park Builder},
    ],
    [
        q{Banjo Kazooie Grunty's Revenge},
        q{banjo-kazooie grunty's revenge},
    ],
    [
        q{Conflict Desert Storm},
        q{conflict: desert storm},
    ],
    [
        q{WWE Wrestlemania 21},
        q{Wrestlemania 21},
    ],
    [
        q{Ultimate Spiderman},
        q{ultimate spider-man},
    ],
    [
        q{Onimusha 3 Demon Siege},
        q{onimusha 3},
    ],
    [
        q{California Games 2},
        q{California Games II},
    ],
    [
        q{Medal of Honor - Rising Sun},
        q{Medal of Honor Rising Sun},
        q{Medal of Honor: Rising Sun},
    ],
    [
        q{Tom and Jerry Magic Ring},
        q{tom & jerry magic ring},
    ],
    [
        q{Boy Genius },
        q{Jimmy Neutron Boy Genius},
    ],
    [
        q{Sonic Adventure DX},
        q{sonic dx},
    ],
    [
        q{Final Fantasy XI w/ HDD},
        q{final fantasy 11},
        q{final fantasy xi},
    ],
    [
        q{Contra III The Alien Wars},
        q{contra 3},
        q{contra iii},
    ],
    [
        q{Bloodrayne},
        q{blood rayne},
    ],
    [
        q{Mystical Ninja's},
        q{goemon's adventure},
        q{goemons adventure},
        q{mystical ninja},
        q{mystical ninjas},
    ],
    [
        q{Star Wars Trilogy Apprentice Of The Force},
        q{star wars trilogy},
    ],
    [
        q{Kill.Switch},
        q{kill switch},
        q{killswitch},
    ],
    [
        q{Brain Age 2},
        q{Brainage 2},
    ],
    [
        q{Ranger Elite},
        q{Spec Ops Ranger Elite},
    ],
    [
        q{Final Fantasy IV Advance},
        q{final fantasy 4 advance},
        q{final fantasy 4: advance},
        q{final fantasy iv: advance},
    ],
    [
        q{Mario vs. Donkey Kong},
        q{mario vs donkey kong},
    ],
    [
        q{Mortal Kombat 4},
        q{mortal combat 4},
        q{mortal kombat4},
    ],
    [
        q{Spyro Collector's Edition},
        q{Spyro Collectors Edition},
        q{Spyro: Collector's Edition},
    ],
    [
        q{Cabela's Dangerous Hunts 2},
        q{dangerous hunts 2},
    ],
    [
        q{Disgaea Hour of Darkness},
        q{disgaea},
    ],
    [
        q{Rocket Power Beach Bandits},
        q{beach bandits},
    ],
    [
        q{Burger Time},
        q{Burgertime},
    ],
    [
        q{GTA 3},
        q{GTA III},
        q{World Driver Championship},
        q{world driver},
    ],
    [
        q{Allstar Tennis 99},
        q{all star tennis 99},
        q{tennis '99},
        q{tennis 1999},
    ],
    [
        q{The House of the Dead 2},
        q{house of the dead 2},
    ],
    [
        q{Metroid Prime Hunters},
        q{metroid prime: hunters},
    ],
    [
        q{Obi-Wan's Adventures},
        q{Star Wars Episode I - Obi-Wan's Adventures},
        q{obi wan's adventures},
    ],
    [
        q{Ape Escape 3},
        q{ape escape iii},
    ],
    [
        q{Track & Field},
        q{Track and Field},
    ],
    [
        q{ACME All-Stars},
        q{ACME AllStars},
        q{Tiny Toon Adventures ACME All-Stars},
    ],
    [
        q{Scooby Doo Mystery Mayhem},
        q{Scooby-Doo Mystery Mayhem},
        q{mystery mayhem},
    ],
    [
        q{Disney Party},
        q{disney's party},
    ],
    [
        q{Federation vs Zeon},
        q{Mobile Suit Gundam Federation vs Zeon},
    ],
    [
        q{Dead or Alive 3},
        q{doa 3},
    ],
    [
        q{Dave Mirra Freestyle BMX 2},
        q{dave mirra 2},
    ],
    [
        q{Medal of Honor  - Vanguard},
        q{Medal of Honor Vanguard},
        q{Medal of Honor: Vanguard},
    ],
    [
        q{Namco},
        q{Namco Museum},
        q{NamcoMuseum},
    ],
    [
        q{Banjo-Tooie},
        q{banjo tooie},
        q{tooie},
    ],
    [
        q{Polaris SnoCross},
        q{polaris},
        q{snocross},
    ],
    [
        q{Starcraft 64},
        q{starcraft},
    ],
    [
        q{Spyro Year of the Dragon},
        q{spyro: year of the dragon},
        q{year of the dragon},
    ],
    [
        q{F zero Maximum Velocity },
        q{F-zero Maximum Velocity},
        q{Fzero Maximum Velocity },
    ],
    [
        q{NCAA March Madness 06},
        q{NCAA March Madness 2006},
    ],
    [
        q{Zelda Ocarina of Time},
        q{legend of zelda ocarina},
        q{legend of zelda: ocarina},
        q{ocarina},
        q{ocarina of time},
    ],
    [
        q{Castlevania Harmony of Dissonance},
        q{harmony of dissonance},
    ],
    [
        q{Dragon Ball Z Legacy of Goku II},
        q{Legacy of Goku 2},
        q{Legacy of Goku II},
    ],
    [
        q{Flash Focus},
        q{Flash Focus Vision Training},
    ],
    [
        q{Scooby Doo Mystery},
        q{scooby doo: mystery},
        q{scoobydoo mystery},
    ],
    [
        q{Beetle Adventure Racing},
        q{adventure racing},
    ],
    [
        q{Robotech Battlecry},
        q{Robotech: Battlecry},
    ],
    [
        q{Kings Field Ancient City},
        q{king's field ancient city},
    ],
    [
        q{Duck Tails 2},
        q{Duck Tales 2},
    ],
    [
        q{KOTOR},
        q{Knights of the Old Republic},
        q{Star Wars Knights of Old Republic},
        q{star wars knight},
    ],
    [
        q{NASCAR Thunder 04},
        q{NASCAR Thunder 2004},
    ],
    [
        q{Star Wars Battle for Naboo},
        q{battle for naboo},
        q{star wars naboo},
    ],
    [
        q{Kelly Slaters Pro Surfer},
        q{kelly slater},
        q{pro surfer},
    ],
    [
        q{Adventures Cookie and Cream},
        q{Cookie & Cream},
        q{Cookie and Cream },
    ],
    [
        q{Super Mario Advance 4},
        q{mario advance 4},
    ],
    [
        q{R.C. Pro-Am 2},
        q{R.C. Pro-Am II},
        q{RC Pro AM 2},
        q{RC Pro AM II},
        q{RC Pro-AM II},
    ],
    [
        q{WCW World Tour},
        q{wcw vs nwo world tour},
        q{wcw vs. nwo world tour},
    ],
    [
        q{Scooby Doo Unmasked},
        q{Scooby-Doo Unmasked},
    ],
    [
        q{Far Cry},
        q{farcry},
    ],
    [
        q{Soul Calibur 2 II},
        q{soul caliber 2},
        q{soul caliber ii},
        q{soul calibur 2},
        q{soul calibur ii},
        q{soulcalibur 2},
        q{soulcalibur ii},
    ],
    [
        q{Disney Sport Basketball },
        q{Disney Sports Basketball},
        q{Disney's Sports Basketball},
    ],
    [
        q{Space Channel 5 Ulalas Cosmic Attack},
        q{space channel 5},
        q{space channel five},
    ],
    [
        q{Star Wars The Force Unleashed},
        q{The Force Unleashed},
    ],
    [
        q{Onimusha Warlords},
        q{onimusha},
    ],
    [
        q{Tomb Raider 2},
        q{Tomb Raider II},
    ],
    [
        q{Super Ghouls 'N Ghosts},
        q{super Ghosts & Ghouls},
        q{super ghouls},
    ],
    [
        q{Wii Remote Controller},
        q{wii remote},
        q{wiimote},
    ],
    [
        q{Power Rangers Space Patrol Delta},
        q{Power Rangers spd},
        q{Space Patrol Delta},
    ],
    [
        q{Bart vs the World},
        q{Bart vs. the World },
    ],
    [
        q{Road Runner's Death Valley Rally},
        q{road runner death valley},
        q{road runner's death valley},
    ],
    [
        q{Marvel Super Heroes vs. Street Fighter},
        q{marvel super heroes vs street fighter},
    ],
    [
        q{Crossbow Training},
        q{Link's Crossbow Training},
        q{Wii Zapper with Link's Crossbow Training},
    ],
    [
        q{Paperboy},
        q{paper boy},
    ],
    [
        q{Sonic Hedgehog 2},
        q{Sonic the Hedgehog 2},
        q{sonic 2},
    ],
    [
        q{Dawn of Destiny},
        q{Yu-Gi-Oh Dawn of Destiny},
    ],
    [
        q{KOTOR 2},
        q{Knights of the Old Republic 2},
        q{Knights of the Old Republic ii},
        q{Star Wars Knights of Old Republic 2},
    ],
    [
        q{Chihuahua},
        q{Chihuahua and Friends},
        q{Nintendogs Chihuahua and Friends},
    ],
    [
        q{Atelier Iris 2},
        q{Atelier Iris 2 the Azoth of Destiny},
    ],
    [
        q{Bust-A-Move DS},
        q{bust a move ds},
    ],
    [
        q{Tomb Raider Legend},
        q{Tomb Raider: Legend},
    ],
    [
        q{Yoshi Touch and Go},
        q{touch & go},
        q{touch and go},
    ],
    [
        q{Chrome Hounds},
        q{Chromehounds},
    ],
    [
        q{Army Men: Sarges Heroes},
        q{Sarge�s Heroes},
        q{army men sarges heroes},
        q{sarge's},
        q{sarge's heroes},
        q{sarges heroes},
    ],
    [
        q{STAR FOX ASSAULT},
        q{Starfox Assault},
    ],
    [
        q{Delta Force Black Hawk Down},
        q{black hawk down},
    ],
    [
        q{Hogan's Alley},
        q{hogans alley},
    ],
    [
        q{Hotel Dusk Room 215},
        q{hotel dusk},
        q{room 215},
    ],
    [
        q{NCAA Football 08},
        q{NCAA Football 2008},
    ],
    [
        q{Pokemon Trozei},
        q{Trozei},
    ],
    [
        q{Far Cry Instincts Evolution},
        q{Farcry Instincts Evolution},
    ],
);

plan tests => scalar @tests;
my $phonetic = Text::Phonetic::VideoGame->new;
for my $test (@tests) {
    my $msg = $test->[0];
    my @encodings = $phonetic->encode(@$test);
    my @unique = uniq @encodings;
    if ( @unique == 1 ) {
        ok( 1, $msg );
        next;
    }

    # if the hashes don't match, produce more helpful output
    my ( %got, %expected );
    @got{ @$test } = @encodings;
    @expected{ @$test } = ($encodings[0]) x @encodings;
    is_deeply( \%got, \%expected, $msg );
}
