# Repository Structure

```text
sanctuary/
├── .devcontainer/
│   ├── scripts/
│   │   ├── initialize.sh
│   │   └── on-create.sh
│   ├── .env
│   ├── devcontainer.json
│   └── Dockerfile
├── .github/
│   ├── actions/
│   │   ├── contributors/
│   │   │   ├── action.yml
│   │   │   └── README.md
│   │   └── generate-repository-intelligence/
│   │       ├── action.yml
│   │       └── generate_repository_intelligence.py
│   ├── ISSUE_TEMPLATE/
│   │   ├── architecture.yml
│   │   ├── bug-report.yml
│   │   └── config.yml
│   ├── scripts/
│   │   └── vitality.rb
│   ├── workflows/
│   │   ├── contributors.yml
│   │   ├── github-pages.yml
│   │   ├── repository-intelligence.yml
│   │   ├── sanity.yml
│   │   └── vitality.yml
│   ├── actionlint.yaml
│   ├── CODEOWNERS
│   ├── copilot-instructions.md
│   ├── FUNDING.yml
│   └── PULL_REQUEST_TEMPLATE.md
├── .idea/
│   ├── res/
│   │   └── colors.xml
│   ├── .gitignore
│   ├── checkstyle-idea.xml
│   ├── detekt.xml
│   ├── externalDependencies.xml
│   ├── google-java-format.xml
│   ├── jpa-buddy.xml
│   ├── other.xml
│   ├── ruff.xml
│   └── vcs.xml
├── .taskfile/
│   ├── git.yml
│   └── security.yml
├── .vscode/
│   ├── cspell.json
│   ├── extensions.json
│   ├── launch.json
│   ├── settings.json
│   └── tasks.json
├── assets/
│   ├── emojis/
│   │   ├── +1.png
│   │   ├── -1.png
│   │   ├── 100.png
│   │   ├── 1234.png
│   │   ├── 1st_place_medal.png
│   │   ├── 2nd_place_medal.png
│   │   ├── 3rd_place_medal.png
│   │   ├── 8ball.png
│   │   ├── a.png
│   │   ├── ab.png
│   │   ├── abacus.png
│   │   ├── abc.png
│   │   ├── abcd.png
│   │   ├── accept.png
│   │   ├── accessibility.png
│   │   ├── accordion.png
│   │   ├── adhesive_bandage.png
│   │   ├── adult.png
│   │   ├── aerial_tramway.png
│   │   ├── afghanistan.png
│   │   ├── airplane.png
│   │   ├── aland_islands.png
│   │   ├── alarm_clock.png
│   │   ├── albania.png
│   │   ├── alembic.png
│   │   ├── algeria.png
│   │   ├── alien.png
│   │   ├── ambulance.png
│   │   ├── american_samoa.png
│   │   ├── amphora.png
│   │   ├── anatomical_heart.png
│   │   ├── anchor.png
│   │   ├── andorra.png
│   │   ├── angel.png
│   │   ├── anger.png
│   │   ├── angola.png
│   │   ├── angry.png
│   │   ├── anguilla.png
│   │   ├── anguished.png
│   │   ├── ant.png
│   │   ├── antarctica.png
│   │   ├── antigua_barbuda.png
│   │   ├── apple.png
│   │   ├── aquarius.png
│   │   ├── argentina.png
│   │   ├── aries.png
│   │   ├── armenia.png
│   │   ├── arrow_backward.png
│   │   ├── arrow_double_down.png
│   │   ├── arrow_double_up.png
│   │   ├── arrow_down.png
│   │   ├── arrow_down_small.png
│   │   ├── arrow_forward.png
│   │   ├── arrow_heading_down.png
│   │   ├── arrow_heading_up.png
│   │   ├── arrow_left.png
│   │   ├── arrow_lower_left.png
│   │   ├── arrow_lower_right.png
│   │   ├── arrow_right.png
│   │   ├── arrow_right_hook.png
│   │   ├── arrow_up.png
│   │   ├── arrow_up_down.png
│   │   ├── arrow_up_small.png
│   │   ├── arrow_upper_left.png
│   │   ├── arrow_upper_right.png
│   │   ├── arrows_clockwise.png
│   │   ├── arrows_counterclockwise.png
│   │   ├── art.png
│   │   ├── articulated_lorry.png
│   │   ├── artificial_satellite.png
│   │   ├── artist.png
│   │   ├── aruba.png
│   │   ├── ascension_island.png
│   │   ├── asterisk.png
│   │   ├── astonished.png
│   │   ├── astronaut.png
│   │   ├── athletic_shoe.png
│   │   ├── atm.png
│   │   ├── atom.png
│   │   ├── atom_symbol.png
│   │   ├── australia.png
│   │   ├── austria.png
│   │   ├── auto_rickshaw.png
│   │   ├── avocado.png
│   │   ├── axe.png
│   │   ├── azerbaijan.png
│   │   ├── b.png
│   │   ├── baby.png
│   │   ├── baby_bottle.png
│   │   ├── baby_chick.png
│   │   ├── baby_symbol.png
│   │   ├── back.png
│   │   ├── bacon.png
│   │   ├── badger.png
│   │   ├── badminton.png
│   │   ├── bagel.png
│   │   ├── baggage_claim.png
│   │   ├── baguette_bread.png
│   │   ├── bahamas.png
│   │   ├── bahrain.png
│   │   ├── balance_scale.png
│   │   ├── bald_man.png
│   │   ├── bald_woman.png
│   │   ├── ballet_shoes.png
│   │   ├── balloon.png
│   │   ├── ballot_box.png
│   │   ├── ballot_box_with_check.png
│   │   ├── bamboo.png
│   │   ├── banana.png
│   │   ├── bangbang.png
│   │   ├── bangladesh.png
│   │   ├── banjo.png
│   │   ├── bank.png
│   │   ├── bar_chart.png
│   │   ├── barbados.png
│   │   ├── barber.png
│   │   ├── baseball.png
│   │   ├── basecamp.png
│   │   ├── basecampy.png
│   │   ├── basket.png
│   │   ├── basketball.png
│   │   ├── basketball_man.png
│   │   ├── basketball_woman.png
│   │   ├── bat.png
│   │   ├── bath.png
│   │   ├── bathtub.png
│   │   ├── battery.png
│   │   ├── beach_umbrella.png
│   │   ├── bear.png
│   │   ├── bearded_person.png
│   │   ├── beaver.png
│   │   ├── bed.png
│   │   ├── bee.png
│   │   ├── beer.png
│   │   ├── beers.png
│   │   ├── beetle.png
│   │   ├── beginner.png
│   │   ├── belarus.png
│   │   ├── belgium.png
│   │   ├── belize.png
│   │   ├── bell.png
│   │   ├── bell_pepper.png
│   │   ├── bellhop_bell.png
│   │   ├── benin.png
│   │   ├── bento.png
│   │   ├── bermuda.png
│   │   ├── beverage_box.png
│   │   ├── bhutan.png
│   │   ├── bicyclist.png
│   │   ├── bike.png
│   │   ├── biking_man.png
│   │   ├── biking_woman.png
│   │   ├── bikini.png
│   │   ├── billed_cap.png
│   │   ├── biohazard.png
│   │   ├── bird.png
│   │   ├── birthday.png
│   │   ├── bison.png
│   │   ├── black_cat.png
│   │   ├── black_circle.png
│   │   ├── black_flag.png
│   │   ├── black_heart.png
│   │   ├── black_joker.png
│   │   ├── black_large_square.png
│   │   ├── black_medium_small_square.png
│   │   ├── black_medium_square.png
│   │   ├── black_nib.png
│   │   ├── black_small_square.png
│   │   ├── black_square_button.png
│   │   ├── blond_haired_man.png
│   │   ├── blond_haired_person.png
│   │   ├── blond_haired_woman.png
│   │   ├── blonde_woman.png
│   │   ├── blossom.png
│   │   ├── blowfish.png
│   │   ├── blue_book.png
│   │   ├── blue_car.png
│   │   ├── blue_heart.png
│   │   ├── blue_square.png
│   │   ├── blueberries.png
│   │   ├── blush.png
│   │   ├── boar.png
│   │   ├── boat.png
│   │   ├── bolivia.png
│   │   ├── bomb.png
│   │   ├── bone.png
│   │   ├── book.png
│   │   ├── bookmark.png
│   │   ├── bookmark_tabs.png
│   │   ├── books.png
│   │   ├── boom.png
│   │   ├── boomerang.png
│   │   ├── boot.png
│   │   ├── bosnia_herzegovina.png
│   │   ├── botswana.png
│   │   ├── bouncing_ball_man.png
│   │   ├── bouncing_ball_person.png
│   │   ├── bouncing_ball_woman.png
│   │   ├── bouquet.png
│   │   ├── bouvet_island.png
│   │   ├── bow.png
│   │   ├── bow_and_arrow.png
│   │   ├── bowing_man.png
│   │   ├── bowing_woman.png
│   │   ├── bowl_with_spoon.png
│   │   ├── bowling.png
│   │   ├── bowtie.png
│   │   ├── boxing_glove.png
│   │   ├── boy.png
│   │   ├── brain.png
│   │   ├── brazil.png
│   │   ├── bread.png
│   │   ├── breast_feeding.png
│   │   ├── bricks.png
│   │   ├── bride_with_veil.png
│   │   ├── bridge_at_night.png
│   │   ├── briefcase.png
│   │   ├── british_indian_ocean_territory.png
│   │   ├── british_virgin_islands.png
│   │   ├── broccoli.png
│   │   ├── broken_heart.png
│   │   ├── broom.png
│   │   ├── brown_circle.png
│   │   ├── brown_heart.png
│   │   ├── brown_square.png
│   │   ├── brunei.png
│   │   ├── bubble_tea.png
│   │   ├── bucket.png
│   │   ├── bug.png
│   │   ├── building_construction.png
│   │   ├── bulb.png
│   │   ├── bulgaria.png
│   │   ├── bullettrain_front.png
│   │   ├── bullettrain_side.png
│   │   ├── burkina_faso.png
│   │   ├── burrito.png
│   │   ├── burundi.png
│   │   ├── bus.png
│   │   ├── business_suit_levitating.png
│   │   ├── busstop.png
│   │   ├── bust_in_silhouette.png
│   │   ├── busts_in_silhouette.png
│   │   ├── butter.png
│   │   ├── butterfly.png
│   │   ├── cactus.png
│   │   ├── cake.png
│   │   ├── calendar.png
│   │   ├── call_me_hand.png
│   │   ├── calling.png
│   │   ├── cambodia.png
│   │   ├── camel.png
│   │   ├── camera.png
│   │   ├── camera_flash.png
│   │   ├── cameroon.png
│   │   ├── camping.png
│   │   ├── canada.png
│   │   ├── canary_islands.png
│   │   ├── cancer.png
│   │   ├── candle.png
│   │   ├── candy.png
│   │   ├── canned_food.png
│   │   ├── canoe.png
│   │   ├── cape_verde.png
│   │   ├── capital_abcd.png
│   │   ├── capricorn.png
│   │   ├── car.png
│   │   ├── card_file_box.png
│   │   ├── card_index.png
│   │   ├── card_index_dividers.png
│   │   ├── caribbean_netherlands.png
│   │   ├── carousel_horse.png
│   │   ├── carpentry_saw.png
│   │   ├── carrot.png
│   │   ├── cartwheeling.png
│   │   ├── cat.png
│   │   ├── cat2.png
│   │   ├── cayman_islands.png
│   │   ├── cd.png
│   │   ├── central_african_republic.png
│   │   ├── ceuta_melilla.png
│   │   ├── chad.png
│   │   ├── chains.png
│   │   ├── chair.png
│   │   ├── champagne.png
│   │   ├── chart.png
│   │   ├── chart_with_downwards_trend.png
│   │   ├── chart_with_upwards_trend.png
│   │   ├── checkered_flag.png
│   │   ├── cheese.png
│   │   ├── cherries.png
│   │   ├── cherry_blossom.png
│   │   ├── chess_pawn.png
│   │   ├── chestnut.png
│   │   ├── chicken.png
│   │   ├── child.png
│   │   ├── children_crossing.png
│   │   ├── chile.png
│   │   ├── chipmunk.png
│   │   ├── chocolate_bar.png
│   │   ├── chopsticks.png
│   │   ├── christmas_island.png
│   │   ├── christmas_tree.png
│   │   ├── church.png
│   │   ├── cinema.png
│   │   ├── circus_tent.png
│   │   ├── city_sunrise.png
│   │   ├── city_sunset.png
│   │   ├── cityscape.png
│   │   ├── cl.png
│   │   ├── clamp.png
│   │   ├── clap.png
│   │   ├── clapper.png
│   │   ├── classical_building.png
│   │   ├── climbing.png
│   │   ├── climbing_man.png
│   │   ├── climbing_woman.png
│   │   ├── clinking_glasses.png
│   │   ├── clipboard.png
│   │   ├── clipperton_island.png
│   │   ├── clock1.png
│   │   ├── clock10.png
│   │   ├── clock1030.png
│   │   ├── clock11.png
│   │   ├── clock1130.png
│   │   ├── clock12.png
│   │   ├── clock1230.png
│   │   ├── clock130.png
│   │   ├── clock2.png
│   │   ├── clock230.png
│   │   ├── clock3.png
│   │   ├── clock330.png
│   │   ├── clock4.png
│   │   ├── clock430.png
│   │   ├── clock5.png
│   │   ├── clock530.png
│   │   ├── clock6.png
│   │   ├── clock630.png
│   │   ├── clock7.png
│   │   ├── clock730.png
│   │   ├── clock8.png
│   │   ├── clock830.png
│   │   ├── clock9.png
│   │   ├── clock930.png
│   │   ├── closed_book.png
│   │   ├── closed_lock_with_key.png
│   │   ├── closed_umbrella.png
│   │   ├── cloud.png
│   │   ├── cloud_with_lightning.png
│   │   ├── cloud_with_lightning_and_rain.png
│   │   ├── cloud_with_rain.png
│   │   ├── cloud_with_snow.png
│   │   ├── clown_face.png
│   │   ├── clubs.png
│   │   ├── cn.png
│   │   ├── coat.png
│   │   ├── cockroach.png
│   │   ├── cocktail.png
│   │   ├── coconut.png
│   │   ├── cocos_islands.png
│   │   ├── coffee.png
│   │   ├── coffin.png
│   │   ├── coin.png
│   │   ├── cold_face.png
│   │   ├── cold_sweat.png
│   │   ├── collision.png
│   │   ├── colombia.png
│   │   ├── comet.png
│   │   ├── comoros.png
│   │   ├── compass.png
│   │   ├── computer.png
│   │   ├── computer_mouse.png
│   │   ├── confetti_ball.png
│   │   ├── confounded.png
│   │   ├── confused.png
│   │   ├── congo_brazzaville.png
│   │   ├── congo_kinshasa.png
│   │   ├── congratulations.png
│   │   ├── construction.png
│   │   ├── construction_worker.png
│   │   ├── construction_worker_man.png
│   │   ├── construction_worker_woman.png
│   │   ├── control_knobs.png
│   │   ├── convenience_store.png
│   │   ├── cook.png
│   │   ├── cook_islands.png
│   │   ├── cookie.png
│   │   ├── cool.png
│   │   ├── cop.png
│   │   ├── copyright.png
│   │   ├── corn.png
│   │   ├── costa_rica.png
│   │   ├── cote_divoire.png
│   │   ├── couch_and_lamp.png
│   │   ├── couple.png
│   │   ├── couple_with_heart.png
│   │   ├── couple_with_heart_man_man.png
│   │   ├── couple_with_heart_woman_man.png
│   │   ├── couple_with_heart_woman_woman.png
│   │   ├── couplekiss.png
│   │   ├── couplekiss_man_man.png
│   │   ├── couplekiss_man_woman.png
│   │   ├── couplekiss_woman_woman.png
│   │   ├── cow.png
│   │   ├── cow2.png
│   │   ├── cowboy_hat_face.png
│   │   ├── crab.png
│   │   ├── crayon.png
│   │   ├── credit_card.png
│   │   ├── crescent_moon.png
│   │   ├── cricket.png
│   │   ├── cricket_game.png
│   │   ├── croatia.png
│   │   ├── crocodile.png
│   │   ├── croissant.png
│   │   ├── crossed_fingers.png
│   │   ├── crossed_flags.png
│   │   ├── crossed_swords.png
│   │   ├── crown.png
│   │   ├── cry.png
│   │   ├── crying_cat_face.png
│   │   ├── crystal_ball.png
│   │   ├── cuba.png
│   │   ├── cucumber.png
│   │   ├── cup_with_straw.png
│   │   ├── cupcake.png
│   │   ├── cupid.png
│   │   ├── curacao.png
│   │   ├── curling_stone.png
│   │   ├── curly_haired_man.png
│   │   ├── curly_haired_woman.png
│   │   ├── curly_loop.png
│   │   ├── currency_exchange.png
│   │   ├── curry.png
│   │   ├── cursing_face.png
│   │   ├── custard.png
│   │   ├── customs.png
│   │   ├── cut_of_meat.png
│   │   ├── cyclone.png
│   │   ├── cyprus.png
│   │   ├── czech_republic.png
│   │   ├── dagger.png
│   │   ├── dancer.png
│   │   ├── dancers.png
│   │   ├── dancing_men.png
│   │   ├── dancing_women.png
│   │   ├── dango.png
│   │   ├── dark_sunglasses.png
│   │   ├── dart.png
│   │   ├── dash.png
│   │   ├── date.png
│   │   ├── de.png
│   │   ├── deaf_man.png
│   │   ├── deaf_person.png
│   │   ├── deaf_woman.png
│   │   ├── deciduous_tree.png
│   │   ├── deer.png
│   │   ├── denmark.png
│   │   ├── department_store.png
│   │   ├── dependabot.png
│   │   ├── derelict_house.png
│   │   ├── desert.png
│   │   ├── desert_island.png
│   │   ├── desktop_computer.png
│   │   ├── detective.png
│   │   ├── diamond_shape_with_a_dot_inside.png
│   │   ├── diamonds.png
│   │   ├── diego_garcia.png
│   │   ├── disappointed.png
│   │   ├── disappointed_relieved.png
│   │   ├── disguised_face.png
│   │   ├── diving_mask.png
│   │   ├── diya_lamp.png
│   │   ├── dizzy.png
│   │   ├── dizzy_face.png
│   │   ├── djibouti.png
│   │   ├── dna.png
│   │   ├── do_not_litter.png
│   │   ├── dodo.png
│   │   ├── dog.png
│   │   ├── dog2.png
│   │   ├── dollar.png
│   │   ├── dolls.png
│   │   ├── dolphin.png
│   │   ├── dominica.png
│   │   ├── dominican_republic.png
│   │   ├── door.png
│   │   ├── doughnut.png
│   │   ├── dove.png
│   │   ├── dragon.png
│   │   ├── dragon_face.png
│   │   ├── dress.png
│   │   ├── dromedary_camel.png
│   │   ├── drooling_face.png
│   │   ├── drop_of_blood.png
│   │   ├── droplet.png
│   │   ├── drum.png
│   │   ├── duck.png
│   │   ├── dumpling.png
│   │   ├── dvd.png
│   │   ├── e-mail.png
│   │   ├── eagle.png
│   │   ├── ear.png
│   │   ├── ear_of_rice.png
│   │   ├── ear_with_hearing_aid.png
│   │   ├── earth_africa.png
│   │   ├── earth_americas.png
│   │   ├── earth_asia.png
│   │   ├── ecuador.png
│   │   ├── egg.png
│   │   ├── eggplant.png
│   │   ├── egypt.png
│   │   ├── eight.png
│   │   ├── eight_pointed_black_star.png
│   │   ├── eight_spoked_asterisk.png
│   │   ├── eject_button.png
│   │   ├── el_salvador.png
│   │   ├── electric_plug.png
│   │   ├── electron.png
│   │   ├── elephant.png
│   │   ├── elevator.png
│   │   ├── elf.png
│   │   ├── elf_man.png
│   │   ├── elf_woman.png
│   │   ├── email.png
│   │   ├── end.png
│   │   ├── england.png
│   │   ├── envelope.png
│   │   ├── envelope_with_arrow.png
│   │   ├── equatorial_guinea.png
│   │   ├── eritrea.png
│   │   ├── es.png
│   │   ├── estonia.png
│   │   ├── ethiopia.png
│   │   ├── eu.png
│   │   ├── euro.png
│   │   ├── european_castle.png
│   │   ├── european_post_office.png
│   │   ├── european_union.png
│   │   ├── evergreen_tree.png
│   │   ├── exclamation.png
│   │   ├── exploding_head.png
│   │   ├── expressionless.png
│   │   ├── eye.png
│   │   ├── eye_speech_bubble.png
│   │   ├── eyeglasses.png
│   │   ├── eyes.png
│   │   ├── face_exhaling.png
│   │   ├── face_in_clouds.png
│   │   ├── face_with_head_bandage.png
│   │   ├── face_with_spiral_eyes.png
│   │   ├── face_with_thermometer.png
│   │   ├── facepalm.png
│   │   ├── facepunch.png
│   │   ├── factory.png
│   │   ├── factory_worker.png
│   │   ├── fairy.png
│   │   ├── fairy_man.png
│   │   ├── fairy_woman.png
│   │   ├── falafel.png
│   │   ├── falkland_islands.png
│   │   ├── fallen_leaf.png
│   │   ├── family.png
│   │   ├── family_man_boy.png
│   │   ├── family_man_boy_boy.png
│   │   ├── family_man_girl.png
│   │   ├── family_man_girl_boy.png
│   │   ├── family_man_girl_girl.png
│   │   ├── family_man_man_boy.png
│   │   ├── family_man_man_boy_boy.png
│   │   ├── family_man_man_girl.png
│   │   ├── family_man_man_girl_boy.png
│   │   ├── family_man_man_girl_girl.png
│   │   ├── family_man_woman_boy.png
│   │   ├── family_man_woman_boy_boy.png
│   │   ├── family_man_woman_girl.png
│   │   ├── family_man_woman_girl_boy.png
│   │   ├── family_man_woman_girl_girl.png
│   │   ├── family_woman_boy.png
│   │   ├── family_woman_boy_boy.png
│   │   ├── family_woman_girl.png
│   │   ├── family_woman_girl_boy.png
│   │   ├── family_woman_girl_girl.png
│   │   ├── family_woman_woman_boy.png
│   │   ├── family_woman_woman_boy_boy.png
│   │   ├── family_woman_woman_girl.png
│   │   ├── family_woman_woman_girl_boy.png
│   │   ├── family_woman_woman_girl_girl.png
│   │   ├── farmer.png
│   │   ├── faroe_islands.png
│   │   ├── fast_forward.png
│   │   ├── fax.png
│   │   ├── fearful.png
│   │   ├── feather.png
│   │   ├── feelsgood.png
│   │   ├── feet.png
│   │   ├── female_detective.png
│   │   ├── female_sign.png
│   │   ├── ferris_wheel.png
│   │   ├── ferry.png
│   │   ├── field_hockey.png
│   │   ├── fiji.png
│   │   ├── file_cabinet.png
│   │   ├── file_folder.png
│   │   ├── film_projector.png
│   │   ├── film_strip.png
│   │   ├── finland.png
│   │   ├── finnadie.png
│   │   ├── fire.png
│   │   ├── fire_engine.png
│   │   ├── fire_extinguisher.png
│   │   ├── firecracker.png
│   │   ├── firefighter.png
│   │   ├── fireworks.png
│   │   ├── first_quarter_moon.png
│   │   ├── first_quarter_moon_with_face.png
│   │   ├── fish.png
│   │   ├── fish_cake.png
│   │   ├── fishing_pole_and_fish.png
│   │   ├── fishsticks.png
│   │   ├── fist.png
│   │   ├── fist_left.png
│   │   ├── fist_oncoming.png
│   │   ├── fist_raised.png
│   │   ├── fist_right.png
│   │   ├── five.png
│   │   ├── flags.png
│   │   ├── flamingo.png
│   │   ├── flashlight.png
│   │   ├── flat_shoe.png
│   │   ├── flatbread.png
│   │   ├── fleur_de_lis.png
│   │   ├── flight_arrival.png
│   │   ├── flight_departure.png
│   │   ├── flipper.png
│   │   ├── floppy_disk.png
│   │   ├── flower_playing_cards.png
│   │   ├── flushed.png
│   │   ├── fly.png
│   │   ├── flying_disc.png
│   │   ├── flying_saucer.png
│   │   ├── fog.png
│   │   ├── foggy.png
│   │   ├── fondue.png
│   │   ├── foot.png
│   │   ├── football.png
│   │   ├── footprints.png
│   │   ├── fork_and_knife.png
│   │   ├── fortune_cookie.png
│   │   ├── fountain.png
│   │   ├── fountain_pen.png
│   │   ├── four.png
│   │   ├── four_leaf_clover.png
│   │   ├── fox_face.png
│   │   ├── fr.png
│   │   ├── framed_picture.png
│   │   ├── free.png
│   │   ├── french_guiana.png
│   │   ├── french_polynesia.png
│   │   ├── french_southern_territories.png
│   │   ├── fried_egg.png
│   │   ├── fried_shrimp.png
│   │   ├── fries.png
│   │   ├── frog.png
│   │   ├── frowning.png
│   │   ├── frowning_face.png
│   │   ├── frowning_man.png
│   │   ├── frowning_person.png
│   │   ├── frowning_woman.png
│   │   ├── fu.png
│   │   ├── fuelpump.png
│   │   ├── full_moon.png
│   │   ├── full_moon_with_face.png
│   │   ├── funeral_urn.png
│   │   ├── gabon.png
│   │   ├── gambia.png
│   │   ├── game_die.png
│   │   ├── garlic.png
│   │   ├── gb.png
│   │   ├── gear.png
│   │   ├── gem.png
│   │   ├── gemini.png
│   │   ├── genie.png
│   │   ├── genie_man.png
│   │   ├── genie_woman.png
│   │   ├── georgia.png
│   │   ├── ghana.png
│   │   ├── ghost.png
│   │   ├── gibraltar.png
│   │   ├── gift.png
│   │   ├── gift_heart.png
│   │   ├── giraffe.png
│   │   ├── girl.png
│   │   ├── globe_with_meridians.png
│   │   ├── gloves.png
│   │   ├── goal_net.png
│   │   ├── goat.png
│   │   ├── goberserk.png
│   │   ├── godmode.png
│   │   ├── goggles.png
│   │   ├── golf.png
│   │   ├── golfing.png
│   │   ├── golfing_man.png
│   │   ├── golfing_woman.png
│   │   ├── gorilla.png
│   │   ├── grapes.png
│   │   ├── greece.png
│   │   ├── green_apple.png
│   │   ├── green_book.png
│   │   ├── green_circle.png
│   │   ├── green_heart.png
│   │   ├── green_salad.png
│   │   ├── green_square.png
│   │   ├── greenland.png
│   │   ├── grenada.png
│   │   ├── grey_exclamation.png
│   │   ├── grey_question.png
│   │   ├── grimacing.png
│   │   ├── grin.png
│   │   ├── grinning.png
│   │   ├── guadeloupe.png
│   │   ├── guam.png
│   │   ├── guard.png
│   │   ├── guardsman.png
│   │   ├── guardswoman.png
│   │   ├── guatemala.png
│   │   ├── guernsey.png
│   │   ├── guide_dog.png
│   │   ├── guinea.png
│   │   ├── guinea_bissau.png
│   │   ├── guitar.png
│   │   ├── gun.png
│   │   ├── guyana.png
│   │   ├── haircut.png
│   │   ├── haircut_man.png
│   │   ├── haircut_woman.png
│   │   ├── haiti.png
│   │   ├── hamburger.png
│   │   ├── hammer.png
│   │   ├── hammer_and_pick.png
│   │   ├── hammer_and_wrench.png
│   │   ├── hamster.png
│   │   ├── hand.png
│   │   ├── hand_over_mouth.png
│   │   ├── handbag.png
│   │   ├── handball_person.png
│   │   ├── handshake.png
│   │   ├── hankey.png
│   │   ├── hash.png
│   │   ├── hatched_chick.png
│   │   ├── hatching_chick.png
│   │   ├── headphones.png
│   │   ├── headstone.png
│   │   ├── health_worker.png
│   │   ├── hear_no_evil.png
│   │   ├── heard_mcdonald_islands.png
│   │   ├── heart.png
│   │   ├── heart_decoration.png
│   │   ├── heart_eyes.png
│   │   ├── heart_eyes_cat.png
│   │   ├── heart_on_fire.png
│   │   ├── heartbeat.png
│   │   ├── heartpulse.png
│   │   ├── hearts.png
│   │   ├── heavy_check_mark.png
│   │   ├── heavy_division_sign.png
│   │   ├── heavy_dollar_sign.png
│   │   ├── heavy_exclamation_mark.png
│   │   ├── heavy_heart_exclamation.png
│   │   ├── heavy_minus_sign.png
│   │   ├── heavy_multiplication_x.png
│   │   ├── heavy_plus_sign.png
│   │   ├── hedgehog.png
│   │   ├── helicopter.png
│   │   ├── herb.png
│   │   ├── hibiscus.png
│   │   ├── high_brightness.png
│   │   ├── high_heel.png
│   │   ├── hiking_boot.png
│   │   ├── hindu_temple.png
│   │   ├── hippopotamus.png
│   │   ├── hocho.png
│   │   ├── hole.png
│   │   ├── honduras.png
│   │   ├── honey_pot.png
│   │   ├── honeybee.png
│   │   ├── hong_kong.png
│   │   ├── hook.png
│   │   ├── horse.png
│   │   ├── horse_racing.png
│   │   ├── hospital.png
│   │   ├── hot_face.png
│   │   ├── hot_pepper.png
│   │   ├── hotdog.png
│   │   ├── hotel.png
│   │   ├── hotsprings.png
│   │   ├── hourglass.png
│   │   ├── hourglass_flowing_sand.png
│   │   ├── house.png
│   │   ├── house_with_garden.png
│   │   ├── houses.png
│   │   ├── hugs.png
│   │   ├── hungary.png
│   │   ├── hurtrealbad.png
│   │   ├── hushed.png
│   │   ├── hut.png
│   │   ├── ice_cream.png
│   │   ├── ice_cube.png
│   │   ├── ice_hockey.png
│   │   ├── ice_skate.png
│   │   ├── icecream.png
│   │   ├── iceland.png
│   │   ├── id.png
│   │   ├── ideograph_advantage.png
│   │   ├── imp.png
│   │   ├── inbox_tray.png
│   │   ├── incoming_envelope.png
│   │   ├── india.png
│   │   ├── indonesia.png
│   │   ├── infinity.png
│   │   ├── information_desk_person.png
│   │   ├── information_source.png
│   │   ├── innocent.png
│   │   ├── interrobang.png
│   │   ├── iphone.png
│   │   ├── iran.png
│   │   ├── iraq.png
│   │   ├── ireland.png
│   │   ├── isle_of_man.png
│   │   ├── israel.png
│   │   ├── it.png
│   │   ├── izakaya_lantern.png
│   │   ├── jack_o_lantern.png
│   │   ├── jamaica.png
│   │   ├── japan.png
│   │   ├── japanese_castle.png
│   │   ├── japanese_goblin.png
│   │   ├── japanese_ogre.png
│   │   ├── jeans.png
│   │   ├── jersey.png
│   │   ├── jigsaw.png
│   │   ├── jordan.png
│   │   ├── joy.png
│   │   ├── joy_cat.png
│   │   ├── joystick.png
│   │   ├── jp.png
│   │   ├── judge.png
│   │   ├── juggling_person.png
│   │   ├── kaaba.png
│   │   ├── kangaroo.png
│   │   ├── kazakhstan.png
│   │   ├── kenya.png
│   │   ├── key.png
│   │   ├── keyboard.png
│   │   ├── keycap_ten.png
│   │   ├── kick_scooter.png
│   │   ├── kimono.png
│   │   ├── kiribati.png
│   │   ├── kiss.png
│   │   ├── kissing.png
│   │   ├── kissing_cat.png
│   │   ├── kissing_closed_eyes.png
│   │   ├── kissing_heart.png
│   │   ├── kissing_smiling_eyes.png
│   │   ├── kite.png
│   │   ├── kiwi_fruit.png
│   │   ├── kneeling_man.png
│   │   ├── kneeling_person.png
│   │   ├── kneeling_woman.png
│   │   ├── knife.png
│   │   ├── knot.png
│   │   ├── koala.png
│   │   ├── koko.png
│   │   ├── kosovo.png
│   │   ├── kr.png
│   │   ├── kuwait.png
│   │   ├── kyrgyzstan.png
│   │   ├── lab_coat.png
│   │   ├── label.png
│   │   ├── lacrosse.png
│   │   ├── ladder.png
│   │   ├── lady_beetle.png
│   │   ├── lantern.png
│   │   ├── laos.png
│   │   ├── large_blue_circle.png
│   │   ├── large_blue_diamond.png
│   │   ├── large_orange_diamond.png
│   │   ├── last_quarter_moon.png
│   │   ├── last_quarter_moon_with_face.png
│   │   ├── latin_cross.png
│   │   ├── latvia.png
│   │   ├── laughing.png
│   │   ├── leafy_green.png
│   │   ├── leaves.png
│   │   ├── lebanon.png
│   │   ├── ledger.png
│   │   ├── left_luggage.png
│   │   ├── left_right_arrow.png
│   │   ├── left_speech_bubble.png
│   │   ├── leftwards_arrow_with_hook.png
│   │   ├── leg.png
│   │   ├── lemon.png
│   │   ├── leo.png
│   │   ├── leopard.png
│   │   ├── lesotho.png
│   │   ├── level_slider.png
│   │   ├── liberia.png
│   │   ├── libra.png
│   │   ├── libya.png
│   │   ├── liechtenstein.png
│   │   ├── light_rail.png
│   │   ├── link.png
│   │   ├── lion.png
│   │   ├── lips.png
│   │   ├── lipstick.png
│   │   ├── lithuania.png
│   │   ├── lizard.png
│   │   ├── llama.png
│   │   ├── lobster.png
│   │   ├── lock.png
│   │   ├── lock_with_ink_pen.png
│   │   ├── lollipop.png
│   │   ├── long_drum.png
│   │   ├── loop.png
│   │   ├── lotion_bottle.png
│   │   ├── lotus_position.png
│   │   ├── lotus_position_man.png
│   │   ├── lotus_position_woman.png
│   │   ├── loud_sound.png
│   │   ├── loudspeaker.png
│   │   ├── love_hotel.png
│   │   ├── love_letter.png
│   │   ├── love_you_gesture.png
│   │   ├── low_brightness.png
│   │   ├── luggage.png
│   │   ├── lungs.png
│   │   ├── luxembourg.png
│   │   ├── lying_face.png
│   │   ├── m.png
│   │   ├── macau.png
│   │   ├── macedonia.png
│   │   ├── madagascar.png
│   │   ├── mag.png
│   │   ├── mag_right.png
│   │   ├── mage.png
│   │   ├── mage_man.png
│   │   ├── mage_woman.png
│   │   ├── magic_wand.png
│   │   ├── magnet.png
│   │   ├── mahjong.png
│   │   ├── mailbox.png
│   │   ├── mailbox_closed.png
│   │   ├── mailbox_with_mail.png
│   │   ├── mailbox_with_no_mail.png
│   │   ├── malawi.png
│   │   ├── malaysia.png
│   │   ├── maldives.png
│   │   ├── male_detective.png
│   │   ├── male_sign.png
│   │   ├── mali.png
│   │   ├── malta.png
│   │   ├── mammoth.png
│   │   ├── man.png
│   │   ├── man_artist.png
│   │   ├── man_astronaut.png
│   │   ├── man_beard.png
│   │   ├── man_cartwheeling.png
│   │   ├── man_cook.png
│   │   ├── man_dancing.png
│   │   ├── man_facepalming.png
│   │   ├── man_factory_worker.png
│   │   ├── man_farmer.png
│   │   ├── man_feeding_baby.png
│   │   ├── man_firefighter.png
│   │   ├── man_health_worker.png
│   │   ├── man_in_manual_wheelchair.png
│   │   ├── man_in_motorized_wheelchair.png
│   │   ├── man_in_tuxedo.png
│   │   ├── man_judge.png
│   │   ├── man_juggling.png
│   │   ├── man_mechanic.png
│   │   ├── man_office_worker.png
│   │   ├── man_pilot.png
│   │   ├── man_playing_handball.png
│   │   ├── man_playing_water_polo.png
│   │   ├── man_scientist.png
│   │   ├── man_shrugging.png
│   │   ├── man_singer.png
│   │   ├── man_student.png
│   │   ├── man_teacher.png
│   │   ├── man_technologist.png
│   │   ├── man_with_gua_pi_mao.png
│   │   ├── man_with_probing_cane.png
│   │   ├── man_with_turban.png
│   │   ├── man_with_veil.png
│   │   ├── mandarin.png
│   │   ├── mango.png
│   │   ├── mans_shoe.png
│   │   ├── mantelpiece_clock.png
│   │   ├── manual_wheelchair.png
│   │   ├── maple_leaf.png
│   │   ├── marshall_islands.png
│   │   ├── martial_arts_uniform.png
│   │   ├── martinique.png
│   │   ├── mask.png
│   │   ├── massage.png
│   │   ├── massage_man.png
│   │   ├── massage_woman.png
│   │   ├── mate.png
│   │   ├── mauritania.png
│   │   ├── mauritius.png
│   │   ├── mayotte.png
│   │   ├── meat_on_bone.png
│   │   ├── mechanic.png
│   │   ├── mechanical_arm.png
│   │   ├── mechanical_leg.png
│   │   ├── medal_military.png
│   │   ├── medal_sports.png
│   │   ├── medical_symbol.png
│   │   ├── mega.png
│   │   ├── melon.png
│   │   ├── memo.png
│   │   ├── men_wrestling.png
│   │   ├── mending_heart.png
│   │   ├── menorah.png
│   │   ├── mens.png
│   │   ├── mermaid.png
│   │   ├── merman.png
│   │   ├── merperson.png
│   │   ├── metal.png
│   │   ├── metro.png
│   │   ├── mexico.png
│   │   ├── microbe.png
│   │   ├── micronesia.png
│   │   ├── microphone.png
│   │   ├── microscope.png
│   │   ├── middle_finger.png
│   │   ├── military_helmet.png
│   │   ├── milk_glass.png
│   │   ├── milky_way.png
│   │   ├── minibus.png
│   │   ├── minidisc.png
│   │   ├── mirror.png
│   │   ├── mobile_phone_off.png
│   │   ├── moldova.png
│   │   ├── monaco.png
│   │   ├── money_mouth_face.png
│   │   ├── money_with_wings.png
│   │   ├── moneybag.png
│   │   ├── mongolia.png
│   │   ├── monkey.png
│   │   ├── monkey_face.png
│   │   ├── monocle_face.png
│   │   ├── monorail.png
│   │   ├── montenegro.png
│   │   ├── montserrat.png
│   │   ├── moon.png
│   │   ├── moon_cake.png
│   │   ├── morocco.png
│   │   ├── mortar_board.png
│   │   ├── mosque.png
│   │   ├── mosquito.png
│   │   ├── motor_boat.png
│   │   ├── motor_scooter.png
│   │   ├── motorcycle.png
│   │   ├── motorized_wheelchair.png
│   │   ├── motorway.png
│   │   ├── mount_fuji.png
│   │   ├── mountain.png
│   │   ├── mountain_bicyclist.png
│   │   ├── mountain_biking_man.png
│   │   ├── mountain_biking_woman.png
│   │   ├── mountain_cableway.png
│   │   ├── mountain_railway.png
│   │   ├── mountain_snow.png
│   │   ├── mouse.png
│   │   ├── mouse2.png
│   │   ├── mouse_trap.png
│   │   ├── movie_camera.png
│   │   ├── moyai.png
│   │   ├── mozambique.png
│   │   ├── mrs_claus.png
│   │   ├── muscle.png
│   │   ├── mushroom.png
│   │   ├── musical_keyboard.png
│   │   ├── musical_note.png
│   │   ├── musical_score.png
│   │   ├── mute.png
│   │   ├── mx_claus.png
│   │   ├── myanmar.png
│   │   ├── nail_care.png
│   │   ├── name_badge.png
│   │   ├── namibia.png
│   │   ├── national_park.png
│   │   ├── nauru.png
│   │   ├── nauseated_face.png
│   │   ├── nazar_amulet.png
│   │   ├── neckbeard.png
│   │   ├── necktie.png
│   │   ├── negative_squared_cross_mark.png
│   │   ├── nepal.png
│   │   ├── nerd_face.png
│   │   ├── nesting_dolls.png
│   │   ├── netherlands.png
│   │   ├── neutral_face.png
│   │   ├── new.png
│   │   ├── new_caledonia.png
│   │   ├── new_moon.png
│   │   ├── new_moon_with_face.png
│   │   ├── new_zealand.png
│   │   ├── newspaper.png
│   │   ├── newspaper_roll.png
│   │   ├── next_track_button.png
│   │   ├── ng.png
│   │   ├── ng_man.png
│   │   ├── ng_woman.png
│   │   ├── nicaragua.png
│   │   ├── niger.png
│   │   ├── nigeria.png
│   │   ├── night_with_stars.png
│   │   ├── nine.png
│   │   ├── ninja.png
│   │   ├── niue.png
│   │   ├── no_bell.png
│   │   ├── no_bicycles.png
│   │   ├── no_entry.png
│   │   ├── no_entry_sign.png
│   │   ├── no_good.png
│   │   ├── no_good_man.png
│   │   ├── no_good_woman.png
│   │   ├── no_mobile_phones.png
│   │   ├── no_mouth.png
│   │   ├── no_pedestrians.png
│   │   ├── no_smoking.png
│   │   ├── non-potable_water.png
│   │   ├── norfolk_island.png
│   │   ├── north_korea.png
│   │   ├── northern_mariana_islands.png
│   │   ├── norway.png
│   │   ├── nose.png
│   │   ├── notebook.png
│   │   ├── notebook_with_decorative_cover.png
│   │   ├── notes.png
│   │   ├── nut_and_bolt.png
│   │   ├── o.png
│   │   ├── o2.png
│   │   ├── ocean.png
│   │   ├── octocat.png
│   │   ├── octopus.png
│   │   ├── oden.png
│   │   ├── office.png
│   │   ├── office_worker.png
│   │   ├── oil_drum.png
│   │   ├── ok.png
│   │   ├── ok_hand.png
│   │   ├── ok_man.png
│   │   ├── ok_person.png
│   │   ├── ok_woman.png
│   │   ├── old_key.png
│   │   ├── older_adult.png
│   │   ├── older_man.png
│   │   ├── older_woman.png
│   │   ├── olive.png
│   │   ├── om.png
│   │   ├── oman.png
│   │   ├── on.png
│   │   ├── oncoming_automobile.png
│   │   ├── oncoming_bus.png
│   │   ├── oncoming_police_car.png
│   │   ├── oncoming_taxi.png
│   │   ├── one.png
│   │   ├── one_piece_swimsuit.png
│   │   ├── onion.png
│   │   ├── open_book.png
│   │   ├── open_file_folder.png
│   │   ├── open_hands.png
│   │   ├── open_mouth.png
│   │   ├── open_umbrella.png
│   │   ├── ophiuchus.png
│   │   ├── orange.png
│   │   ├── orange_book.png
│   │   ├── orange_circle.png
│   │   ├── orange_heart.png
│   │   ├── orange_square.png
│   │   ├── orangutan.png
│   │   ├── orthodox_cross.png
│   │   ├── otter.png
│   │   ├── outbox_tray.png
│   │   ├── owl.png
│   │   ├── ox.png
│   │   ├── oyster.png
│   │   ├── package.png
│   │   ├── page_facing_up.png
│   │   ├── page_with_curl.png
│   │   ├── pager.png
│   │   ├── paintbrush.png
│   │   ├── pakistan.png
│   │   ├── palau.png
│   │   ├── palestinian_territories.png
│   │   ├── palm_tree.png
│   │   ├── palms_up_together.png
│   │   ├── panama.png
│   │   ├── pancakes.png
│   │   ├── panda_face.png
│   │   ├── paperclip.png
│   │   ├── paperclips.png
│   │   ├── papua_new_guinea.png
│   │   ├── parachute.png
│   │   ├── paraguay.png
│   │   ├── parasol_on_ground.png
│   │   ├── parking.png
│   │   ├── parrot.png
│   │   ├── part_alternation_mark.png
│   │   ├── partly_sunny.png
│   │   ├── partying_face.png
│   │   ├── passenger_ship.png
│   │   ├── passport_control.png
│   │   ├── pause_button.png
│   │   ├── paw_prints.png
│   │   ├── peace_symbol.png
│   │   ├── peach.png
│   │   ├── peacock.png
│   │   ├── peanuts.png
│   │   ├── pear.png
│   │   ├── pen.png
│   │   ├── pencil.png
│   │   ├── pencil2.png
│   │   ├── penguin.png
│   │   ├── pensive.png
│   │   ├── people_holding_hands.png
│   │   ├── people_hugging.png
│   │   ├── performing_arts.png
│   │   ├── persevere.png
│   │   ├── person_bald.png
│   │   ├── person_curly_hair.png
│   │   ├── person_feeding_baby.png
│   │   ├── person_fencing.png
│   │   ├── person_in_manual_wheelchair.png
│   │   ├── person_in_motorized_wheelchair.png
│   │   ├── person_in_tuxedo.png
│   │   ├── person_red_hair.png
│   │   ├── person_white_hair.png
│   │   ├── person_with_probing_cane.png
│   │   ├── person_with_turban.png
│   │   ├── person_with_veil.png
│   │   ├── peru.png
│   │   ├── petri_dish.png
│   │   ├── philippines.png
│   │   ├── phone.png
│   │   ├── pick.png
│   │   ├── pickup_truck.png
│   │   ├── pie.png
│   │   ├── pig.png
│   │   ├── pig2.png
│   │   ├── pig_nose.png
│   │   ├── pill.png
│   │   ├── pilot.png
│   │   ├── pinata.png
│   │   ├── pinched_fingers.png
│   │   ├── pinching_hand.png
│   │   ├── pineapple.png
│   │   ├── ping_pong.png
│   │   ├── pirate_flag.png
│   │   ├── pisces.png
│   │   ├── pitcairn_islands.png
│   │   ├── pizza.png
│   │   ├── placard.png
│   │   ├── place_of_worship.png
│   │   ├── plate_with_cutlery.png
│   │   ├── play_or_pause_button.png
│   │   ├── pleading_face.png
│   │   ├── plunger.png
│   │   ├── point_down.png
│   │   ├── point_left.png
│   │   ├── point_right.png
│   │   ├── point_up.png
│   │   ├── point_up_2.png
│   │   ├── poland.png
│   │   ├── polar_bear.png
│   │   ├── police_car.png
│   │   ├── police_officer.png
│   │   ├── policeman.png
│   │   ├── policewoman.png
│   │   ├── poodle.png
│   │   ├── poop.png
│   │   ├── popcorn.png
│   │   ├── portugal.png
│   │   ├── post_office.png
│   │   ├── postal_horn.png
│   │   ├── postbox.png
│   │   ├── potable_water.png
│   │   ├── potato.png
│   │   ├── potted_plant.png
│   │   ├── pouch.png
│   │   ├── poultry_leg.png
│   │   ├── pound.png
│   │   ├── pout.png
│   │   ├── pouting_cat.png
│   │   ├── pouting_face.png
│   │   ├── pouting_man.png
│   │   ├── pouting_woman.png
│   │   ├── pray.png
│   │   ├── prayer_beads.png
│   │   ├── pregnant_woman.png
│   │   ├── pretzel.png
│   │   ├── previous_track_button.png
│   │   ├── prince.png
│   │   ├── princess.png
│   │   ├── printer.png
│   │   ├── probing_cane.png
│   │   ├── puerto_rico.png
│   │   ├── punch.png
│   │   ├── purple_circle.png
│   │   ├── purple_heart.png
│   │   ├── purple_square.png
│   │   ├── purse.png
│   │   ├── pushpin.png
│   │   ├── put_litter_in_its_place.png
│   │   ├── qatar.png
│   │   ├── question.png
│   │   ├── rabbit.png
│   │   ├── rabbit2.png
│   │   ├── raccoon.png
│   │   ├── racehorse.png
│   │   ├── racing_car.png
│   │   ├── radio.png
│   │   ├── radio_button.png
│   │   ├── radioactive.png
│   │   ├── rage.png
│   │   ├── rage1.png
│   │   ├── rage2.png
│   │   ├── rage3.png
│   │   ├── rage4.png
│   │   ├── railway_car.png
│   │   ├── railway_track.png
│   │   ├── rainbow.png
│   │   ├── rainbow_flag.png
│   │   ├── raised_back_of_hand.png
│   │   ├── raised_eyebrow.png
│   │   ├── raised_hand.png
│   │   ├── raised_hand_with_fingers_splayed.png
│   │   ├── raised_hands.png
│   │   ├── raising_hand.png
│   │   ├── raising_hand_man.png
│   │   ├── raising_hand_woman.png
│   │   ├── ram.png
│   │   ├── ramen.png
│   │   ├── rat.png
│   │   ├── razor.png
│   │   ├── receipt.png
│   │   ├── record_button.png
│   │   ├── recycle.png
│   │   ├── red_car.png
│   │   ├── red_circle.png
│   │   ├── red_envelope.png
│   │   ├── red_haired_man.png
│   │   ├── red_haired_woman.png
│   │   ├── red_square.png
│   │   ├── registered.png
│   │   ├── relaxed.png
│   │   ├── relieved.png
│   │   ├── reminder_ribbon.png
│   │   ├── repeat.png
│   │   ├── repeat_one.png
│   │   ├── rescue_worker_helmet.png
│   │   ├── restroom.png
│   │   ├── reunion.png
│   │   ├── revolving_hearts.png
│   │   ├── rewind.png
│   │   ├── rhinoceros.png
│   │   ├── ribbon.png
│   │   ├── rice.png
│   │   ├── rice_ball.png
│   │   ├── rice_cracker.png
│   │   ├── rice_scene.png
│   │   ├── right_anger_bubble.png
│   │   ├── ring.png
│   │   ├── ringed_planet.png
│   │   ├── robot.png
│   │   ├── rock.png
│   │   ├── rocket.png
│   │   ├── rofl.png
│   │   ├── roll_eyes.png
│   │   ├── roll_of_paper.png
│   │   ├── roller_coaster.png
│   │   ├── roller_skate.png
│   │   ├── romania.png
│   │   ├── rooster.png
│   │   ├── rose.png
│   │   ├── rosette.png
│   │   ├── rotating_light.png
│   │   ├── round_pushpin.png
│   │   ├── rowboat.png
│   │   ├── rowing_man.png
│   │   ├── rowing_woman.png
│   │   ├── ru.png
│   │   ├── rugby_football.png
│   │   ├── runner.png
│   │   ├── running.png
│   │   ├── running_man.png
│   │   ├── running_shirt_with_sash.png
│   │   ├── running_woman.png
│   │   ├── rwanda.png
│   │   ├── sa.png
│   │   ├── safety_pin.png
│   │   ├── safety_vest.png
│   │   ├── sagittarius.png
│   │   ├── sailboat.png
│   │   ├── sake.png
│   │   ├── salt.png
│   │   ├── samoa.png
│   │   ├── san_marino.png
│   │   ├── sandal.png
│   │   ├── sandwich.png
│   │   ├── santa.png
│   │   ├── sao_tome_principe.png
│   │   ├── sari.png
│   │   ├── sassy_man.png
│   │   ├── sassy_woman.png
│   │   ├── satellite.png
│   │   ├── satisfied.png
│   │   ├── saudi_arabia.png
│   │   ├── sauna_man.png
│   │   ├── sauna_person.png
│   │   ├── sauna_woman.png
│   │   ├── sauropod.png
│   │   ├── saxophone.png
│   │   ├── scarf.png
│   │   ├── school.png
│   │   ├── school_satchel.png
│   │   ├── scientist.png
│   │   ├── scissors.png
│   │   ├── scorpion.png
│   │   ├── scorpius.png
│   │   ├── scotland.png
│   │   ├── scream.png
│   │   ├── scream_cat.png
│   │   ├── screwdriver.png
│   │   ├── scroll.png
│   │   ├── seal.png
│   │   ├── seat.png
│   │   ├── secret.png
│   │   ├── see_no_evil.png
│   │   ├── seedling.png
│   │   ├── selfie.png
│   │   ├── senegal.png
│   │   ├── serbia.png
│   │   ├── service_dog.png
│   │   ├── seven.png
│   │   ├── sewing_needle.png
│   │   ├── seychelles.png
│   │   ├── shallow_pan_of_food.png
│   │   ├── shamrock.png
│   │   ├── shark.png
│   │   ├── shaved_ice.png
│   │   ├── sheep.png
│   │   ├── shell.png
│   │   ├── shield.png
│   │   ├── shinto_shrine.png
│   │   ├── ship.png
│   │   ├── shipit.png
│   │   ├── shirt.png
│   │   ├── shit.png
│   │   ├── shoe.png
│   │   ├── shopping.png
│   │   ├── shopping_cart.png
│   │   ├── shorts.png
│   │   ├── shower.png
│   │   ├── shrimp.png
│   │   ├── shrug.png
│   │   ├── shushing_face.png
│   │   ├── sierra_leone.png
│   │   ├── signal_strength.png
│   │   ├── singapore.png
│   │   ├── singer.png
│   │   ├── sint_maarten.png
│   │   ├── six.png
│   │   ├── six_pointed_star.png
│   │   ├── skateboard.png
│   │   ├── ski.png
│   │   ├── skier.png
│   │   ├── skull.png
│   │   ├── skull_and_crossbones.png
│   │   ├── skunk.png
│   │   ├── sled.png
│   │   ├── sleeping.png
│   │   ├── sleeping_bed.png
│   │   ├── sleepy.png
│   │   ├── slightly_frowning_face.png
│   │   ├── slightly_smiling_face.png
│   │   ├── slot_machine.png
│   │   ├── sloth.png
│   │   ├── slovakia.png
│   │   ├── slovenia.png
│   │   ├── small_airplane.png
│   │   ├── small_blue_diamond.png
│   │   ├── small_orange_diamond.png
│   │   ├── small_red_triangle.png
│   │   ├── small_red_triangle_down.png
│   │   ├── smile.png
│   │   ├── smile_cat.png
│   │   ├── smiley.png
│   │   ├── smiley_cat.png
│   │   ├── smiling_face_with_tear.png
│   │   ├── smiling_face_with_three_hearts.png
│   │   ├── smiling_imp.png
│   │   ├── smirk.png
│   │   ├── smirk_cat.png
│   │   ├── smoking.png
│   │   ├── snail.png
│   │   ├── snake.png
│   │   ├── sneezing_face.png
│   │   ├── snowboarder.png
│   │   ├── snowflake.png
│   │   ├── snowman.png
│   │   ├── snowman_with_snow.png
│   │   ├── soap.png
│   │   ├── sob.png
│   │   ├── soccer.png
│   │   ├── socks.png
│   │   ├── softball.png
│   │   ├── solomon_islands.png
│   │   ├── somalia.png
│   │   ├── soon.png
│   │   ├── sos.png
│   │   ├── sound.png
│   │   ├── south_africa.png
│   │   ├── south_georgia_south_sandwich_islands.png
│   │   ├── south_sudan.png
│   │   ├── space_invader.png
│   │   ├── spades.png
│   │   ├── spaghetti.png
│   │   ├── sparkle.png
│   │   ├── sparkler.png
│   │   ├── sparkles.png
│   │   ├── sparkling_heart.png
│   │   ├── speak_no_evil.png
│   │   ├── speaker.png
│   │   ├── speaking_head.png
│   │   ├── speech_balloon.png
│   │   ├── speedboat.png
│   │   ├── spider.png
│   │   ├── spider_web.png
│   │   ├── spiral_calendar.png
│   │   ├── spiral_notepad.png
│   │   ├── sponge.png
│   │   ├── spoon.png
│   │   ├── squid.png
│   │   ├── sri_lanka.png
│   │   ├── st_barthelemy.png
│   │   ├── st_helena.png
│   │   ├── st_kitts_nevis.png
│   │   ├── st_lucia.png
│   │   ├── st_martin.png
│   │   ├── st_pierre_miquelon.png
│   │   ├── st_vincent_grenadines.png
│   │   ├── stadium.png
│   │   ├── standing_man.png
│   │   ├── standing_person.png
│   │   ├── standing_woman.png
│   │   ├── star.png
│   │   ├── star2.png
│   │   ├── star_and_crescent.png
│   │   ├── star_of_david.png
│   │   ├── star_struck.png
│   │   ├── stars.png
│   │   ├── station.png
│   │   ├── statue_of_liberty.png
│   │   ├── steam_locomotive.png
│   │   ├── stethoscope.png
│   │   ├── stew.png
│   │   ├── stop_button.png
│   │   ├── stop_sign.png
│   │   ├── stopwatch.png
│   │   ├── straight_ruler.png
│   │   ├── strawberry.png
│   │   ├── stuck_out_tongue.png
│   │   ├── stuck_out_tongue_closed_eyes.png
│   │   ├── stuck_out_tongue_winking_eye.png
│   │   ├── student.png
│   │   ├── studio_microphone.png
│   │   ├── stuffed_flatbread.png
│   │   ├── sudan.png
│   │   ├── sun_behind_large_cloud.png
│   │   ├── sun_behind_rain_cloud.png
│   │   ├── sun_behind_small_cloud.png
│   │   ├── sun_with_face.png
│   │   ├── sunflower.png
│   │   ├── sunglasses.png
│   │   ├── sunny.png
│   │   ├── sunrise.png
│   │   ├── sunrise_over_mountains.png
│   │   ├── superhero.png
│   │   ├── superhero_man.png
│   │   ├── superhero_woman.png
│   │   ├── supervillain.png
│   │   ├── supervillain_man.png
│   │   ├── supervillain_woman.png
│   │   ├── surfer.png
│   │   ├── surfing_man.png
│   │   ├── surfing_woman.png
│   │   ├── suriname.png
│   │   ├── sushi.png
│   │   ├── suspect.png
│   │   ├── suspension_railway.png
│   │   ├── svalbard_jan_mayen.png
│   │   ├── swan.png
│   │   ├── swaziland.png
│   │   ├── sweat.png
│   │   ├── sweat_drops.png
│   │   ├── sweat_smile.png
│   │   ├── sweden.png
│   │   ├── sweet_potato.png
│   │   ├── swim_brief.png
│   │   ├── swimmer.png
│   │   ├── swimming_man.png
│   │   ├── swimming_woman.png
│   │   ├── switzerland.png
│   │   ├── symbols.png
│   │   ├── synagogue.png
│   │   ├── syria.png
│   │   ├── syringe.png
│   │   ├── t-rex.png
│   │   ├── taco.png
│   │   ├── tada.png
│   │   ├── taiwan.png
│   │   ├── tajikistan.png
│   │   ├── takeout_box.png
│   │   ├── tamale.png
│   │   ├── tanabata_tree.png
│   │   ├── tangerine.png
│   │   ├── tanzania.png
│   │   ├── taurus.png
│   │   ├── taxi.png
│   │   ├── tea.png
│   │   ├── teacher.png
│   │   ├── teapot.png
│   │   ├── technologist.png
│   │   ├── teddy_bear.png
│   │   ├── telephone.png
│   │   ├── telephone_receiver.png
│   │   ├── telescope.png
│   │   ├── tennis.png
│   │   ├── tent.png
│   │   ├── test_tube.png
│   │   ├── thailand.png
│   │   ├── thermometer.png
│   │   ├── thinking.png
│   │   ├── thong_sandal.png
│   │   ├── thought_balloon.png
│   │   ├── thread.png
│   │   ├── three.png
│   │   ├── thumbsdown.png
│   │   ├── thumbsup.png
│   │   ├── ticket.png
│   │   ├── tickets.png
│   │   ├── tiger.png
│   │   ├── tiger2.png
│   │   ├── timer_clock.png
│   │   ├── timor_leste.png
│   │   ├── tipping_hand_man.png
│   │   ├── tipping_hand_person.png
│   │   ├── tipping_hand_woman.png
│   │   ├── tired_face.png
│   │   ├── tm.png
│   │   ├── togo.png
│   │   ├── toilet.png
│   │   ├── tokelau.png
│   │   ├── tokyo_tower.png
│   │   ├── tomato.png
│   │   ├── tonga.png
│   │   ├── tongue.png
│   │   ├── toolbox.png
│   │   ├── tooth.png
│   │   ├── toothbrush.png
│   │   ├── top.png
│   │   ├── tophat.png
│   │   ├── tornado.png
│   │   ├── tr.png
│   │   ├── trackball.png
│   │   ├── tractor.png
│   │   ├── traffic_light.png
│   │   ├── train.png
│   │   ├── train2.png
│   │   ├── tram.png
│   │   ├── transgender_flag.png
│   │   ├── transgender_symbol.png
│   │   ├── triangular_flag_on_post.png
│   │   ├── triangular_ruler.png
│   │   ├── trident.png
│   │   ├── trinidad_tobago.png
│   │   ├── tristan_da_cunha.png
│   │   ├── triumph.png
│   │   ├── trolleybus.png
│   │   ├── trollface.png
│   │   ├── trophy.png
│   │   ├── tropical_drink.png
│   │   ├── tropical_fish.png
│   │   ├── truck.png
│   │   ├── trumpet.png
│   │   ├── tshirt.png
│   │   ├── tulip.png
│   │   ├── tumbler_glass.png
│   │   ├── tunisia.png
│   │   ├── turkey.png
│   │   ├── turkmenistan.png
│   │   ├── turks_caicos_islands.png
│   │   ├── turtle.png
│   │   ├── tuvalu.png
│   │   ├── tv.png
│   │   ├── twisted_rightwards_arrows.png
│   │   ├── two.png
│   │   ├── two_hearts.png
│   │   ├── two_men_holding_hands.png
│   │   ├── two_women_holding_hands.png
│   │   ├── u5272.png
│   │   ├── u5408.png
│   │   ├── u55b6.png
│   │   ├── u6307.png
│   │   ├── u6708.png
│   │   ├── u6709.png
│   │   ├── u6e80.png
│   │   ├── u7121.png
│   │   ├── u7533.png
│   │   ├── u7981.png
│   │   ├── u7a7a.png
│   │   ├── uganda.png
│   │   ├── uk.png
│   │   ├── ukraine.png
│   │   ├── umbrella.png
│   │   ├── unamused.png
│   │   ├── underage.png
│   │   ├── unicorn.png
│   │   ├── united_arab_emirates.png
│   │   ├── united_nations.png
│   │   ├── unlock.png
│   │   ├── up.png
│   │   ├── upside_down_face.png
│   │   ├── uruguay.png
│   │   ├── us.png
│   │   ├── us_outlying_islands.png
│   │   ├── us_virgin_islands.png
│   │   ├── uzbekistan.png
│   │   ├── v.png
│   │   ├── vampire.png
│   │   ├── vampire_man.png
│   │   ├── vampire_woman.png
│   │   ├── vanuatu.png
│   │   ├── vatican_city.png
│   │   ├── venezuela.png
│   │   ├── vertical_traffic_light.png
│   │   ├── vhs.png
│   │   ├── vibration_mode.png
│   │   ├── video_camera.png
│   │   ├── video_game.png
│   │   ├── vietnam.png
│   │   ├── violin.png
│   │   ├── virgo.png
│   │   ├── volcano.png
│   │   ├── volleyball.png
│   │   ├── vomiting_face.png
│   │   ├── vs.png
│   │   ├── vulcan_salute.png
│   │   ├── waffle.png
│   │   ├── wales.png
│   │   ├── walking.png
│   │   ├── walking_man.png
│   │   ├── walking_woman.png
│   │   ├── wallis_futuna.png
│   │   ├── waning_crescent_moon.png
│   │   ├── waning_gibbous_moon.png
│   │   ├── warning.png
│   │   ├── wastebasket.png
│   │   ├── watch.png
│   │   ├── water_buffalo.png
│   │   ├── water_polo.png
│   │   ├── watermelon.png
│   │   ├── wave.png
│   │   ├── wavy_dash.png
│   │   ├── waxing_crescent_moon.png
│   │   ├── waxing_gibbous_moon.png
│   │   ├── wc.png
│   │   ├── weary.png
│   │   ├── wedding.png
│   │   ├── weight_lifting.png
│   │   ├── weight_lifting_man.png
│   │   ├── weight_lifting_woman.png
│   │   ├── western_sahara.png
│   │   ├── whale.png
│   │   ├── whale2.png
│   │   ├── wheel_of_dharma.png
│   │   ├── wheelchair.png
│   │   ├── white_check_mark.png
│   │   ├── white_circle.png
│   │   ├── white_flag.png
│   │   ├── white_flower.png
│   │   ├── white_haired_man.png
│   │   ├── white_haired_woman.png
│   │   ├── white_heart.png
│   │   ├── white_large_square.png
│   │   ├── white_medium_small_square.png
│   │   ├── white_medium_square.png
│   │   ├── white_small_square.png
│   │   ├── white_square_button.png
│   │   ├── wilted_flower.png
│   │   ├── wind_chime.png
│   │   ├── wind_face.png
│   │   ├── window.png
│   │   ├── wine_glass.png
│   │   ├── wink.png
│   │   ├── wolf.png
│   │   ├── woman.png
│   │   ├── woman_artist.png
│   │   ├── woman_astronaut.png
│   │   ├── woman_beard.png
│   │   ├── woman_cartwheeling.png
│   │   ├── woman_cook.png
│   │   ├── woman_dancing.png
│   │   ├── woman_facepalming.png
│   │   ├── woman_factory_worker.png
│   │   ├── woman_farmer.png
│   │   ├── woman_feeding_baby.png
│   │   ├── woman_firefighter.png
│   │   ├── woman_health_worker.png
│   │   ├── woman_in_manual_wheelchair.png
│   │   ├── woman_in_motorized_wheelchair.png
│   │   ├── woman_in_tuxedo.png
│   │   ├── woman_judge.png
│   │   ├── woman_juggling.png
│   │   ├── woman_mechanic.png
│   │   ├── woman_office_worker.png
│   │   ├── woman_pilot.png
│   │   ├── woman_playing_handball.png
│   │   ├── woman_playing_water_polo.png
│   │   ├── woman_scientist.png
│   │   ├── woman_shrugging.png
│   │   ├── woman_singer.png
│   │   ├── woman_student.png
│   │   ├── woman_teacher.png
│   │   ├── woman_technologist.png
│   │   ├── woman_with_headscarf.png
│   │   ├── woman_with_probing_cane.png
│   │   ├── woman_with_turban.png
│   │   ├── woman_with_veil.png
│   │   ├── womans_clothes.png
│   │   ├── womans_hat.png
│   │   ├── women_wrestling.png
│   │   ├── womens.png
│   │   ├── wood.png
│   │   ├── woozy_face.png
│   │   ├── world_map.png
│   │   ├── worm.png
│   │   ├── worried.png
│   │   ├── wrench.png
│   │   ├── wrestling.png
│   │   ├── writing_hand.png
│   │   ├── x.png
│   │   ├── yarn.png
│   │   ├── yawning_face.png
│   │   ├── yellow_circle.png
│   │   ├── yellow_heart.png
│   │   ├── yellow_square.png
│   │   ├── yemen.png
│   │   ├── yen.png
│   │   ├── yin_yang.png
│   │   ├── yo_yo.png
│   │   ├── yum.png
│   │   ├── zambia.png
│   │   ├── zany_face.png
│   │   ├── zap.png
│   │   ├── zebra.png
│   │   ├── zero.png
│   │   ├── zimbabwe.png
│   │   ├── zipper_mouth_face.png
│   │   ├── zombie.png
│   │   ├── zombie_man.png
│   │   ├── zombie_woman.png
│   │   └── zzz.png
│   ├── gitignore/
│   │   ├── community/
│   │   │   ├── AWS/
│   │   │   │   ├── CDK.gitignore
│   │   │   │   └── SAM.gitignore
│   │   │   ├── DotNet/
│   │   │   │   ├── core.gitignore
│   │   │   │   ├── InforCMS.gitignore
│   │   │   │   ├── Kentico.gitignore
│   │   │   │   └── Umbraco.gitignore
│   │   │   ├── Elixir/
│   │   │   │   └── Phoenix.gitignore
│   │   │   ├── embedded/
│   │   │   │   ├── AtmelStudio.gitignore
│   │   │   │   ├── esp-idf.gitignore
│   │   │   │   ├── IAR_EWARM.gitignore
│   │   │   │   └── uVision.gitignore
│   │   │   ├── GNOME/
│   │   │   │   └── GNOMEShellExtension.gitignore
│   │   │   ├── Golang/
│   │   │   │   ├── Go.AllowList.gitignore
│   │   │   │   └── Hugo.gitignore
│   │   │   ├── Java/
│   │   │   │   ├── JBoss4.gitignore
│   │   │   │   └── JBoss6.gitignore
│   │   │   ├── JavaScript/
│   │   │   │   ├── Cordova.gitignore
│   │   │   │   ├── Meteor.gitignore
│   │   │   │   ├── NWjs.gitignore
│   │   │   │   └── Vue.gitignore
│   │   │   ├── Linux/
│   │   │   │   └── Snap.gitignore
│   │   │   ├── PHP/
│   │   │   │   ├── Bitrix.gitignore
│   │   │   │   ├── CodeSniffer.gitignore
│   │   │   │   ├── Drupal7.gitignore
│   │   │   │   ├── Jigsaw.gitignore
│   │   │   │   ├── Magento1.gitignore
│   │   │   │   ├── Magento2.gitignore
│   │   │   │   ├── Pimcore.gitignore
│   │   │   │   └── ThinkPHP.gitignore
│   │   │   ├── Python/
│   │   │   │   ├── JupyterNotebooks.gitignore
│   │   │   │   └── Nikola.gitignore
│   │   │   ├── AltiumDesigner.gitignore
│   │   │   ├── AutoIt.gitignore
│   │   │   ├── B4X.gitignore
│   │   │   ├── Bazel.gitignore
│   │   │   ├── Beef.gitignore
│   │   │   ├── Exercism.gitignore
│   │   │   ├── Gretl.gitignore
│   │   │   ├── LensStudio.gitignore
│   │   │   ├── Logtalk.gitignore
│   │   │   ├── NasaSpecsIntact.gitignore
│   │   │   ├── Nix.gitignore
│   │   │   ├── OpenSSL.gitignore
│   │   │   ├── Puppet.gitignore
│   │   │   ├── Racket.gitignore
│   │   │   ├── Red.gitignore
│   │   │   ├── ROS2.gitignore
│   │   │   ├── SPFx.gitignore
│   │   │   ├── Splunk.gitignore
│   │   │   ├── Strapi.gitignore
│   │   │   ├── Toit.gitignore
│   │   │   ├── V.gitignore
│   │   │   └── Xilinx.gitignore
│   │   ├── Global/
│   │   │   ├── AL.gitignore
│   │   │   ├── Anjuta.gitignore
│   │   │   ├── Ansible.gitignore
│   │   │   ├── Archives.gitignore
│   │   │   ├── Backup.gitignore
│   │   │   ├── Bazaar.gitignore
│   │   │   ├── BricxCC.gitignore
│   │   │   ├── Calabash.gitignore
│   │   │   ├── Cloud9.gitignore
│   │   │   ├── CodeKit.gitignore
│   │   │   ├── CVS.gitignore
│   │   │   ├── DartEditor.gitignore
│   │   │   ├── Diff.gitignore
│   │   │   ├── Dreamweaver.gitignore
│   │   │   ├── Dropbox.gitignore
│   │   │   ├── Eclipse.gitignore
│   │   │   ├── EiffelStudio.gitignore
│   │   │   ├── Emacs.gitignore
│   │   │   ├── Ensime.gitignore
│   │   │   ├── Espresso.gitignore
│   │   │   ├── FlexBuilder.gitignore
│   │   │   ├── GPG.gitignore
│   │   │   ├── Images.gitignore
│   │   │   ├── JDeveloper.gitignore
│   │   │   ├── JEnv.gitignore
│   │   │   ├── JetBrains.gitignore
│   │   │   ├── Kate.gitignore
│   │   │   ├── KDevelop4.gitignore
│   │   │   ├── Lazarus.gitignore
│   │   │   ├── LibreOffice.gitignore
│   │   │   ├── Linux.gitignore
│   │   │   ├── LyX.gitignore
│   │   │   ├── macOS.gitignore
│   │   │   ├── MATLAB.gitignore
│   │   │   ├── Mercurial.gitignore
│   │   │   ├── Metals.gitignore
│   │   │   ├── MicrosoftOffice.gitignore
│   │   │   ├── ModelSim.gitignore
│   │   │   ├── Momentics.gitignore
│   │   │   ├── MonoDevelop.gitignore
│   │   │   ├── NetBeans.gitignore
│   │   │   ├── Ninja.gitignore
│   │   │   ├── NotepadPP.gitignore
│   │   │   ├── Octave.gitignore
│   │   │   ├── Otto.gitignore
│   │   │   ├── Patch.gitignore
│   │   │   ├── PSoCCreator.gitignore
│   │   │   ├── PuTTY.gitignore
│   │   │   ├── README.md
│   │   │   ├── Redcar.gitignore
│   │   │   ├── Redis.gitignore
│   │   │   ├── SBT.gitignore
│   │   │   ├── SlickEdit.gitignore
│   │   │   ├── Stata.gitignore
│   │   │   ├── SublimeText.gitignore
│   │   │   ├── SVN.gitignore
│   │   │   ├── Syncthing.gitignore
│   │   │   ├── SynopsysVCS.gitignore
│   │   │   ├── Tags.gitignore
│   │   │   ├── TextMate.gitignore
│   │   │   ├── TortoiseGit.gitignore
│   │   │   ├── Vagrant.gitignore
│   │   │   ├── Vim.gitignore
│   │   │   ├── VirtualEnv.gitignore
│   │   │   ├── Virtuoso.gitignore
│   │   │   ├── VisualStudioCode.gitignore
│   │   │   ├── WebMethods.gitignore
│   │   │   ├── Windows.gitignore
│   │   │   ├── Xcode.gitignore
│   │   │   └── XilinxISE.gitignore
│   │   ├── Actionscript.gitignore
│   │   ├── Ada.gitignore
│   │   ├── Agda.gitignore
│   │   ├── AL.gitignore
│   │   ├── Android.gitignore
│   │   ├── AppceleratorTitanium.gitignore
│   │   ├── AppEngine.gitignore
│   │   ├── ArchLinuxPackages.gitignore
│   │   ├── Autotools.gitignore
│   │   ├── C++.gitignore
│   │   ├── C.gitignore
│   │   ├── CakePHP.gitignore
│   │   ├── CFWheels.gitignore
│   │   ├── ChefCookbook.gitignore
│   │   ├── Clojure.gitignore
│   │   ├── CMake.gitignore
│   │   ├── CodeIgniter.gitignore
│   │   ├── CommonLisp.gitignore
│   │   ├── Composer.gitignore
│   │   ├── Concrete5.gitignore
│   │   ├── CONTRIBUTING.md
│   │   ├── Coq.gitignore
│   │   ├── CraftCMS.gitignore
│   │   ├── CUDA.gitignore
│   │   ├── D.gitignore
│   │   ├── Dart.gitignore
│   │   ├── Delphi.gitignore
│   │   ├── DM.gitignore
│   │   ├── Drupal.gitignore
│   │   ├── Eagle.gitignore
│   │   ├── Elisp.gitignore
│   │   ├── Elixir.gitignore
│   │   ├── Elm.gitignore
│   │   ├── EPiServer.gitignore
│   │   ├── Erlang.gitignore
│   │   ├── ExpressionEngine.gitignore
│   │   ├── ExtJs.gitignore
│   │   ├── Fancy.gitignore
│   │   ├── Finale.gitignore
│   │   ├── FlaxEngine.gitignore
│   │   ├── ForceDotCom.gitignore
│   │   ├── Fortran.gitignore
│   │   ├── FuelPHP.gitignore
│   │   ├── Gcov.gitignore
│   │   ├── GitBook.gitignore
│   │   ├── Go.gitignore
│   │   ├── Godot.gitignore
│   │   ├── Gradle.gitignore
│   │   ├── Grails.gitignore
│   │   ├── GWT.gitignore
│   │   ├── Haskell.gitignore
│   │   ├── Idris.gitignore
│   │   ├── IGORPro.gitignore
│   │   ├── Java.gitignore
│   │   ├── JBoss.gitignore
│   │   ├── Jekyll.gitignore
│   │   ├── JENKINS_HOME.gitignore
│   │   ├── Joomla.gitignore
│   │   ├── Julia.gitignore
│   │   ├── KiCad.gitignore
│   │   ├── Kohana.gitignore
│   │   ├── Kotlin.gitignore
│   │   ├── LabVIEW.gitignore
│   │   ├── Laravel.gitignore
│   │   ├── Leiningen.gitignore
│   │   ├── LemonStand.gitignore
│   │   ├── LICENSE
│   │   ├── Lilypond.gitignore
│   │   ├── Lithium.gitignore
│   │   ├── Lua.gitignore
│   │   ├── Magento.gitignore
│   │   ├── Maven.gitignore
│   │   ├── Mercury.gitignore
│   │   ├── MetaProgrammingSystem.gitignore
│   │   ├── Nanoc.gitignore
│   │   ├── Nim.gitignore
│   │   ├── Node.gitignore
│   │   ├── Objective-C.gitignore
│   │   ├── OCaml.gitignore
│   │   ├── Opa.gitignore
│   │   ├── OpenCart.gitignore
│   │   ├── OracleForms.gitignore
│   │   ├── Packer.gitignore
│   │   ├── Perl.gitignore
│   │   ├── Phalcon.gitignore
│   │   ├── PlayFramework.gitignore
│   │   ├── Plone.gitignore
│   │   ├── Prestashop.gitignore
│   │   ├── Processing.gitignore
│   │   ├── PureScript.gitignore
│   │   ├── Python.gitignore
│   │   ├── Qooxdoo.gitignore
│   │   ├── Qt.gitignore
│   │   ├── R.gitignore
│   │   ├── Racket.gitignore
│   │   ├── Rails.gitignore
│   │   ├── Raku.gitignore
│   │   ├── README.md
│   │   ├── RhodesRhomobile.gitignore
│   │   ├── ROS.gitignore
│   │   ├── Ruby.gitignore
│   │   ├── Rust.gitignore
│   │   ├── Sass.gitignore
│   │   ├── Scala.gitignore
│   │   ├── Scheme.gitignore
│   │   ├── SCons.gitignore
│   │   ├── Scrivener.gitignore
│   │   ├── Sdcc.gitignore
│   │   ├── SeamGen.gitignore
│   │   ├── SketchUp.gitignore
│   │   ├── Smalltalk.gitignore
│   │   ├── Stella.gitignore
│   │   ├── SugarCRM.gitignore
│   │   ├── Swift.gitignore
│   │   ├── Symfony.gitignore
│   │   ├── SymphonyCMS.gitignore
│   │   ├── Terraform.gitignore
│   │   ├── TeX.gitignore
│   │   ├── Textpattern.gitignore
│   │   ├── TurboGears2.gitignore
│   │   ├── TwinCAT3.gitignore
│   │   ├── Typo3.gitignore
│   │   ├── Unity.gitignore
│   │   ├── UnrealEngine.gitignore
│   │   ├── VisualStudio.gitignore
│   │   ├── VVVV.gitignore
│   │   ├── Waf.gitignore
│   │   ├── WordPress.gitignore
│   │   ├── Xojo.gitignore
│   │   ├── Yeoman.gitignore
│   │   ├── Yii.gitignore
│   │   ├── ZendFramework.gitignore
│   │   └── Zephir.gitignore
│   ├── licenses/
│   │   ├── Apache License 2.0
│   │   ├── Boost Software License 1.0
│   │   ├── GNU AGPLv3
│   │   ├── GNU GPLv3
│   │   ├── GNU LGPLv3
│   │   ├── MIT License
│   │   ├── Mozilla Public License 2.0
│   │   └── The Unlicense
│   ├── shields/
│   │   ├── for-the-badge/
│   │   │   ├── android-studio.svg
│   │   │   ├── built-with-gradle.svg
│   │   │   ├── css3.svg
│   │   │   ├── cucumber.svg
│   │   │   ├── detekt.svg
│   │   │   ├── docker.svg
│   │   │   ├── eslint.svg
│   │   │   ├── git.svg
│   │   │   ├── github.svg
│   │   │   ├── gmail.svg
│   │   │   ├── google-chrome.svg
│   │   │   ├── google-cloud.svg
│   │   │   ├── google-drive.svg
│   │   │   ├── google-meet.svg
│   │   │   ├── googlechrome.svg
│   │   │   ├── googlecloud.svg
│   │   │   ├── googledrive.svg
│   │   │   ├── googlemeet.svg
│   │   │   ├── gradle.svg
│   │   │   ├── html5.svg
│   │   │   ├── intellij-idea.svg
│   │   │   ├── intellij.svg
│   │   │   ├── javascript.svg
│   │   │   ├── jest.svg
│   │   │   ├── keycloak.svg
│   │   │   ├── kotlin.svg
│   │   │   ├── ktlint.svg
│   │   │   ├── made-with-kotlin.svg
│   │   │   ├── markdown.svg
│   │   │   ├── mui.svg
│   │   │   ├── nodejs.svg
│   │   │   ├── npm.svg
│   │   │   ├── pgadmin.svg
│   │   │   ├── portainer.svg
│   │   │   ├── postgres.svg
│   │   │   ├── postgresql.svg
│   │   │   ├── prettier.svg
│   │   │   ├── react-hook-form.svg
│   │   │   ├── react-router.svg
│   │   │   ├── redis.svg
│   │   │   ├── redux.svg
│   │   │   ├── sass.svg
│   │   │   ├── shellscript.svg
│   │   │   ├── slack.svg
│   │   │   ├── sonarlint.svg
│   │   │   ├── spring.svg
│   │   │   ├── storybook.svg
│   │   │   ├── stylelint.svg
│   │   │   ├── testinglibrary.svg
│   │   │   ├── typescript.svg
│   │   │   ├── ubuntu.svg
│   │   │   └── webpack.svg
│   │   └── README.md
│   └── README.md
├── automation/
│   └── make/
│       ├── colors.mk
│       ├── common.mk
│       ├── gmsl.mk
│       ├── LICENSE
│       ├── Makefile
│       ├── os.mk
│       ├── project.mk
│       ├── README.md
│       ├── utils.mk
│       └── variables.mk
├── docs/
│   ├── javascripts/
│   │   └── extra.js
│   ├── stylesheets/
│   │   └── extra.css
│   └── index.md
├── garden/
│   ├── awesome/
│   │   └── templates/
│   │       └── .gitkeep
│   ├── concepts/
│   │   └── .gitkeep
│   ├── experiments/
│   │   └── .gitkeep
│   ├── notes/
│   │   └── .gitkeep
│   ├── reflections/
│   │   └── .gitkeep
│   ├── research/
│   │   └── .gitkeep
│   └── .gitkeep
├── lint/
│   ├── config/
│   │   ├── actions/
│   │   │   └── actionlint.yml
│   │   ├── ansible/
│   │   │   └── ansible-lint.yml
│   │   ├── api/
│   │   │   └── .spectral.yaml
│   │   ├── arm/
│   │   │   └── .arm-ttk.psd1
│   │   ├── checkstyle/
│   │   │   ├── google_checks.xml
│   │   │   └── sun_checks.xml
│   │   ├── clojure/
│   │   │   ├── .clj-kondo/
│   │   │   │   └── config.edn
│   │   │   └── .cljstyle
│   │   ├── cloudformation/
│   │   │   └── .cfnlintrc.yml
│   │   ├── coffee/
│   │   │   └── .coffee-lint.json
│   │   ├── commits/
│   │   │   └── .commitlint.config.cjs
│   │   ├── copypaste/
│   │   │   └── .jscpd.json
│   │   ├── cpp/
│   │   │   └── .clang-format
│   │   ├── css/
│   │   │   └── .stylelintrc.json
│   │   ├── dart/
│   │   │   └── analysis_options.yml
│   │   ├── dockerfile/
│   │   │   └── .hadolint.yaml
│   │   ├── editorconfig/
│   │   │   ├── .ecrc
│   │   │   └── .editorconfig-checker.json
│   │   ├── gherkin/
│   │   │   └── .gherkin-lintrc
│   │   ├── go/
│   │   │   ├── .golangci.yml
│   │   │   └── .revive.toml
│   │   ├── graphql/
│   │   │   └── .graphql-schema-linter.yml
│   │   ├── groovy/
│   │   │   └── .groovylintrc.json
│   │   ├── html/
│   │   │   └── .htmlhintrc
│   │   ├── java/
│   │   │   ├── java-pmd-ruleset.xml
│   │   │   └── sun_checks.xml
│   │   ├── javascript/
│   │   │   ├── .eslintignore
│   │   │   ├── .eslintrc-json.json
│   │   │   ├── .prettier.config.mjs
│   │   │   ├── .prettierignore
│   │   │   └── eslint.config.mjs
│   │   ├── json/
│   │   │   ├── .jsonlintrc
│   │   │   └── .npmpackagejsonlintrc.json
│   │   ├── latex/
│   │   │   ├── .chktexrc
│   │   │   └── latexindent.yml
│   │   ├── lua/
│   │   │   └── .luacheckrc
│   │   ├── makefile/
│   │   │   └── .checkmake.ini
│   │   ├── markdown/
│   │   │   ├── .markdown-link-check.json
│   │   │   ├── .markdownlint.json
│   │   │   ├── .markdownlint.yml
│   │   │   └── .remarkrc.json
│   │   ├── php/
│   │   │   ├── .phplint.yml
│   │   │   ├── phpcs.xml
│   │   │   ├── phpstan.neon.dist
│   │   │   └── psalm.xml
│   │   ├── powershell/
│   │   │   ├── .powershell-formatter.psd1
│   │   │   └── .powershell-psscriptanalyzer.psd1
│   │   ├── prose/
│   │   │   ├── dictionaries/
│   │   │   │   ├── backend-terms.dictionary
│   │   │   │   ├── devops-cloud-terms.dictionary
│   │   │   │   ├── frontend-terms.dictionary
│   │   │   │   ├── programming-terms.dictionary
│   │   │   │   ├── project-words.dictionary
│   │   │   │   └── software-terms.dictionary
│   │   │   ├── spell/
│   │   │   │   ├── .codespellrc
│   │   │   │   ├── .lycheeignore
│   │   │   │   ├── .spelling
│   │   │   │   ├── cspell.json
│   │   │   │   ├── cspell.megalinter.json
│   │   │   │   └── lychee.toml
│   │   │   ├── styles/
│   │   │   │   ├── proselint/
│   │   │   │   │   ├── Airlinese.yml
│   │   │   │   │   ├── AnimalLabels.yml
│   │   │   │   │   ├── Annotations.yml
│   │   │   │   │   ├── Apologizing.yml
│   │   │   │   │   ├── Archaisms.yml
│   │   │   │   │   ├── But.yml
│   │   │   │   │   ├── Cliches.yml
│   │   │   │   │   ├── CorporateSpeak.yml
│   │   │   │   │   ├── Currency.yml
│   │   │   │   │   ├── Cursing.yml
│   │   │   │   │   ├── DateCase.yml
│   │   │   │   │   ├── DateMidnight.yml
│   │   │   │   │   ├── DateRedundancy.yml
│   │   │   │   │   ├── DateSpacing.yml
│   │   │   │   │   ├── DenizenLabels.yml
│   │   │   │   │   ├── Diacritical.yml
│   │   │   │   │   ├── GenderBias.yml
│   │   │   │   │   ├── GroupTerms.yml
│   │   │   │   │   ├── Hedging.yml
│   │   │   │   │   ├── Hyperbole.yml
│   │   │   │   │   ├── Jargon.yml
│   │   │   │   │   ├── LGBTOffensive.yml
│   │   │   │   │   ├── LGBTTerms.yml
│   │   │   │   │   ├── Malapropisms.yml
│   │   │   │   │   ├── meta.json
│   │   │   │   │   ├── Needless.yml
│   │   │   │   │   ├── Nonwords.yml
│   │   │   │   │   ├── Oxymorons.yml
│   │   │   │   │   ├── P-Value.yml
│   │   │   │   │   ├── RASSyndrome.yml
│   │   │   │   │   ├── README.md
│   │   │   │   │   ├── Skunked.yml
│   │   │   │   │   ├── Spelling.yml
│   │   │   │   │   ├── Typography.yml
│   │   │   │   │   ├── Uncomparables.yml
│   │   │   │   │   └── Very.yml
│   │   │   │   └── write-good/
│   │   │   │       ├── Cliches.yml
│   │   │   │       ├── E-Prime.yml
│   │   │   │       ├── Illusions.yml
│   │   │   │       ├── meta.json
│   │   │   │       ├── Passive.yml
│   │   │   │       ├── README.md
│   │   │   │       ├── So.yml
│   │   │   │       ├── ThereIs.yml
│   │   │   │       ├── TooWordy.yml
│   │   │   │       └── Weasel.yml
│   │   │   ├── .proselintrc
│   │   │   └── .vale.ini
│   │   ├── protobuf/
│   │   │   └── .protolintrc.yml
│   │   ├── puppet/
│   │   │   └── .puppet-lint.rc
│   │   ├── python/
│   │   │   ├── .bandit.yml
│   │   │   ├── .isort.cfg
│   │   │   ├── .mypy.ini
│   │   │   ├── .pylintrc
│   │   │   ├── .ruff.toml
│   │   │   ├── flake8
│   │   │   └── pyrightconfig.json
│   │   ├── r/
│   │   │   └── .lintr
│   │   ├── raku/
│   │   │   └── META6.json
│   │   ├── repo/
│   │   │   └── .ls-lint.yml
│   │   ├── rst/
│   │   │   └── .rstcheck.cfg
│   │   ├── ruby/
│   │   │   └── .ruby-lint.yml
│   │   ├── rust/
│   │   │   └── .clippy.toml
│   │   ├── salesforce/
│   │   │   ├── .flow-scanner.json
│   │   │   └── apex-pmd-ruleset.xml
│   │   ├── scala/
│   │   │   └── .scalafix.conf
│   │   ├── security/
│   │   │   ├── lynis/
│   │   │   │   └── custom.prf
│   │   │   ├── .checkov.yml
│   │   │   ├── .devskim.json
│   │   │   ├── .gitleaks.toml
│   │   │   ├── .grype.yaml
│   │   │   ├── .kics.config.json
│   │   │   ├── .secretlintignore
│   │   │   ├── .secretlintrc.json
│   │   │   ├── .syft.yaml
│   │   │   ├── .trufflehog.yml
│   │   │   ├── .trufflehogignore
│   │   │   ├── trivy-sbom.yaml
│   │   │   └── trivy.yaml
│   │   ├── shell/
│   │   │   └── shellcheckrc
│   │   ├── snakemake/
│   │   │   └── .snakefmt.toml
│   │   ├── sql/
│   │   │   ├── .sqlfluff
│   │   │   └── .tsqllintrc.json
│   │   ├── swift/
│   │   │   └── .swiftlint.yml
│   │   ├── system/
│   │   │   ├── apt.conf
│   │   │   └── dpkg.cfg
│   │   ├── tekton/
│   │   │   └── .tektonlintrc.yaml
│   │   ├── terraform/
│   │   │   ├── .tflint.hcl
│   │   │   ├── terragrunt.hcl
│   │   │   └── terrascan-config.toml
│   │   └── yaml/
│   │       ├── .v8rrc.yml
│   │       └── .yamllint.yml
│   └── .megalinter.yml
├── scripts/
│   └── megalinter.sh
├── shell/
│   ├── .vscode/
│   │   ├── dictionaries/
│   │   │   ├── backend-terms.dictionary
│   │   │   ├── devops-cloud-terms.dictionary
│   │   │   ├── frontend-terms.dictionary
│   │   │   ├── programming-terms.dictionary
│   │   │   ├── project-words.dictionary
│   │   │   └── software-terms.dictionary
│   │   ├── extensions.json
│   │   ├── launch.json
│   │   ├── settings.json
│   │   └── tasks.json
│   ├── bin/
│   │   ├── cb
│   │   ├── convert-to-ico
│   │   ├── generate-certs
│   │   ├── generate-password
│   │   ├── generate-tree
│   │   ├── ghignore
│   │   ├── ghprotect
│   │   ├── git-remove-exec-no-shebang
│   │   └── sysinfo
│   ├── init/
│   │   ├── bootstrap.sh
│   │   ├── init.sh
│   │   ├── load-core.sh
│   │   └── load-extensions.sh
│   ├── lib/
│   │   ├── core/
│   │   │   ├── bash.sh
│   │   │   ├── colors.sh
│   │   │   ├── core.sh
│   │   │   ├── guards.sh
│   │   │   ├── logging.sh
│   │   │   ├── os.sh
│   │   │   └── time.sh
│   │   ├── extensions/
│   │   │   ├── fonts.sh
│   │   │   └── github.sh
│   │   └── modules.sh
│   ├── modules/
│   │   ├── cache.sh
│   │   ├── environment.sh
│   │   ├── history.sh
│   │   ├── privacy.sh
│   │   ├── tooling.sh
│   │   └── xdg.sh
│   ├── tests/
│   │   ├── core/
│   │   │   ├── bash.bats
│   │   │   └── time.bats
│   │   ├── extensions/
│   │   │   └── github.bats
│   │   ├── bootstrap.bats
│   │   ├── cb.bats
│   │   ├── convert-to-ico.bats
│   │   ├── environment.bats
│   │   ├── git-remove-exec-no-shebang.bats
│   │   ├── test_helper.bash
│   │   └── xdg.bats
│   ├── .gitignore
│   ├── .shellrc
│   ├── LICENSE
│   ├── README.md
│   └── shell.code-workspace
├── skills/
│   └── threejs/
│       ├── threejs-animation/
│       │   └── SKILL.md
│       ├── threejs-fundamentals/
│       │   └── SKILL.md
│       ├── threejs-geometry/
│       │   └── SKILL.md
│       ├── threejs-interaction/
│       │   └── SKILL.md
│       ├── threejs-lighting/
│       │   └── SKILL.md
│       ├── threejs-loaders/
│       │   └── SKILL.md
│       ├── threejs-materials/
│       │   └── SKILL.md
│       ├── threejs-postprocessing/
│       │   └── SKILL.md
│       ├── threejs-shaders/
│       │   └── SKILL.md
│       └── threejs-textures/
│           └── SKILL.md
├── templates/
│   ├── changesets/
│   │   └── .changeset/
│   │       ├── config.json
│   │       └── README.md
│   └── poetry/
│       └── poetry.toml
├── .actrc
├── .allcontributorsrc
├── .czrc
├── .dockerignore
├── .editorconfig
├── .gitignore
├── .mailmap
├── .pnpmignore
├── .talismanrc
├── .typos.toml
├── CODE_OF_CONDUCT.md
├── CONTRIBUTORS.md
├── humans.txt
├── LICENSE
├── mkdocs.yml
├── package.json
├── README.md
├── sanctuary.code-workspace
└── Taskfile.yml
```
