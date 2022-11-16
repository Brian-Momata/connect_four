require_relative '../connect_four'

describe Player do
  describe "#get_name" do
    subject(:player) { Player.new }
    before do
      allow(player).to receive(:empty?).and_return(true)
    end
    it 'asks player 1 for name' do
      expect(player).to receive(:puts).with('Player 1: What is your name?')
      player.get_name
    end

    it 'asks player 2 for name' do
      allow(player).to receive(:empty?).and_return(false)
      expect(player).to receive(:puts).with('Player 2: What is your name?')
      player.get_name
    end
  end

  describe "#get_token" do
    subject(:player) { Player.new }
    context "when there's only one player" do
      before do
        allow(player).to receive(:size).and_return(1)
      end
      it "return '\e[33m \u26AB'" do
        token = player.get_token
        expect(token). to eq("\e[33m \u26AB")
      end
    end

    context "when there're two players" do
      before do
        allow(player).to receive(:size).and_return(2)
      end
      it "return '\e[31m \u26AB'" do
        token = player.get_token
        expect(token). to eq("\e[31m \u26AB")
      end
    end 
  end
end