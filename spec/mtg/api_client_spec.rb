# frozen_string_literal: true

require 'api_client'

describe MTG::ApiClient do
  it 'formats the right Endpoint path' do
    page_number = 28
    endpoint_path = "/v1/cards?page=#{page_number}"
    client = described_class.new
    expect(client.send(:full_path, 'cards', page: page_number)).to eq endpoint_path
  end

  context '.get' do
    before do
      response = double('Net::HTTPResponse', body: response_body)
      allow_any_instance_of(Net::HTTP).to receive(:request).and_return(response)
    end

    it 'returns a JSON object when we get a URL' do
      expect(described_class.get('cards')).to be_a Hash
    end

    it 'raises an exception when response body does not return a string-like JSON' do
      response = double('Net::HTTPResponse', body: 'Something went wrong')
      allow_any_instance_of(Net::HTTP).to receive(:request).and_return(response)
      expect { described_class.get('cards') }.to raise_error(JSON::ParserError)
    end
  end

  def response_body
    '{
        "cards": [
            {
                "name": "Adorable Kitten",
                "manaCost": "{W}",
                "cmc": 1,
                "colors": [
                    "White"
                ],
                "colorIdentity": [
                    "W"
                ],
                "type": "Host Creature — Cat",
                "types": [
                    "Host",
                    "Creature"
                ],
                "subtypes": [
                    "Cat"
                ],
                "rarity": "Common",
                "set": "UST",
                "setName": "Unstable",
                "text": "When this creature enters the battlefield, roll a six-sided die. You gain life equal to the result.",
                "artist": "Andrea Radeck",
                "number": "1",
                "power": "1",
                "toughness": "1",
                "layout": "normal",
                "multiverseid": 439390,
                "imageUrl": "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=439390&type=card",
                "rulings": [
                    {
                        "date": "2018-01-19",
                        "text": "Host creatures each have an ability that triggers when it enters the battlefield. It functions like any other creature."
                    }
                ],
                "printings": [
                    "UST"
                ],
                "originalText": "When this creature enters the battlefield, roll a six-sided die. You gain life equal to the result.",
                "originalType": "Host Creature — Cat",
                "legalities": [
                    {
                        "format": "Un-Sets",
                        "legality": "Legal"
                    }
                ],
                "id": "95ebdf85f4ea74d584dfdfb72e3de5001d0748a9"
            },
            {
                "name": "Aerial Toastmaster",
                "manaCost": "{3}{W}",
                "cmc": 4,
                "colors": [
                    "White"
                ],
                "colorIdentity": [
                    "W"
                ],
                "type": "Artifact Creature — Cyborg Rigger",
                "types": [
                    "Artifact",
                    "Creature"
                ],
                "subtypes": [
                    "Cyborg",
                    "Rigger"
                ],
                "rarity": "Uncommon",
                "set": "UST",
                "setName": "Unstable",
                "text": "Flying\n{3}{W}, Sacrifice another artifact: Aerial Toastmaster assembles a Contraption. (Put the top card of your Contraption deck face up onto one of your sprockets.)",
                "artist": "Carl Critchlow",
                "number": "2",
                "power": "3",
                "toughness": "2",
                "layout": "normal",
                "multiverseid": 439391,
                "imageUrl": "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=439391&type=card",
                "watermark": "Order of the Widget",
                "printings": [
                    "UST"
                ],
                "originalText": "Flying\n{3}{W}, Sacrifice another artifact: Aerial Toastmaster assembles a Contraption. (Put the top card of your Contraption deck face up onto one of your sprockets.)",
                "originalType": "Artifact Creature — Cyborg Rigger",
                "legalities": [
                    {
                        "format": "Un-Sets",
                        "legality": "Legal"
                    }
                ],
                "id": "9bf93829d5f697e3d6324c439a932804bdfdec3f"
            }
        ]
    }'
  end
end
