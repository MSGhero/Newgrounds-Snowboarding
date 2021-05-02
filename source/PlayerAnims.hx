package;

import openfl.utils.Assets;

class PlayerAnims {
	
	public static function setAnim(name:Chars):Animation {
		
		var animation = null;
		
		switch (name) {
			case PICO:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/pico_ss.png"), Assets.getText("assets/data/pico.json"));
				animation.addSequence("default", false, "char_pico00", 1, 1);
				animation.addSequence("leftin", false, "char_pico00", 1, 5);
				animation.addSequence("lefthold", false, "char_pico00", 6, 6);
				animation.addSequence("leftout", false, "char_pico00", 7, 10);
				animation.addSequence("rightin", false, "char_pico00", 11, 15);
				animation.addSequence("righthold", false, "char_pico00", 16, 16);
				animation.addSequence("rightout", false, "char_pico00", 17, 20);
				animation.addSequence("tailin", false, "char_pico00", 21, 26);
				animation.addSequence("tailhold", false, "char_pico00", 27, 27);
				animation.addSequence("tailout", false, "char_pico00", 28, 32);
				animation.addSequence("nosein", false, "char_pico00", 33, 38);
				animation.addSequence("nosehold", false, "char_pico00", 39, 39);
				animation.addSequence("noseout", false, "char_pico00", 40, 44);
				animation.addSequence("trickin", false, "char_pico00", 45, 50);
				animation.addSequence("trickhold", false, "char_pico00", 51, 51);
				animation.addSequence("trickout", false, "char_pico00", 52, 56);
			case JOHNY:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/johny_ss.png"), Assets.getText("assets/data/johny.json"));
				animation.addSequence("default", false, "char_johny00", 1, 1);
				animation.addSequence("leftin", false, "char_johny00", 1, 5);
				animation.addSequence("lefthold", false, "char_johny00", 6, 6);
				animation.addSequence("leftout", false, "char_johny00", 7, 10);
				animation.addSequence("rightin", false, "char_johny00", 11, 15);
				animation.addSequence("righthold", false, "char_johny00", 16, 16);
				animation.addSequence("rightout", false, "char_johny00", 17, 20);
				animation.addSequence("tailin", false, "char_johny00", 21, 25);
				animation.addSequence("tailhold", false, "char_johny00", 26, 26);
				animation.addSequence("tailout", false, "char_johny00", 27, 30);
				animation.addSequence("nosein", false, "char_johny00", 30, 35);
				animation.addSequence("nosehold", false, "char_johny00", 36, 36);
				animation.addSequence("noseout", false, "char_johny00", 37, 40);
				animation.addSequence("trickin", false, "char_johny00", 41, 45);
				animation.addSequence("trickhold", false, "char_johny00", 46, 46);
				animation.addSequence("trickout", false, "char_johny00", 47, 50);
			case KING:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/king_ss.png"), Assets.getText("assets/data/king.json"));
				animation.addSequence("default", false, "char_king00", 1, 1);
				animation.addSequence("leftin", false, "char_king00", 1, 5);
				animation.addSequence("lefthold", false, "char_king00", 6, 6);
				animation.addSequence("leftout", false, "char_king00", 7, 10);
				animation.addSequence("rightin", false, "char_king00", 11, 15);
				animation.addSequence("righthold", false, "char_king00", 16, 16);
				animation.addSequence("rightout", false, "char_king00", 17, 20);
				animation.addSequence("tailin", false, "char_king00", 21, 25);
				animation.addSequence("tailhold", false, "char_king00", 26, 26);
				animation.addSequence("tailout", false, "char_king00", 27, 30);
				animation.addSequence("nosein", false, "char_king00", 30, 35);
				animation.addSequence("nosehold", false, "char_king00", 36, 36);
				animation.addSequence("noseout", false, "char_king00", 37, 40);
				animation.addSequence("trickin", false, "char_king00", 41, 45);
				animation.addSequence("trickhold", false, "char_king00", 46, 46);
				animation.addSequence("trickout", false, "char_king00", 47, 50);
			case CHOCO:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/choco_ss.png"), Assets.getText("assets/data/choco.json"));
				animation.addSequence("default", false, "char_choco00", 1, 1);
				animation.addSequence("leftin", false, "char_choco00", 1, 5);
				animation.addSequence("lefthold", false, "char_choco00", 6, 6);
				animation.addSequence("leftout", false, "char_choco00", 7, 10);
				animation.addSequence("rightin", false, "char_choco00", 11, 15);
				animation.addSequence("righthold", false, "char_choco00", 16, 16);
				animation.addSequence("rightout", false, "char_choco00", 17, 20);
				animation.addSequence("tailin", false, "char_choco00", 21, 25);
				animation.addSequence("tailhold", false, "char_choco00", 26, 26);
				animation.addSequence("tailout", false, "char_choco00", 27, 30);
				animation.addSequence("nosein", false, "char_choco00", 30, 35);
				animation.addSequence("nosehold", false, "char_choco00", 36, 36);
				animation.addSequence("noseout", false, "char_choco00", 37, 40);
				animation.addSequence("trickin", false, "char_choco00", 41, 45);
				animation.addSequence("trickhold", false, "char_choco00", 46, 46);
				animation.addSequence("trickout", false, "char_choco00", 47, 50);
			case BOOG:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/boog_ss.png"), Assets.getText("assets/data/boog.json"));
				animation.addSequence("default", false, "char_boog00", 1, 1);
				animation.addSequence("leftin", false, "char_boog00", 1, 5);
				animation.addSequence("lefthold", false, "char_boog00", 6, 6);
				animation.addSequence("leftout", false, "char_boog00", 7, 10);
				animation.addSequence("rightin", false, "char_boog00", 11, 15);
				animation.addSequence("righthold", false, "char_boog00", 16, 16);
				animation.addSequence("rightout", false, "char_boog00", 17, 20);
				animation.addSequence("tailin", false, "char_boog00", 21, 25);
				animation.addSequence("tailhold", false, "char_boog00", 26, 26);
				animation.addSequence("tailout", false, "char_boog00", 27, 30);
				animation.addSequence("nosein", false, "char_boog00", 30, 35);
				animation.addSequence("nosehold", false, "char_boog00", 36, 36);
				animation.addSequence("noseout", false, "char_boog00", 37, 40);
				animation.addSequence("trickin", false, "char_boog00", 41, 45);
				animation.addSequence("trickhold", true, "char_boog00", 46, 46);
				animation.addSequence("trickout", false, "char_boog00", 47, 50);
			case GOAT:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/goat_ss.png"), Assets.getText("assets/data/goat.json"));
				animation.addSequence("default", false, "char_goat00", 1, 1);
				animation.addSequence("leftin", false, "char_goat00", 1, 5);
				animation.addSequence("lefthold", false, "char_goat00", 6, 6);
				animation.addSequence("leftout", false, "char_goat00", 7, 10);
				animation.addSequence("rightin", false, "char_goat00", 11, 15);
				animation.addSequence("righthold", false, "char_goat00", 16, 16);
				animation.addSequence("rightout", false, "char_goat00", 17, 20);
				animation.addSequence("tailin", false, "char_goat00", 21, 25);
				animation.addSequence("tailhold", false, "char_goat00", 26, 26);
				animation.addSequence("tailout", false, "char_goat00", 27, 30);
				animation.addSequence("nosein", false, "char_goat00", 30, 35);
				animation.addSequence("nosehold", false, "char_goat00", 36, 36);
				animation.addSequence("noseout", false, "char_goat00", 37, 40);
				animation.addSequence("trickin", false, "char_goat00", 41, 41);
				animation.addSequence("trickhold", true, "char_goat00", 41, 49);
				animation.addSequence("trickout", false, "char_goat00", 50, 50);
			case CAPTAIN:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/captain_ss.png"), Assets.getText("assets/data/captain.json"));
				animation.addSequence("default", false, "char_tankman00", 1, 1);
				animation.addSequence("leftin", false, "char_tankman00", 1, 5);
				animation.addSequence("lefthold", false, "char_tankman00", 6, 6);
				animation.addSequence("leftout", false, "char_tankman00", 7, 10);
				animation.addSequence("rightin", false, "char_tankman00", 11, 15);
				animation.addSequence("righthold", false, "char_tankman00", 16, 16);
				animation.addSequence("rightout", false, "char_tankman00", 17, 20);
				animation.addSequence("tailin", false, "char_tankman00", 21, 25);
				animation.addSequence("tailhold", false, "char_tankman00", 26, 26);
				animation.addSequence("tailout", false, "char_tankman00", 27, 30);
				animation.addSequence("nosein", false, "char_tankman00", 30, 35);
				animation.addSequence("nosehold", false, "char_tankman00", 36, 36);
				animation.addSequence("noseout", false, "char_tankman00", 37, 40);
				animation.addSequence("trickin", false, "char_tankman00", 41, 45);
				animation.addSequence("trickhold", true, "char_tankman00", 46, 46);
				animation.addSequence("trickout", false, "char_tankman00", 47, 50);
			case PHIL:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/phil_ss.png"), Assets.getText("assets/data/phil.json"));
				animation.addSequence("default", false, "char_phil00", 1, 1);
				animation.addSequence("leftin", false, "char_phil00", 1, 5);
				animation.addSequence("lefthold", false, "char_phil00", 6, 6);
				animation.addSequence("leftout", false, "char_phil00", 7, 10);
				animation.addSequence("rightin", false, "char_phil00", 11, 15);
				animation.addSequence("righthold", false, "char_phil00", 16, 16);
				animation.addSequence("rightout", false, "char_phil00", 17, 20);
				animation.addSequence("tailin", false, "char_phil00", 21, 25);
				animation.addSequence("tailhold", false, "char_phil00", 26, 26);
				animation.addSequence("tailout", false, "char_phil00", 27, 30);
				animation.addSequence("nosein", false, "char_phil00", 30, 35);
				animation.addSequence("nosehold", false, "char_phil00", 36, 36);
				animation.addSequence("noseout", false, "char_phil00", 37, 40);
				animation.addSequence("trickin", false, "char_phil00", 41, 46);
				animation.addSequence("trickhold", true, "char_phil00", 47, 47);
				animation.addSequence("trickout", false, "char_phil00", 48, 51);
			case ELLIE:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/ellie_ss.png"), Assets.getText("assets/data/ellie.json"));
				animation.addSequence("default", false, "char_ellie00", 1, 1);
				animation.addSequence("leftin", false, "char_ellie00", 1, 5);
				animation.addSequence("lefthold", false, "char_ellie00", 6, 6);
				animation.addSequence("leftout", false, "char_ellie00", 7, 10);
				animation.addSequence("rightin", false, "char_ellie00", 11, 15);
				animation.addSequence("righthold", false, "char_ellie00", 16, 16);
				animation.addSequence("rightout", false, "char_ellie00", 17, 20);
				animation.addSequence("tailin", false, "char_ellie00", 21, 25);
				animation.addSequence("tailhold", false, "char_ellie00", 26, 26);
				animation.addSequence("tailout", false, "char_ellie00", 27, 30);
				animation.addSequence("nosein", false, "char_ellie00", 30, 35);
				animation.addSequence("nosehold", false, "char_ellie00", 36, 36);
				animation.addSequence("noseout", false, "char_ellie00", 37, 40);
				animation.addSequence("trickin", false, "char_ellie00", 41, 46);
				animation.addSequence("trickhold", true, "char_ellie00", 47, 47);
				animation.addSequence("trickout", false, "char_ellie00", 48, 51);
			case HENRY:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/henry_ss.png"), Assets.getText("assets/data/henry.json"));
				animation.addSequence("default", false, "char_henry00", 1, 1);
				animation.addSequence("leftin", false, "char_henry00", 1, 5);
				animation.addSequence("lefthold", false, "char_henry00", 6, 6);
				animation.addSequence("leftout", false, "char_henry00", 7, 10);
				animation.addSequence("rightin", false, "char_henry00", 11, 15);
				animation.addSequence("righthold", false, "char_henry00", 16, 16);
				animation.addSequence("rightout", false, "char_henry00", 17, 20);
				animation.addSequence("tailin", false, "char_henry00", 21, 25);
				animation.addSequence("tailhold", false, "char_henry00", 26, 26);
				animation.addSequence("tailout", false, "char_henry00", 27, 30);
				animation.addSequence("nosein", false, "char_henry00", 30, 35);
				animation.addSequence("nosehold", false, "char_henry00", 36, 36);
				animation.addSequence("noseout", false, "char_henry00", 37, 40);
				animation.addSequence("trickin", false, "char_henry00", 41, 46);
				animation.addSequence("trickhold", true, "char_henry00", 47, 47);
				animation.addSequence("trickout", false, "char_henry00", 48, 51);
			case CHIBI:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/chibi_ss.png"), Assets.getText("assets/data/chibi.json"));
				animation.addSequence("default", false, "char_chibi00", 1, 1);
				animation.addSequence("leftin", false, "char_chibi00", 1, 5);
				animation.addSequence("lefthold", false, "char_chibi00", 6, 6);
				animation.addSequence("leftout", false, "char_chibi00", 7, 10);
				animation.addSequence("rightin", false, "char_chibi00", 11, 15);
				animation.addSequence("righthold", false, "char_chibi00", 16, 16);
				animation.addSequence("rightout", false, "char_chibi00", 17, 20);
				animation.addSequence("tailin", false, "char_chibi00", 21, 25);
				animation.addSequence("tailhold", false, "char_chibi00", 26, 26);
				animation.addSequence("tailout", false, "char_chibi00", 27, 30);
				animation.addSequence("nosein", false, "char_chibi00", 30, 35);
				animation.addSequence("nosehold", false, "char_chibi00", 36, 36);
				animation.addSequence("noseout", false, "char_chibi00", 37, 40);
				animation.addSequence("trickin", false, "char_chibi00", 41, 46);
				animation.addSequence("trickhold", true, "char_chibi00", 47, 47);
				animation.addSequence("trickout", false, "char_chibi00", 48, 51);
			case GF:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/gf_ss.png"), Assets.getText("assets/data/gf.json"));
				animation.addSequence("default", false, "char_gf00", 1, 1);
				animation.addSequence("leftin", false, "char_gf00", 1, 5);
				animation.addSequence("lefthold", false, "char_gf00", 6, 6);
				animation.addSequence("leftout", false, "char_gf00", 7, 10);
				animation.addSequence("rightin", false, "char_gf00", 11, 15);
				animation.addSequence("righthold", false, "char_gf00", 16, 16);
				animation.addSequence("rightout", false, "char_gf00", 17, 20);
				animation.addSequence("tailin", false, "char_gf00", 21, 25);
				animation.addSequence("tailhold", false, "char_gf00", 26, 26);
				animation.addSequence("tailout", false, "char_gf00", 27, 30);
				animation.addSequence("nosein", false, "char_gf00", 30, 35);
				animation.addSequence("nosehold", false, "char_gf00", 36, 36);
				animation.addSequence("noseout", false, "char_gf00", 37, 40);
				animation.addSequence("trickin", false, "char_gf00", 41, 46);
				animation.addSequence("trickhold", true, "char_gf00", 47, 47);
				animation.addSequence("trickout", false, "char_gf00", 48, 51);
			case ROGUE:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/rogue_ss.png"), Assets.getText("assets/data/rogue.json"));
				animation.addSequence("default", false, "char_rogue00", 1, 1);
				animation.addSequence("leftin", false, "char_rogue00", 1, 5);
				animation.addSequence("lefthold", false, "char_rogue00", 6, 6);
				animation.addSequence("leftout", false, "char_rogue00", 7, 10);
				animation.addSequence("rightin", false, "char_rogue00", 11, 15);
				animation.addSequence("righthold", false, "char_rogue00", 16, 16);
				animation.addSequence("rightout", false, "char_rogue00", 17, 20);
				animation.addSequence("tailin", false, "char_rogue00", 21, 25);
				animation.addSequence("tailhold", false, "char_rogue00", 26, 26);
				animation.addSequence("tailout", false, "char_rogue00", 27, 30);
				animation.addSequence("nosein", false, "char_rogue00", 30, 35);
				animation.addSequence("nosehold", false, "char_rogue00", 36, 36);
				animation.addSequence("noseout", false, "char_rogue00", 37, 40);
				animation.addSequence("trickin", false, "char_rogue00", 41, 46);
				animation.addSequence("trickhold", true, "char_rogue00", 47, 47);
				animation.addSequence("trickout", false, "char_rogue00", 48, 51);
			case SMILEY:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/smiley_ss.png"), Assets.getText("assets/data/smiley.json"));
				animation.addSequence("default", false, "char_smiley00", 1, 1);
				animation.addSequence("leftin", false, "char_smiley00", 1, 5);
				animation.addSequence("lefthold", false, "char_smiley00", 6, 6);
				animation.addSequence("leftout", false, "char_smiley00", 7, 10);
				animation.addSequence("rightin", false, "char_smiley00", 11, 15);
				animation.addSequence("righthold", false, "char_smiley00", 16, 16);
				animation.addSequence("rightout", false, "char_smiley00", 17, 20);
				animation.addSequence("tailin", false, "char_smiley00", 21, 25);
				animation.addSequence("tailhold", false, "char_smiley00", 26, 26);
				animation.addSequence("tailout", false, "char_smiley00", 27, 30);
				animation.addSequence("nosein", false, "char_smiley00", 30, 35);
				animation.addSequence("nosehold", false, "char_smiley00", 36, 36);
				animation.addSequence("noseout", false, "char_smiley00", 37, 40);
				animation.addSequence("trickin", false, "char_smiley00", 41, 46);
				animation.addSequence("trickhold", true, "char_smiley00", 47, 47);
				animation.addSequence("trickout", false, "char_smiley00", 48, 51);
			case JOSH:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/josh_ss.png"), Assets.getText("assets/data/josh.json"));
				animation.addSequence("default", false, "char_josh00", 1, 1);
				animation.addSequence("leftin", false, "char_josh00", 1, 5);
				animation.addSequence("lefthold", false, "char_josh00", 6, 6);
				animation.addSequence("leftout", false, "char_josh00", 7, 10);
				animation.addSequence("rightin", false, "char_josh00", 11, 15);
				animation.addSequence("righthold", false, "char_josh00", 16, 16);
				animation.addSequence("rightout", false, "char_josh00", 17, 20);
				animation.addSequence("tailin", false, "char_josh00", 21, 25);
				animation.addSequence("tailhold", false, "char_josh00", 26, 26);
				animation.addSequence("tailout", false, "char_josh00", 27, 30);
				animation.addSequence("nosein", false, "char_josh00", 30, 35);
				animation.addSequence("nosehold", false, "char_josh00", 36, 36);
				animation.addSequence("noseout", false, "char_josh00", 37, 40);
				animation.addSequence("trickin", false, "char_josh00", 41, 45);
				animation.addSequence("trickhold", true, "char_josh00", 46, 46);
				animation.addSequence("trickout", false, "char_josh00", 47, 50);
			case CORDELIA:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/cordelia_ss.png"), Assets.getText("assets/data/cordelia.json"));
				animation.addSequence("default", false, "char_cordelia00", 1, 1);
				animation.addSequence("leftin", false, "char_cordelia00", 1, 5);
				animation.addSequence("lefthold", false, "char_cordelia00", 6, 6);
				animation.addSequence("leftout", false, "char_cordelia00", 7, 10);
				animation.addSequence("rightin", false, "char_cordelia00", 11, 15);
				animation.addSequence("righthold", false, "char_cordelia00", 16, 16);
				animation.addSequence("rightout", false, "char_cordelia00", 17, 20);
				animation.addSequence("tailin", false, "char_cordelia00", 21, 25);
				animation.addSequence("tailhold", false, "char_cordelia00", 26, 26);
				animation.addSequence("tailout", false, "char_cordelia00", 27, 30);
				animation.addSequence("nosein", false, "char_cordelia00", 30, 35);
				animation.addSequence("nosehold", false, "char_cordelia00", 36, 36);
				animation.addSequence("noseout", false, "char_cordelia00", 37, 40);
				animation.addSequence("trickin", false, "char_cordelia00", 41, 45);
				animation.addSequence("trickhold", true, "char_cordelia00", 46, 46);
				animation.addSequence("trickout", false, "char_cordelia00", 47, 50);
			case TRICKY:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/tricky_ss.png"), Assets.getText("assets/data/tricky.json"));
				animation.addSequence("default", false, "char_tricky00", 1, 1);
				animation.addSequence("leftin", false, "char_tricky00", 1, 5);
				animation.addSequence("lefthold", false, "char_tricky00", 6, 6);
				animation.addSequence("leftout", false, "char_tricky00", 7, 10);
				animation.addSequence("rightin", false, "char_tricky00", 11, 15);
				animation.addSequence("righthold", false, "char_tricky00", 16, 16);
				animation.addSequence("rightout", false, "char_tricky00", 17, 20);
				animation.addSequence("tailin", false, "char_tricky00", 21, 25);
				animation.addSequence("tailhold", false, "char_tricky00", 26, 26);
				animation.addSequence("tailout", false, "char_tricky00", 27, 30);
				animation.addSequence("nosein", false, "char_tricky00", 30, 35);
				animation.addSequence("nosehold", false, "char_tricky00", 36, 36);
				animation.addSequence("noseout", false, "char_tricky00", 37, 40);
				animation.addSequence("trickin", false, "char_tricky00", 41, 52);
				animation.addSequence("trickhold", true, "char_tricky00", 53, 53);
				animation.addSequence("trickout", false, "char_tricky00", 54, 59);
			case SHOTGUN:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/shotgun_ss.png"), Assets.getText("assets/data/shotgun.json"));
				animation.addSequence("default", false, "char_shotgun00", 1, 1);
				animation.addSequence("leftin", false, "char_shotgun00", 1, 5);
				animation.addSequence("lefthold", false, "char_shotgun00", 6, 6);
				animation.addSequence("leftout", false, "char_shotgun00", 7, 10);
				animation.addSequence("rightin", false, "char_shotgun00", 11, 15);
				animation.addSequence("righthold", false, "char_shotgun00", 16, 16);
				animation.addSequence("rightout", false, "char_shotgun00", 17, 20);
				animation.addSequence("tailin", false, "char_shotgun00", 21, 25);
				animation.addSequence("tailhold", false, "char_shotgun00", 26, 26);
				animation.addSequence("tailout", false, "char_shotgun00", 27, 30);
				animation.addSequence("nosein", false, "char_shotgun00", 30, 35);
				animation.addSequence("nosehold", false, "char_shotgun00", 36, 36);
				animation.addSequence("noseout", false, "char_shotgun00", 37, 40);
				animation.addSequence("trickin", false, "char_shotgun00", 41, 45);
				animation.addSequence("trickhold", true, "char_shotgun00", 46, 46);
				animation.addSequence("trickout", false, "char_shotgun00", 47, 50);
			case KERRIGAN:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/kerrigan_ss.png"), Assets.getText("assets/data/kerrigan.json"));
				animation.addSequence("default", false, "char_kerrigan00", 1, 1);
				animation.addSequence("leftin", false, "char_kerrigan00", 1, 5);
				animation.addSequence("lefthold", false, "char_kerrigan00", 6, 6);
				animation.addSequence("leftout", false, "char_kerrigan00", 7, 10);
				animation.addSequence("rightin", false, "char_kerrigan00", 11, 15);
				animation.addSequence("righthold", false, "char_kerrigan00", 16, 16);
				animation.addSequence("rightout", false, "char_kerrigan00", 17, 20);
				animation.addSequence("tailin", false, "char_kerrigan00", 21, 25);
				animation.addSequence("tailhold", false, "char_kerrigan00", 26, 26);
				animation.addSequence("tailout", false, "char_kerrigan00", 27, 30);
				animation.addSequence("nosein", false, "char_kerrigan00", 30, 35);
				animation.addSequence("nosehold", false, "char_kerrigan00", 36, 36);
				animation.addSequence("noseout", false, "char_kerrigan00", 37, 40);
				animation.addSequence("trickin", false, "char_kerrigan00", 41, 45);
				animation.addSequence("trickhold", true, "char_kerrigan00", 46, 46);
				animation.addSequence("trickout", false, "char_kerrigan00", 47, 50);
			case NENE:
				animation = new Animation(Assets.getBitmapData("assets/images/sheets/nene_ss.png"), Assets.getText("assets/data/nene.json"));
				animation.addSequence("default", false, "char_nene00", 1, 1);
				animation.addSequence("leftin", false, "char_nene00", 1, 5);
				animation.addSequence("lefthold", false, "char_nene00", 6, 6);
				animation.addSequence("leftout", false, "char_nene00", 7, 10);
				animation.addSequence("rightin", false, "char_nene00", 11, 15);
				animation.addSequence("righthold", false, "char_nene00", 16, 16);
				animation.addSequence("rightout", false, "char_nene00", 17, 20);
				animation.addSequence("tailin", false, "char_nene00", 21, 25);
				animation.addSequence("tailhold", false, "char_nene00", 26, 26);
				animation.addSequence("tailout", false, "char_nene00", 27, 30);
				animation.addSequence("nosein", false, "char_nene00", 30, 35);
				animation.addSequence("nosehold", false, "char_nene00", 36, 36);
				animation.addSequence("noseout", false, "char_nene00", 37, 40);
				animation.addSequence("trickin", false, "char_nene00", 41, 45);
				animation.addSequence("trickhold", true, "char_nene00", 46, 46);
				animation.addSequence("trickout", false, "char_nene00", 47, 50);
			case NONE:
		}
		
		return animation;
	}
	
