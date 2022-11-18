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

describe GameBoard do
  subject(:game) { GameBoard.new }
  describe "#place_token" do
    let(:brian) { Player.new }
    it 'places token one the last line' do
      board = game.instance_variable_get(:@board)
      expect{ game.place_token(brian, 0) }.to change { board[5][0] }.from("\e[37m \u26AA").to("\e[31m \u26AB")
    end
    
    context "when there's a token on the column" do
      it 'paces a token on top of another' do
        board = game.instance_variable_get(:@board)
        board[5][0] = "\e[31m \u26AB"
        expect{ game.place_token(brian, 0)}.to change{ board[4][0] }.from("\e[37m \u26AA").to("\e[31m \u26AB")
      end
    end
  end
end