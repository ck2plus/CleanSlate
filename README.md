CleanSlate

Master Changelog

=== For players ===

= General improvements =

Simplified/prettified many tooltips
Fixed countless minor issues and oversights
Fixed various grammatical and spelling errors in localisation
Many opinion changes are shown to both characters involved (but only applied once, of course)
Many opinion modifiers are now applied to the correct character
Several opinions are now checked for the correct character
Improved game performance, dependent on enabled DLC, game rules, start date, etc. (your mileage may vary, naturally)



= Changes/oversights =

Open Succession is now only unlocked, not enacted when a religion is reformed with Agnatic/Enatic Clans, to be consistent with these features' tooltips
Only the 'feminist' Christian religions (Cathar, Messalian) start off with Agnatic-Cognatic gender succession, instead of all of them
All event-driven deaths occur instantly in multiplayer, rather than on clicking the event option
Various events check the number of personality traits, rather than overall number of traits, before possibly adding a personality trait
Events about healing from disease and wounds now instantly remove those traits in multiplayer, so you won't die from those traits before clicking the event option
Sons and brothers of rulers will only ask to join a holy order if in the court of a parent/sibling, since only they should have a say in disinheritance



= Bugfixes =

Random tiger accidents now only happen in India, rather than only outside India (random_accident_death_effect)
Added missing notification events in various places
Added missing 'No longer humble/proud/trusting' notification event calls
Corrected wrong notification event for becoming shy
Gaining and losing Temperate and Gluttunous will now always adjust a character's weight
A successful faction to increase council power now increases available council laws in the correct order
'stable_attribute_improvement_effect' now also never causes burnout the first time for diplomacy and martial, not only stewardship, intrigue
Holy Family is now selected properly (child and sibling) upon reforming with the correct religion features
Holy orders will now actually abdicate their leaders if not the correct religion and also keep in mind heresy takeovers of holy orders
Fixed events where old religion wouldn't be set as secret religion
Removed obsolete event MNM.10025 (save game conversion of secret_traits to secret religions)
Removed obsolete event ZP.5 (converts old pet traits into modifiers)
legitimize_bastard decision now works for polygamist religions
Fixed bug where a ruler wouldn't take their child out of hiding if they, personally, had a plot against them but not the child
Leaders of holy orders now abdicate as soon as they convert to a different religion (players excluded, just in case)
Added various checks preventing holy order leaders from converting religion in some events
Fixed baptism decisions, no longer blocking a non-religion head baptism
Fixes several logic errors in the baptism event which could/would cause a satanic character to be baptised into the satanists by the pope
AI will now properly enact useful Centralization laws, keeping in mind both vassal limit and demesne limit
The Fraticelli Papacy will now also use papal succession
AI can now found bloodlines through ambition
The first leader of a newly founded holy order is now of the proper religion, instead of Catholic
Dissatisfied vassals are now more likely to go independent, instead of less likely, for not liking their new liege, after a succession of a ruler who was over vassal limit
Characters can now get Aztec Syphilis randomly
The various German kingdoms can no longer be created in other starts, and only if non-titular in 936, or by event
Various achievement requirements are now consistent with their descriptions
Provinces in which peasants/heretics/rebels/nationalists rise up will now get reduced revolt risk for five years
Grace is now taken away from both claimant and attacker in third party CBs (other_claim and other_dejure_county_claim)
Catholic/Fraticelli AI will now wage fewer wars only if they are not yet coronated and are actually eligible for coronation
Tribal Kinslayer will now be added whenever it should be
Safe religion checks no longer allow game-overs
Player heir's secret religion is no longer cleared on player death, since only public religion is restricted by DLC
Fixed exploit allowing plot leader to frame a plot backer
Fixed a wrong event call in 'Carriage Accident' and 'Decadent Debauchery' plot event chains
Merchant Republics can revert to Minimum Crown Authority again
Merchant Republics will no longer spawn and destroy patrician houses under Holy Order lieges
All GHW-traits are now taken into account for succession screen heir flavour text
Added female title for d_bon_reformed
Removed duplicate Chinese temple names
The Jomsvikings now convert to Reformed Germanic if they were founded before the Germanic religion is reformed
A theocratic Germanic religious head will no longer have gavelkind succession, but open elective, like all other theocratic pagan religious heads
Brazen Bull and Dragon Burning decisions now also apply kinslayer traits, if applicable
Claim Duel decision is now available when having a strong claim on any of the target's demesne titles, not just the primary title, matching the description
Added expelled modifier for k_teutonic_state
Becoming Genghis Khan without Horse Lords enabled will now also give the appropriate bloodline, if Holy Fury is enabled
The Teutonic State is now also checked wherever the Teutonic Order is checked
AI devil worshippers can now recruit other AI into their societies
You can no longer game over by restoring the Pope in Rome by decision
Torture decisions now properly use the torturer's capital location, rather than the victim's
The nomad prisoner humiliation (tar and feathers on horseback) now properly works for nomads only, instead of for everyone but nomadic and tribal torturers
Landed holy orders can no longer request mass baptism
Fixes issues where councillors could possibly not take a vote stance due to having certain exact opinions of their liege or other characters
Malcontents may now vote along with their liege on status of women laws, depending on their gender, enabling long dormant script
Fixed some council vote tooltips being misleading, even if they worked correctly
Made many other council vote tooltips easier to read
Impregnation scripted effects no longer work on children
Province names are now displayed when their prosperity slightly increases/decreases due to decisions/events
Various events for the Knights of St. John and the Knights Templar should now work after the Schism has been mended and the orders have become Orthodox
Various birth events (449, 456) now properly check for required participants
Event 1926 now requires child to be attractive or groomed, and is now properly restricted to lacking Conclave DLC
Event 1935 now checks diplomacy instead of intrigue
Event 1986 is now exclusive to muslims only
All childhood events are now restricted to non-imprisoned, non-incapable children
Events 38200 - 38204 no longer check traits of the grandfather instead of the father
Various non-Conclave childhood education event options now affect the child instead of the guardian
The Pope will now also lift the excommucation for rulers under a non-Catholic top liege
Muslims who have changed their succession away from Agnatic can now press women's claims
Rulers on a hunt who are being targeted by a courtier's murder plot can no longer kill everyone at court, who isn't part of such a plot, in an ambush. Instead, one courtier is picked randomly, excluding the ruler
Fixed requirements for the Phalaris bloodline event in alternate starts
The capital of the Golden Horde/Il-Khanate will now always convert if the ruler converts, instead of only on conversion to Catholicism/Nestorianism
Mourning event 24504 will no longer cause bastard children
Restored old Crusade announcement for all characters who can't participate offensively, so they won't be caught off-guard
Plots now won't be leaked to anyone who is backing any plot that isn't yours - instead they need to not be backing your plot
Plots leaking no longer depends on the plot backers of your liege instead of your own
Only one realm lord will discover any plot at a time, instead of everyone eligible to discover it
Added checks to prevent plots with many backers/high plot power from affecting plots with much fewer backers/less plot power - as a result successful kill plots may now be rarer
Changed traits that affect child drowning chance in event 7805 to match survival chance, as well as the incapable drowning plot
Plot event 7835 now calls on_action event 11 for consequences of plot discovery, in line with all other similar events
MTTH for plot leaders to see opportunities no longer depends on other character's backed plots to have high plot power, instead of their own plots
Fixed Assassination quest checks in all murder plot events, potentially making this quest a lot more difficult to complete...
Plot backers can now only see opportunities to kill decadent characters if they also use decadence
Added 3 missing 'plot_power' checks in event 7801
Plot backers are no longer twice as likely as the plot leader to see an opportunity to poison a plot target's wine, matching other plot opportunities
Disabled straggler duel events in 'Courtier takes over regency'-event chain
Regents will now also lower crown authority if their crown law title is not the de jure liege title of their primary title
The Catholic/Fraticelli Pope and Ecumenical Patriach now disapprove of all non-Christian councillors, not just Muslims and pagans (event 39240/39260)
Several religious events properly check for the overall religion head, instead of possibly checking for antipopes
Reworked event (39271) in which the Pope demands a ruler replace a bishop. Now a new bishop is created instantly and subsequent messy events have been disabled.
Events 39701 and 39702 are no longer MTTH, but called on_character_convert_religion instead
Event 39705 (Restore the Pope in Rome) is announced as a major event once more, just like event 39706 (Restore the Ecumenical Patriarchy)
Vassals no longer steadfastly refuse to attend their liege's Bema festival because they dislike themselves
Fixed event option triggers for vassal invitation to Sadeh festival
Used event targets to display same character in all relevant event options in various events
Fixed wrong event call in incest rumour event 69010
Fixed weight modifiers for siege events (used to be MTTH), so better commanders are now more likely to get good siege events, etc.
Added province 1713 (c_arezzo) to the Tuscan Raiders siege event
Vacant titles with elective succession no longer plan to hold elections
Grand tournaments will now also be cancelled if war breaks out after the tournament has already started
Event chain starting with event 3095 now actually uses the lord spiritual instead of the steward, as intended
Event 3145 will now only target women younger than the woman receiving the event
Event 3220 will now only cancel the ambition to reject pride, rather than any current ambition
Event 3610 will now only cancel the ambition to reject cruelty, rather than any current ambition
Event 3520 can no longer cause bastard children
The zealous option in event 3525 now has the correct text
Restored missing character flag in first option in event 3540
Fixed various event tooltips in Brazen Bull event chain (events 3600 through 3604)
Switched job_spymaster and job_marshal in event options of event 3650, matching localisation
Lovers event 64105 now also breaks the love relationship before adding a rivalry
Event 65057 will now only fire in January, as the localisation suggests it should
Event 65092 is now delayed by 2 days, to match localisation
Fixed localisation key EVTDESC65125
Event 65031 is now aware of The Reaper's Due diseases
Event 78020 now always checks for presence of other children at court
Corrected Muslim tooltip in event 94153
Civil war events no longer spawn characters to lead troops, since they can't actually lead troops
Fixed broken Altaic modifier on event 55001
Norse and Norman rulers can now adopt local French, Occitan and Breton culture after 1150, at which point in time Norman culture stops forming
Fixed council eligibility logic for events 77790 and 77760
Event 100180 now only confronts friends who are a heresy to ROOT, rather than any random heresy
Added missing disease checks to event 100410
Fixed event 100412
Fixed scope for event call 100427 in event 100427
Fixed various issues in event chains starting at events 100510 and 100530
Corrected several capitals for kingdoms and duchies that were outside their de jure borders
Fixed wrong religion moral authority checks in various diplomatic requests from the Pope
Mothers now also won't be heartless to their own children in event 65056
Added various missing translations for bodies of water and wastes
The Papal States can now only be usurped by non-Catholic AI, or AI who personally hold both the Duchy of Latium and the County of Rome. There is no additional restriction for players. This check existed for Romagna instead of the Papal States.
The Duchy of Amalfi is now de jure part of the Kingdom of Sicily in starts where it is not titular (before 1060)
Titular Turkish kingdoms in e_byzantium now must be non-titular to be recreated if destroyed
Fixed automatic usurpation of theocratic rulers on religious conversion
Eulogies will no longer speak of a 'young child' when the deceased was in fact no longer a child
Temporary title holders (decadence invasions, claimant hosts, raiding hosts, peasant revolts, etc.) can and will once again appoint commanders
Added Hajj backup cleaning event for invited characters who did not have it
Ensured Hajj events will only fire if characters are eligible
Various event options now show up as they should (correct flags are set/checked)
The Fedayeen (d_hashashin) is now (re)created with order government instead of feudal government
Fixed inconsistencies between tournament events and furusiyya events
Backported martial-coloured event window borders from Furusiyya events to tournament events
Princely Elective electors no longer consider their own prestige and piety when voting for themselves, matching all other succession voting patterns
A few other succession voting considerations also ignore the voter voting for oneself
Lord Spirituals will now only convert provinces faster by virtue of their liege owning a finger of St. John if that liege is also Christian
Lord Spirituals can now sabotage relations between other priests and the religous head if the religious head is independent
The pope will no longer trick tribal kinslayers into absolution, then refuse to come through
Event 3607 now properly increases intrigue instead of stewardship
Vassals now will not start/join any factions when in seclusion or preparing an invasion, rather than just a select few factions
Independence factions are now properly blocked in merchant republics
Claimants for claimant factions now properly check succession law and religion features, fixing a longstanding vanilla bug (no more female claimants in the Arabian Empire in 769, etc.)
Non-claimants eligible for claimant factions for titles with feudal/princely elective succession are now properly required to be electors for that title
Players now also cannot join factions if coerced by their liege to leave another faction, matching AI behaviour
Fixed elder selection criteria relating to former elders who are direct courtiers to the current title holder
Characters should now abandon all ambitions and focuses if they no longer meet the requirements
Characters ordered to take the vows now also lose any consorts they might have, in addition to spouses
Non-dynastic children can now also be sent into hiding and taken out of hiding
AI non consider all possible succession laws when considering to send kids who are not their heir into hiding
All rulers can now go into hiding, not just all playable rulers
'fantastic commanders' now also spawn with a zodiac trait, if appropriate
Added support for Qarmatian in various events, decisions and more, in particular secret religious societies
All secular religious head titles are now forfeit upon openly adopting a secret faith, not just Caliphates and the Fylkirate
Ambitions and associated decisions to gain land for an unlanded child no longer consider dead children, bastards and eunuchs
Most bloodline checks now also require the bloodline to be active
Portrait triggers now consider all spouses, rather than just the primary spouse
Aztec and Zunist secular religious heads will now also obey the Martial Headgear gamerule when charging headfirst into battle
Bacchants are no longer impressed by one-eyed Odin-impersonators
Added checks in several CBs to ensure patricians are not vassalised by non-Merchant Republic rulers
Eldership succession now properly praises candidates for their stewardship skill, instead of martial skill
Ensured Palnatoke can't try to clone himself and establish the Jomsvikings in two places simultaneously
When a holy order grandmaster demands a son in return for a loan, the son now loses his money instead of the grandmaster
Grandmasters will now only demand sons who match their religion
Non-Muslim sons now also lose their concubines when joining a holy order at the grandmaster's request
Sons sent to the Bektashi at the grandmaster's request will now also be disinherited (just like sons sent to the Assassins and Haruriyyah)
Holy order events account for k_teutonic_state in addition to d_teutonic_order
The Teutonic State can now also be expelled, in addition to the Teutonic Order
Corrected various wrong localisation keys
The Knights of the Sun and Haruriyyah are now created with order government instead of feudal government
You will now only have a chance to visit Cluny and Athos if you are close to it, rather than if you are not close to it (SoA.5342)
When a devil worshipper is impregnated in an orgy, the dark lord may now properly decide to replace the seed with its own
clear_disease_level_effect now also clears all treatment modifiers
Ensured various Diwali feast events always fire when they should
Ensured various Guru events can now fire for Bon characters
Ensured various Tiger hunt events only try to fire if eligible
Dharmic holy orders are now created with order government instead of feudal government
Fixed the religious outcome of visiting Nalanda university not clearing the do_not_disturb-flag
Fixed visiting the Ganges clearing instead of setting the do_not_disturb-flag
Should Charlemagne die before Carloman, their mother will now actually visit Carloman about reconciliation, instead of only practicing in the mirror
Meddling mothers who seduce spouses will now actually become lovers as well, and only homosexual mothers may seduce female spouses
The Chronicle for player heirs dying now works properly
Fixed trigger for various Chronicle events (CM.10021)
Various chronicle entries for religious heads now also account for antipopes and patriarchs
The Start of the Viking Age will now also build shipbuilders in holdings held by rulers of a wrong government type
Passing Zun's judgment now clears all imprison reasons a liege has, rather than just a small selection of them
Matched 'into/out of hiding'-notification event options trigger logic to match 'send into/take out of hiding' decisions in dynasty_decisions, expanded decisions to fire these notification events for all close relatives, friends, lovers and rivals
Murder plots for characters in hiding now require the target to actually be in hiding, and all other murder plots require the target not to be in hiding
Investing more gold in murder plots for targets in hiding now actually increases the chance of success and reduces discovery chance
Fixed a vanilla bug where cultural buildings would be visible in all castle holdings in a province if it was built in any one of the holdings
Fixed a vanilla bug where the status of women laws wouldn't be applied in succession voting in secondary titles because it was checking against the wrong title
Opened up the Hagia Sophia conversion event to catholic and orthodox heresies as well
Event WoL.2305 will now correctly fire WoL.2304 to the spymaster's liege
Removed double STD and impregnation chance for event WoL.1161 and follow-up events WoL.1162/WoL.1163
Ensured the Aztec emperor has enough prestige to declare his invasions.
Chinese Envoys who are unhappy with their liege may now, after many years, resign after at least 500 days of service (HL.5002)
Fixed scope issues in tributary detection in event ZE.9000
Chance for childhood prison pet rat to get sick now the same regardless of name chosen
Now actually possible for a player with heritage focus or in house arrest to reject culture change
Events ZE.2130 and ZE.2140 now correctly display if the asker will be offended
Prevented "Daughter protests against marriage" event ZE.1011 from firing twice on the same marriage
Eternal Life Mystics now won't accept invitations to court until the quest has been completed or aborted
Reincarnated rulers from the Eternal Life event chain will now gain all appropriate religious traits, flags and modifiers
Ensured all events of the actual search for immortality can continue if imprisoned
Reworked investigator selection in RIP.21499
Reduced potential impact of RIP.21112, RIP.21114, RIP.21212, RIP.21214, RIP.21314
The Il-Khanate, Golden Horde and the Mongol Empire are no longer landless, letting them finally change succession laws again, and properly switching them over to open succession on conversion to Islam
The Chagatai Khaganate now also uses ultimogeniture, if Horse Lords is disabled
If eligible to restore the Byzantine Empire by decision, it can no longer be created normally, to ensure Imperial Elective succession and Imperial Government are restored.
Flag from declining guide dog now set on the correct character (RIP.4011)
Indian pilgrims now receive the correct trait in RIP.4501
RIP.12007 now respects celibacy and sexual orientation.
Improved trigger for fallback option in RIP.21001.
Event 39400 no longer shows the portrait of the satanist who caused the province to fall to heresy.
Fixed various religion head checks for lifting the excommunicating of other characters
Religious heads no longer care about strange otherworldly 'Christian' ideas when considering requests from their faithful
Fixed various checks on the asker and target in the 'ask for claim'-interaction accept chance
Faction ultimatum events will now always show faction backers, where previously none would be shown if there were more than 10 backers
The Jomsvikings are now also founded with order government instead of feudal government
Councillors married to you will no longer complain to you, their liege, about their bothersome spouse (ZE.8110)
The Pope will no longer request you to attack rulers who hold land in the Papal States if you have a truce with the target ruler (HF.20201)
Charlemagne will now lose his uncrowned modifiers when crowned emperor through his special event (CM.1500)
Charlemagne now properly remembers the pope who coronates him (CM.1500)
Secular religious head titles can now have secular succession laws and non-agnatic gender succession laws when held as a primary title

