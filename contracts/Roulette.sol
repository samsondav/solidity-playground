pragma solidity ^0.4.24;

contract Roulette {
    /*
    A simple roulette that allows betting on Red/Black.

    */
    enum Color {
        Red,
        Black,
        Green
    }

    struct Bet {
        Color color;
        uint placedAtBlockNum;
        uint amount;
    }
    mapping(address => Bet) private bets;

    function placeBet(bool _colorBool) public payable {
        require(msg.value > 0, "must bet at least 1 wei");
        require(bets[msg.sender].amount == 0, "you already have a bet pending, spin first before placing another");
        require(address(this).balance > 2*msg.value, "contract does not have enough eth to pay out if you win");
        Color _color;
        if (_colorBool) {
            _color = Color.Red;
        } else {
            _color = Color.Black;
        }
        bets[msg.sender] = Bet(
            _color,
            block.number,
            msg.value
        );
    }

    function spin() public returns (string color) {
        Bet memory _bet = bets[msg.sender];
        require(_bet.amount > 0, "you haven't placed a bet");
        require(_bet.placedAtBlockNum < block.number, "must wait at least one block before spinning");
        delete bets[msg.sender];
        Color _spinResult = generateSpinResult();
        if (_spinResult == _bet.color) {
            payout(msg.sender, _bet.amount*2);
        }
        if (_spinResult == Color.Red) {
            return "red";
        } else if (_spinResult == Color.Black) {
            return "black";
        } else {
            return "green";
        }
    }

    function payout(address _winner, uint _amount) private {
        _winner.transfer(_amount);
    }

    function generateSpinResult() private view returns (Color) {
        uint randomnumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
        if (randomnumber % 19 == 0) {
            return Color.Green;
        } else if (randomnumber % 2 == 0) {
            return Color.Red;
        } else {
            return Color.Black;
        }
    }

    function () public payable {
    }
}
