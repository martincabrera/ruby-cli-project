# frozen_string_literal: true

require 'card_filter'
require 'byebug'

describe MTG::CardFilter do
  before do
    allow_any_instance_of(MTG::CardFilter).to receive(:cards_list).and_return(cards)
  end

  describe '#cards_grouped_by_set' do
    let(:expected_card_set) { %w[SOI KTK] }
    let(:ktk_cards_count) { 3 }
    it 'returns cards grouped by set' do
      card_filter = described_class.new
      card_set = card_filter.option(:one)
      expect(card_set.keys).to match_array expected_card_set
      expect(card_set[expected_card_set[1]].count).to eq ktk_cards_count
    end
  end

  describe '#cards_grouped_by_set_rarity' do
    let(:expected_card_set_rarity) { [%w[SOI Uncommon], %w[KTK Rare], %w[KTK Uncommon]] }
    let(:ktk_cards_uncommon_count) { 2 }

    it 'returns cards grouped by set and rarity' do
      card_filter = described_class.new
      card_set = card_filter.option(:two)
      expect(card_set.keys).to match_array expected_card_set_rarity
      expect(card_set[expected_card_set_rarity[2]].count).to eq ktk_cards_uncommon_count
    end
  end

  describe '#cards_with_code_only_colors' do
    it 'returns all cards with KTK code and ONLY Red & Blue colors' do
      card_filter = described_class.new
      card_set = card_filter.option(:three)
      expect(card_set.count).to eq 2
    end
  end

  describe '#cards_with_code_colors' do
    it 'returns all cards with KTK code and Red & Blue colors among others' do
      card_filter = described_class.new
      card_set = card_filter.option(:four)
      expect(card_set.count).to eq 3
    end
  end

  def cards
    [
      {
        'name' => 'Master the Way',
        'manaCost' => '{3}{U}{R}',
        'cmc' => 5,
        'colors' => %w[Blue Red],
        'colorIdentity' => %w[U R],
        'type' => 'Sorcery',
        'types' => ['Sorcery'],
        'rarity' => 'Uncommon',
        'set' => 'SOI',
        'setName' => 'Khans of Tarkir',
        'text' => 'Draw a card. Master the Way deals damage to any target equal to the number of cards in your hand.',
        'flavor' => "\"The Way has no beginning and no end. It is simply the path.\"\n\u2014Narset, khan of the Jeskai",
        'artist' => 'Howard Lyon',
        'number' => '188',
        'layout' => 'normal',
        'multiverseid' => 386_601,
        'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=386601&type=card',
        'rulings' => [{
          'date' => '2014-09-20',
          'text' => "Use the number of cards in your hand after you draw the card to determine how much damage Master the Way deals to the target permanent or player. (Remember that Master the Way is not in your hand; it's on the stack.)"
        }, {
          'date' => '2014-09-20',
          'text' => "If the permanent or player is an illegal target as Master the Way tries to resolve, Master the Way won't resolve and none of its effects will happen. You won't draw a card."
        }],
        'foreignNames' => [{
          'name' => "\u901A\u609F\u7075\u5B97",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=386870&type=card',
          'language' => 'Chinese Simplified',
          'multiverseid' => 386_870
        }, {
          'name' => "\u901A\u609F\u9748\u5B97",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387139&type=card',
          'language' => 'Chinese Traditional',
          'multiverseid' => 387_139
        }, {
          'name' => 'Den Weg meistern',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387408&type=card',
          'language' => 'German',
          'multiverseid' => 387_408
        }, {
          'name' => "Ma\u00EEtriser la Voie",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387677&type=card',
          'language' => 'French',
          'multiverseid' => 387_677
        }, {
          'name' => 'Padroneggiare la Via',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387946&type=card',
          'language' => 'Italian',
          'multiverseid' => 387_946
        }, {
          'name' => "\u9053\u6975\u3081",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388215&type=card',
          'language' => 'Japanese',
          'multiverseid' => 388_215
        }, {
          'name' => "\uB3C4\uC758 \uAE68\uC6B0\uCE68",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388484&type=card',
          'language' => 'Korean',
          'multiverseid' => 388_484
        }, {
          'name' => 'Dominar o Caminho',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388753&type=card',
          'language' => 'Portuguese (Brazil)',
          'multiverseid' => 388_753
        }, {
          'name' => "\u041F\u0443\u0442\u044C \u041C\u0430\u0441\u0442\u0435\u0440\u0430",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=389022&type=card',
          'language' => 'Russian',
          'multiverseid' => 389_022
        }, {
          'name' => "Dominar la sabidur\u00EDa",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=389291&type=card',
          'language' => 'Spanish',
          'multiverseid' => 389_291
        }],
        'printings' => ['KTK'],
        'originalText' => 'Draw a card. Master the Way deals damage to target creature or player equal to the number of cards in your hand.',
        'originalType' => 'Sorcery',
        'legalities' => [{
          'format' => 'Commander',
          'legality' => 'Legal'
        }, {
          'format' => 'Khans of Tarkir Block',
          'legality' => 'Legal'
        }, {
          'format' => 'Legacy',
          'legality' => 'Legal'
        }, {
          'format' => 'Modern',
          'legality' => 'Legal'
        }, {
          'format' => 'Vintage',
          'legality' => 'Legal'
        }],
        'id' => '9b65561b8f4ed6ae89715e8858dbff2f12f41a0a'
      },
      {
        'name' => 'Mindswipe',
        'manaCost' => '{X}{U}{R}',
        'cmc' => 2,
        'colors' => %w[Blue Red Yellow],
        'colorIdentity' => %w[U R],
        'type' => 'Instant',
        'types' => ['Instant'],
        'rarity' => 'Rare',
        'set' => 'KTK',
        'setName' => 'Khans of Tarkir',
        'text' => "Counter target spell unless its controller pays {X}. Mindswipe deals X damage to that spell's controller.",
        'flavor' => "\"The past and the unwritten are frozen. To understand their meaning requires heat.\"\n\u2014Arel the Whisperer",
        'artist' => 'Ryan Alexander Lee',
        'number' => '189',
        'layout' => 'normal',
        'multiverseid' => 386_604,
        'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=386604&type=card',
        'rulings' => [{
          'date' => '2014-09-20',
          'text' => "If the controller of the target spell pays {X}, the spell won't be countered. Mindswipe will still deal damage to that player."
        }, {
          'date' => '2014-09-20',
          'text' => "If the target spell is an illegal target as Mindswipe tries to resolve (perhaps because it was countered by another spell or ability), Mindswipe won't resolve and none of its effects will happen. No damage will be dealt."
        }],
        'foreignNames' => [{
          'name' => "\u6DA4\u7075\u7130",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=386873&type=card',
          'language' => 'Chinese Simplified',
          'multiverseid' => 386_873
        }, {
          'name' => "\u6ECC\u9748\u7130",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387142&type=card',
          'language' => 'Chinese Traditional',
          'multiverseid' => 387_142
        }, {
          'name' => 'Gedankenhieb',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387411&type=card',
          'language' => 'German',
          'multiverseid' => 387_411
        }, {
          'name' => "Frappe c\u00E9r\u00E9brale",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387680&type=card',
          'language' => 'French',
          'multiverseid' => 387_680
        }, {
          'name' => 'Psicoartiglio',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387949&type=card',
          'language' => 'Italian',
          'multiverseid' => 387_949
        }, {
          'name' => "\u7CBE\u795E\u632F\u308A",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388218&type=card',
          'language' => 'Japanese',
          'multiverseid' => 388_218
        }, {
          'name' => "\uC815\uC2E0 \uD560\uD034\uAE30",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388487&type=card',
          'language' => 'Korean',
          'multiverseid' => 388_487
        }, {
          'name' => 'Patada Mental',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388756&type=card',
          'language' => 'Portuguese (Brazil)',
          'multiverseid' => 388_756
        }, {
          'name' => "\u0423\u0434\u0430\u0440 \u041C\u044B\u0441\u043B\u0435\u0439",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=389025&type=card',
          'language' => 'Russian',
          'multiverseid' => 389_025
        }, {
          'name' => 'Impacto mental',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=389294&type=card',
          'language' => 'Spanish',
          'multiverseid' => 389_294
        }],
        'printings' => ['KTK'],
        'originalText' => "Counter target spell unless its controller pays {X}. Mindswipe deals X damage to that spell's controller.",
        'originalType' => 'Instant',
        'legalities' => [{
          'format' => 'Commander',
          'legality' => 'Legal'
        }, {
          'format' => 'Khans of Tarkir Block',
          'legality' => 'Legal'
        }, {
          'format' => 'Legacy',
          'legality' => 'Legal'
        }, {
          'format' => 'Modern',
          'legality' => 'Legal'
        }, {
          'format' => 'Vintage',
          'legality' => 'Legal'
        }],
        'id' => '50e3f962e3e2e6ac8abb6246b88c5053b80205cf'
      },
      {
        'name' => 'Winterflame',
        'manaCost' => '{1}{U}{R}',
        'cmc' => 3,
        'colors' => %w[Blue Red],
        'colorIdentity' => %w[U R],
        'type' => 'Instant',
        'types' => ['Instant'],
        'rarity' => 'Uncommon',
        'set' => 'KTK',
        'setName' => 'Khans of Tarkir',
        'text' => "Choose one or both \u2014\n\u2022 Tap target creature.\n\u2022 Winterflame deals 2 damage to target creature.",
        'flavor' => "\"The mountains scream with the dragons' throats.\"\n\u2014Chianul, Who Whispers Twice",
        'artist' => 'Richard Wright',
        'number' => '213',
        'layout' => 'normal',
        'multiverseid' => 386_727,
        'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=386727&type=card',
        'rulings' => [{
          'date' => '2014-09-20',
          'text' => "You choose which mode you're using\u2014or that you're using both modes\u2014as you're casting the spell. Once this choice is made, it can't be changed later while the spell is on the stack."
        }, {
          'date' => '2014-09-20',
          'text' => 'If you choose both modes, they can each target the same creature or they can target different creatures.'
        }, {
          'date' => '2014-09-20',
          'text' => "Winterflame won't affect any target that's illegal as it tries to resolve. If you choose to use both modes and both targets are illegal at that time, Winterflame won't resolve."
        }],
        'foreignNames' => [{
          'name' => "\u71C3\u51AC\u7130",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=386996&type=card',
          'language' => 'Chinese Simplified',
          'multiverseid' => 386_996
        }, {
          'name' => "\u71C3\u51AC\u7130",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387265&type=card',
          'language' => 'Chinese Traditional',
          'multiverseid' => 387_265
        }, {
          'name' => 'Winterflamme',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387534&type=card',
          'language' => 'German',
          'multiverseid' => 387_534
        }, {
          'name' => 'Flamme hivernale',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387803&type=card',
          'language' => 'French',
          'multiverseid' => 387_803
        }, {
          'name' => "Fiamma d'Inverno",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388072&type=card',
          'language' => 'Italian',
          'multiverseid' => 388_072
        }, {
          'name' => "\u51AC\u306E\u708E",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388341&type=card',
          'language' => 'Japanese',
          'multiverseid' => 388_341
        }, {
          'name' => "\uACA8\uC6B8\uBD88\uAF43",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388610&type=card',
          'language' => 'Korean',
          'multiverseid' => 388_610
        }, {
          'name' => 'Chama Hibernal',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388879&type=card',
          'language' => 'Portuguese (Brazil)',
          'multiverseid' => 388_879
        }, {
          'name' => "\u0417\u0438\u043C\u043D\u0435\u0435 \u041F\u043B\u0430\u043C\u044F",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=389148&type=card',
          'language' => 'Russian',
          'multiverseid' => 389_148
        }, {
          'name' => 'Llama invernal',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=389417&type=card',
          'language' => 'Spanish',
          'multiverseid' => 389_417
        }],
        'printings' => ['KTK'],
        'originalText' => "Choose one or both \u2014\n\u2022 Tap target creature.\n\u2022 Winterflame deals 2 damage to target creature.",
        'originalType' => 'Instant',
        'legalities' => [{
          'format' => 'Commander',
          'legality' => 'Legal'
        }, {
          'format' => 'Khans of Tarkir Block',
          'legality' => 'Legal'
        }, {
          'format' => 'Legacy',
          'legality' => 'Legal'
        }, {
          'format' => 'Modern',
          'legality' => 'Legal'
        }, {
          'format' => 'Vintage',
          'legality' => 'Legal'
        }],
        'id' => '0e548fba3628dea5f514297afbe9818616982b2f'
      },
      {
        'name' => 'Master the Way',
        'manaCost' => '{3}{U}{R}',
        'cmc' => 5,
        'colors' => %w[Blue Red],
        'colorIdentity' => %w[U R],
        'type' => 'Sorcery',
        'types' => ['Sorcery'],
        'rarity' => 'Uncommon',
        'set' => 'KTK',
        'setName' => 'Khans of Tarkir',
        'text' => 'Draw a card. Master the Way deals damage to any target equal to the number of cards in your hand.',
        'flavor' => "\"The Way has no beginning and no end. It is simply the path.\"\n\u2014Narset, khan of the Jeskai",
        'artist' => 'Howard Lyon',
        'number' => '188',
        'layout' => 'normal',
        'multiverseid' => 386_601,
        'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=386601&type=card',
        'rulings' => [{
          'date' => '2014-09-20',
          'text' => "Use the number of cards in your hand after you draw the card to determine how much damage Master the Way deals to the target permanent or player. (Remember that Master the Way is not in your hand; it's on the stack.)"
        }, {
          'date' => '2014-09-20',
          'text' => "If the permanent or player is an illegal target as Master the Way tries to resolve, Master the Way won't resolve and none of its effects will happen. You won't draw a card."
        }],
        'foreignNames' => [{
          'name' => "\u901A\u609F\u7075\u5B97",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=386870&type=card',
          'language' => 'Chinese Simplified',
          'multiverseid' => 386_870
        }, {
          'name' => "\u901A\u609F\u9748\u5B97",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387139&type=card',
          'language' => 'Chinese Traditional',
          'multiverseid' => 387_139
        }, {
          'name' => 'Den Weg meistern',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387408&type=card',
          'language' => 'German',
          'multiverseid' => 387_408
        }, {
          'name' => "Ma\u00EEtriser la Voie",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387677&type=card',
          'language' => 'French',
          'multiverseid' => 387_677
        }, {
          'name' => 'Padroneggiare la Via',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=387946&type=card',
          'language' => 'Italian',
          'multiverseid' => 387_946
        }, {
          'name' => "\u9053\u6975\u3081",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388215&type=card',
          'language' => 'Japanese',
          'multiverseid' => 388_215
        }, {
          'name' => "\uB3C4\uC758 \uAE68\uC6B0\uCE68",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388484&type=card',
          'language' => 'Korean',
          'multiverseid' => 388_484
        }, {
          'name' => 'Dominar o Caminho',
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=388753&type=card',
          'language' => 'Portuguese (Brazil)',
          'multiverseid' => 388_753
        }, {
          'name' => "\u041F\u0443\u0442\u044C \u041C\u0430\u0441\u0442\u0435\u0440\u0430",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=389022&type=card',
          'language' => 'Russian',
          'multiverseid' => 389_022
        }, {
          'name' => "Dominar la sabidur\u00EDa",
          'imageUrl' => 'http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=389291&type=card',
          'language' => 'Spanish',
          'multiverseid' => 389_291
        }],
        'printings' => ['KTK'],
        'originalText' => 'Draw a card. Master the Way deals damage to target creature or player equal to the number of cards in your hand.',
        'originalType' => 'Sorcery',
        'legalities' => [{
          'format' => 'Commander',
          'legality' => 'Legal'
        }, {
          'format' => 'Khans of Tarkir Block',
          'legality' => 'Legal'
        }, {
          'format' => 'Legacy',
          'legality' => 'Legal'
        }, {
          'format' => 'Modern',
          'legality' => 'Legal'
        }, {
          'format' => 'Vintage',
          'legality' => 'Legal'
        }],
        'id' => '9b65561b8f4ed6ae89715e8858dbff2f12f41a0a'
      }
    ]
  end
end