=== Monks & Mystics

mnm_artifacts_events
You can no longer thank a councillor who found an artifact with a favor if you already owe a favor, and the option is no longer available without the Conclave DLC
Capital sieges will no longer have a chance of the attacker stealing your artifact if you are leading troops in your liege's capital.

mnm_devil_worshippers_decisons
Devil Worshipper societies are now visible if you have the appropriate religion openly or secretly.
AI characters should now be able to dark divorce their wife if the wife hasn't and isn't likely to give them an heir, as intended
Prisoner sacrifice sound effect now determined and played independently of if you have a quest to sacrifice them.
Characters can now only be inducted if they are openly of the correct religion

mnm_secret_religious_societies_decisions
secret_religions_openly_adopt_faith now flips provinces with secret communities directly from the decision; the events are just notifications now.
Now flips all realm provinces with a secret community, rather than only the cult leader's demesne + the demense of characters who were sympathetic but not in the cult.

mnm_assassin_events
Assassins debt amount owed now visible in the tooltip of the modifier
The assassins_debt modifier was renamed to assassins_debt_modifier as sharing a name with variable was interfering with the localisation.
Only paranoid characters will falsely suspect their spouse of cheating while high, as intended
MNM.6812 now picks more appropriate lovers
The Friend or Foe event chain now chooses a target similar in age to you, rather than dissimilar
Outcome of MNM.6906 now affected by if the target is attracted to the sender rather than themself
Now actually kicks to the backup event if your inductor dies mid induction