	public static function getPoseAnim():Animation {
		
		var anim = new Animation(Assets.getBitmapData("assets/images/sheets/pose_ss.png"), Assets.getText("assets/data/pose.json"));
		
		anim.addSingle("boog", "boog");
		anim.addSingle("captain", "captain");
		anim.addSingle("chibi", "chibi");
		anim.addSingle("choco", "choco");
		anim.addSingle("ellie", "ellie");
		anim.addSingle("gf", "gf");
		anim.addSingle("goat", "goat");
		anim.addSingle("henry", "henry");
		anim.addSingle("johny", "johny");
		anim.addSingle("king", "king");
		anim.addSingle("phil", "phil");
		anim.addSingle("pico", "pico");
		anim.addSingle("rogue", "rogue");
		anim.addSingle("smiley", "smiley");
		anim.addSingle("cordelia", "cordelia");
		anim.addSingle("tricky", "tricky");
		anim.addSingle("nene", "nene");
		anim.addSingle("kerrigan", "kerrigan");
		anim.addSingle("shotgun", "shotgun");
		anim.addSingle("josh", "josh");
		
		return anim;
	}
	
	public static function getLinkAnim():Animation {
		
		var anim = new Animation(Assets.getBitmapData("assets/images/sheets/link_ss.png"), Assets.getText("assets/data/link.json"));
		
		anim.addSingle("boog", "boog");
		anim.addSingle("captain", "captain");
		anim.addSingle("chibi", "chibi");
		anim.addSingle("choco", "choco");
		anim.addSingle("ellie", "ellie");
		anim.addSingle("gf", "gf");
		anim.addSingle("goat", "goat");
		anim.addSingle("henry", "henry");
		anim.addSingle("johny", "johny");
		anim.addSingle("king", "king");
		anim.addSingle("phil", "phil");
		anim.addSingle("pico", "pico");
		anim.addSingle("rogue", "rogue");
		anim.addSingle("smiley", "smiley");
		anim.addSingle("cordelia", "cordelia");
		anim.addSingle("tricky", "tricky");
		anim.addSingle("nene", "nene");
		anim.addSingle("kerrigan", "kerrigan");
		anim.addSingle("shotgun", "shotgun");
		anim.addSingle("josh", "josh");
		
		return anim;
	}
	