mnm_devil_worshipers_events
Assassins no longer praise Shaytan in the backup recruitment event (MNM.7030?)
Now sends the recruitment cancelled messages to the correct character.
A message in the middle of the recruitment chain is no longer sent by a random society member
No longer possible for your inductor to show up two weeks early
AI no longer given impossible to target quest targets for the corrupt priest mission
Dark healing will no longer remove phantom pain when you are still one-eyed.
Failed inductions of prisoners can now make the target possessed/luntic/wounded, as intended
Sound effects now play even if you don't have the quest
Can now actually gain deceitful and gluttonous in MNM.20049, as intended
Now actually possible for soul corruption to cause witch hunters to come after you, as intended
Fixed potential undesirable randomness in event MNM.7123
The priest of the desecrated temple will no longer die if not present (MNM.7113, MNM.7114)

mnm_grand_debate_events
MNM.5202 now actually tries to select a rival
MNM.5210 now displays the correct opinion modifiers
The host of a Grand Debate now has their debate score initialized/reset at the start, just like the invitees

mnm_hermetic_events
Now possible for the Infiltrate lab mission to target someone because they have stealable hermetic artifacts, as intended.
MNM.1451 now displays the chances based on the correct character's traits
Refuting a paper now grants the correct opinion modifier
MNM.1641 should now display the correct description
MNM.1810, MNM.1815, and MNM.1820 should now display the correct option name
Fixed the 'Failed Prediction' modifier having no duration
Now actually possible for the infiltration target to rival your companion if you get caught
You're no longer busy doing nothing for a while after declining a quest to gather ingredients
The social outcome of stargazing can no longer occur before you've actually started preparing for it
Hermetic members can no longer name a star after themselves more than once
Choosing a hermetic art now shows the traits in the initial event

mnm_indian_pilgrim_events
Fixed MNM.8035 not showing the correct localisation

mnm_job_offmap_events
Fixed a typo that caused ai spymasters to sometimes have a worse chance of surviving thug attacks than they should have (MNM.70023)

mnm_monastic_orders_events
Invited monks and nuns now have a chance to gain diligent, as intended
Invited monks and nuns now can have "the wise" nickname when they are smart rather than dumb
MNM.4609 should now display the correct descriptions
Now actually applies the gardening and fell asleep cooldown timers
Removed some exploits from the monastic theft event chain
Now actually possible to burn multiple books in MNM.4217
Hindu monastic members no longer try to remove lustful from/add chaste to their wards
Now possible to get the sarira artifact from the monastic theft event

mnm_secret_religious_societies_events
MNM.3502 now actually removes stressed and depressed from your companion as well, rather than from ROOT twice
Fixed MNM.3434 being mostly evaluated from the wrong scope
Fixed MNM.3435 always having a 50/50 chance of the kid converting/becoming your rival. Should now match the chance displayed in MNM.3434.
Now actually flips all provinces with a secret religious community not held by the cult leader when the cult goes public.
Check added to prevent players converting to an unsafe religion if they are part of cult that goes public but are not the grandmaster.
You can now fall in love with a close relative in your secret religious society if feeling stressed, so long as both of you are okay with incest (MNM.3502)
MNM.3430 can now fire (consider whether to read your secret religion's holy scripture to your child)

mnm_smith_events
No longer better to have an utterly imcompetent smith. Chance to upgrade the item upon 'success' rather than 'failure'.
No longer possible to make a profit when you have a sufficiently large yearly income by hiring a smith and then killing them
Now get a refund if the smith dies while creating quality 4 items
Now possible to get a refund if your smith dies after asking about upgrades but before finishing the item

=== Jade Dragon ===

Guru changed from character flag to character modifier for clarity.
Strategist now made into a minor title, to make more clear that duplicates are redundant.

Fixed bad changes to the like/dislike tooltips
Removed show_only_failed_conditions from the third_party_potential of decisions with show_third_party_potential = yes, as this was confusing and made it hard to figure out what exactly the requirements were.
Moved prisoner = no from potential to allow blocks of those decisions, since its something the player might be able to quickly change to get a usable courtier.
Married people now excluded from the third_party_potential of the chinese_imperial_marriage decision
Removed obselete event JD.60005, converting prosthetics into artifacts

JD.10018 (Courtier returns from China) now respects celibacy and sexual orientation
JD.32299 now actually clears kowtow flags when a kowtow is forced to be canceled.

=== Holy Fury ===

HF_alternate_start_events
All holy orders now start with order government in alternate start, instead of feudal government
The name and CoA of the Papal Guard, Scholae Palatinae and the Treasure Fleet are now also randomised in alternate starts
The Hellenic and Norse religious head titles also get a randomised CoA in alternate starts
The Order of Saint Anthony is no longer created twice once the great holy wars unlock in alternate starts

HF_antagonize_events
Antagonizing is now much more likely to end once the target has become your rival
Antagonizing will now immediately end if the yearly pulse finds a reason to end it (becoming friends/lovers, the target becoming imprisoned, incapable or if either of you is secluded but you are not secluded in the same place)
Losing craven/gaining brave in HF.22035 is now based on one's own traits

HF_baptism_events
Vassals who falsely convert in a sponsored baptism no longer disband their secret religious society they're leading
Restored missing tooltip in event HF.20048
Rulers receiving a mass baptism will no longer think of their lovers when considering offering friendship to their sponsor, instead keeping in mind how many friends they have
Moved mass conversion tombola random event delays to the tombola event calls instead, so events can always fire, all events now fire with a uniform delay
Child baptisms will no longer look for imprisoned godparents
The Fraticelli pope can now also baptise children the same way the Catholic pope and the Orthodox ecumenical patriarch can

HF_battle_events
Event 79009 (Shieldmaiden can save liege on battlefield) can fire once more
Added missing logic that determines event descriptions and options in event HFP.11011
Ensured HFP.11019 (PTSD after battle) only shows event options matching the event description

HF_bloodline_acquisition_events
HF.199 (extra chance for player children to become a Child of Destiny) can now actually fire even if the child is not a player, but a child of a player

HF_bloodline_events
Fixed the Murder Builder Hybrid bloodline not being created when the last requirement being fulfilled is constructing a new holding (HF.24022, HF.24023, HF.24024)
Murder plot events involving the Murder bloodline now always kill instantly in multiplayer, fixing exploits.
Fixed HF.24252 randomly displaying the special description for Matilda if she is not involved

HF_childrens_crusade_events
Fixed the portrait of the leader of the Children's Crusade not appearing on some on_action events
Merged events HF.25821, HF.25822 and associated scripted effects into HF.25820

HF_coronation_events
Rulers are now more, not less likely, to request a coronation from the Pope if the Pope likes them a lot (HF.20200)
The Pope is no longer annoyed you didn't ask him to coronate you if you have an antipope (HF.20200)
Priests can no longer demand children not in your court to be sent to a monastery/nunnery (HF.20201)
Priests can no longer demand children who are the primary heir to anyone, rather than not just your primary heir, to be sent to a monastery/nunnery or a holy order (HF.20201)
The Pope now doesn't look for a ruler who hates him, but rather a ruler the Pope himself severely dislikes (HF.20201)
The Pope now properly receives his desired titles and vassals in Italy (HF.20216)
Eliminated hidden events HF.20234
Fixed random event description in event HF.20308
Event HF.20329 can no longer give Conclave childhood traits if Conclave is disabled
Fixed rival selection in HF.20334
Knights who show up for coronations will no longer be crusaders if crusades have not yet been unlocked
Lieges receiving homage will no longer consider their special relationship to their liege in deciding whether to reject the homage. Instead, the special relationships to the vassal are under consideration instead. (HF.20396)
Special artifacts for temporally reformed West African, Zun, Baltic, Azted, Bon and Hellenic pagans are now also always transferred upon title usurpation (HF.20414)
Merged HF.20406 and HF.20407 into HF.20415
Fixed a wrong event call in HF.20408 (ruler to be coronated converted before coronation was finished)

HF_religious_events
Close relatives will no longer get upset if succession laws don't change after converting to a religion that mandates different gender laws (for patricians, for example) (HF.23034)
Close relatives will now get doubly upset over succession law changes if changing from a patriarchal religion to a matriarchal religion, or vice versa, and are no longer doubly upset after switching from an equal gender religion to either patriarchal or matriarchal (HF.23034)
Added missing script for very bad omens to 'Interpret less favourable omen to avoid bad modifier'-option in event HF23400
Fixed random descriptions in option 2 in event HF.23401
Fixed descriptions not matching between HF.23402 and HF.23403
Fixed wrong logic in event HF.23430, awarding burned heart points
Option C in HF.23462 no longer decreases capital prosperity twice
The Myrmidons are now created with order government instead of feudal government
Fixed potential random event pictures in events HF.23760/HF.23761
Fixed it being impossible to teach someone about personal combat skill in event HF.23760 (Meliorism religion feature)
Fixed change of burnout during attribute improvement (Meliorism) depending on the character teaching the improvement, rather than the character learning from the teacher (HF.23760)

HF_saint_flavour_events
Fixed event HF.46001 handing out random traits instead of traits of the local saint that the character receiving the event doesn't have

HF_sainthood_events
Added fallbacks for circumstances that could, in very rare cases, stop a beatification and/or canonisation in progress

HF_saintly_bloodline_events
Added missing Christian religions to HF.43400, can now all join an appropriate monastic order

HF_saintly_pilgrimage_events
Made events HF.41340, HF.41370 and HF.41400 aware of The Reaper's Due's various dismemberment traits
Ensured pilgrimages to Saints will end on imprisonment
Running away from a bear in HF.41370 no longer ends the pilgrimage
Event HF.41410 (Weird village) now only fires if supernatural events are enabled per game rule, rather than disabled. It also won't stop the pilgrimage from sometimes seemingly ending without reason, if the game rule isn't enabled.

soa_pilgrim_events
Ensured Christian pilgrimages always end on conversion to a different religion group

HF_sway_events
Ensured no unsuitable events will fire when at war with sway target
You will now only gain sympathy towards the religion group of your sway target if you inquired about their religion (HF.21078)
AI now correctly judges war score and also keeps in mind whether it is attacking or defending when considering to suggest a white peace to their sway target, and not when considering to meet under armistice (HF.21140)
Accepting a white peace from someone swaying you will now only end war in which and your swayer are the primary attacker and primary defender (HF.21141)
HF.42009 (swayed rejected help in increasing education trait) is now sent to the swayer instead of the swayed
HF.42062 now knows about The Reaper's Due's various dismemberment traits
Fixed various attributes/skills being checked on the wrong character in option B (don't aid swayer) in event HF.42026
Fixed many inconsistencies in event HF.42046 and follow-up events

HF_tribal_events
Fixed wrong event call in HF.23801 (society members would hear the tribal event is cancelled because war broke out, when in fact the ruler had died)
Guests abandoned in the wilderness are no longer subjected to two tests that wound, maim or kill them (HF.23831/HF.23832)

HFP_crusade_events
The Pope will no longer be mad if you for not crusading when you are, in fact, crusading (HFP.41144)
The Pope can now excommunicate rulers who repeatedly dishonour their crusade pledge, even if he does not own Rome (HFP.41140, HFP.41142)

HFP_crusade_flavour
Establishing a crusader state no longer usurps all titles within, held by Christians (HFP.42000)

HFP_duel_events
Duel events for titles try to display the most relevant title in event descriptions
Duels can now only spark a romance with a close relative if both combatants have a religion allowing incest, not just the challenged character

HFP_health_events
Fixed many issues in maintenance event applying weight changes dependent on various traits and modifiers, including:
 - all characters with a crusader-trait can now lose weight, not just Christians
 - being apathetic no longer causes extreme weight loss
 - all patricians, not just leaders of merchant republics, now gain some weight
 - parents will only gain weight if they're raising children who are alive, and not if all their children have died

You can no longer both:
 - lose greedy and gain charitable (HFP.20611)
 - lose cruel and gain kind (HFP.20613)
 - lose slothful and gain diligent (HFP.20615, HFP.20630)
 - lose cynical and gain zealous (HFP.20635)
 - lose humble and gain proud (HFP.20663)
 - lose wroth and gain patient (HFP.20664)
 - lose ambitious and gain content (HFP.20665)
 - lose proud and gain umble (HFP.20666)
 - lose kind and gain envious (HFP.20667)
 - lose kind and gain cruel (HFP.20668)

You can no longer lose an extreme amount of health in the bottom option in events HFP.20647 and HFP.20648, as well as events HFP.20661 and HFP.20662

HFP_pregnancy_events
Fixed one event description never showing in event HFP.20507
The tooltip in event HFP.20515 now reflects that the regent is indeed killed instead of imprisoned.
Fixed mother's not receiving loving attention from their sons when pregnant (HFP.20578)
HFP.20027 can no longer downgrade children from genius to quick and will now always give a positive trait
HFP.20059 and subsequent events can now fire

HFP_religious_events
Made the Pope much better at requesting historical Vatican lands before lifting an excommunication

Warrior Lodge events
warrior_lodge_slavic_stand_together character conditions now match the event
warrior_training now conditioned on the number of leadership traits rather than lifestyle traits

Dice event chain now removes favor from the correct character (HF.25230)
Dice event chain cheating options now displayed appropriately (HF.25229)
Losers who challenge their opponent to a duel are no longer indignant at themselves (HF.25268)
Scorned host now actually informed that you turned down their offer at the end of a drinking contest (HF.25296, HF.25298)

HF.550, AI warrior lodge members random duel, now actually restricted to warrior lodge members rather than any society members
HF.550 now only requires that a suitable target exists in ROOT's realm or a neighbor's, not both
Consorts of ROOT are no longer valid duel targets in HF.550
Fixed AI not gaining the trait rather than not paying in HF.14003
Fixed HF.51000 not accounting for number of artifacts correctly
Fixed competent characters being more likely to fail in HF.51002
Fixed HF.51002 setting ROOT as the forger and portential sacrifice
The outcome events of the HF.51000 chain now repeat themselves rather than rolling up a new event when you are unavailable

HF.12001, option A no longer displays the portrait of a random ruler

Fixed the 'Duel someone to the death' mission checking that you didn't exceed a distance limit from your capital rather than the target (HF.10510)
Slavic Stand Together decision no longer recruits from among all members of any society (HF.25008)
HF.25008 no longer fires a commander if you have free commander slots
HF.25008 now respects celibacy
HF.25021 now adds the opinion modifiers to the correct character's relatives when you sacrifice a courtier
Max number of commanders no longer softcoded in HF.25000, Summon Commander

The Warrior Lodge war aid event chain now has a resolution when the war ends due to becoming invalid (HF.50101)
You can no longer be asked to join a war against any of your lieges, not just your direct liege (HF.50100, HF.50101, HF.50102, HF.50103, HF.50002)

Co-hunter can no longer help you from beyond the grave
Now actually possible to die in HF.25603 and HF.25606 as a result of selecting option C
HF.25604 and HF.25607 now respect celibacy and prohibitions on incest
Events no longer hand out favours without having Conclave (HF.25604, HF.25607)
No longer locked out of both the lunatic and possesed options if you have both traits in HF.25615
You no longer share the meat with all members of all societies in HF.25628

Fixed various dishonorable duel effects not being applied in warrior lodge training events
Fixed AI having to pay in HF.14003, and not having a chance to become proud
Warrior Lodge missions to Loot a holding should now always clear out if the target title somehow ends up in your realm (HF.25510)

=== LT ===

The "Ask Courtiers to Leave Court" decision event_chain should be much better at selecting unwanted courtiers
Characters who are excluded from being selected can no longer have their spouses selected for expulsion and thus themselves.
Characters are now expellable if they haven't had any children with ROOT, rather than any child not with ROOT
Adult children are no longer expelled along with their parents.
In LT.61002, courtiers can now fall in love with people they like, rather than dislike
LT.61002 now respects celibacy
In LT.61006, restored some nicknames that were unable to be assigned
Option D of LT.10103 now displays the correct text
The Kleve renaming event, LT.41006, is now broadcast to rulers near Kleve, rather than far from it.

Renaming West-Frisia to Holland now actually requires all three provinces to be of Dutch culture (LT.41000)
AI will now absolutely always proceed with renaming the various Dutch titles, rather than almost always
Conversion tracking for the now defunct Monarch's Journey Featured Ruler Arwa Al-Sulayhi now works properly
The wonder_stage_ flags are actually cleared from wonders now after maintenance events

Now sets Alexandria as a backup province should LT.20001 fail to set a book_province
LT.20010 now selects more appropriate emissaries
The emissary no longer actually changes courts unless they flee
Fleeing emissaries will no longer try to flee to somewhere within their liege's realm
LT.20060 now selects more appropriate scholars
Those scholars are no longer permanen	tly abducted
LT.20110 now repeats if ROOT is inaccessible
The "Private Conversation" event chain now respects celibacy and sexual orientation
In LT.20301 there is no longer the option to try to get a favor if you already have a favor from the target
So many flags that were never cleared are now cleared, or never set
Decimating your troops in LT.21000 now only affects troops in that province
LT.60501 should be able to fire now



= Fixed vanilla events (finally!) =

Event 100540 can now fire, since the required opinion modifier is now set properly in various other events
Ward events 78010 and 78015 can now fire
Powerful siege events 62011 through 62014 can now actually fire
Event 38226 now finally works
Reactions to newborn children can now actually fire (RIP.29601, RIP.29602)



=== For modders ===

= General =

Used 'show_scope_change = no' to clean up tooltips
Simplified and optimised script where possible, using all script features added in various patches
Adjusted whitespacing to make script easier to read
Stripped away many useless `hidden_tooltip`-clauses
Changed references to Zeus to Conclave (has_dlc = "")
Changed most 'tier'-triggers to 'real_tier' equivalents
Consistently applied 'owner'-scope in province scope, 'holder_scope' in title scope
Uses of 'prisoner'-command changed into 'imprison', leaving 'prisoner' as a trigger only
'modifier'-clauses renamed to 'mult_modifier'
'mult_modifier'-clauses with 'factor = 0' moved into 'trigger'-clauses, to avoid inverted logic
Used numerical operators wherever possible
Removed contents of 'save_conversion' - obsolete since both vanilla and CleanSlate are no longer compatible with saves that necessitated these files
'resolve_severely_injured_effect = yes' is now used with consistent weights and delays
Replaced all 'trait = incapable' checks with 'is_incapable = yes/no'
All notifications events now only fire for players
Removed redundant logic flow (AND, OR, NOT. etc.)
Replaced all uses of 'hidden_tooltip' with 'hidden_effect' and 'hidden_trigger'
'age = 16' changed to 'is_adult = yes/no'
Commented out unused event targets, restored others as originally intended
Removed no longer used 'is_tribal_type_title'-checks
Much more use of religion_openly_<pagan_religion>_or_reformed_trigger
Fixed numerous inconsistencies in various events
Patched up many slightly inconsistent triggers between 'any_' and 'random_' scopes
Removed lots of flag setting and checking, replaced by clear_delayed_event
Scripted effects to add/remove Temperate/Gluttonous now include updating and re-evaluating weight variable/traits
Changed many months/days durations into years/months, making them easier to read
Global events no longer have to rely on the Pope, freeing mods up to disable the Papacy. Instead, use the 'pulse_province' flag, set on a random province at first game start-up. For example, in your event trigger, check for the following, to ensure it can only fire once, or use 'has_flag = pulse_province' as a pre-trigger for a province_event:

owns = event_target:pulse_province

or

has_flag = pulse_province

Many uses of variables in events are changed to local_ variables, which aren't bound to any scope and are automatically cleared when the event chain ends.



= Buildings =

Files re-organised



= Casus Belli =

Added documentation on scopes
Replaced many ROOTs and FROMs with 'attacker' and 'defender' for intelligibility
Refactored common parts of script into scripted effects/triggers
Adjusted tooltip scopes: religious_cb_succ_tip, religious_cb_succ_muslim_tip
Sorted into various files by category



= Localisation =

Deleted all commented out strings
Sorted localisation into many categories, making it much easier to find what you're looking for
Fixed many text colouring inconsistencies
Fixed many messy tooltips for various triggers and effects, adding/removing newlines, periods, colouring many more character names, etc.
Added missing tooltips for various triggers, effects and scope changes
Added continents localisation for continents-trigger
Added missing _short localisation for various ambitions, factions and plots, used in some trigger-tooltips
Standardised common event responses (OK, Excellent, I see, etc.)



= Customizable localisation =

Added many uses of `use_first_valid = yes`
Fixed various triggers to work properly, mostly in warrior lodges (`vassal_of = FROM` in ROOT scope, instead of FROM scope)
Fixed many lazy word endings for Spanish and German compliments and insults
Added various custom loc commands for French, German and Spanish, implemented them across localisation
Renamed GetComplimentNoun/Adjective to GetEducationComplimentNoun/Adjective
Added missing Get(Adult/Child)Compliment/Insult(Noun/Adjective) customizable localisation commands
Added missing compliment nouns and adjectives to GetInsultNoun/Adjective
Supplemented GetRootRelation with GetPrevRelation and GetEventTarget1/2/3/4Relation
Added gendered commands GetParent, GetGrandParent, GetChild, GetGrandChild, GetSibling, GetConcubineConsort, GetRival, GetFriend, GetLover, GetAuntUncle, GetNibling, GetCousin, GetSiblingInLaw, GetParentInLaw, GetKin, GetLiege, GetVassal, GetCourtier
Added Bon/Aztec/Hellenic to French loc command GetReligousPerson
Added GetDogName
Added GetHuntingQuarry(Cap)



= Cultures/religions =

Sorted into files, per group
Re-organised all elements to be much more consistent
Changed graphical culture on Orthodox to easterngfx, Miaphysite to africangfx, and Nestorian to persiangfx
Pagan reformation flags are set in religion scope, instead of globally



= Laws =

Massive rewrite of all triggers to be much easier to read and modify
Separated gender succession laws into separate file
Switched order of title grants and title revocation council laws, to be consistent with the rest of the game
Refactored opinion modifiers from vassals/courtiers into scripted effects
Added logging to many laws to make it easier to find issues



= Governments =

Rewrite of all trigger to be easier to read, added a few comments
Used 'allow'-trigger in addition to 'potential'-trigger for a few governments



= Nicknames =

Alphabetised nicknames, added comments on various uses of nicknames



= on_actions =

Added missing on_actions for various hardcoded diplomatic interactions
Added missing scope documentation for many on_actions, corrected outdated scope documentation



= Event/opinion modifiers =

Renamed modifiers:
- assassins_debt -> assassins_debt_modifier

Guru changed from character flag to character modifier for clarity
Strategist now made into a minor title, to make more clear that duplicates are redundant


= Trade routes =

Added comments with province names



= Traits =

Re-organised into various different files
Ensured all traits only have one insult per category (male, female, child), since only the last one listed is ever used
Added Crusader compliments to Crusader King/Queen traits
Adjusted a few other compliments/insults to various traits, to make more sense
Added missing compliments/insults to various Crusader/Great Holy War traits
Disease symptoms no longer count as illnesses



= Scripted triggers/effects =

Reworked safe (secret) religion checks to be functional and easier to use
tiered_prestige/piety effects now consider all spouses
Improved sibling in-law detection
Added several add/remove_trait_(silently)_<trait>_effect
Standardised increase/decrease_prosperity_variable_effect, now display province name, effects now used in province scope
Simplified pay_back_assassins_effect, now uses variables throughout
Added 'has_character_flag = do_not_disturb' to 'is_inaccessible_trigger'

Removed scripted triggers:
 - cousin_of_root_trigger
 - sibling_of_root_trigger
 - sibling_child_of_root_trigger
 - parent_sibling_of_root_trigger
 - grandchild_of_root_trigger
 - has_secret_religion_trait_trigger
 - true_religion_<religion>_trigger
 - is_secret_religious_society_member_trigger
 - is_openly_of_prevs_secret_religion_trigger
 - is_openly_of_roots_secret_religion_trigger
 - shares_prevs_secret_religion_trigger
 - shares_true_religion_group_with_prev_trigger
 - is_openly_of_prevs_true_religion_group
 - same_true_religion_as_from_trigger
 - same_true_religion_as_root_trigger
 - FROMs_religion_is_playable_trigger
 - ROOTs_religion_is_playable_trigger
 - ROOTs_secret_religion_is_playable_trigger
 - can_pay_assassins_debt

Removed scripted effects:
 - add_secret_religion_trait_trigger_is_religion_or_old_religion_flag_clear_flag_after_effect_is_run_this_name_is_a_tribute_to_m_effect
 - add_religion_char_flag_effect
 - clr_religion_char_flag_effect
 - event_target_old_religion_from_flag_effect
 - randomize_ABC_desc_flag_effect
 - clr_ABC_desc_flag_effect
 - remove_secret_religion_trait_effect
 - add_trait_for_prevs_secret_religion_society_effect
 - send_final_book_outcome_event_effect
 - WL_ritual_hunt_cleanup_effect
 - warrior_lodge_get_dice_bet_effect
 - warrior_lodge_double_dice_bet_effect
 - give_weaponsmith_artifacts_flag_okay_effect
 - give_weaponsmith_artifacts_flag_good_effect
 - give_weaponsmith_artifacts_flag_expensive_effect

Added scripted triggers:
 - has_sympathy_for_true_religion_of_from_trigger
 - is_catholic_branch
 - is_orthodox_branch
 - is_miaphysite_branch
 - is_nestorian_branch
 - is_sunni_branch
 - is_ibadi_branch
 - is_shiite_branch
 - is_catholic_true_branch
 - is_orthodox_true_branch
 - is_miaphysite_true_branch
 - is_nestorian_true_branch
 - is_sunni_true_branch
 - is_ibadi_true_branch
 - is_shiite_true_branch
 - is_catholic_secret_branch
 - is_orthodox_secret_branch
 - is_miaphysite_secret_branch
 - is_nestorian_secret_branch
 - is_sunni_secret_branch
 - is_ibadi_secret_branch
 - is_shiite_secret_branch
 - religion_secretly_<pagan_religion>_or_reformed_trigger
 - true_<pagan_religion>_religion_trigger
 - has_secret_dharmic_religion_trigger
 - has_safe_religion
 - has_safe_secret_religion
 - is_unreformed_pagan_trigger
 - is_not_unreformed_pagan_trigger
 - is_not_ascetic_trigger
 - is_not_in_regency_trigger
 - has_sympathy_for_true_religion_of_from_trigger
 - byzantines_can_grant_commander_trigger
 - courtier_is_mass_expellable
 - courtier_is_preferred_for_mass_expulsion
 - sibling_in_law_of_prev_trigger
 - sibling_in_law_of_event_target_1_trigger
 - sibling_in_law_of_event_target_2_trigger
 - sibling_in_law_of_event_target_3_trigger
 - sibling_in_law_of_event_target_4_trigger
 - religion_has_excommunication
 - religion_has_incest

Added scripted effects:
 - setup_holy_order_religion_scopes
 - setup_province_pulse
 - clear_smith_flags_effect
 - clear_smith_employer_flags_effect
 - hermetics_upgrade_scandal_effect
 - flip_all_realm_secret_religious_community_provinces
 - decreased_council_power_effect
 - decreased_crown_authority_effect
 - decreased_tribal_organization_effect
 - decreased_feudal_obligation_laws_effect
 - decreased_republic_obligation_laws_effect
 - decreased_theocratic_obligation_laws_effect
 - decreased_tribal_obligation_laws_effect
 - increased_council_power_effect
 - increased_crown_authority_effect
 - increased_tribal_organization_effect
 - increased_feudal_obligation_laws_effect
 - increased_republic_obligation_laws_effect
 - increased_theocratic_obligation_laws_effect
 - increased_tribal_obligation_laws_effect

Renamed scripted triggers:
- have_duplicate_goldsmith_artifacts_flag_okay_trigger          -> have_duplicate_goldsmith_artifacts_tier_1_trigger
- have_duplicate_goldsmith_artifacts_flag_good_trigger          -> have_duplicate_goldsmith_artifacts_tier_2_trigger
- have_duplicate_goldsmith_artifacts_flag_expensive_trigger     -> have_duplicate_goldsmith_artifacts_tier_3_trigger
- have_duplicate_goldsmith_artifacts_flag_amazing_trigger       -> have_duplicate_goldsmith_artifacts_tier_4_trigger
- have_all_armorsmith_artifacts_all_flags_trigger               -> have_all_armorsmith_artifacts_trigger
- have_all_weaponsmith_artifacts_all_flags_trigger              -> have_all_weaponsmith_artifacts_trigger
- have_all_weaponsmith_mace_all_flags_trigger                   -> have_all_weaponsmith_mace_trigger
- have_all_weaponsmith_axe_all_flags_trigger                    -> have_all_weaponsmith_axe_trigger
- have_all_weaponsmith_lance_all_flags_trigger                  -> have_all_weaponsmith_lance_trigger
- have_all_weaponsmith_swords_all_flags_trigger                 -> have_all_weaponsmith_swords_trigger
- have_all_weaponsmith_scimitar_all_flags_trigger               -> have_all_weaponsmith_scimitar_trigger
- have_all_weaponsmith_bow_all_flags_trigger                    -> have_all_weaponsmith_bow_trigger
- have_duplicate_smith_artifacts_flag_okay_trigger              -> have_duplicate_smith_artifacts_tier_1_trigger
- have_duplicate_smith_artifacts_flag_good_trigger              -> have_duplicate_smith_artifacts_tier_2_trigger
- have_duplicate_smith_artifacts_flag_amazing_optionA_trigger   -> have_duplicate_smith_artifacts_tier_3_optionA_trigger
- have_duplicate_smith_artifacts_flag_amazing_optionB_trigger   -> have_duplicate_smith_artifacts_tier_3_optionB_trigger
- have_duplicate_smith_artifacts_flag_amazing_optionC_trigger   -> have_duplicate_smith_artifacts_tier_3_optionC_trigger
- have_duplicate_smith_artifacts_flag_expensive_optionA_trigger -> have_duplicate_smith_artifacts_tier_4_optionA_trigger
- have_duplicate_smith_artifacts_flag_expensive_optionB_trigger -> have_duplicate_smith_artifacts_tier_4_optionB_trigger
- have_duplicate_smith_artifacts_flag_expensive_optionC_trigger -> have_duplicate_smith_artifacts_tier_4_optionC_trigger

Renamed scripted effects:
 - give_goldsmith_artifacts_flag_okay_effect          -> give_goldsmith_artifacts_tier_1_effect
 - give_goldsmith_artifacts_flag_good_effect          -> give_goldsmith_artifacts_tier_2_effect
 - give_goldsmith_artifacts_flag_expensive_effect     -> give_goldsmith_artifacts_tier_3_effect
 - give_goldsmith_artifacts_flag_amazing_effect       -> give_goldsmith_artifacts_tier_4_effect
 - give_smith_artifacts_flag_okay_effect              -> give_smith_artifacts_tier_1_effect
 - give_smith_artifacts_flag_good_effect              -> give_smith_artifacts_tier_2_effect
 - give_smith_artifacts_flag_amazing_optionA_effect   -> give_smith_artifacts_tier_3_optionA_effect
 - give_smith_artifacts_flag_amazing_optionB_effect   -> give_smith_artifacts_tier_3_optionB_effect
 - give_smith_artifacts_flag_amazing_optionC_effect   -> give_smith_artifacts_tier_3_optionC_effect
 - give_smith_artifacts_flag_expensive_optionA_effect -> give_smith_artifacts_tier_4_optionA_effect
 - give_smith_artifacts_flag_expensive_optionB_effect -> give_smith_artifacts_tier_4_optionB_effect
 - give_smith_artifacts_flag_expensive_optionC_effect -> give_smith_artifacts_tier_4_optionC_effect


Reworked 'abdicate_holy_order_if_religion_changes_effect', in conjuction with 'setup_holy_order_religion_scopes' (new, called on_startup) and 'immediate'-clause in event SoA.4200. Update these when adding new religions and/or holy orders. 'abdicate_holy_order_if_religion_changes_effect' is now only called when a holy order leader changes religion, rather than all over the place

Rubbish 'old religion'-system is gone, saving several thousand lines of script. Instead, in events that may lead to a character converting, while keeping their old religion secretly, save the current religion before conversion in a persistent event target, named 'old_religion)'. See event 39700 (religious_events.txt), events SoA.4021, SoA.4024, SoA.4031 and SoA.4032 (soa_heresy_events.txt) as well as event MNM.3949 (mnm_secret_religious_societies_events.txt)



= Succession voting =

Significantly simplified candidate selection criteria
Removed many useless checks in voting criteria
Split into files per elective succession voting ruleset
Exported most scoring criteria to scripted score values



= Societies =

Separated into various files, by society type
Warrior lodges now have associated religions set, which can be used to convert character religion



= Decisions =

Ensured all decisions have only one ai_target_filter



= Interface files =

Fixed up all ugly/inconsistent formatting, making these files easier to read



= Great Works (and upgrades) =

Upgrades sorted into various files



= Message types =

Added missing message types:
 - ASK_TO_DECLARE_WAR_INTERACTION_DECLINE
 - ASK_TO_EMBARGO_INTERACTION_DECLINE



= Decisions =

Deleted duplicate decision 'stable_attribute_improvement_self_decision' - 'stable_attribute_improvement_decision' contains all the necessary functionality
Made triggers to form/vassalize holy orders much more consistent
Various 'create kingdom' decisions are much more consistent in triggers and effects
Various holy order decisions are much more consistent
Added missing remove_province_modifier effects to 'secret_religions_personally_adopt_secret_religion'
Merged all seven devil worshipper recruit decisions into one, added required customizable localisation



= Council voting =

Added council voting localisation for all vanilla interactions



= Events =

Moved misplaced end of event chain to married_life_events.txt
Moved most of guardian_events into childhood_personality_trait_events, because event chains shouldn't jump back and forth between two files
Merged events for arriving at Crusade/Jihad/GHW
Merged all Crusade/Jihad/GHW announcement events
Changed all 'capable_only' pre-triggers to 'only_capable', for consistency
Moved triggers to pre-triggers wherever possible



= Landed titles =

Separated landed titles per de jure empire, as well as religious heads, holy orders, mercenary bands, special titles, etc.
Added (empty) scripted triggers governing creation/usurption of duchy, kingdom and empire titles

Renamed title IDs:
 - k_papal_state -> k_papacy
 - k_papacy -> k_papal_state



= Dynasties =

Fixed duplicate dynasties:
 - 1059971 -> 1059977
 - 1061019 -> 1061028
 - 105946 -> 105948
 - 1062442 -> 1062626
 - 1062594 -> 1062625

Fixed duplicate animal dynasty IDs



= on_actions =

Split per DLC



= Map =

Added d_cumbria to custom_england

Aded geographical regions:

world_middle_east_persia
world_middle_east_levant
world_middle_east_asia_minor
world_europe_west_gaul
world_europe_west_british_isles
world_europe_west_ireland
world_europe_west_britain
world_europe_south_sicily
world_europe_south_sardinia_corsica
world_europe_north_sea
world_europe_north_jutland
world_europe_north_fennoscandia
world_europe_east_timan_ridge
world_europe_east_russia
world_europe_north_danish_archipelago
world_europe_east_pannonia
world_europe_east_baltic
world_asia
world_africa_north_west
world_africa_north_nile

Removed geographical regions:

world_asia_minor
world_europe_west_brittania
world_europe_west_francia
world_middle_east_jerusalem
world_persia
custom_russia