	public static function getTumbleAnim():Animation {
		
		var anim = new Animation(Assets.getBitmapData("assets/images/sheets/tumble_ss.png"), Assets.getText("assets/data/tumble.json"));
		
		anim.addSingle("boog", "boog");
		anim.addSingle("captain", "captain");
		anim.addSingle("chibi", "chibi");
		anim.addSingle("choco", "choco");
		anim.addSingle("ellie", "ellie");
		anim.addSingle("gf", "gf");
		anim.addSingle("goat", "goat");
		anim.addSingle("henry", "henry");
		anim.addSingle("johny", "johny");
		anim.addSingle("king", "king");
		anim.addSingle("phil", "phil");
		anim.addSingle("pico", "pico");
		anim.addSingle("rogue", "rogue");
		anim.addSingle("smiley", "smiley");
		anim.addSingle("cordelia", "cordelia");
		anim.addSingle("tricky", "tricky");
		anim.addSingle("nene", "nene");
		anim.addSingle("kerrigan", "kerrigan");
		anim.addSingle("shotgun", "shotgun");
		anim.addSingle("josh", "josh");
		
		return anim;
	}
	
	public static function getBigBoardAnim():Animation {
		// not a player
		var anim = new Animation(Assets.getBitmapData("assets/images/sheets/bigboard_ss.png"), Assets.getText("assets/data/bigboard.json"));
		
		anim.addSingle("0", "0001");
		anim.addSingle("1", "0002");
		anim.addSingle("2", "0003");
		anim.addSingle("3", "0004");
		anim.addSingle("4", "0005");
		anim.addSingle("5", "0006");
		anim.addSingle("6", "0007");
		anim.addSingle("7", "0008");
		anim.addSingle("8", "0009");
		anim.addSingle("9", "0010");
		anim.addSingle("10", "0011");
		anim.addSingle("11", "0012");
		anim.addSingle("12", "0013");
		anim.addSingle("13", "0014");
		anim.addSingle("14", "0015");
		
		return anim;
	}
	
	public static function getBoardAnim():Animation {
		// not a player
		var anim = new Animation(Assets.getBitmapData("assets/images/sheets/board_ss.png"), Assets.getText("assets/data/board.json"));
		
		anim.addSingle("0", "0001");
		anim.addSingle("1", "0002");
		anim.addSingle("2", "0003");
		anim.addSingle("3", "0004");
		anim.addSingle("4", "0005");
		anim.addSingle("5", "0006");
		anim.addSingle("6", "0007");
		anim.addSingle("7", "0008");
		anim.addSingle("8", "0009");
		anim.addSingle("9", "0010");
		anim.addSingle("10", "0011");
		anim.addSingle("11", "0012");
		anim.addSingle("12", "0013");
		anim.addSingle("13", "0014");
		anim.addSingle("14", "0015");
		
		return anim;
	}
}